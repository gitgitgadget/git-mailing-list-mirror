From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 1/9] send-email: further document missing sendmail aliases functionality
Date: Sun, 31 May 2015 18:29:23 -0400
Message-ID: <1433111371-19573-2-git-send-email-sunshine@sunshineco.com>
References: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 00:30:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzBkV-0005cM-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 00:30:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbbEaWaW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 May 2015 18:30:22 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:33840 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751642AbbEaWaU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 May 2015 18:30:20 -0400
Received: by igbhj9 with SMTP id hj9so48926235igb.1
        for <git@vger.kernel.org>; Sun, 31 May 2015 15:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h1pNuR4Dhl6MEQ/nn3CI4136wzQ09z3SvKb2rfZKiaI=;
        b=ufQiBQdaicZ7v64vTuVvoZnvuGPFiPZz9E4Jt/E+jykym2BVgRlaekDNXLgvnGZw9C
         p6MnDKmVdc4UEhto0hkL/tCc5muH1fW/c4GjXXTbO8UQKTY7WehME470HPktY5zRjrd7
         orsSUFahZKKGhEUaizRWRjQJqq9HnXBE8RaT1VL9kJGWCNKfBq3JvfFcLd2JC1fatqwz
         O8CvE8S2U0EhkKWpIU2gz50Oq5ZI12Pp8coii6oKenFXpC3J9Yse5Xy09bu+ruixVj6T
         pwsrhlpowT2WnnMcUryoz+jePzZMD6cqlhPYqzlKWZAY6GxCuOvvD+34kB2k45SSjCRV
         vU8g==
X-Received: by 10.50.79.196 with SMTP id l4mr9809587igx.48.1433111419707;
        Sun, 31 May 2015 15:30:19 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id j20sm6571830igt.5.2015.05.31.15.30.19
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 May 2015 15:30:19 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.325.gb038f2f
In-Reply-To: <1433111371-19573-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270358>

Sendmail aliases[1] supports expansion to a file ("/path/name") or
pipe ("|command"), as well as file inclusion (":include: /path/name"),
however, our implementation does not support such functionality.

[1]: https://www.freebsd.org/cgi/man.cgi?query=aliases&sektion=5

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 Documentation/git-send-email.txt | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index b48a764..e6d466e 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -396,6 +396,9 @@ sendmail;;
 	contain a `"` symbol are ignored.
 *	Line continuations are not supported: lines that start with
 	whitespace characters, or end with a `\` symbol are ignored.
+*	Redirection to a file (`/path/name`) or pipe (`|command`) is not
+	supported.
+*	File inclusion (`:include: /path/name`) is not supported.
 *	Warnings are printed on the standard error output for any
 	explicitly unsupported constructs, and any other lines that are not
 	recognized by the parser.
-- 
2.4.2.538.g5f4350e
