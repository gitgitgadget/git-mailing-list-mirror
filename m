Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D02EA1F461
	for <e@80x24.org>; Fri,  6 Sep 2019 20:07:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394372AbfIFUHU (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 16:07:20 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40780 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730769AbfIFUHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 16:07:20 -0400
Received: from [92.7.169.237] (helo=[192.168.1.22])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1i6KVo-0006Ao-Cl; Fri, 06 Sep 2019 21:07:17 +0100
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Cc:     Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
 <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
 <20190904224821.mgh4srhc22grkraz@yadavpratyush.com>
 <CAGr--=J1YmMbud4tcZjAZ06m0CmRbAqQTzs+FTgeJkJp4d2FzQ@mail.gmail.com>
 <CAKPyHN1VeK4bR3Dn5yjrs2UwT5XGKOPU_FHaMBsP+riM-bjeWA@mail.gmail.com>
 <CAGr--=JpsgESv8W90-iT11VCAD3xQYipN3+Tt7cNyeZrsvhP_Q@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <ed572a47-b3d1-028f-0576-aac6c922671e@iee.email>
Date:   Fri, 6 Sep 2019 21:07:15 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAGr--=JpsgESv8W90-iT11VCAD3xQYipN3+Tt7cNyeZrsvhP_Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Birger,

On 06/09/2019 15:08, Birger Skogeng Pedersen wrote:
> Hi Bert,
>
>
> We should probably distinguish between what is wrapped in git-gui
> (i.e. purely visual), and what is actually wrapped in the commit
> message.
> I believe the former is referred to as "soft wrap", while the latter
> is "hard wrap".
>
>
> On Thu, Sep 5, 2019 at 7:46 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
>> Please exclude the first line, i.e., the subject. This should not be
>> wrapped at all.
> I think all lines should be soft wrapped. Scrolling sideways is just
> not something I'd want to do in the gui.
>
> How about we soft wrap all lines (in gui). But when the commit is
> created, the actual hard wrap (newline characters) happens only on
> lines other than the first one?

Not sure if I parsed this correctly, but I'd want a WYSIWYG approach 
that if we wrap on the display it will be wrapped (newline char) in the 
commit. It sounded as if you were proposing a soft wrap visually, but 
not doing the same for the commit.

Personally, I've had both feelings with the gui. I like that the 'hard' 
visual char limit is there that encourages me to wrap my messages.
But at the same time if I'm typing on a flow then it's annoying that 
there wasn't any auto wrap.

The other problem is if one is amending a commit and I need to add a few 
word mid paragraph, the manual re-flowing and manual wrapping can be 
annoying.

I suspect there is a moderately happy medium between the two, perhaps 
with an autowrap key (per paragraph) being available.

I also had it in my head that some parts of Git do allow more than a 
single line headers, or at least can cope with a run-on second line 
before the blank line that flags the start of the message proper. (I may 
be wrong...)
> But then again, the user might get frustrated when the resulting
> commit message looks different than what it appeared in git-gui.
>
> Honestly I'd prefer just wrap the first line as well. If the user gets
> frustrated that the first line gets wrapped there are two options:
> - Refrain from writing such a long line
> - Disable word wrapping (it should be configurable, like you said)
Configurable wrapping point - yes, would be nice (a feeling of control, 
that I'd probably never change ;-).
>
> Thoughts?
>
>
>
> Birger
Philip
