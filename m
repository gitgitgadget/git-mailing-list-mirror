From: allstars <allstars.chh@gmail.com>
Subject: rebase on remote branch
Date: Tue, 12 Apr 2011 10:17:06 -0700 (PDT)
Message-ID: <6b4c9a4d-075c-4805-8fad-bacecb24e9de@w7g2000pre.googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 12 19:26:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9hLr-0007Tl-IW
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 19:26:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658Ab1DLR0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 13:26:00 -0400
Received: from mail-pv0-f184.google.com ([74.125.83.184]:58763 "EHLO
	mail-pv0-f184.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755368Ab1DLR0A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 13:26:00 -0400
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Apr 2011 13:26:00 EDT
Received: by pvf33 with SMTP id 33so1596019pvf.1
        for <git@vger.kernel.org>; Tue, 12 Apr 2011 10:25:59 -0700 (PDT)
Received: by 10.142.171.2 with SMTP id t2mr1189488wfe.23.1302628626691; Tue,
 12 Apr 2011 10:17:06 -0700 (PDT)
Received: by w7g2000pre.googlegroups.com with HTTP; Tue, 12 Apr 2011 10:17:06
 -0700 (PDT)
X-IP: 220.130.135.229
User-Agent: G2/1.0
X-HTTP-UserAgent: Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/534.16
 (KHTML, like Gecko) Chrome/10.0.648.204 Safari/534.16,gzip(gfe)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171404>

hi
first I know rebase on remote branch is bad idea
so I am here asking for suggestions if you can kindly provide some

in my server I got two branches , master and release ,
and release is branched from master

0---0---0---0-- master
        \
           0---0-- release

our work mainly focus on master, so we will keep committing code to
master
for some reasons, release branch is for others, and it has some
commits that master doesn't have

and now in every week, we have some stable code in master branch
so we also want the release branch also has these new code

0---0---0---0---*---*---* master
        \
           0---0-- release

how should we do now??

currently our way is doing rebase in our local pc

0---0---0---0---*---*---* master
                                    \
                                      0'---0'-- release
in release branch
$>git rebase master

but in that way when we want to push the release branch back
it will fail because it's non-fast-forward updates
so we doing git push -f origin release to force it to 'rebase' on our
remote server


or if we use cherry-pick model

0---0---0---0---*---*---* master
        \
           0---0---*---*---* release

but in this case , how do we do it in script?
I mean, how do we know we need to start cherry-pick from the 1st '*'
to the 3rd '*' in master

more precisely , if A to E represents the commit SHA1

0---0---0---0---A---B---C---D---E master
        \
           0---0---A'---B'---C' release

the 3 cherry-picks A' B' C' on release branch won't have the same SHA1
for A B C in master
how can we know effectively we need to start cherry-pick from C to E
on master


thanks
