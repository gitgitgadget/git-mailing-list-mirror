Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD9C1F4BD
	for <e@80x24.org>; Tue,  8 Oct 2019 17:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbfJHR7n (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Oct 2019 13:59:43 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:40569 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbfJHR7n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Oct 2019 13:59:43 -0400
Received: from localhost (unknown [1.186.12.44])
        (Authenticated sender: me@yadavpratyush.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id 53FE0100007;
        Tue,  8 Oct 2019 17:59:41 +0000 (UTC)
Date:   Tue, 8 Oct 2019 23:29:38 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>
Subject: Re: git-gui: automatically move focus to staged file before typing
 commit message?
Message-ID: <20191008175938.iqibournnxam4r6d@yadavpratyush.com>
References: <CAGr--=KMJmYtVaATFkOPcboAdkLvpZFbWAo4QAE0-uC6RL4Lqg@mail.gmail.com>
 <20190914211509.sjy6lh2rlcl32lj5@yadavpratyush.com>
 <20190914212732.plymb3vnz3dv4rmc@yadavpratyush.com>
 <CAGr--=LmhE9m9V4Dq8Zt0aXqdThzrNnWSnxWawVZiLYTKbL2ig@mail.gmail.com>
 <20190916180059.aifw5r4c4k5o5hur@yadavpratyush.com>
 <CAGr--=+SNO7GuHH-dE_ZnrJDCa8tv8EA5LMrVGwsMTRpxhzEZA@mail.gmail.com>
 <20190926193004.jspiirmb4ejxznjo@yadavpratyush.com>
 <CAGr--=Jiu-haHMX2fc8AB1uGWT1OMw5=M3_CuGWVzrYmO0uq3A@mail.gmail.com>
 <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=KXpt7GzqPpm1BCrsc1jhfaXeCT-XrWKNvq2pLtgAbSwQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/10/19 06:52PM, Birger Skogeng Pedersen wrote:
> So I kinda got this working, but only when focusing the commit message widget.

Isn't this the point of your feature? You change the view when focusing 
the commit message widget. I remember you were explicitly against doing 
it as soon as all unstaged files were staged. Did you change your point 
of view on that?
 
> I did not manage to get it working when invoking "do_add_all", (e.g.
> when pressing CTRL/CMD+i). I added this:
> 
> bind $ui_comm <$M1B-Key-i> {do_add_all;select_staged_file;break}
> bind $ui_comm <$M1B-Key-I> {do_add_all;select_staged_file;break}
> 
> But it seems that the "select_staged_file" procedure is invoked
> _before_ "do_add_all" finishes. So that's not working. All changes
> gets staged, but no staged change is selected.

Hmm, that shouldn't happen. select_staged_file should be executed 
_after_ do_add_all, not before. I haven't looked into your patches yet 
though.
 
> And I'm quite stuck. Do I send the unfinished patch, so maybe I can
> get some advice? Or is it better to just wait until I have the perfect
> patch ready?

If you are stuck on something, and want to share the WIP feature to get 
help/comments, you should mark your patches as "RFC" (Request For 
Comments). This can be done by passing the option '-rfc' to 
`git-format-patch`. This will make your subject prefix to "RFC PATCH" 
instead of just "PATCH".

And yes, it is perfectly OK to send incomplete changes as long as you 
mark them as such, and specify what you need help with.

But I see that you have already sent those patches. I'm not sure when I 
can find time to tinker around with them, so it might take me a couple 
of days to get to them.

-- 
Regards,
Pratyush Yadav
