From: Florian Lindner <mailinglists@xgm.de>
Subject: Right way to import a repo
Date: Fri, 21 Dec 2012 17:11:54 +0100
Message-ID: <1530104.jO5zzzN8PS@horus>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 21 17:12:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tm5Cr-0004bY-PL
	for gcvg-git-2@plane.gmane.org; Fri, 21 Dec 2012 17:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab2LUQMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Dec 2012 11:12:00 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:55382 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484Ab2LUQL6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Dec 2012 11:11:58 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so2530044bkw.33
        for <git@vger.kernel.org>; Fri, 21 Dec 2012 08:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xgm.de; s=google;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type;
        bh=X3NwmLe56q9NCk/q+Q8RURUHNVCvWyHiwz/+ubpYeJ8=;
        b=fkmeq4VcBJf7+c32bn9sT8YveqB4zfL8l45wWugFaCGsizIEL9gYE1rKbmReBKO1He
         yBo+/upikJuUQsNW0/3VednRO30ZYp9pqCnUyems4kNv3cMg/0qhpJrtLBnkwxf5YMpI
         FOKCTwPZam1Xdglwf7TPXv3Gp5D2Q9Abv1D8I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:from:to:subject:date:message-id:user-agent:mime-version
         :content-transfer-encoding:content-type:x-gm-message-state;
        bh=X3NwmLe56q9NCk/q+Q8RURUHNVCvWyHiwz/+ubpYeJ8=;
        b=TDnKDORmLgpbqlbo6pSL5JTNSsnQKJB5JJ4Q1OYlo5jZ+EgwtdUOYfkeizx79mQi6q
         wwj067+L08wMFbAs+nal6Eo/lRAxw/t7CE0oTkLlaSKZqmvFIwGmDI1yqb8K5a3Xm5mV
         GlqmWGvgVfKkpySMYrIgLH7qGqEmNwwLskHDFo9LwTiLTnnyvEpLga3OAFmG5pRiztvg
         DMZhMwYksoeJ5z8Z12pMnoFkbf/XSexrghE3gOvFPNFLspcyZFxfHIzmN3/HSDiMVPXE
         6WkfZC+PeXc/HMBwnRClMnWCYag/4269SRgU9HLY72QcKn3tYvEkAwcfMEXouh3hitkH
         WbaA==
X-Received: by 10.204.153.197 with SMTP id l5mr6579004bkw.80.1356106317251;
        Fri, 21 Dec 2012 08:11:57 -0800 (PST)
Received: from horus.localnet (host134-2.natpool.mwn.de. [138.246.2.134])
        by mx.google.com with ESMTPS id z5sm10535615bkv.11.2012.12.21.08.11.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 21 Dec 2012 08:11:56 -0800 (PST)
User-Agent: KMail/4.9.4 (Linux/3.6.10-1-ARCH; KDE/4.9.4; x86_64; ; )
X-Gm-Message-State: ALoCoQk/z/fCi65Q9Cxk9l1Hg6zDNrSTtsxIq8uprzkH3xpXyR5Xx82SoCMKkk2QbY+lXMH5Zip0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211981>

Hello,

I have two repositories. tools and flof. I want to merge flof into tools (and 
flof will be deleted after that) while keeping history intact. Of course I've 
googled that and found a number of different solution which all seem to be 
pretty komplex, so I just tried it myself. It seems to work.... are there any 
problems with my approach?

~/software/tools.test (git)-[master] % git remote add fl ~/flof

~/software/tools.test (git)-[master] % git fetch fl
warning: no common commits
remote: Counting objects: 475, done.
remote: Compressing objects: 100% (460/460), done.
remote: Total 475 (delta 251), reused 0 (delta 0)
Receiving objects: 100% (475/475), 190.40 KiB, done.
Resolving deltas: 100% (251/251), done.
From /home/florian/flof
 * [new branch]      master     -> fl/master
 * [new branch]      v2-rewrite -> fl/v2-rewrite

/software/tools.test (git)-[master] % git checkout -b import fl/master
Branch import set up to track remote branch master from fl.
Switched to a new branch 'import'

Doing some mkdir und git mv for reorganisation.

~/software/tools.test/flof (git)-[import] % git commit -m "Reorganize flof."
[import a00ab54] Reorganize flof.
 152 files changed, 0 insertions(+), 0 deletions(-)
 rename {doc => flof/doc}/common.rst (100%)
 rename {doc => flof/doc}/conf.py (100%)
 [...]

~/software/tools.test/flof (git)-[import] % git checkout master
Switched to branch 'master'

~/software/tools.test (git)-[master] % git merge import
Auto-merging .gitignore
CONFLICT (add/add): Merge conflict in .gitignore
Automatic merge failed; fix conflicts and then commit the result.

Resolving the conflict.

~/software/tools.test (git)-[master|merge] % git add .gitignore

~/software/tools.test (git)-[master|merge] % git commit -m "Merged flof."
[master b8c85be] Merged flof.

~/software/tools.test (git)-[master] % git remote rm fl

Are thery any problems with this procedure? The history seems to intact. I'm 
quite unsure since still being a git beginner. 

Thanks,

Florian
