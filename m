From: knittl <knittl89@googlemail.com>
Subject: [PATCH] Match lightweight tags too in bash prompt
Date: Fri, 19 Nov 2010 16:43:09 +0100
Message-ID: <AANLkTikeH=MODho_GsZP5VPQmt2NOoHyfw2pbt4yqGkt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 19 16:43:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJT7o-0003VY-Kb
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 16:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753273Ab0KSPnc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 10:43:32 -0500
Received: from mail-qy0-f181.google.com ([209.85.216.181]:48899 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753054Ab0KSPna (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Nov 2010 10:43:30 -0500
Received: by qyk33 with SMTP id 33so7602qyk.19
        for <git@vger.kernel.org>; Fri, 19 Nov 2010 07:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type;
        bh=Z2gWoKF8eehnRNq3+Uf/+IIf+GvoBoq9hwshCyDEzIk=;
        b=HG5LrW/jkz/qVHZGRE2xYfI7kfa1wy5joR3KCTkRSX4ZghHYzt4LR1OMCtyxUZdC3M
         mLruZKKZVbXoIF8tRf+szTONiT1KVr39cg5lj1/t+YwnBvgFNnZuR9yv4LcYSw7EiVOZ
         GqjtLuRjbzUuy5Fzcxz/3Mzs6qyeL9YkzLbck=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        b=sZwW7gnWjtCnTwio0/uIgbxTVXbUf5q5RFdVbCLK13YDHV1BQGYqqVg1E41p8TXThh
         Zr3SUqCz5E5VLJAOmeVz3e+CaNOpkIiDS0A+LVOeo5e4gpAEBC4+rYBrQOye3F6OOKzU
         up3Twq8uLR6VB5t4DCDFUOLc3Wr270apGtH5Q=
Received: by 10.229.97.13 with SMTP id j13mr1863984qcn.251.1290181410025; Fri,
 19 Nov 2010 07:43:30 -0800 (PST)
Received: by 10.229.36.135 with HTTP; Fri, 19 Nov 2010 07:43:09 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161758>

>From 1fea30e0167681917b4f40a3cb2cde9a90706011 Mon Sep 17 00:00:00 2001
From: Daniel Knittl-Frank <knittl89+git@googlemail.com>
Date: Fri, 19 Nov 2010 16:40:02 +0100
Subject: [PATCH] Match lightweight tags too in bash prompt

provide `--tags` to git describe
---

bash prompt would display a commit's sha1, when checking out a lightweight tag.
provide --tags to git describe in the completion script, so it will
display the name
of the tag (as it already does for annotated tags)

 contrib/completion/git-completion.bash |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/completion/git-completion.bash
b/contrib/completion/git-completion.bash
index f710469..604fa79 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -261,7 +261,7 @@ __git_ps1 ()
 				(describe)
 					git describe HEAD ;;
 				(* | default)
-					git describe --exact-match HEAD ;;
+					git describe --tags --exact-match HEAD ;;
 				esac 2>/dev/null)" ||

 				b="$(cut -c1-7 "$g/HEAD" 2>/dev/null)..." ||
-- 
1.7.3.2.334.gd1031


-- 
typed with http://neo-layout.org
myFtPhp -- visit http://myftphp.sf.net -- v. 0.4.7 released!
