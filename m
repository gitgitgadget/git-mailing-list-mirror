Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB761F4C1
	for <e@80x24.org>; Tue, 15 Oct 2019 18:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731819AbfJOSeH (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Oct 2019 14:34:07 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:37566 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfJOSeH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Oct 2019 14:34:07 -0400
Received: by mail-ed1-f66.google.com with SMTP id r4so18983141edy.4
        for <git@vger.kernel.org>; Tue, 15 Oct 2019 11:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1dFA9HcXdkgh3JkbTasRvTobm1zEpaXP58E8CBXpjh0=;
        b=PT9UtH82HIX5BFIKkeDw0ljKyMrGnvzvmsrx7atbNRrPE8f9N3bzi3Gs+Y8tSBr909
         YoqYr1vMDB8yjopjT3sL6MJCOAoI6TOtg/wvHFeUlNsiHnWohOwVoyX1v9wH//v+2Bp1
         osjA9qytMawuJW+gKyq7sxC4H3eNY2cHEnh2cRVsgHnHxWgzijvTvR5RaRiasB/2CZ2m
         Kc6gfhVTYI0cLy5DR9VWtcujhGAfiMB+nFPsXCJNyt2wiCbw1x1vtuwPDjEr+EpPvjY8
         dWOz5QD8Ae1kg2y6uE7YY7S+PcKgk2dhW/iohoZ9ZLDfv9KuH7dEUsY2Of0kGIRGbk81
         pPmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1dFA9HcXdkgh3JkbTasRvTobm1zEpaXP58E8CBXpjh0=;
        b=CfAfZlxNFx9kGDqQbouF7CGfYW4CE2Ql0ZF9JhgEyD1BKUf7IK1PfD97PLKe1bsZ3v
         wTTER1a1jR0BUUk3l39bcBVGgDb2pyr8hE52AQRdywS26cTnoYlNHWwDSDPqJJwNSTsQ
         z67D3tLLLUig3yeihuqdFilvprwtv+3RmiHxOQ/MjMdxrGJtaa+3HM05sjsZsnSrwitV
         xxp9UFZV0NBqFhx/qp4YAURvtpmQiFzR8wHqnGgo9cGH1hqf7Uk4GAFgdcK365jT68bC
         bcln8BzRRmJ6DCyH75pn6qP8HR9/cYwWasEn+gFidwMhAhFBxj+tBkAY4WYm3ikIGx9k
         t5/A==
X-Gm-Message-State: APjAAAWQQIaE0T8rynKhGtmEfliq1o2ja7tyUMcdwuROUO5rP8BLzobu
        ejEovCEH3+VRLikTlfG3UMqUm7ptVzlA2EfghcE=
X-Google-Smtp-Source: APXvYqzCU2pC8zpFIYfWfc9+/s77vxgekm9sLJHr+tSlgHJ+7mWWMco9sph5qcGaY07HNgBSBu8ExhNQ/JNaFf5b8Vs=
X-Received: by 2002:a17:906:f54:: with SMTP id h20mr36311757ejj.55.1571164444263;
 Tue, 15 Oct 2019 11:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1571089481.git.wink@saville.com> <d47c5de5fc812b1fbd04bb259a522e453d4b21e2.1571089481.git.wink@saville.com>
 <xmqq4l0ad7vn.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq4l0ad7vn.fsf@gitster-ct.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 15 Oct 2019 11:33:52 -0700
Message-ID: <CA+P7+xr-4WXuDFL-D8pmoxFvLB0Rkm4zsGO9=aOy5-3o=m=5Tg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] Teach remote add the --prefix-tags option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Wink Saville <wink@saville.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 14, 2019 at 8:07 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Wink Saville <wink@saville.com> writes:
>
> > When --prefix-tags is passed to `git remote add` the tagopt is set to
> > --prefix-tags and a second fetch line is added so tags are placed in
> > a separate hierarchy per remote.
>
>
> In the olden days, there was no refs/remotes/$remoteName/ hiearchy,
> and until we made it the default at around Git 1.5.0, such a modern
> layout for the branches were called the "separate remote" layout,
> and can be opted into with "clone --use-separate-remote" by early
> adopters.
>
> I doubt that use of refs/tags/$remoteName/ is a good design if we
> want to achieve similar isolation between local tags and and tags
> obtained from each remote.
>
> An obvious alternative, refs/remotes/$remoteName/tags/, is not a
> good design for exactly the same reason.  You cannot tell between a
> local tag foo/bar and a tag bar obtained from remote foo when you
> see refs/tags/foo/bar, and you cannot tell between a branch tag/bar
> obtained from remote foo and a tag bar obtained from remote foo when
> you see refs/remotes/foo/tags/bar.  In the past, people suggested to
> use refs/remoteTags/$remoteName/ for proper isolation, and it might
> be a better middle-ground than either of the two, at least in the
> shorter term, but not ideal.
>
> In short, if you truly want to see "separate hierarchy per remote",
> you should consider how you can reliably implement an equivalent of
> "git branch --list --remote"; a design that does not allow it is a
> failure.
>
> A better solution with longer lifetime would probably be to use
>
>         refs/remotes/$remoteName/{heads,tags,...}/
>
> when core.useTotallySeparateRemote configuration exists (and
> eventually at Git 3.0 make the layout the default).  It would
> involve changes in the refname look-up rules, but it would not have
> to pollute refs/ namespace like the refs/remoteTags/ half-ground
> design, which would require us to add refs/remoteNotes/ and friends,
> who knows how many more we would end up having to support if we go
> that route.
>
> Thanks.
>

Something like this makes sense and I've thought about the problem for
a long time. Unfortunately it's quite a bit trickier to do this.

It would solve the problem more generally though, and definitely seems
like the right approach.. but at least for me, every time I looked at
trying this I got lost. I haven't had time to investigate it recently
:(

Thanks,
Jake
