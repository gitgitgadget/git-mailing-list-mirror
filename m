From: Santi <sbejar@gmail.com>
Subject: Re: Tracking a branch using StGIT
Date: Fri, 15 Sep 2006 13:17:23 +0200
Message-ID: <8aa486160609150417s288d6540tc8ee6aa83bbf67b4@mail.gmail.com>
References: <64de5c8b0609150120h3aeee6dcv976da13134396654@mail.gmail.com>
	 <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Rajkumar S" <rajkumars+git@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 15 13:18:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOBiW-0008B2-On
	for gcvg-git@gmane.org; Fri, 15 Sep 2006 13:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750798AbWIOLRZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Sep 2006 07:17:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWIOLRZ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Sep 2006 07:17:25 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:36825 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750798AbWIOLRY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Sep 2006 07:17:24 -0400
Received: by wx-out-0506.google.com with SMTP id s14so3110813wxc
        for <git@vger.kernel.org>; Fri, 15 Sep 2006 04:17:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=d3DF+WQPImNnwtnQmYK3KB5WB6aTHB6zegLAZ+33y6nk2Rwj069pkkYkR1LRnXbE+g8tmMqqo18moYkaBjIfgzi8opukBDper6MWQMru0giAs7dmo/Kqfdoc52If5WA/mLP1Z4VEYxgMyeB6awVxbZA3uT7c1pdiPrzHect2oeA=
Received: by 10.70.109.4 with SMTP id h4mr14451708wxc;
        Fri, 15 Sep 2006 04:17:23 -0700 (PDT)
Received: by 10.70.46.8 with HTTP; Fri, 15 Sep 2006 04:17:23 -0700 (PDT)
To: "Catalin Marinas" <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0609150342y6105d8d1o61abb1934da9f51b@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27076>

2006/9/15, Catalin Marinas <catalin.marinas@gmail.com>:
> On 15/09/06, Rajkumar S <rajkumars+git@gmail.com> wrote:
> > I am using StGIT to track a branch of a remote git repository
> > (actually a remote cvs repository, which I am tracking cvsimport)
> [...]
> > The .git/remotes/origin is
> > URL: /usr/local/pfSense/upstream/pfSense/.git
> > Pull: refs/heads/master:refs/heads/origin
> > Pull: refs/heads/avendor:refs/heads/avendor
> > Pull: refs/heads/Package-Reorg-2005:refs/heads/Package-Reorg-2005
> > Pull: refs/heads/RELENG_1:refs/heads/RELENG_1
> >
> > My requirement is to track RELENG_1 branch with StGIT while
> > maintaining my own patches. but when I do a stg pull the messages are:
> [...]
> > It seems StGIT is trying to merge the origin branch from remote to
> > RELENG_1 of local. Is there a way to get RELENG_1 of remote to merge
> > with MyBranch (clone of "RELENG_1") of local?
>
> After StGIT pops all the patches, it just calls "git pull origin". My
> understanding of GIT is that this should update local RELENG_1 with
> the remote RELENG_1 from the "origin" repository. Anything wrong with
> my assumptions?
>

No. But the it merge the first pull line in .git/remotes/origin into
the current branch. So he only has to put the RELENG_1 line the first,
as:

URL: /usr/local/pfSense/upstream/pfSense/.git
Pull: refs/heads/RELENG_1:refs/heads/RELENG_1
Pull: refs/heads/master:refs/heads/origin
Pull: refs/heads/avendor:refs/heads/avendor
Pull: refs/heads/Package-Reorg-2005:refs/heads/Package-Reorg-2005

Santi
