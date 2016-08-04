Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABD7020450
	for <e@80x24.org>; Thu,  4 Aug 2016 16:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933989AbcHDQsb (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 12:48:31 -0400
Received: from mail-it0-f47.google.com ([209.85.214.47]:35843 "EHLO
	mail-it0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933732AbcHDQsa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 12:48:30 -0400
Received: by mail-it0-f47.google.com with SMTP id x130so540360ite.1
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 09:48:30 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1XbRo/v7HfklG06w4VAEMyLWlaGQYwm89+F1hvcuyIM=;
        b=HdvmlYWKFN0xBJcMDa+QI+mSKXHksHD2I3VG7X9qw9lk5EcO4axJSLAHmxnvZXuTj2
         FHutqu8YGTb4bqK/O/lFgT6TjHgBbcnmhejb+wT0qgqTiMauH4sFb4YnjHk1uYpgnix/
         9VSeb2BIA3K8LDZdFvxt00tZWJAjtEYhEanDUY8lTIuJW/AhBA/999C737nYFl0uRiXR
         yqZVrCiHT57Ot1x1ILH55VA0R/rzrFIs0uLyAKm0BHC1DeXTsWDgYj3qClOpDYP+2LB2
         86Bn4GI1F2qYqLKHsacM0ed6k2EwdUBwIpU6PKnzpBYe+GNigBy8E9BePauoWbvePFo8
         8qKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1XbRo/v7HfklG06w4VAEMyLWlaGQYwm89+F1hvcuyIM=;
        b=mfIM7P7nqq8ZLfK20EN+6X2ddm2T4+mYZuVXXX2qcJ6WbqTyRHGjm4DUjR2nfLWSBl
         1sjf7fN3jKBdkwXIoP7nW3BSs4Pe16q+qs5aNC2f6IrtsTL2teXeuBISOLuXYOo8Qf86
         pL2zTAJGp8c1D231e+PZDVStK4kIXeePCaXm+JfWZnA0yjejtXCMwGAZUHN6siFZJsze
         WYTEVFJ4j//iDbilSBLR2hTIKwOD/ISGePTFoeL9d8MJZoV33AxSnnjOc7QF/sSt1yye
         R4CsvQKyW3XYuSgjcusP7GbMQ1ueoCB2DTr8hc0ezx9+YtkeWon44jrOUSGK8xugtQST
         S1nw==
X-Gm-Message-State: AEkooutcuJATz46orsHuLq3X13DdU7oetuPo4InssExie9kXmLZKfILIAgFEwAeFecBQEMMM2V0TMopoJBajSbr2
X-Received: by 10.36.127.7 with SMTP id r7mr75755567itc.49.1470328938945; Thu,
 04 Aug 2016 09:42:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Thu, 4 Aug 2016 09:42:18 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1608041730130.5786@virtualbox>
References: <cover.1469547160.git.johannes.schindelin@gmx.de>
 <cover.1470051326.git.johannes.schindelin@gmx.de> <8ff71aba37be979f05abf88f467ec932aa522bdd.1470051326.git.johannes.schindelin@gmx.de>
 <xmqqlh0gjpr6.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608021004080.79248@virtualbox>
 <xmqqy44ec15p.fsf@gitster.mtv.corp.google.com> <alpine.DEB.2.20.1608031021050.79248@virtualbox>
 <CAPc5daXJzMsJf5K84XBFuQ5=q_OwtYUW2FikZ2QsZWk8fa9jgg@mail.gmail.com>
 <alpine.DEB.2.20.1608031753431.107993@virtualbox> <CAGZ79kYWdZCNW_eBi5aLAacyBZJXQ9xyOWMBmjNsYT5NWjr-Og@mail.gmail.com>
 <alpine.DEB.2.20.1608041730130.5786@virtualbox>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 4 Aug 2016 09:42:18 -0700
Message-ID: <CAGZ79kaTT3NgKj8akB8t9b1BF3i6sXe7Un9oq5KP8077Wz-E+g@mail.gmail.com>
Subject: Re: patch submission process, was Re: [PATCH v6 06/16]
 merge_recursive: abort properly upon errors
To:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Aug 4, 2016 at 8:58 AM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
>> If we were to change our workflows drastically, I'd propose to
>> go a way[1] similar to notedb in Gerrit, or git-series,
>
> Gerrit is a huge, non-distributed system. Complex, too. If we change the
> patch submission process, we should make things *easier*, not *harder*. So
> I think Gerrit is pretty much out of the question.

I did not propose to use Gerrit or git-series or git appraise.

However whenever I see these projects talking to each other, the talk focuses on
a "unified review storage format" pretty often, which would make them compatible
with each other. So then I could choose git-series, while you could go with
git appraise (although that is written in go, so maybe too fancy already ;)
Or there could be another new program written in C that follows the "review
format".


>
> Even requiring every contributor to register with GitHub would be too much
> of a limitation, I would wager.
>
> And when I said I have zero interest in tools that use the "latest and
> greatest language", I was hinting at git-series. Rust may be a fine and
> wonderful language. Implementing git-series in Rust, however, immediately
> limited the potential engagement with developers dramatically.
>
> Additionally, I would like to point out that defining a way to store
> reviews in Git is not necessarily improving the way our code contribution
> process works. If you want to record the discussions revolving around the
> code, I think public-inbox already does a pretty good job at that.

Yeah recording is great, but we want to talk about replying and modifying
a series? So if I see a patch flying by on the mailing list, ideally I could
attach a "!fixup, signed off by Stefan" thing to that patch. (I said "thing"
as I do not necessarily mean email here.

>
> I guess I have no really good idea yet, either, how to retain the ease of
> access of sending mails to the list, yet somehow keep a strong tie with
> the original data stored in Git.

Does it have to be email? Transmitting text could be solved differently as well.

With git push/fetch we can interact with a git remote and pertain the state
(commits, ancestor graph) at a full level even including notes that comment
on commits.

git send-email/format-patch recently learned to include a base commit
(xy/format-patch-base), maybe we need a counter part to git send-email
that downloads a series from your mailbox, such that a local branch
can be transmitted to via

    "git send-email --base=origin/master --include-notes --name=sb/new-series"

and completely reconstructed (i.e. the commit sha1s even match) including
notes via:

    git fetch-email --name=sb/new-series

That way would ensure we have a "simple" way to transmit patches back and forth
and adding potential fixups.


You wrote:
> In short, I agree that our patch submission process is a saber tooth tiger
> that still reflects pre-Git times. While we use Git's tools, the workflow
> really tries to cut out Git as much as possible, in favor of pure mails
> with non-corrupted, non-HTML patches in them, a charmingly anachronistic
> requirement until you try to use state-of-the-art mail clients to send
> them.

And there are two ways out:
* either we teach git how to deal with emails (completely, i.e.
sending+receiving)
* or we change the development model (e.g. no emails any more)

There is no golden third way IMHO.

Thanks,
Stefan
