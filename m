From: Eric Gillum <eric@color.com>
Subject: Re: git rebase keeps saying local changes would conflict..what changes?
Date: Thu, 21 Jun 2012 14:11:04 -0700
Message-ID: <890895A7-9DB5-4FD5-A45B-03151236FD70@color.com>
References: <D8381FF2-A6B4-4596-B565-7E5BB3F239D8@color.com> <2652085F-C1BC-4EAB-9289-F508E64982F0@color.com> <20120615160813.GB4572@sigill.intra.peff.net>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Eric Gillum <eric@color.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 21 23:11:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Shoeo-0003TT-1t
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jun 2012 23:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760306Ab2FUVLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jun 2012 17:11:08 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:63248 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760297Ab2FUVLH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Jun 2012 17:11:07 -0400
Received: by dady13 with SMTP id y13so1409222dad.19
        for <git@vger.kernel.org>; Thu, 21 Jun 2012 14:11:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer
         :x-gm-message-state;
        bh=U+sHsX3Sd1gY2Rk+soJsSeMFrAh4Xe50MAZE9pOBSt4=;
        b=BmafY9ArJVh1IKWsS2rIqhAAUjqsK8JkEG1de+eNKvNd1q/tbeuVLav2CnzMTPw3eN
         cWirzGoCbBDqYeNGJBIp5Q2CcAUrDNA1QI9Wr6igEuYWqAwK/3Dh/kNo2Y7sOd1SNh5i
         IcTPhrxyYmhHV1rMBkJ6+XXFf/KWEwz26UF32yYM3myyEPZ1QhnCuq62KYlANNEdBJce
         ADOBss4sti2UImXMMWpt2peXHDk6CXCEW8cU4Bj7evF13NlP58CM25fi12h5qNbSKt82
         IQ6jOQ/7JMz0HPoiOMS3qsOQ2MdhKG9CieI1IuS7jM4Z+P8WFaxzmQExaC9r6I4sMdbQ
         hq/w==
Received: by 10.68.241.8 with SMTP id we8mr2128642pbc.130.1340313067111;
        Thu, 21 Jun 2012 14:11:07 -0700 (PDT)
Received: from [10.0.3.163] ([65.50.211.37])
        by mx.google.com with ESMTPS id io2sm36719955pbc.24.2012.06.21.14.11.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 21 Jun 2012 14:11:06 -0700 (PDT)
In-Reply-To: <20120615160813.GB4572@sigill.intra.peff.net>
X-Mailer: Apple Mail (2.1278)
X-Gm-Message-State: ALoCoQlZ/K/GImA/6TYSHMDjyUUR4cWRQF2cNCoO+/uo/3PLAoqXXDAw49P4QhaHvTr8c9KDOHvI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200416>

Hi,

It finally happened again today. I avoided git status and instead ran git diff-files, which showed a mix of files that had been edited today (only on the branch) and files that had been edited days ago (only on the branch). This particular rebase claimed that the files that had been edited days ago were the ones that had local changes. I don't know enough about the rebase/merge procedure to say anything. I include the output below, substituting commit messages and file names.

I've tried it with and without my editors open (including Xcode). It seems more or less "stuck" -- unable to complete the rebase -- but both the files reported as having local changes and the files reported by git diff-files are different every time (albeit always files that were edited on the branch).

> git rebase master
First, rewinding head to replay your work on top of it...
Applying: <commit1 msg>
Applying: <commit2 msg>
Applying: <commit3 msg>
Applying: <commit4 msg>
Applying: <commit5 msg>
Using index info to reconstruct a base tree...
<stdin>:124: trailing whitespace.
<stdin>:125: trailing whitespace.
<stdin>:218: trailing whitespace.
<stdin>:278: trailing whitespace.
<stdin>:310: trailing whitespace.
warning: squelched 4 whitespace errors
warning: 9 lines add whitespace errors.
Falling back to patching base and 3-way merge...
error: Your local changes to the following files would be overwritten by merge:
	<file1>
	<file2>
	<file3>
	<file4>
Please, commit your changes or stash them before you can merge.
Aborting
Failed to merge in the changes.
Patch failed at 0005 <commit5 msg>.

