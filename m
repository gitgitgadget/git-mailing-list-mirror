From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC/PATCH 1/1] format-patch: add an option to record base tree info
Date: Tue, 23 Feb 2016 14:21:59 -0800
Message-ID: <CAGZ79kYVHJFeS41yj+JymKyfKpSW4y-Wpk6ZTT4yxzprC6UQTg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>, ebiederm@xmission.com,
	Fengguang Wu <fengguang.wu@intel.com>,
	Xiaolong Ye <xiaolong.ye@intel.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, ying.huang@intel.com,
	philip.li@intel.com, julie.du@intel.com,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: linux-kernel-owner@vger.kernel.org Tue Feb 23 23:22:17 2016
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1aYLLV-0006ij-3e
	for glk-linux-kernel-3@plane.gmane.org; Tue, 23 Feb 2016 23:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbcBWWWG (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 23 Feb 2016 17:22:06 -0500
Received: from mail-io0-f182.google.com ([209.85.223.182]:35451 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755349AbcBWWWA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Feb 2016 17:22:00 -0500
Received: by mail-io0-f182.google.com with SMTP id g203so4637989iof.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Feb 2016 14:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=wGYQvmUDIZg1zXAg34X2xQ5H5tMViENYTXBSczt8raU=;
        b=Mx4B+hEgdXNoMjiH19Imy3vLHQGukr6JD1ESaVejMadqn95SypBJiTMjdFj8YJbTRK
         wFbm0mmo3uTM4DGUujut+vhzvNALjAQY8FxNGwXNYIzc/Qeiqq0TsNNdntOYDeNvcUEd
         bgCxzX3uVwKlJX6zQkVzq5mLdVRh2xckZTyJxkumTDJKsQh7VcKo3rOcNaZ1k7u44KOH
         inSd4dPAB2PYaElRcDueRgeoce/NjhQ9ICppxSXZuScC4U94Euo5IfdTdQJYDXXkvsRF
         FG2Rr0eoQ20fa3VLSGN/trqawoxLPXII0wREQsG8ClZB2JqA/GAjOvN+gHzEg2TYN1p1
         9SOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=wGYQvmUDIZg1zXAg34X2xQ5H5tMViENYTXBSczt8raU=;
        b=kpEwNDPXzynSRwgaABLpdtMWRrw5MmU7XQCUh5jZeMdivvoLXSPkAgNAXb3DM12u2E
         Z2oHuDv+xJ323di05f113+Nf81vrEuInOwgpcuTueR8U3HUJVbzCMe0Tb9mqqqOMoeiQ
         MOn4zZmfKaq6G7LosQs/QyeOd+OPk0kselVBnAXL1F9pM5ure54aU2qUsF2T6U0RoG2q
         TpXnXWK7M/Vs5y1LvukY35CQDMPeTjMSHWNxwTTqzv/WIagBJwRR4CqOqPp2MJlgupRd
         0Pdg3tV1A9YamX3zDOUzG5pOR09hwMIds7HQ2istWjKfgnz5hBYsKKrCYY1GuHRtjpda
         K82g==
X-Gm-Message-State: AG10YOQHwJ9+rneuGLPA8WW2eEqF5/TTOZOcbGIWRKTq4/fqK7/qNb2AVWFHeZqwFGiW73Q+8E2bazboFdpPgg9Q
X-Received: by 10.50.92.68 with SMTP id ck4mr8051416igb.93.1456266120121; Tue,
 23 Feb 2016 14:22:00 -0800 (PST)
Received: by 10.107.4.210 with HTTP; Tue, 23 Feb 2016 14:21:59 -0800 (PST)
In-Reply-To: <3FAB2030-8106-4114-99A4-B04A8A0D22FB@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287134>

On Tue, Feb 23, 2016 at 12:46 PM, H. Peter Anvin <hpa@zytor.com> wrote:
> On February 23, 2016 12:35:12 PM PST, Junio C Hamano <gitster@pobox.com> wrote:
>>ebiederm@xmission.com (Eric W. Biederman) writes:
>>
>>> Junio C Hamano <gitster@pobox.com> writes:
>>>
>>>> It is valuable for a testing organization to say "We tested this
>>>> series on top of version X.  We know it works, we have tested on a
>>>> lot more hardware than the original developer had, we know this is
>>>> good to go."  It is a valuable service.
>>>>
>>>> But that is valuable only if version X is still relevant, isn't it?
>>>>
>>>> Is the relevance of a version something that is decided by a
>>>> developer who submits a patch series, or is it more of an attribute
>>>> of the project and where the current integration is happening?
>>>> Judging from the responses from Dan to this thread, I think the
>>>> answer is the latter, and for the purpose of identifying the
>>>> relevant version(s), the project does not even care about the exact
>>>> commit, but it wants to know more about which branch the series is
>>>> targetted to.
>>>>
>>>> With that understanding, I find it hard to believe that it buys the
>>>> project much for the "base" commit to be recorded in a patch series
>>>> and automated testing is done by applying the patches to that exact
>>>> commit, which possibly is no-longer-relevant, even though it may
>>>> help shielding the testing machinery from "you tested with a wrong
>>>> version" complaints.
>>>>
>>>> Isn't it more valuable for the test robot to say "this may or may
>>>> not have worked well with whatever old version the patch series was
>>>> based on, but it no longer is useful to the current tip of the
>>>> 'master'"?  If you consider what benefit the project would gain by
>>>> having such a robot, that is the conclusion I have to draw.
>>>>
>>>> So I still am not convinced that this "record base commit" is a
>>>> useful thing to do.
>>>
>>> So I don't know what value this has to the git project.
>>
>>Oh, don't worry, I wasn't talking about value this may have to the
>>Git project at all.  "The value to the project" I mentioned in my
>>response was all about the value to the kernel project.
>>
>>> The value of Fengguag's automated testing to the kernel project is to
>>> smoke out really stupid things.
>>
>>I'll snip your bullet points, but as I wrote, I do understand the
>>value of prescreening test.
>>
>>What I was questioning was what value it gives to that testing to
>>use "the developer based this patch on this exact commit" added to
>>each incoming patch, and have Fengguag's testing machinery test a
>>patch with a base version that may no longer be relevant in the
>>context of the project.  Compared to that, wouldn't "this no longer
>>applies to the branch the series targets" or "this still applies
>>cleanly, but no longer compiles because the surrounding API has
>>changed" be much more valuable?
>>
>>In your other message, you mentioned the "index $old..$new" lines,
>>and it is possible to use them to find a tree that the patch cleanly
>>applies to, but it will not uniquely identify _the_ version the
>>patch submitter used.  IMHO, finding such _a_ tree from the recent
>>history of the branch that the patch targets and testing the patch
>>on top of that tree (as opposed to testing the patch in the exact
>>context the developer worked on) would give the project a better
>>value.
>
> Personally, as a maintainer, I would love to see the tree ID and ideally also the commit ID a series is based on.  The commit ID is in some ways less useful since it is non-recreatable (and therefore will never match for anything but the first patch of a series), but could be useful to the maintainer.

As a contributor a commit id would also add value I would think. When
it is unclear
where a series is headed, contributors in Git land say things like:

    This applies cleanly on origin/master.

And usually this is the master branch from yesterday as Junio pushes
once a day. origin/master being a moving target, so it may not apply any more,
so a commit sha1 would help for finding out what to do in the maintainer role.

This discussion sounds to me as if we'd want to have some advantages of
the (kernel pull style, not github style) pull-request here for patch
submissions.

I don't remember the exact quote, but Linus said once upon a time about the
pull request workflow roughly:

    "Please pull from ... And by the way I tested this software for 2
month during development"
    (For kernels that makes sense as the contributor run the kernel
and it worked)

as pull requests have the new patches on top of the exact parents the
contributor put them
on, there can be more faith in the process to divide between the
problems the contributor
overlooked/introduced and problems as introduced by the merge of the maintainer.

Now when applying patches at another parent than the contributor
developed on, some
subtle problems may arise, which are not easily spotted by compile
tests or running the
test suite.

Maybe this could be solved by a convention (similar to a sign-off line
in each patch
which is not formally checked) in the cover letter, such that we have
a both machine
and human readable format where the contributor can suggest an anchor point?
(The maintainer may ignore it, but buildbots are free to follow strictly)

Thanks,
Stefan


>
> As far as putting in a bunch of metainformation that has to be manually or semimanually obtained, there are a lot of issues with that, as it way too easily turns into wrong information or potential information leaks that might make corporate contributors uncomfortable.
> --
> Sent from my Android device with K-9 Mail. Please excuse brevity and formatting.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
