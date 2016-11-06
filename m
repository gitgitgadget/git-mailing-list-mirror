Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 418922021E
	for <e@80x24.org>; Sun,  6 Nov 2016 20:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751387AbcKFURd (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Nov 2016 15:17:33 -0500
Received: from mail-yw0-f180.google.com ([209.85.161.180]:35249 "EHLO
        mail-yw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbcKFURc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Nov 2016 15:17:32 -0500
Received: by mail-yw0-f180.google.com with SMTP id i145so23961320ywg.2
        for <git@vger.kernel.org>; Sun, 06 Nov 2016 12:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0TlFbKi4dsf8mf6DrCwedL4xOftd9nLhpqpnC3xk9RA=;
        b=e7B4j667U8Nyxm+5C1b09lYqaMlDZZSubHcjAUsAPSnFegEk3RTa3JncGsT86pEbS9
         wfEEZgn3r0dKUoURuD7okCA+0BVXLbuYUDTZrhg70xVZIssJOg84UyRxp2i0zqpo6f6D
         YB2Q768YrN/exef6/15eSKKlaufzeV7B/v+9p2eFdZTR6+A9xthSsQTyQA+fPRBuQeNj
         pVI2iB0ssIWfQ/ugVVBibsKPWaJeNooUXs4l1Dh9KPG4zq34PGxYiMclimuMIm1wli4d
         2w2RqPciw8AjaV8wRNvlzs/m1g4fJI2705x58zLi8kXSRC+ileB7po2zml2gl9Nqrvg9
         fMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0TlFbKi4dsf8mf6DrCwedL4xOftd9nLhpqpnC3xk9RA=;
        b=EnuTaxqK178uQAeu0N4JTYleEoDZrkkjkbM9bsA33RtaGv31trB1w8XEHXaJdB8V7+
         cse07B+njp+bFj8CInepdmCo0pxotLy/A4XmGxjMWsqa+bCYEGCy9r9CrpRF83jyvqPb
         bFwauzbZjm9vum5/9l+sOdxBU+Vd9ttDfP9d3BnsoqiO/EmLkeMbJoB++J5Hua1tH1ZR
         c/8Mb7G7GeC06KPGDDnMLq5Jr0cj2xP2Oji9zMxkE08FQcAyw/pJL9hrU8hGObrxSt/N
         NMr6+500xJPt7oSRbwRFMvPzap+n+0KRx+IFkzO6eJIDrSQFmQeQvs9v2dQcX+iSR6u4
         YktQ==
X-Gm-Message-State: ABUngveLAQMx0H7jvjq/fB/+AckTRWNA8f/1JbDGloXTMNcA/zbGaO6+UnaDhW+Wq+VSFu4Fq0U9/tnT7F1muA==
X-Received: by 10.129.130.193 with SMTP id s184mr2774684ywf.276.1478463451353;
 Sun, 06 Nov 2016 12:17:31 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.33.132 with HTTP; Sun, 6 Nov 2016 12:17:10 -0800 (PST)
In-Reply-To: <20161106173311.lqoxxgcklx4jlrg7@x>
References: <CAP8UFD2+A0MUKazAfSwCvv61TJRPuoOzH5EkqcrBOUi4TcuoDw@mail.gmail.com>
 <xmqq1syqedv4.fsf@gitster.mtv.corp.google.com> <CAP8UFD0bqNQZ3nuGUDX0qrSo44hf1NL9LeZB_FQcXg3j0mD38A@mail.gmail.com>
 <CAP8UFD1EZ8HBzLAeyFBFgU7n2uJpswqgEgA4XM1YJuRAG_ZAAQ@mail.gmail.com>
 <20161105151836.wztypzrdywyltvrc@x> <CAP8UFD3XFHr7POKmZr_6guapC6sme3GvWBV5vPw4XO7FE5HOPw@mail.gmail.com>
 <20161105202553.migx75gfuujakqyk@x> <CA+P7+xoG3ag8dj7s_NRoqz-EwjVENSJSzE_qj6gnW-SmWt0bgA@mail.gmail.com>
 <20161106163410.ilysej5r6qd3744e@x> <xmqqshr4cyy7.fsf@gitster.mtv.corp.google.com>
 <20161106173311.lqoxxgcklx4jlrg7@x>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Sun, 6 Nov 2016 12:17:10 -0800
Message-ID: <CA+P7+xoxjwvjXrW0Pwh7ZK-OYBiYamPAxvf_=zqJOsQ8xWDPWw@mail.gmail.com>
Subject: Re: Regarding "git log" on "git series" metadata
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git <git@vger.kernel.org>,
        "Shawn O. Pierce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 6, 2016 at 9:33 AM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Sun, Nov 06, 2016 at 09:14:56AM -0800, Junio C Hamano wrote:
>> Josh Triplett <josh@joshtriplett.org> writes:
>> > We could, but if we (or one of the many third-party git implementations)
>> > miss a case, gitlinks+reachability may appear to work in many cases with
>> > dataloss afterward, while gitrefs will fail early and not appear
>> > functional.
>>
>> I wonder what happens if we do not introduce the "gitref" but
>> instead change the behaviour of "gitlink" to imply an optional
>> reachability.  That is, when enumerating what is reachable in your
>> repository, if you see a gitlink and if you notice that you locally
>> have the target of that gitlink, you follow, but if you know you
>> lack it, you do not error out.  This may be making things too
>> complex to feasibily implement by simplify them ;-) and I see a few
>> immediate fallout that needs to be thought through (i.e. downsides)
>> and a few upsides, too.  I am feeling feverish and not thinking
>> straight, so I won't try to weigh pros-and-cons.
>>
>> This would definitely need protocol extension when transferring
>> objects across repositories.
>
> It'd also need a repository format extension locally.  Otherwise, if you
> ever touched that repository with an older git (or a tool built on an
> older libgit2 or JGit or other library), you could lose data.
>
> It does seem conceptually appealing, though.  In an ideal world, the
> original version of gitlink would have had opt-out reachability (and
> .gitmodules with an external repository reference could count as opting
> out).
>
> But I can't think of any case where it's OK for a git implementation to
> not know about this reachability extension and still operate on the
> gitlink.  And given that, it might as well use a new object type that
> the old version definitely won't think it understands.
>
> - Josh Triplett

That's still only true if the receiving end runs fsck, isn't it? I
suppose that's a large number of receivers, and at least there are
ways post-push to determine that objects don't make sense to that
version of git.

I think using a new mode is the safest way, and it allows easily
implementing RefTrees as well as other projects. Additionally, if we
*wanted* additional "opt-in / opt-out" support we could add this by
default to gitrefs,and they could (possibly) replace gitlinks in the
future?

Thanks,
Jake
