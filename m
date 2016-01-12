From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: [PATCH v4 0/2] grep: add fallbackToNoIndex config option
Date: Tue, 12 Jan 2016 11:40:24 +0100
Message-ID: <1452595226-14616-1-git-send-email-t.gummerer@gmail.com>
References: <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
Cc: pclouds@gmail.com, sunshine@sunshineco.com, gitster@pobox.com,
	peff@peff.net, Thomas Gummerer <t.gummerer@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 12 11:40:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIwND-0004ql-NN
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jan 2016 11:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934770AbcALKkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 05:40:12 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34522 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762075AbcALKkD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 05:40:03 -0500
Received: by mail-wm0-f68.google.com with SMTP id b14so30653303wmb.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2016 02:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q6Y0nCNHhPiLCm3gi8HW3AQs70E9xkUwONMOs4CwQMI=;
        b=BBtAzHisY17VxlNiXA6kovDZKckD5RwOFHmI6LELEDkx6bKcPGG5MCPaRX1QhfwCrx
         7hcvQWRFaQr5VN+Dfrg+cfE8oh5HrU0Q0djM7fSNgD1sNMKG/FrZ5D2IJbN2adhNmJcW
         OUdqqDMDd6ZN7bsUPG0AS/ia3DCQtXhkJglAk39s8zff5A/Y9uLA8Fg+feMK3exn337f
         MSnyIERhH782IeKQEJjEUP0z8mh7hZU61cXt7x5STPC23SNzbGH6uzd9BpyQHMeCWIbQ
         39k2Q+eWIa1wUKxG393sAxbxXsRWW+UDHUTGTjMPCSPhXiO8yx8hjdVsRwcHUanlesD2
         X4lw==
X-Received: by 10.28.176.131 with SMTP id z125mr19920337wme.5.1452595202130;
        Tue, 12 Jan 2016 02:40:02 -0800 (PST)
Received: from localhost (host214-63-dynamic.48-82-r.retail.telecomitalia.it. [82.48.63.214])
        by smtp.gmail.com with ESMTPSA id c185sm15247684wma.5.2016.01.12.02.40.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jan 2016 02:40:00 -0800 (PST)
X-Mailer: git-send-email 2.7.0.2.gcdcca30.dirty
In-Reply-To: <1452547580-30687-1-git-send-email-t.gummerer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283786>

Previous rounds are at $gmane/283619 and $gmane/283670. (Gmane seems
to lag behind, I can't seem to find v3 there). Thanks to Peff for the
review of the previous round.

Changes since the previous round:
  - removed unnecessary call to setup_git_directory_gently()
  - reverted the change to the error messages, as the originals should
    provide enough information to the user.

Thomas Gummerer (2):
  t7810: correct --no-index test
  builtin/grep: add grep.fallbackToNoIndex config

 Documentation/config.txt   |  4 ++++
 Documentation/git-grep.txt |  4 ++++
 builtin/grep.c             | 12 +++++++++---
 t/t7810-grep.sh            | 49 ++++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 62 insertions(+), 7 deletions(-)

-- 
2.7.0.2.gcdcca30.dirty
