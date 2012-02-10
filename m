From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: nested git repos (not submodules)
Date: Fri, 10 Feb 2012 16:07:36 -0600
Message-ID: <4F359528.1060603@gmail.com>
References: <jh1vo3$7af$1@dough.gmane.org> <CAH5451mU5G-_FaPkpuhKrHAt4_5wiECj=-j9wkA_Ctb=27ncQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 23:07:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvydA-0001uA-C6
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 23:07:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760280Ab2BJWHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Feb 2012 17:07:43 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:61158 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760277Ab2BJWHn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2012 17:07:43 -0500
Received: by ggnh1 with SMTP id h1so1763027ggn.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 14:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=lvjyynVSb6QOctG7iMG0511M6X6So8PNGQDtr22M2zQ=;
        b=CPy8F6fhcUGHE1GSBsfQ5M0GOOTA2S60duOuoP6CngWnUzHXTmnrEaY7HD7tdFXcKh
         gTBaeZxPwAkmrDqNfSrstgORIYsDHDNUdL1559814orUVVsOxKl/sGUK36krmGppSNdC
         8wufW7iRe/2FXTxcYzGoq/FPAKQRJjVofbRg8=
Received: by 10.236.9.106 with SMTP id 70mr11316060yhs.118.1328911662612;
        Fri, 10 Feb 2012 14:07:42 -0800 (PST)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id g49sm11682661yhk.20.2012.02.10.14.07.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 14:07:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.26) Gecko/20120129 Thunderbird/3.1.18
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAH5451mU5G-_FaPkpuhKrHAt4_5wiECj=-j9wkA_Ctb=27ncQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190468>

On 2/9/2012 9:47 PM, Andrew Ardill wrote:

> My understanding was that such a configuration is essentially
> tracking the same set of files in two different git repositories. The
> location of the .git is not important, I could just as easily set the
> working directory of any git repository to be a folder tracked by
> another repository.
>
> My concerns would be based primarily on the different repositories
> trying to act on the same files at the same time. Ignoring the
> sub-folder completely within the encompassing repository would avoid
> that, however you might have use cases that prohibit that.
>
WORKTREE/SUBDIR/ was already tracked by WORKTREE/.git because the files 
in WORKTREE/SUBDIR/ directly correlate to WORKTREE/ files (ie., 
WORKTREE/., WORKTREE/SUBDIR2/., WORKTREE/SUBDIR3/.).  This is the 
published model.

> Out of interest, what itch are you scratching by using this model?
>
(I can only speculate) I think it was intended to ensure that he would 
only be modifying the WORKTREE/SUBDIR/ files of WORKTREE/.git.  He did 
some sequence of commands with the end result of:

(a) bare repo HISPATH/SUBDIR.git

and

(b1)
WORKTREE/.git
WORKTREE/SUBDIR/

is now

(b2)
WORKTREE/.git
WORKTREE/SUBDIR/.git

which means that the files of WORKTREE/SUBDIR are now tracked by 
WORKTREE/.git and WORKTREE/SUBDIR/.git, as you stated.

Due to a drop-dead short-term deadline, I am being compelled to "just 
deal with it" (work around the annoyances) unless there is a dire reason 
it will blow up in our faces.  At this point, (b2) is more-or-less an 
intermediate "integration repo" between (a) and (b1-canonical), and I'm 
assuming I can just jump thru some hoops to accomplish the integration 
when the time comes (unless I hear of or step on any landmines).

Now that the newsgroup has confirmed that having "a repo that tracks the 
worktree of a nested repo" is not a sound model, I can advise against it 
on a go-forward basis without being concerned that I'm not open to new 
ideas.


v/r,
neal
