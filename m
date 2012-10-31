From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 3/4] fast-export: don't handle uninteresting refs
Date: Wed, 31 Oct 2012 03:22:40 +0100
Message-ID: <CAMP44s1EX8AJgFyOjbr0v5mrQooCwQ_gbr2HYf32qwU_Xf7HfA@mail.gmail.com>
References: <CAMP44s3LP65XOYFg-tBe_rzT1+gXp=714C-u14mkwxY26r4b=g@mail.gmail.com>
	<CAMP44s1tFhh3Xqe9tqoDAdtwnGc=kFT6OmAreeP1nbTstweaQQ@mail.gmail.com>
	<20121030214531.GN15167@elie.Belkin>
	<CAMP44s1b+E8a0kdSgREbGzRTFy+nCw4VcjHadd3soQAXRkNzZw@mail.gmail.com>
	<20121030220717.GO15167@elie.Belkin>
	<CAMP44s3ArAQXH+-EbH4MHYaV6fTAWdwGzBdZwzn_qtCABHyonQ@mail.gmail.com>
	<20121030235506.GT15167@elie.Belkin>
	<CAMP44s1ftDijYpZW_Reu5qNi1T_L52_353ngNaRW3W1gz+k9jw@mail.gmail.com>
	<20121031010823.GX15167@elie.Belkin>
	<CAMP44s0RcbAiUmvGACxO+H-b-anQSPXxUqUuZwYRKWfrpXYeew@mail.gmail.com>
	<20121031015103.GA15167@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 03:22:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTNxF-0005mE-LJ
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 03:22:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932951Ab2JaCWl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2012 22:22:41 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:52374 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab2JaCWk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2012 22:22:40 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so974568obb.19
        for <git@vger.kernel.org>; Tue, 30 Oct 2012 19:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CDo/QA9DqgaXHsnLI4IV+6sRwhwLes45h3lrOzSXakI=;
        b=bA43nnb+KqlJrUU2uxnhq98OI8FFzYGqeVSBbJ3CTOmF6hH2/hsL0PhpGcETFAtp0B
         VpXvNEGURTq7Y0wp44gfxnD9MoxCSFJm0doV4czkwf29pVT7fKCq8BHFHYbdn9lg/+J0
         +O2z7WjYnrimBMHK1yhABsUp04r6E3vtHpQbErF4QQoevOQZtQDr3cDvfOKur/+ZN+v3
         tsYcgVZtMD7GTkRSwosi0B/PW8omIDlO7/McMk/G7rtCW5KTKENsErlNXB976HFkoWt/
         4KG1sCQplNmF4a+iYA9VXk63EEGhd1H/I6MCCzATt99AHrFPLtvjEM6qlyyuMKCyQ4JG
         QPdw==
Received: by 10.182.194.70 with SMTP id hu6mr29525648obc.4.1351650160123; Tue,
 30 Oct 2012 19:22:40 -0700 (PDT)
Received: by 10.60.4.74 with HTTP; Tue, 30 Oct 2012 19:22:40 -0700 (PDT)
In-Reply-To: <20121031015103.GA15167@elie.Belkin>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208787>

On Wed, Oct 31, 2012 at 2:51 AM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Felipe Contreras wrote:
>
>>                                                    It's not my job to
>> explain to you that 'git fast-export' doesn't work this way, you have
>> a command line to type those commands and see for yourself if they do
>> what you think they do with a vanilla version of git. That's exactly
>> what I did, to make sure I'm not using assumptions as basis  for
>> arguing, it took me a few minutes.
>
> Well no, when I run "git blame" 10 years down the line and do not
> understand what your code is doing, it is not at all reasonable to
> expect me to checkout the parent commit, get it to compile with a
> modern toolchain, and type those commands for myself.
>
> Instead, the commit message should be self-contained and explain what
> the patch does.
>
> That has multiple parts:
>
>  - first, what the current behavior is
>
>  - second, what the intent behind the current behavior is.  This is
>    crucial information because presumably we want the change not to
>    break that.
>
>  - third, what change the patch makes
>
>  - fourth, what the consequences of that are, in terms of new use
>    cases that become possible and old use cases that become less
>    convenient
>
>  - fifth, optionally, how the need for this change was discovered
>    (real-life usage, code inspection, or something else)
>
>  - sixth, optionally, implementation considerations and alternate
>    approaches that were discarded

I don't see any "Explain in detail what different commands do, even if
they are irrelevant to the patch in question because someone might
think they would get broken by this patch when in fact they wouldn't",
that might belong in the discussion, but not in the commit message,
and certainly not in the form of any entitlement.

Again, it's _your_ responsibility to make sure the commands you say
might get broken do actually work with your current git, it's not mine
to run them for you, even though that's exactly what I did, because
I'm interested in getting things correctly on record.

And FTR, since you removed it, here is what I proposed to add to the
commit message:

---
The reason this happens is that before traversing the commits,
fast-export checks if any of the refs point to the same object, and
any duplicated ref gets added to a list in order to issue 'reset'
commands after the traversing. Unfortunately, it's not even checking
if the commit is flagged as UNINTERESTING. The fix of course, is to do
precisely that.
---

With that, all the points above are tackled, except fourth, because
there aren't any.

Cheers.

-- 
Felipe Contreras
