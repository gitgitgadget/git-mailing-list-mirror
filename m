From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree
 info
Date: Wed, 24 Feb 2016 11:31:29 +0100
Message-ID: <56CD8681.9010308@drmicha.warpmail.net>
References: <1456109938-8568-1-git-send-email-xiaolong.ye@intel.com>
 <1456109938-8568-2-git-send-email-xiaolong.ye@intel.com>
 <xmqqmvqt8jgz.fsf@gitster.mtv.corp.google.com>
 <20160223014741.GA21025@wfg-t540p.sh.intel.com>
 <xmqqio1f3oi9.fsf@gitster.mtv.corp.google.com>
 <20160223091740.GA3830@wfg-t540p.sh.intel.com>
 <xmqq1t8319z0.fsf@gitster.mtv.corp.google.com>
 <87d1rnjil4.fsf@x220.int.ebiederm.org>
 <xmqqtwkzyxkv.fsf@gitster.mtv.corp.google.com>
 <3FAB2030-8106-4114-99A4-B04A8A0D22FB@zytor.com>
 <CAGZ79kYVHJFeS41yj+JymKyfKpSW4y-Wpk6ZTT4yxzprC6UQTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, ebiederm@xmission.com,
	Fengguang Wu <fengguang.wu@intel.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 24 11:31:52 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYWjX-0003od-Fg
	for glk-linux-kernel-3@plane.gmane.org; Wed, 24 Feb 2016 11:31:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755727AbcBXKbi (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 24 Feb 2016 05:31:38 -0500
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:56557 "EHLO
	out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753032AbcBXKbd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Feb 2016 05:31:33 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
	by mailout.nyi.internal (Postfix) with ESMTP id 7035020EA5
	for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2016 05:31:32 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 24 Feb 2016 05:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=XvjHugYdprxyGt5UJutRY0kkQpE=; b=dJHvcQ
	zGeFP18VYLgOKl7qDX5u9YKy41ZvdMXagJq4H/mudblqahyBUMyUBcm/71hmZXRc
	bHSCzyvWbAePA+3/aFTliZf3YPBUw/RipT3zfgstOSGlq5tREEl/UyVXMKlP7IBP
	DFwA6X8XFjptaB8yTLXy05hMkYdrUTF+5px2k=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=XvjHugYdprxyGt5
	UJutRY0kkQpE=; b=KLclJzzmrPwdFJATna6XZGjMyU/nLOlLpN0+6EA1Gi+ZhY1
	onTnq6Dm2JbxEeOpkoLVOwydh9+vNBNE6MNrAc+aw62L6hx/5+z44BqbV6x9TZUy
	v4+twiCYBeX1hI5zNoVG8x+Tq9T6lTrUfX7q0FZNbDY1gOqNkpN89i3x0FSg=
X-Sasl-enc: tcdbNsyhxMtXNLcO7+vsha7BFynFy2mQfEf6OenNHvnF 1456309892
Received: from skimbleshanks.math.uni-hannover.de (skimbleshanks.math.uni-hannover.de [130.75.46.4])
	by mail.messagingengine.com (Postfix) with ESMTPA id 700A9C0001D;
	Wed, 24 Feb 2016 05:31:30 -0500 (EST)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <CAGZ79kYVHJFeS41yj+JymKyfKpSW4y-Wpk6ZTT4yxzprC6UQTg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287193>

Stefan Beller venit, vidit, dixit 23.02.2016 23:21:
> On Tue, Feb 23, 2016 at 12:46 PM, H. Peter Anvin <hpa@zytor.com> wrote:
>> On February 23, 2016 12:35:12 PM PST, Junio C Hamano <gitster@pobox.com> wrote:
>>> ebiederm@xmission.com (Eric W. Biederman) writes:
>>>
>>>> Junio C Hamano <gitster@pobox.com> writes:
>>>>
>>>>> It is valuable for a testing organization to say "We tested this
>>>>> series on top of version X.  We know it works, we have tested on a
>>>>> lot more hardware than the original developer had, we know this is
>>>>> good to go."  It is a valuable service.
>>>>>
>>>>> But that is valuable only if version X is still relevant, isn't it?
>>>>>
>>>>> Is the relevance of a version something that is decided by a
>>>>> developer who submits a patch series, or is it more of an attribute
>>>>> of the project and where the current integration is happening?
>>>>> Judging from the responses from Dan to this thread, I think the
>>>>> answer is the latter, and for the purpose of identifying the
>>>>> relevant version(s), the project does not even care about the exact
>>>>> commit, but it wants to know more about which branch the series is
>>>>> targetted to.
>>>>>
>>>>> With that understanding, I find it hard to believe that it buys the
>>>>> project much for the "base" commit to be recorded in a patch series
>>>>> and automated testing is done by applying the patches to that exact
>>>>> commit, which possibly is no-longer-relevant, even though it may
>>>>> help shielding the testing machinery from "you tested with a wrong
>>>>> version" complaints.
>>>>>
>>>>> Isn't it more valuable for the test robot to say "this may or may
>>>>> not have worked well with whatever old version the patch series was
>>>>> based on, but it no longer is useful to the current tip of the
>>>>> 'master'"?  If you consider what benefit the project would gain by
>>>>> having such a robot, that is the conclusion I have to draw.
>>>>>
>>>>> So I still am not convinced that this "record base commit" is a
>>>>> useful thing to do.
>>>>
>>>> So I don't know what value this has to the git project.
>>>
>>> Oh, don't worry, I wasn't talking about value this may have to the
>>> Git project at all.  "The value to the project" I mentioned in my
>>> response was all about the value to the kernel project.
>>>
>>>> The value of Fengguag's automated testing to the kernel project is to
>>>> smoke out really stupid things.
>>>
>>> I'll snip your bullet points, but as I wrote, I do understand the
>>> value of prescreening test.
>>>
>>> What I was questioning was what value it gives to that testing to
>>> use "the developer based this patch on this exact commit" added to
>>> each incoming patch, and have Fengguag's testing machinery test a
>>> patch with a base version that may no longer be relevant in the
>>> context of the project.  Compared to that, wouldn't "this no longer
>>> applies to the branch the series targets" or "this still applies
>>> cleanly, but no longer compiles because the surrounding API has
>>> changed" be much more valuable?
>>>
>>> In your other message, you mentioned the "index $old..$new" lines,
>>> and it is possible to use them to find a tree that the patch cleanly
>>> applies to, but it will not uniquely identify _the_ version the
>>> patch submitter used.  IMHO, finding such _a_ tree from the recent
>>> history of the branch that the patch targets and testing the patch
>>> on top of that tree (as opposed to testing the patch in the exact
>>> context the developer worked on) would give the project a better
>>> value.
>>
>> Personally, as a maintainer, I would love to see the tree ID and ideally also the commit ID a series is based on.  The commit ID is in some ways less useful since it is non-recreatable (and therefore will never match for anything but the first patch of a series), but could be useful to the maintainer.
> 
> As a contributor a commit id would also add value I would think. When
> it is unclear
> where a series is headed, contributors in Git land say things like:
> 
>     This applies cleanly on origin/master.
> 
> And usually this is the master branch from yesterday as Junio pushes
> once a day. origin/master being a moving target, so it may not apply any more,
> so a commit sha1 would help for finding out what to do in the maintainer role.
> 
> This discussion sounds to me as if we'd want to have some advantages of
> the (kernel pull style, not github style) pull-request here for patch
> submissions.
> 
> I don't remember the exact quote, but Linus said once upon a time about the
> pull request workflow roughly:
> 
>     "Please pull from ... And by the way I tested this software for 2
> month during development"
>     (For kernels that makes sense as the contributor run the kernel
> and it worked)
> 
> as pull requests have the new patches on top of the exact parents the
> contributor put them
> on, there can be more faith in the process to divide between the
> problems the contributor
> overlooked/introduced and problems as introduced by the merge of the maintainer.
> 
> Now when applying patches at another parent than the contributor
> developed on, some
> subtle problems may arise, which are not easily spotted by compile
> tests or running the
> test suite.
> 
> Maybe this could be solved by a convention (similar to a sign-off line
> in each patch
> which is not formally checked) in the cover letter, such that we have
> a both machine
> and human readable format where the contributor can suggest an anchor point?
> (The maintainer may ignore it, but buildbots are free to follow strictly)
> 
> Thanks,
> Stefan

Thanks for mentioning pull-requests. In fact: Is there any problem (in
the OP's use case) that would not be solved by pull-requests?

In other words: Are we talking "pull-request by format-patch"?

[Still trying to figure out what problem to solve exactly, and how
generic that is.]

Michael
