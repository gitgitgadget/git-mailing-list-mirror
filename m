Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DA131F463
	for <e@80x24.org>; Wed, 11 Sep 2019 17:48:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbfIKRsX (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Sep 2019 13:48:23 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:49271 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729646AbfIKRsX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Sep 2019 13:48:23 -0400
X-Originating-IP: 1.186.12.58
Received: from localhost (unknown [1.186.12.58])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id C0E31C0004;
        Wed, 11 Sep 2019 17:48:20 +0000 (UTC)
Date:   Wed, 11 Sep 2019 23:18:13 +0530
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     Birger Skogeng Pedersen <birger.sp@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        davvid@gmail.com, Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH v5] git-gui: Add hotkeys to set widget focus
Message-ID: <20190911174813.3v2f4s7wxolkkyef@yadavpratyush.com>
References: <20190903214942.ubcbdgtphpwnaxs6@yadavpratyush.com>
 <20190904143055.11400-1-birger.sp@gmail.com>
 <20190910191217.qgb23x5tvaajppfh@yadavpratyush.com>
 <CAGr--=+9t1m-8LdVnnhkUFS0LMss0WecUjjtR=s_b98qB9qKeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGr--=+9t1m-8LdVnnhkUFS0LMss0WecUjjtR=s_b98qB9qKeA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/09/19 08:49AM, Birger Skogeng Pedersen wrote:
> Hi Pratyush,
> 
> On Tue, Sep 10, 2019 at 9:12 PM Pratyush Yadav <me@yadavpratyush.com> wrote:
> > This patch LGTM, but I'm not sure how to resolve the keybindings
> > problem. Junio suggested we have configurable keybindings, and I agree
> > with him, but until we do, something has to be agreed upon. And we also
> > need to come up with a reasonable default.
> >
> > So, I don't have any preferences for either using Alt+3 for the commit
> > message buffer, or Alt+4. Unless someone has objections, I'll go with
> > Alt+3 for the commit message buffer, and Alt+4 for the diff.
> 
> I honestly don't quite follow the argumentation to use Alt+3 for the
> commit message widget. Is Alt+4 (really) too awkward? And if it is,
> how is Alt+3 better?

It isn't really much more than personal preference.

> If you want to see it merged now (which I do, too), I propose we leave
> it at Alt+3 for the diff, and Alt+4 for the commit message buffer.

Since this entire debate essentially boils down to personal preference, 
there is no clear answer. So I'll just go with the author's 
implementation.

Do note that I fixed a small nitpick locally. Changed the subject from 
"git-gui: Add..." to "git-gui: add...".
 
> As David A. mentioned in his email[1], git-cola utilizes CTRL+J/K/L
> for navigation, maybe we should consider(?):
> Alt+i: focus unstaged
> Alt+j: focus staged
> Alt+k: focus commit widget
> Alt+l: focus diff view

David's suggestion was to try to use the vim keys, which are h,j,k,l, 
and not i,j,k,l. Also, in git-cola (I learned this from reading his 
email, I don't use git-cola myself), Ctrl+j is for focussing on the 
lower part of the UI, which is their diff viewer. j is used for moving 
down in vim. Ctrl+k focusses on the status widget, which is in the upper 
part of the UI. k is used for moving up in vim.

But we can't do something similar with git-gui. Why would Alt+k make 
more sense when bound to diff instead of the unstaged changes widget? 
Both are in the upper part of the UI. Similar argument for why Alt+j 
would make more sense bound to commit message buffer instead of the 
staged changes widget? Both are in the lower part of the UI. And you 
can't fit h or l in this similar analogy, because they don't make sense 
to me at all.

I realise that the bindings I mentioned are not what you proposed, but 
they are more in line with the vim keys.

My point being, it is not simple to bind our 4 widgets to 4 directional 
keys, unlike in git-cola where you only have an up and down.

So I don't see any reasonable bindings what would work with the 4 vim 
directional keys: h,j,k,l. Maybe I'm missing something?

-- 
Regards,
Pratyush Yadav
