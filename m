From: "Rajkumar S" <rajkumars+git@gmail.com>
Subject: Re: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 17:02:14 +0530
Message-ID: <64de5c8b0609150432o5d6835a8pb578082746576864@mail.gmail.com>
References: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com>
	 <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 13:32:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOBve-0002zf-3B
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 13:32:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750865AbWIOLcP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 07:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWIOLcP
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 07:32:15 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:17348 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750865AbWIOLcO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 07:32:14 -0400
Received: by py-out-1112.google.com with SMTP id n25so4040032pyg
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 04:32:14 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=ER3g7IGaC5bPX/LFdBHZs8Xr/GZdSMhDNYbP7gp+I/Jns/oFao7YYU1iL89ImNN2wT/d43OElYquR9LNUW9IdMVzJew6uFwmcmF83m1PJ2NQSjAZKh7N/mYYMlpTXovbF8MUUqUM1kCgvZEl4kyea8h+Xs4pxx3/EKFFMEfi1EE=
Received: by 10.65.114.16 with SMTP id r16mr11590566qbm;
        Fri, 15 Sep 2006 04:32:14 -0700 (PDT)
Received: by 10.65.248.1 with HTTP; Fri, 15 Sep 2006 04:32:14 -0700 (PDT)
To: "Catalin Marinas" <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 537c5cc9375d9b97
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27078>

On 9/15/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:

> After StGIT pops all the patches, it just calls "git pull origin". My
> understanding of GIT is that this should update local RELENG_1 with
> the remote RELENG_1 from the "origin" repository. Anything wrong with
> my assumptions?

I checked this again, this time with out using stgit, and the results
are the same. So this is not a StGIT problem but a user error :(

My sequence of test is as follows:

# root@beastie:# git clone /usr/local/pfSense/upstream/pfSense/ releng_1
<snip>
 100% (1220/1220) done
# cd releng_1/

# cat .git/remotes/origin
URL: /usr/local/pfSense/upstream/pfSense/.git
Pull: refs/heads/master:refs/heads/origin
Pull: refs/heads/avendor:refs/heads/avendor
Pull: refs/heads/Package-Reorg-2005:refs/heads/Package-Reorg-2005
Pull: refs/heads/RELENG_1:refs/heads/RELENG_1

# git branch
  Package-Reorg-2005
  RELENG_1
  avendor
* master
  origin

# git pull
Already up-to-date.

# git checkout RELENG_1

# git pull
Trying really trivial in-index merge...
fatal: Merge requires file-level merging
Nope.
Merging HEAD with c0a06b86b8431293214f5eb18e49fcb8117c6070
Merging:
997e28966d7b7964562232628cc4f64dccbead9e Execute after commands via sh &
c0a06b86b8431293214f5eb18e49fcb8117c6070 Execute after commands via sh &
found 1 common ancestor(s):
1b08ecedad1e6a7199f12d1fad97373587c85454 Minor nitpick.  <br> after
firmware branch select box

As you can see, when I switched to RELENG_1 branch and did a git pull,
I am getting errors. I am wondering where I am wrong.

raj