When you have resolved this problem run "git rebase --continue".
If you would prefer to skip this patch, instead run "git rebase --skip".
To check out the original branch and stop rebasing run "git rebase --abort".

> git diff-files
:100644 100644 57156597cffa5f962030ed08a02ce58ddadd4034 0000000000000000000000000000000000000000 M	<file5>
:100644 100644 7e5864955f6fab817e9345487d536f9917c1f59d 0000000000000000000000000000000000000000 M	<file6>
:100644 100644 fe43d7699d63b305796bbbcd2ca7f1203f55c357 0000000000000000000000000000000000000000 M	<file7>
:100644 100644 952efbee4ef3de93e18ee714927c4e62280f0474 0000000000000000000000000000000000000000 M	<file1>
:100644 100644 e0200cb978e136ed04a173019bf233d048bdbb9f 0000000000000000000000000000000000000000 M	<file2>
:100644 100644 ec0f2e8113f3041e79d47f73f06932317c29b757 0000000000000000000000000000000000000000 M	<file8>
:100644 100644 f3118e5a547624ed3adf3adc569ccf819828f0f3 0000000000000000000000000000000000000000 M	<file9>
:100644 100644 4fb2917de4fcd8f4dbe5f4c4e9bdf23b8e821bc4 0000000000000000000000000000000000000000 M	<file3>
:100644 100644 9f4a78d31b6d0f73449eebe847beffa1795460ca 0000000000000000000000000000000000000000 M	<file4>
:100644 100644 20d3e4dad060c94d1d99f92b9cd67875a31f08d6 0000000000000000000000000000000000000000 M	<file10>
:100644 100644 6e59bdd1deaf98a9582c703dc38e68949f871c10 0000000000000000000000000000000000000000 M	<file11>


On Jun 15, 2012, at 9:08 AM, Jeff King wrote:

> On Thu, Jun 14, 2012 at 04:49:54PM -0700, Eric Gillum wrote:
> 
>> Just found a similar problem here:
>> http://stackoverflow.com/questions/5074136. I do use Xcode, which may
>> be related. Maybe I'll try the proposed solution. But I'd still love
>> to know what the issue is, or how I can help debug it.
> 
> Reading that thread, one answer mentions that Xcode may overwrite files
> in the middle of your rebase. There is no git fix for that; tweaking
> files in the middle of a git operation can only lead to bad and
> confusing results.
> 
> Turning off trustctime only makes sense if Xcode is touching the file
> metadata but not modifying the file at all. Is that what's happening?
> 
> Further confusing to me is that the original poster there mentioned that
> the dirty state is untracked files in the working directory. But ctime
> shouldn't be involved at all, then. It sounds more like tracked files
> were not deleted when we switched away from the branch (either because
> of a bug in git, or because something like Xcode is re-creating them
> behind our back).
> 
>>> I have a sometimes-reproducible issue when trying to rebase. In
>>> short, I've created a local branch B off of master, made several
>>> commits on B, switched to master and pulled, switched back to B,
>>> then tried "git rebase master", which fails. What I get about half
>>> the time is a failure that claims I have local changes to files that
>>> would be overridden by the merge. Nothing is reported by git status
>>> (I've even tried closing all editors), so I am forced to do git
>>> rebase --abort or --skip.
> 
> Try running "git diff-files" instead of "git status". If something is
> munging the files behind git's back, then the index (which should have
> been refreshed by "git update-index --refresh" at the start of the
> rebase) will be out of date. "git status" will refresh the index itself,
> but we would not want that if we are interested in making the same
> comparison that the rebase is doing.
> 
>>> What's wrong? Why would I get the local changes warning but have no
>>> local changes? The merge conflicts tend to be within a file that has
>>> been changed multiple times on B. These "conflicts" are literally
>>> changes I've made at one point or another on B. The relevant files
>>> were never touched on master while I was working on B. And no
>>> changes on B are amends or reverts or anything remotely tricky --
>>> they're simply more changes committed with "git commit". So why
>>> would I have to "resolve conflicts"?
> 
> You shouldn't have to if there were no changes to the same areas on
> master. But if something like Xcode were externally munging files to
> some other version, then it would make sense.
> 
> -Peff
