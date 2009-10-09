From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/9 v2] Documentation: clone: clarify discussion of initial
 branch
Date: Fri, 9 Oct 2009 18:07:39 -0500
Message-ID: <20091009230739.GC4605@progeny.tock>
References: <20091009101400.GA16549@progeny.tock>
 <20091009101825.GE16558@progeny.tock>
 <7vskdsqlvh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 10 01:02:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwOU8-00010e-ML
	for gcvg-git-2@lo.gmane.org; Sat, 10 Oct 2009 01:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933537AbZJIXAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 19:00:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757121AbZJIXAE
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 19:00:04 -0400
Received: from mail-qy0-f172.google.com ([209.85.221.172]:40949 "EHLO
	mail-qy0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752532AbZJIXAD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 19:00:03 -0400
Received: by qyk2 with SMTP id 2so6927272qyk.21
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 15:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=q9+A8OdMoFLOO+QQZHkHS6GEAYn9ycwripj7LtFZOQc=;
        b=Phf1jRok3viS4G9REZKVjr1b9iqLDs0UQDhFmhZw1zur1CamP3qZuvfq7CETN2LIww
         HqL0UN5b2A67t4RT9DaEMHsQvjN3V1CQt3isOEfwLEOIE4+j2GPwu1G+p3r+Gudr8G51
         Oi/7vyz/uRVQnnQxxoFUcHYaNKAfcJfe046Hc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BRosfiLCCiJ+UVxTu+xbb0cflg29QpPj0p/cP+Uq1+Qd2wENf4ZJl1aI1fJ6Br9Y1E
         qFv3hveiuQy7eSlnz7eLenxKIF/l7q2s/I0iWzq/YKHuV2WEzg3cJXK5f7J5HzTWzWxD
         g+vggNlnr1vm2EfKpmPI+N+w+cQ5q2jVpaFbU=
Received: by 10.224.13.66 with SMTP id b2mr3162384qaa.370.1255129166071;
        Fri, 09 Oct 2009 15:59:26 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 4sm11000qwe.38.2009.10.09.15.59.24
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 15:59:25 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vskdsqlvh.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129856>

When saying the initial branch is equal to the currently active
remote branch, it is probably intended that the branch heads
point to the same commit.  Maybe it would be more useful to a
new user to emphasize that the tree contents and history are the
same.

More important, probably, is that this new branch is set up so
that "git pull" merges changes from the corresponding remote
branch.  The next paragraph addresses that directly.  What the
reader needs to know to begin with is that (1) the initial branch
is your own; if you do not pull, it won't get updated, and that
(2) the initial branch starts out at the same commit as the
upstream.

Thanks to Junio C Hamano for the wording.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Junio C Hamano wrote:

> Perhaps
> 
>     ... creates and checks out an initial branch that is forked from the
>     cloned repository's currently active branch.
> 
> would convey that (1) the initial branch is your own; if you do not pull,
> you won't get updated, and that (2) the initial branch starts out at the
> same commit as the upstream.

That does work better.  Explanation stolen for the commit message ---
I hope you don't mind.

Thanks,
Jonathan

 Documentation/git-clone.txt |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index aacf4fd..5ebcba1 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -19,8 +19,9 @@ DESCRIPTION
 
 Clones a repository into a newly created directory, creates
 remote-tracking branches for each branch in the cloned repository
-(visible using `git branch -r`), and creates and checks out an initial
-branch equal to the cloned repository's currently active branch.
+(visible using `git branch -r`), and creates and checks out an
+initial branch that is forked from the cloned repository's
+currently active branch.
 
 After the clone, a plain `git fetch` without arguments will update
 all the remote-tracking branches, and a `git pull` without
-- 
1.6.5.rc1.199.g596ec
