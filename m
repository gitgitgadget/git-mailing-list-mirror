From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 2/4] githooks.txt: Amend dangerous advice about 'update' hook ACL
Date: Tue, 26 Apr 2016 18:13:20 +0000
Message-ID: <1461694402-9629-3-git-send-email-avarab@gmail.com>
References: <1461694402-9629-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:14:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1av7Uz-0006qz-Dh
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 20:14:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752375AbcDZSOI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Apr 2016 14:14:08 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35784 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752366AbcDZSOH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 14:14:07 -0400
Received: by mail-wm0-f66.google.com with SMTP id e201so6509685wme.2
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 11:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D9p5Wkr2+IDHxEFLVaFTCkVC6+gNSBKP6wm6RrsPSXk=;
        b=Q/og5AT/qFUOLaJoN4vyo3CaUoOUGUC/v3I0BFC64pDccoOW1Vx/gsW6waHmTjWwlg
         3Qq7byYmdEuV+G7jeDokv7SY2zG3rGa+arQV6YTePW8mqmamSIVmLt4ZE7D3MY12EuOx
         3VP6lMLaSj8fRbo6RwB60JiAgd6YE7kbA0ioEOLQOrwbLWmJXGVaQagV/rTrDQ2rcnqD
         JDU1KR7IQT/wNrQYIp5xRFspsSDaBND58qIv4DxrVi4fb9Ea1TpGWskAuzZYyob3rvxj
         hl5lXFK0bRJ6+LgbFnB6fJYA0dZqKi8wJb20BwmgwrZyxW9W0vbpai8mWtiVktu7V+I/
         l9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D9p5Wkr2+IDHxEFLVaFTCkVC6+gNSBKP6wm6RrsPSXk=;
        b=c6wjArvbODV+18w2g2upMUN4QNb6h08mV/kJLs4qw/ZvXw+nMFKrw3/uedo3xnWaFg
         B0K1ht17OoljghLupPw72Rfq3H0zYD3YJj8FfzM3yzIQP40YPJuBq2w6uP5gfOm4IxbO
         4dyRxUTAmVuKD9SkX7J1vACzWDrpAyKzr+tk/zquCBInb5yw1lMis1jO+ZE9R/vaYpSX
         hCCPKUShv/WZCe/997mcv4BptlUBUciZF+JYdT1HQmKikb6kj3TnOyjKTapHV0z363XM
         l/ehWNxkF2M4l43i11KcY6Hh/rjTqD1cYa3Tm+iGlvQOPS+ajzg+7LiWQOCbKoD7ToHZ
         Q6cA==
X-Gm-Message-State: AOPr4FX5P9x21YQ2cXMYohBONUCbJopivqIit9QQEkMsjHE6TvvGxLh+TQPkO1aM/rY9eg==
X-Received: by 10.194.178.233 with SMTP id db9mr4736390wjc.11.1461694445884;
        Tue, 26 Apr 2016 11:14:05 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id h8sm4392371wmd.2.2016.04.26.11.14.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 26 Apr 2016 11:14:05 -0700 (PDT)
X-Mailer: git-send-email 2.1.3
In-Reply-To: <1461694402-9629-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292636>

Any ACL you implement via an 'update' hook isn't actual access control
if the user has login access to the machine running git, because they
can trivially just built their own git version which doesn't run the
hook.

Change the documentation to take this dangerous edge case into account,
and remove the mention of the advice originating on the mailing list,
the users reading this don't care where the idea came up.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 Documentation/githooks.txt | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 7660b95..9051584 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -275,9 +275,11 @@ does not know the entire set of branches, so it wo=
uld end up
 firing one e-mail per ref when used naively, though.  The
 <<post-receive,'post-receive'>> hook is more suited to that.
=20
-Another use suggested on the mailing list is to use this hook to
-implement access control which is finer grained than the one
-based on filesystem group.
+In an environment that restricts the users' access only to git
+commands over the wire, this hook can be used to implement access
+control without relying on filesystem ownership and group
+membership. See linkgit:git-shell[1] for how you might use the login
+shell to restrict the user's access to only git commands.
=20
 Both standard output and standard error output are forwarded to
 'git send-pack' on the other end, so you can simply `echo` messages
--=20
2.1.3
