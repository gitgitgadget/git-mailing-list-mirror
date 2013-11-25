From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/9] mark contributed hooks executable
Date: Mon, 25 Nov 2013 12:55:30 -0800
Message-ID: <20131125205530.GT4212@google.com>
References: <20131125205119.GQ4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Olivier Berger <olivier.berger@it-sudparis.eu>,
	Clemens Buchacher <drizzd@aon.at>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 25 21:55:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl3By-0000g4-4C
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:55:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081Ab3KYUze (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:55:34 -0500
Received: from mail-yh0-f54.google.com ([209.85.213.54]:49421 "EHLO
	mail-yh0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751280Ab3KYUzd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:55:33 -0500
Received: by mail-yh0-f54.google.com with SMTP id z12so3340680yhz.27
        for <git@vger.kernel.org>; Mon, 25 Nov 2013 12:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=8jRRB5mDxwdMQUvfu+Zc7bwSB5Dw2Z/EjOuWJYIda0c=;
        b=xCBgPnZPrvCrqOPBCS7DjDuvrFLya/qzgk2Yqc9fyJ/XSm6bo7q7SaIVuc0zyGcRcM
         tfK8FpEUqytlqN+g69VpUQ6BWNFicqFtowwsRweHQYegHoDf12BSdy6HXmQzaDw29CjI
         DEylo/umO19tz4Z68V7UdbgmMi3NHcTIFxnNiAgPJze500HVomAIdNN12yHPiBQLFIAx
         UXsi5yX52ZPrHewI8/B2WFu4uDinUkxbA2HCDqmdBMTH1bBRVA0re5aTaAUnF8Ok92La
         7tQEbDhCbO+SxnasaYnopf+zUI8Aa5cLCrstL8UjUjJ9d+X2jpgaSX/+FITDTWUjCx2Y
         nvEw==
X-Received: by 10.236.120.74 with SMTP id o50mr29389161yhh.45.1385412933082;
        Mon, 25 Nov 2013 12:55:33 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id m29sm76395476yho.14.2013.11.25.12.55.32
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 25 Nov 2013 12:55:32 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20131125205119.GQ4212@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238350>

The docs in contrib/hooks/pre-auto-gc-battery suggest:

	For example, if the hook is stored in
	/usr/share/git-core/contrib/hooks/pre-auto-gc-battery:

	chmod a+x pre-auto-gc-battery
	cd /path/to/your/repository.git
	ln -sf /usr/share/git-core/contrib/hooks/pre-auto-gc-battery \
	     hooks/pre-auto-gc

Unfortunately on multi-user systems most users do not have write
access to /usr.  Better to mark the sample hooks executable in
the first place so users do not have to tweak their permissions to
use them by symlinking into .git/hooks/.

Reported-by: Olivier Berger <olivier.berger@it-sudparis.eu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 contrib/hooks/post-receive-email  | 1 -
 contrib/hooks/pre-auto-gc-battery | 1 -
 contrib/hooks/setgitperms.perl    | 0
 contrib/hooks/update-paranoid     | 0
 4 files changed, 2 deletions(-)
 mode change 100644 => 100755 contrib/hooks/pre-auto-gc-battery
 mode change 100644 => 100755 contrib/hooks/setgitperms.perl
 mode change 100644 => 100755 contrib/hooks/update-paranoid

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index 8ee410f..8747b84 100755
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -22,7 +22,6 @@
 # For example, on debian the hook is stored in
 # /usr/share/git-core/contrib/hooks/post-receive-email:
 #
-#  chmod a+x post-receive-email
 #  cd /path/to/your/repository.git
 #  ln -sf /usr/share/git-core/contrib/hooks/post-receive-email hooks/post-receive
 #
diff --git a/contrib/hooks/pre-auto-gc-battery b/contrib/hooks/pre-auto-gc-battery
old mode 100644
new mode 100755
index 1f914c9..9d0c2d1
--- a/contrib/hooks/pre-auto-gc-battery
+++ b/contrib/hooks/pre-auto-gc-battery
@@ -13,7 +13,6 @@
 # For example, if the hook is stored in
 # /usr/share/git-core/contrib/hooks/pre-auto-gc-battery:
 #
-# chmod a+x pre-auto-gc-battery
 # cd /path/to/your/repository.git
 # ln -sf /usr/share/git-core/contrib/hooks/pre-auto-gc-battery \
 #	hooks/pre-auto-gc
diff --git a/contrib/hooks/setgitperms.perl b/contrib/hooks/setgitperms.perl
old mode 100644
new mode 100755
diff --git a/contrib/hooks/update-paranoid b/contrib/hooks/update-paranoid
old mode 100644
new mode 100755
-- 
1.8.4.1
