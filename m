From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How do I .gitignore files starting with "#"?
Date: Fri, 10 Sep 2010 11:52:15 -0700 (PDT)
Message-ID: <m38w39mnyd.fsf@localhost.localdomain>
References: <AANLkTimaPrDX4rn2xRYyLn-bh2rB-TgKaEtGSQ+JxSnM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruce Korb <bruce.korb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 20:52:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou8i0-0006FT-Lp
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 20:52:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab0IJSwS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 14:52:18 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:34670 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573Ab0IJSwR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 14:52:17 -0400
Received: by ewy23 with SMTP id 23so1950097ewy.19
        for <git@vger.kernel.org>; Fri, 10 Sep 2010 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=MbWgb4vKGvOBEUtBI9d7eM8jmlmrbECQzb0amvtvB2U=;
        b=bJEa2aH6A2mr4heykwjLu9IHtl3XZOT8G0XHOIfu/8ojjUDlOI7uxaN4MoK8IWXWc3
         vkgY8pmWBkZF1PVnpRhKxZQiYE02/S4eekOZlfEIBNFfJy9XRnQbdGrPk9PxSVCwFwhl
         FTFqBhwPAQRZntsykfaZqOr+vjPf9p3VgzhJM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=sy0705gC7Kut61hIcqheqLPwpf1VGyd3oXTHrEZwRO61grRPc2WXAmM5fKjFnI9bCi
         4sMIMaGpi7lTl2S13c+V94PjDNyxnHrIfiXTkJF1nkLe8mYJY6+jHbrEaKxxcHrB8Ew6
         n7TLXifAFtcLuHm8A2gbK2haBBNwJkKx247Ng=
Received: by 10.213.7.7 with SMTP id b7mr921353ebb.30.1284144736694;
        Fri, 10 Sep 2010 11:52:16 -0700 (PDT)
Received: from localhost.localdomain (abuz124.neoplus.adsl.tpnet.pl [83.8.197.124])
        by mx.google.com with ESMTPS id z55sm4349232eeh.9.2010.09.10.11.52.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 10 Sep 2010 11:52:15 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o8AIpnZ1020396;
	Fri, 10 Sep 2010 20:52:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o8AIpcPR020393;
	Fri, 10 Sep 2010 20:51:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTimaPrDX4rn2xRYyLn-bh2rB-TgKaEtGSQ+JxSnM@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155952>

Bruce Korb <bruce.korb@gmail.com> writes:

> After trying lots of variations, I found it to be:
> 
> \#*
> 
> Not obvious and not easy to look up.  Please add it to your
> .git/info/exclude sample text.  Thanks!

Well, it is quite obvious to me, as escaping special characters using
backslash is typical in Unix tools.  But you are right that this needs
to be documented.

Perhaps something like this?  I am not sure about example in
.git/info/exclude skeleton

-- >8 --
Subject: [PATCH] Document escaping of special characters in gitignore files

Requested-by: Bruce Korb <bruce.korb@gmail.com>
Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 Documentation/gitignore.txt |    6 ++++++
 templates/info--exclude     |    1 +
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 7dc2e8b..67ae4d0 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -98,6 +98,12 @@ Patterns have the following format:
    For example, "/{asterisk}.c" matches "cat-file.c" but not
    "mozilla-sha1/sha1.c".
 
+ - You can escape special characters using backslash.
+   For example, "{backslash}#*" matches files beginning in `#`
+   (otherwise it would be considered comment),
+   and "{backslash}!*{backslash}?" matches files starting with `!`
+   (negate pattern prefix) and ending with `?` (glob wildcard).
+
 An example:
 
 --------------------------------------------------------------
diff --git a/templates/info--exclude b/templates/info--exclude
index a5196d1..2ebaf0d 100644
--- a/templates/info--exclude
+++ b/templates/info--exclude
@@ -4,3 +4,4 @@
 # exclude patterns (uncomment them if you want to use them):
 # *.[oa]
 # *~
+# \#*#
-- 
1.7.2.1
