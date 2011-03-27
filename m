From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: start of git2 (based on libgit2)
Date: Sun, 27 Mar 2011 11:56:04 +0200
Message-ID: <4D8F09B4.7030602@lyx.org>
References: <20110325231203.GA7961@jakstys.lt> <4D8D2B31.4040908@lyx.org> <20110326132915.GA2859@sigill.intra.peff.net> <7v62r52c85.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?windows-1252?Q?Motiejus_Jak=9Atys?= <desired.mta@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 27 11:56:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3mht-0007b7-Ny
	for gcvg-git-2@lo.gmane.org; Sun, 27 Mar 2011 11:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752945Ab1C0J4G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Mar 2011 05:56:06 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41683 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911Ab1C0J4F (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Mar 2011 05:56:05 -0400
Received: by wya21 with SMTP id 21so2129637wya.19
        for <git@vger.kernel.org>; Sun, 27 Mar 2011 02:56:03 -0700 (PDT)
Received: by 10.227.140.32 with SMTP id g32mr2681180wbu.83.1301219762831;
        Sun, 27 Mar 2011 02:56:02 -0700 (PDT)
Received: from [192.168.101.108] (62-193-62-123.stella-net.net [62.193.62.123])
        by mx.google.com with ESMTPS id ed10sm1395263wbb.49.2011.03.27.02.56.00
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 27 Mar 2011 02:56:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7v62r52c85.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170079>

> I agree that for a summer student project, aiming at basic stuff makes
> more sense than trying to chew a large bite that cannot be managed within
> the timeframe and not achieving anything

If things will be working out, I will at least not disappear after the 
summer. I'm quite new here, but I'd like to help out in coordinating the 
student(s) and to continue with it after summer (if the student(s) do 
not stick to the git development). I'm still missing quite some 
knowledge about git, but I hope that will come with time.

> "A..B" requires you to walk the ancestry chain. Limiting history with
> pathspec while simplifying merges needs to use the tree-diff machinery;
> and filtering commits by looking at the message with "--grep" needs to
> call into the grep machinery.  Depending on how much libgit2 has already
> covered the basic blocks, even the above list might be too much, I am
> afraid.

Yes, it would be important to understand how much already is covered by 
libgit2. If someone could shed some light on this (see also my message 
on the libgit2@librelist.org mailing list).

> A good news is

[..] still re-reading this paragraph to find out what the actual 'good' 
part of this news is ;)...[..]

> that among the larger and more important basic building
> blocks in C git, there is only one part that was designed from day one to
> disregard the reusability and instead aimed for speed and simplicity, and
> that is the history and object walking. The way the in-core object pool is
> managed and especially the way per-object flags are designed to be used
> clearly show that the revision walker machinery can take it granted that
> the calling programs are run-once-and-clean-via-exit.

That's what I meant with my previous message. I was not aiming to 
implement all exotic features, but I think that it would be a good 
design if git and git2 share a lot together and only differ in how they 
actually use the git/libgit backend. As part of the process, the git 
code can be adjusted as well to "libify" it (as it was called in another 
thread).

Vincent
