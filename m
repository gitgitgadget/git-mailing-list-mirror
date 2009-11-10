From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: Git drawbacks?
Date: Tue, 10 Nov 2009 16:45:40 +0300
Message-ID: <20091110134540.GK27126@dpotapov.dyndns.org>
References: <loom.20091106T160709-387@post.gmane.org> <32541b130911060849s2d8f13f5sb9b8390f075f8d15@mail.gmail.com> <loom.20091106T180313-750@post.gmane.org> <32541b130911060951q3358ce9ahe28fb0cf902853f2@mail.gmail.com> <alpine.DEB.2.00.0911061051540.3216@asgard.lang.hm> <loom.20091109T084539-720@post.gmane.org> <20091109154816.GH27126@dpotapov.dyndns.org> <loom.20091109T170054-451@post.gmane.org> <20091109183404.GI27126@dpotapov.dyndns.org> <loom.20091110T092404-595@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dmitry Smirnov <divis1969@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 10 14:45:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7r2i-0003ds-4W
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 14:45:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752258AbZKJNpo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 08:45:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751965AbZKJNpo
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 08:45:44 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:39123 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386AbZKJNpo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 08:45:44 -0500
Received: by bwz27 with SMTP id 27so24020bwz.21
        for <git@vger.kernel.org>; Tue, 10 Nov 2009 05:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=E/SIJqu0l9ngq6PK1OnkUh1yGNl+2H79NcjoTnRMznw=;
        b=H688ZQ2ZgYN5btWvffOoGuZXanHro0YC0hVL6ZFUGun7/23G/nQ76Niszebb1T/afR
         LBXSgoS3Gf5IZ1Wq1ed26Ziw1K0MZ5g8cY3zC9R7W0lysr96MNP37jmwmY/rarylxC3k
         OAqwAidDi6ZZDofzVcxL3hy2lRf1FIh4cpsm8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=QQhLJhgDuUuwgLHX14IB6etZaX9buVdnh4o0qL1vTNs96cpc/b3uNNuk8snM51nuY2
         qF2t3L4hcayBugZ1GU0uJ0iC+qWVAFsRnr2ntK82f7gouiTMVIXX9ko4csA77NKs7UAi
         7t95c+du4RNL/ycr3A/YOVvKiC2C242M2wnvQ=
Received: by 10.204.26.206 with SMTP id f14mr91695bkc.95.1257860744068;
        Tue, 10 Nov 2009 05:45:44 -0800 (PST)
Received: from localhost (ppp85-140-126-241.pppoe.mtu-net.ru [85.140.126.241])
        by mx.google.com with ESMTPS id 15sm217299bwz.4.2009.11.10.05.45.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 10 Nov 2009 05:45:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <loom.20091110T092404-595@post.gmane.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132567>

On Tue, Nov 10, 2009 at 08:31:48AM +0000, Dmitry Smirnov wrote:
> Dmitry Potapov <dpotapov <at> gmail.com> writes:
>  
> > Yes, but then I do not see any reason to do any time consuming building
> > and testing in the working tree. I create a snapshot of the interesting
> > version using 'git archive' and then run build&test on it... In this
> > way, I can make sure that the archive I deliver is tested properly. If
> > you do your testing in the working tree, sometimes uncommitted or some
> > other files that are left over from previous builds may affect result.
> > So, if it takes considerable time anyhow, why do not do clean build and
> > test? And if you worry about compilation time, you can use ccache.
> 
> It is not clear for me. Yes, I have to get some fixed version to reproduce
> the bug reported by someone. Then I need to fix it and commit the change 
> back (on the head). Also, it is obvious to reproduce the issue and 
> test the fix on the tip. Can do this with 'git archive'?
> BTW, doesn't 'git archive' sync to some version that I probably already 
> have in other clone? ;-)

I am not sure I understood your question. What 'git archive' does is to
create a tar or zip archive or any version that you specify. So, you can
use it to export the snapshot of any version to a temporary directory
for testing if this testing takes a noticeable time and you want to be
able to work on something else in meanwhile. If necessary, you can
create a temporary branch starting at the intesting point and to add
some commits there (such as a new test case to reproduce the problem)
and then run test on it. Later, you can either rebase or merge these
commits to any branch that needs them.

Actually, when someone reports a problem, I do not use 'git archive'
because I write a test case for this bug and run it alone, and it does
not take much time to run it. But periodically (a few times a day), I
run the full test suit, which takes considerable amount of time, so I
run this test outside of my working directory, using 'git archive'.


Dmitry
