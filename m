From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v3 0/2] grep: add fallbackToNoIndex config option
Date: Mon, 11 Jan 2016 22:26:18 +0100
Message-ID: <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
References: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 11 22:26:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIjyr-0004EI-HR
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbcAKV0V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:26:21 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34363 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbcAKV0U (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:26:20 -0500
Received: by mail-wm0-f67.google.com with SMTP id b14so28180517wmb.1
        for <git@vger.kernel.org>; Mon, 11 Jan 2016 13:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LH9MJ9TMP0hUNEiK/p3fb9Bq/oXN9lBdxRGpF529Cbo=;
        b=Ke3EebStwG9/gTUnY0cyAMe7N91nxvEcoVdXkMK7OvwGWt1XbeOM9f0G1RQmx+G6dh
         FHPNR+Y/Dk2RPqZZxjEzKLF64bEvRdNmRNKZ0hatNdE2Qn88WgtOyYbd6zoq2N3vcfLi
         ZQcyiOem3g4XFPBfG/kuiJzh1xqbU2vXIroEj1llqQDYfDlANhs3nurbDAGg7eINS/5u
         UXlZKkM5IHWohCHl/GXiMZVkLwuS2gxx6FOZSdkuwlKEQoVA48Na+yluF6mJEJ53EYVW
         4dkQMeIeqNPCuPO2icx8D9KQWlPIAHe1vZ6bFHVleCyoipCeSxFL3ymvhOnfLPZ/Et4M
         cpPA==
X-Received: by 10.194.21.101 with SMTP id u5mr141930468wje.53.1452547579275;
        Mon, 11 Jan 2016 13:26:19 -0800 (PST)
Received: from localhost (host143-106-dynamic.248-95-r.retail.telecomitalia.it. [95.248.106.143])
        by smtp.gmail.com with ESMTPSA id v82sm14557947wmv.12.2016.01.11.13.26.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jan 2016 13:26:17 -0800 (PST)
X-Mailer: git-send-email 2.7.0.2.gafd9bce.dirty
In-Reply-To: <1452435597-12099-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283722>

Previous rounds are at $gmane/283619 and $gmane/283670.  Thanks to
Junio and Peff for the input after the last round.

After the discussion I decided to drop the --use-index command line
argument, and use a fallbackToNoIndex config option instead.  In
addition I dropped the second patch, keeping the use_index name for
the variable used to keep track which mode should be used.

Thomas Gummerer (2):
  t7810: correct --no-index test
  builtin/grep: add grep.fallbackToNoIndex config

 Documentation/config.txt   |  4 ++++
 Documentation/git-grep.txt |  4 ++++
 builtin/grep.c             | 23 +++++++++++++++++-----
 t/t7810-grep.sh            | 49 ++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 71 insertions(+), 9 deletions(-)

-- 
2.7.0.2.gafd9bce.dirty
