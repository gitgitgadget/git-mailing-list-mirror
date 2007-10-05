From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
Subject: Re: Question about "git commit -a"
Date: Fri, 5 Oct 2007 14:19:02 +0200
Message-ID: <4d8e3fd30710050519k7a3db02dk5ba9750fd8e9705f@mail.gmail.com>
References: <4d8e3fd30710040838t48bb590erbd90a8c4a1c6e932@mail.gmail.com>
	 <545CB3B2-96B3-4853-9397-B42F4F268A15@wincent.com>
	 <fcaeb9bf0710041333l636b2c1fn4d8f3298000127c7@mail.gmail.com>
	 <Pine.LNX.4.64.0710042209410.4174@racer.site>
	 <4d8e3fd30710050139j45a5a924t5c048994e3457c5f@mail.gmail.com>
	 <4705FB52.3030208@op5.se>
	 <4d8e3fd30710050206h7a177472x7c92f91204b15aa4@mail.gmail.com>
	 <47060BB3.3030208@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Nguyen Thai Ngoc Duy" <pclouds@gmail.com>,
	"Wincent Colaiuta" <win@wincent.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Andreas Ericsson" <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 05 14:19:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Idm9D-0000jm-Va
	for gcvg-git-2@gmane.org; Fri, 05 Oct 2007 14:19:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251AbXJEMTH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Oct 2007 08:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752232AbXJEMTH
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Oct 2007 08:19:07 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:11408 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247AbXJEMTF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Oct 2007 08:19:05 -0400
Received: by wr-out-0506.google.com with SMTP id 36so360457wra
        for <git@vger.kernel.org>; Fri, 05 Oct 2007 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=2sI4+nqLpjP4W2Zs1CV6KmBdrZsh5Jo3rxxPRM0mWEk=;
        b=O0ESHd/rzyWbNqxSmpJ1+MPcNgYAn7czuRBeSCaaaL5XWmQ8o5dP6zty91E+tqtAAfDO24c0ebS0t29V/5J1g4hvLPO7hH99zA772Uqrcd7Q2FJR6FhnPNNbHO0lXt4qdusLH0NfizklsKCZXsIdsK7SWVQ6LWQsKuAdG/PxN5I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Fy+F9R2aPV2QU/9HOD5Vj6Sk2XT5Z8dpSrprAlD8q2tA8/r3K+wWv+gFc7lhIF243GC6GI/04eW9G6Bgmalwr724eKOgBrR5K8N+jxC9cqCY4j/iKWVrwSNhtr/tgR7gF4Bxv2cBiuJY2ruGmm61cJHKPnHkdHjLsUgXnINVA1c=
Received: by 10.142.144.16 with SMTP id r16mr1442381wfd.1191586742122;
        Fri, 05 Oct 2007 05:19:02 -0700 (PDT)
Received: by 10.143.43.21 with HTTP; Fri, 5 Oct 2007 05:19:02 -0700 (PDT)
In-Reply-To: <47060BB3.3030208@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60074>

On 10/5/07, Andreas Ericsson <ae@op5.se> wrote:
[...]
> As for the "git commit should default to -a" discussion, I think it's pretty
> clear where I stand ;-)

Fair enough.

Another try to have an easy explanation of how the staging area works:

paolo@paolo-desktop:~/HowIndexWorks$ ls
A  B  C  D  E  F  G

Now I edit A,B,C,D and E:

$ echo A >> A
$ echo B >> B
$ echo C >> C
$ echo D >> D
$ echo E >> E

I now realize want to only commit the changes I did to A,B,C,D.
First step is to place A,B,C and D into the staging area:
$ git add A B C D

Now I can commit:
$ git commitpaolo@paolo-desktop:~/HowIndexWorks$ git commit
Created commit 16032dc: I modified A,B,C and D
 4 files changed, 4 insertions(+), 0 deletions(-)

It's now time to work on F and G:
$ echo F >> F
$ echo G >> G

Current status is:
paolo@paolo-desktop:~/HowIndexWorks$ git status
# On branch master
# Changed but not updated:
#   (use "git add <file>..." to update what will be committed)
#
#       modified:   E
#       modified:   F
#       modified:   G

Instead of adding E,F and G to the staging are and then commit them in
two steps I can using a single command:
$ git commit E F G (in this case it's equivalent to git commit -a)

paolo@paolo-desktop:~/HowIndexWorks$ git commit E F G
Created commit 69ec8be: I modified E, F and G
 3 files changed, 3 insertions(+), 0 deletions(-)

status now is:
paolo@paolo-desktop:~/HowIndexWorks$ git status
# On branch master
nothing to commit (working directory clean)

Regards,
-- 
Paolo
http://paolo.ciarrocchi.googlepages.com/
