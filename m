Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDB161F463
	for <e@80x24.org>; Tue, 10 Sep 2019 08:04:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbfIJIEO (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Sep 2019 04:04:14 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37321 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbfIJIEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Sep 2019 04:04:13 -0400
Received: by mail-pf1-f194.google.com with SMTP id y5so8326357pfo.4
        for <git@vger.kernel.org>; Tue, 10 Sep 2019 01:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JhUVEkuXnevzOo47Qx9AsxpFDnOAWuzcmNV/pZBwXXg=;
        b=JIhAmZVw2oy8VJFOdEYY24N4zzo/raxIsDFZM62y1rT/3BVXN8Wvjf5VpQFaMwj7cO
         X2qhWv7CzbL9maJpB8bEuG3ZM4HmtbjQvTr5+EZkaGpW/Ft5H7hB/ktIYK3osgiMZ13h
         IFwPD6lagfCIln+FGcKg+iyzkWNMJarOPqKdeHYxNYJW+5rUf27mACf82HWQG2t8cdJf
         H27aZXdRLET7z5YW9VXCSR/1BIeAznERIDcfqOrECcOvurr96OyP9OxlgzLHlaf+bGZx
         NaJG/VyBD5UFmAtj2VqLtQ9eJWbW92aF7Xs5/X5C0ymcgXCC2ipFTv5k1mQ8kpKCuv1v
         Tzrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JhUVEkuXnevzOo47Qx9AsxpFDnOAWuzcmNV/pZBwXXg=;
        b=i4om/pA9c1AgwQffGzs2t14ZG2AnunNgfRynMl+sSdoa2nNI0cxiwGzpjhZ56SyIjy
         0npXM61dxD9Mq/v0yPhjdT3eJJAaLjtl/bsZJIoEgHybPC8Xe3GoYXwRzcDXo3JAWL7F
         x2Rkad86VXoAWLlRnwkt2CaOYztb2m5zoMuqiC4r6dNWFhlvRi5bYMtrlduQNh8C94o+
         kwW4pJdelHUAF7e6TsSUmj28g5YPLftXgXEKlFkPT1IkxuPlnL2oACrPOEhFY3qIwadB
         /WYi++8TNwVl0lBrad5Oh5jmhsUj9vK5w+afkH3jTtneQFkWqNfH06phAsQy1UvvMDjH
         AThA==
X-Gm-Message-State: APjAAAXUo+RWLxYD6pYNzoVrhvJ1TxLXLaBIvRw5+SWI4BlLQTA7j356
        xr9JpXEzmIt4BV6qXXpa3AM=
X-Google-Smtp-Source: APXvYqyin94J9wKR8IUdgIpF5uRUOk+IWJWfvBwdj0deql7+3AeD2eUNDMHt1meN41NtrQvm44c5aA==
X-Received: by 2002:a63:c246:: with SMTP id l6mr26684160pgg.210.1568102652136;
        Tue, 10 Sep 2019 01:04:12 -0700 (PDT)
Received: from gmail.com (50-1-201-252.dsl.static.fusionbroadband.com. [50.1.201.252])
        by smtp.gmail.com with ESMTPSA id w6sm39258158pfw.84.2019.09.10.01.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2019 01:04:10 -0700 (PDT)
Date:   Tue, 10 Sep 2019 01:04:08 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Bert Wesarg <bert.wesarg@googlemail.com>,
        Git List <git@vger.kernel.org>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: Re: [PATCH 1/2] git-gui: warn if the commit message contains lines
 longer than the set limit
Message-ID: <20190910080408.GA32239@gmail.com>
References: <7da71d89f9fa987eca2e25974e4cec382c146e44.1567627609.git.bert.wesarg@googlemail.com>
 <CAPig+cSL0fpc5cVgO1soAksD2b5xadkDLG+JxiDCi5s95VRU_A@mail.gmail.com>
 <CAKPyHN3=hh7DCoyEKB9DOf=t=v=Y1bX1xVx9r6Lxy=WQb9JC-A@mail.gmail.com>
 <20190904224821.mgh4srhc22grkraz@yadavpratyush.com>
 <CAGr--=J1YmMbud4tcZjAZ06m0CmRbAqQTzs+FTgeJkJp4d2FzQ@mail.gmail.com>
 <CAKPyHN1VeK4bR3Dn5yjrs2UwT5XGKOPU_FHaMBsP+riM-bjeWA@mail.gmail.com>
 <CAGr--=JpsgESv8W90-iT11VCAD3xQYipN3+Tt7cNyeZrsvhP_Q@mail.gmail.com>
 <ed572a47-b3d1-028f-0576-aac6c922671e@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed572a47-b3d1-028f-0576-aac6c922671e@iee.email>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 06, 2019 at 09:07:15PM +0100, Philip Oakley wrote:
> Hi Birger,
> 
> On 06/09/2019 15:08, Birger Skogeng Pedersen wrote:
> > Hi Bert,
> > 
> > 
> > We should probably distinguish between what is wrapped in git-gui
> > (i.e. purely visual), and what is actually wrapped in the commit
> > message.
> > I believe the former is referred to as "soft wrap", while the latter
> > is "hard wrap".
> > 
> > 
> > On Thu, Sep 5, 2019 at 7:46 PM Bert Wesarg <bert.wesarg@googlemail.com> wrote:
> > > Please exclude the first line, i.e., the subject. This should not be
> > > wrapped at all.
> > I think all lines should be soft wrapped. Scrolling sideways is just
> > not something I'd want to do in the gui.
> > 
> > How about we soft wrap all lines (in gui). But when the commit is
> > created, the actual hard wrap (newline characters) happens only on
> > lines other than the first one?
> 
> Not sure if I parsed this correctly, but I'd want a WYSIWYG approach that if
> we wrap on the display it will be wrapped (newline char) in the commit. It
> sounded as if you were proposing a soft wrap visually, but not doing the
> same for the commit.
> 
> Personally, I've had both feelings with the gui. I like that the 'hard'
> visual char limit is there that encourages me to wrap my messages.
> But at the same time if I'm typing on a flow then it's annoying that there
> wasn't any auto wrap.
> 
> The other problem is if one is amending a commit and I need to add a few
> word mid paragraph, the manual re-flowing and manual wrapping can be
> annoying.
> 
> I suspect there is a moderately happy medium between the two, perhaps with
> an autowrap key (per paragraph) being available.
> 
> I also had it in my head that some parts of Git do allow more than a single
> line headers, or at least can cope with a run-on second line before the
> blank line that flags the start of the message proper. (I may be wrong...)


Correct, you're thinking about the subject line -- it has that
multi-line behavior.

In git-cola we use a separate LineEdit for the "Commit summary" line,
which has improved the commit messages users write and is good because
the user doesn't need to worry about the "blank line between subject and
body" Git commit message convention.

When the user presses "enter" in the subject line it jumps to the
"Extended description" TextEdit, so it still "feels" like a single
widget.  Likewise, up-arrow from the first line of the Extended
description also jumps to the summary LineEdit.  We also have a "Ctrl-L"
global hotkey to jump back to the subject line (same hotkey as Web
browsers for the "hot" action of focusing the URL).

Using two widgets is a bigger rework for git-gui, but should be
considered for future enhancement.

We also deal with the "Amend a commit" issue through the word-wrap
approach.  It's actually a paragraph reflow (not a line-by-line wrap) so
adding words is fine and easy and does the natural expected thing --
when amending it'll still feel like a long flow line and when committed
it'll wrap with newlines at the configured column.


> > But then again, the user might get frustrated when the resulting
> > commit message looks different than what it appeared in git-gui.
> > 
> > Honestly I'd prefer just wrap the first line as well. If the user gets
> > frustrated that the first line gets wrapped there are two options:
> > - Refrain from writing such a long line
> > - Disable word wrapping (it should be configurable, like you said)
> Configurable wrapping point - yes, would be nice (a feeling of control, that
> I'd probably never change ;-).
> > 
> > Thoughts?


Those are the same controls git-cola has.
- Commit message word-wrap can be turned on/off.  Defaults to on.
- The line length is configurable.  Defaults to 72.

Regarding, "the user might get frusted when the resulting commit message
looks different" -- I don't think that's really a concern in practice
but that might be we have a dedicated LineEdit for the subject line.

For git-gui, it seems fine since Git already has conventions about how
the subject line gets wrapped, so tools will still see the wrapped
subject line as a logical "single line".

The "Extended description" commit message editor is WYSWIYG, but if the
widget is smaller than the configured value then we still wrap the
committed message using the configured value, which is what the user
would likely expect even though the visual wrapping is smaller.

We also special-case trailers like "Signed-off-by:" and other common
trailers since user names can get long, and users sometimes use things
like "See-also:" and paste a long URL that we don't want to wrap.

Lastly, we have a convenient session-only checkbox to temporarily disable
wrapping for a commit that does not persist across restarts.  The idea
is that sometimes you might use the GUI for a one-off commit where you
want to disable the wrapping for whatever reason, but don't want to
change your configuration.
-- 
David
