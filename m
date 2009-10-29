From: Lachlan Deck <lachlan.deck@gmail.com>
Subject: Re: git svn branch tracking + ignore paths
Date: Thu, 29 Oct 2009 12:53:05 +1100
Message-ID: <D9663C6B-AF5E-4267-9E31-F1584D912461@gmail.com>
References: <41F0F1D6-4F99-4828-9259-1B2BDC689747@gmail.com>  <32541b130910271616ha861d08xa4b90b822d31f0ea@mail.gmail.com>  <AC7B0CB1-1B14-4EAE-A6B6-D0845EACE626@gmail.com> <32541b130910272220p59482397wef0d51b1adf1a5bd@mail.gmail.com>  <19979334-07EB-48CA-8E62-4ECC5E1FA51C@gmail.com> <32541b130910280900p421e69b1nbcd8dcfa211521ac@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git list <git@vger.kernel.org>
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 02:53:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3KCW-0002tJ-JR
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 02:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755053AbZJ2BxJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 21:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbZJ2BxI
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 21:53:08 -0400
Received: from mail-yw0-f202.google.com ([209.85.211.202]:54793 "EHLO
	mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbZJ2BxH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 21:53:07 -0400
Received: by ywh40 with SMTP id 40so1266048ywh.33
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 18:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:mime-version
         :content-type:from:in-reply-to:date:cc:content-transfer-encoding
         :message-id:references:to:x-mailer;
        bh=Y9FeGVrpqplqU59xxd04qJad25XZJOuk+HniyqhZNV0=;
        b=hzI4WEDCK6SopO/zhgG9T1Yca4hmX/5ww6WJKKv4bavrXd53ILQpSmZCGr6aF5SsEu
         gt75KeKPB/+VEfPsE5YLpLEHWmPUgLItbO3tZPuFw7+rc0TpdFbS6NKzwi9fVxQIUje7
         trKvg4YafqmxITRyWb05smWuc+ak+D+HE2Tmc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        b=QvDbQt3tIvn9Rv/wg6H5a1Tp+b//srxIC4g7em2GEqe858mYb4+Q/I0Pi/BM8D+zfg
         9ijuBM9iaGgVsVTT4f9GYlQiRnQOZqQAcN18Q3EipiqPiEDYWXFeDZkrtUxcveEhQHI/
         72gEsv8GZz4YbKCG/ZwnR4s6cUB1LRZhUy6lo=
Received: by 10.150.76.7 with SMTP id y7mr2415093yba.238.1256781191560;
        Wed, 28 Oct 2009 18:53:11 -0700 (PDT)
Received: from ip-144.ish.com.au (ip-144.ish.com.au [203.29.62.144])
        by mx.google.com with ESMTPS id 16sm124084gxk.15.2009.10.28.18.53.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 18:53:10 -0700 (PDT)
In-Reply-To: <32541b130910280900p421e69b1nbcd8dcfa211521ac@mail.gmail.com>
X-Mailer: Apple Mail (2.1076)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131548>

On 29/10/2009, at 3:00 AM, Avery Pennarun wrote:

> On Wed, Oct 28, 2009 at 1:59 AM, Lachlan Deck  
> <lachlan.deck@gmail.com> wrote:
>> On 28/10/2009, at 4:20 PM, Avery Pennarun wrote:
>>> So which are the files you don't want to import from trunk?  It
>>> doesn't sound like there are any... so it's getting simpler already.
>>
>> There are. I've currently (as a workaround) done the following  
>> within the
>> main branch:
>> add the following to .git/info/exclude
>> .settings
>> target
>> .classpath
>> .project
>>
>> The last two of these has no effect of course because .project and
>> .classpath files already exist -- and thus are marked as modified.  
>> So I'm
>> currently doing a git stash && git svn rebase && git svn dcommit &&  
>> git
>> stash pop
>>
>> I'm also wanting to exclude 'lib' folders from trunk (as these are  
>> not
>> needed).
>
> The problem is that as your branch diverges from what you *actually*
> want to commit, it becomes exponentially more complicated to figure
> out what you *do* want to commit.

Sure.

> Note that if you're planning to share your git project with other
> people anyway, then you have an additional problem: you're using git
> svn rebase, which is almost useless for sharing with other people
> (other than through svn, of course), for the same reason any git
> rebase is.
>
> One option you have is to maintain two branches:
>
> 1. (git-svn) The git-svn trunk, which contains only stuff you want  
> upstream
>
> 2. (master) Your live branch, which contains everything from (1) plus
> your local customizations.
>
> When you want to fetch from svn, you do this:
>
>  git checkout master
>  git svn fetch git-svn
>  git merge git-svn
>
> When you want to push to svn, you do this:
>
>  git checkout git-svn
>  git merge --squash --no-commit master
>    (now undo your local customizations)
>  git commit
>  git svn dcommit
>  git checkout master
>  git merge git-svn
>
> Note that master never gets rebased, only merged.  If you can write a
> simple script for "undo your local customizations" - such as reverting
> a particular commit, for example - then you can put the above in a
> shell script and it should work fine most of the time.

Thanks Avery!
  - that gives me something to think about.

with regards,
--

Lachlan Deck
