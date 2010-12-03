From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH] Documentation: do not misinterpret pull refspec as bold text
Date: Fri, 3 Dec 2010 14:04:17 -0600
Message-ID: <20101203200417.GA15300@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 03 21:04:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PObs1-0003Md-2b
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 21:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876Ab0LCUEf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 15:04:35 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48758 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651Ab0LCUEf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Dec 2010 15:04:35 -0500
Received: by wyb28 with SMTP id 28so9829470wyb.19
        for <git@vger.kernel.org>; Fri, 03 Dec 2010 12:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:mime-version:content-type:content-disposition:user-agent;
        bh=P1C+vd94uGjmPsEUeBCkHBaFlcOXw2P/Nv/v7KxicPM=;
        b=x/Nzh8W2uNuOMTLTK+/fvz+zDmISkMBy2KCfwmNPVzJrmziLwklVavI3sEsbPewoev
         inmbSjWaXk8EM1mlvfRCDYxpZL9suv1j7T0My1QSBoszEzwWLdykbjnWF4ng/TLWbitK
         n7Y3pZdODaLO0EvWsmj6j01FSGxeo0y/HmGvg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=svVMxvBRuaGgLIUi1lrOqJehJhmUOztRcv0MQi7XwFIKFwYT58QRW9Z09KNuUcWOoB
         inhyZ4ygv9NqAmD2dYAi+CS5z1C0J0tN7JDdpRlsepp6aLlIUJ1IkW2SUzqPSvOhkR0y
         P5LH+AJWu4uYRvkMlUsufaTwSBw/0J7mCcRhI=
Received: by 10.227.145.134 with SMTP id d6mr2422366wbv.195.1291406673519;
        Fri, 03 Dec 2010 12:04:33 -0800 (PST)
Received: from burratino (adsl-68-255-109-73.dsl.chcgil.sbcglobal.net [68.255.109.73])
        by mx.google.com with ESMTPS id j58sm1077223wes.21.2010.12.03.12.04.31
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Dec 2010 12:04:33 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162841>

Use the {asterisk} entity to avoid mistreating the asterisks
in "(e.g., refs/heads/*:refs/remotes/origin/*)" as delimiters
for bold text.

>From a quick search with 'git grep -e "\*.*\*"', this seems to
be the last example of this particular formatting problem.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Noticed while reading the pull --rebase documentation[1] suggestions.
[1] http://thread.gmane.org/gmane.comp.version-control.git/162837

 Documentation/git-pull.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e47361f..a421789 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -27,8 +27,8 @@ With `--rebase`, it runs 'git rebase' instead of 'git merge'.
 passed to linkgit:git-fetch[1].  <refspec> can name an
 arbitrary remote ref (for example, the name of a tag) or even
 a collection of refs with corresponding remote-tracking branches
-(e.g., refs/heads/*:refs/remotes/origin/*), but usually it is
-the name of a branch in the remote repository.
+(e.g., `refs/heads/{asterisk}:refs/remotes/origin/{asterisk}`),
+but usually it is the name of a branch in the remote repository.
 
 Default values for <repository> and <branch> are read from the
 "remote" and "merge" configuration for the current branch
-- 
1.7.2.4
