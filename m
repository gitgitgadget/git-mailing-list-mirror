From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: clarify git clone --local --shared --reference
Date: Fri, 08 Jun 2007 13:35:58 -0500
Message-ID: <4669A18E.4080702@nrlssc.navy.mil>
References: <4664A5FE.30208@nrlssc.navy.mil> <20070605045008.GC9513@spearce.org> <46658F98.6020001@nrlssc.navy.mil> <20070606051111.GF9513@spearce.org> <466701E0.4000108@nrlssc.navy.mil> <20070608053750.GB18521@spearce.org> <AF0367BA48C55940A43CCF08DF35553C013C76BF@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Loeliger Jon-LOELIGER <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Fri Jun 08 20:36:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwjJn-0003BB-Oa
	for gcvg-git@gmane.org; Fri, 08 Jun 2007 20:36:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbXFHSgO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Jun 2007 14:36:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968169AbXFHSgO
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Jun 2007 14:36:14 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57914 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966434AbXFHSgN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jun 2007 14:36:13 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l58IXmpU027277;
	Fri, 8 Jun 2007 13:33:51 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 8 Jun 2007 13:35:58 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <AF0367BA48C55940A43CCF08DF35553C013C76BF@az33exm24.fsl.freescale.net>
X-OriginalArrivalTime: 08 Jun 2007 18:35:58.0936 (UTC) FILETIME=[DB974D80:01C7A9FB]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15224001
X-TM-AS-Result: : Yes--7.747200-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE1MDY2OC0xNTA2?=
	=?us-ascii?B?NzMtMTQ3MDE4LTcwMTI5Mi03MDAwNzUtMTM5MDEwLTcwMjU3Mi03?=
	=?us-ascii?B?MDAxNjAtNzAyMDQ0LTcwNDQ5Ni03MDE1NzYtNzAxNzE5LTcwMTM5?=
	=?us-ascii?B?NC0xODgwMTktNzA0OTI3LTcwNDQyNS03MDE0MzctNzAyNDc0LTcw?=
	=?us-ascii?B?MTczOC03MDkxMzctNzA0OTgwLTcwMjc2Mi03MTE5NTMtNzA3NDEw?=
	=?us-ascii?B?LTcwNTczMy03MDI0NDUtMTE0MTMxLTcwMjEzMS03MDM3ODgtNzA1?=
	=?us-ascii?B?OTAxLTcwNzExOS03MDIzNTgtMTIxMTEwLTcwNzEwNC03MDUzODgt?=
	=?us-ascii?B?NzAwNzgyLTcwMjM3Ni0xMzk1MDQtNzAxNDU1LTcwMzQxNy03MDM3?=
	=?us-ascii?B?MTItNzAyNzI2LTcwMTQ1MC0xMDU3MDAtMTIxNTg4LTcwMTU5MC03?=
	=?us-ascii?B?MDQ4ODUtMTQ4MDUxLTIwMDQz?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49491>

Loeliger Jon-LOELIGER wrote:
> Shawn O. Pearce wrote:
>> Brandon Casey <casey@nrlssc.navy.mil> wrote:
>>> ok. I just want to make sure this is not really about prune'ing.
>>>
>>> In the following, source and --shared repos are identical except...
>>> 1) Source repo contains loose objects which are new commits.
>>>    --shared repo does git-pull.
>>>    we fast-forward, copying very little.
>>>    success.
>> Copying nothing actually.  All of the objects required are in the
>> source repository, so --shared needs nothing additional.
> 
> So the thing I find myself wanting to do is
> A "crib from local copy".  That is, the network
> Cost is large, so when cloning point to a local
> (ie, already on same Filesystem) clone that is
> Similar, use it as a reference, but, in the end,
> Create a complete copy into the new repository.
> 
> I don't want it hard linked with --local.
> I don't want it shared with --shared.
> I don't want it as an altrnate source with --reference.
> 
> What I want is a new, clean, complete, unshared repository.
> 
> But for efficiency reasons, I want to grab objects
> From a different, filesystem-local clone if possible.
> 
> Does that work?

I don't think that exact behavior is implemented yet, but...

If the filesystem-local repo is pure subset version of the source repo 
you could do this:

(assuming the filesystem-local repo is on branch master, and that is 
what you want)
git clone -l <filesystem-local repo> <my_new_repo>
cd <my_new_repo>
git pull <source-repo>

No reason not to use -l on clone in this case IMO.

Otherwise...
If the filesystem-local repo has changes past the master HEAD on source 
repo that you are not necessarily interested in...

1) git clone -l -n <filesystem-local repo> <my_new_repo>
2) cd <my_new_repo>
3) git fetch <source_repo> master:tmp
4) git branch -M tmp master
5) git checkout master

1) Here we use -l to encourage hard linking (no reason not to IMO),
    and tell clone not (-n) to checkout the active branch.
3) Now fetch the master branch from the source_repo and store into
    a new branch named tmp.
4) Rename tmp to master.
5) Checkout the files.
- Now the HEAD of master branch is at the same commit as the
   source_repo.

One drawback is that origin is now tracking the filesystem-local repo, 
so a git pull without supplying a repo will pull from filesystem-local repo.

-brandon
