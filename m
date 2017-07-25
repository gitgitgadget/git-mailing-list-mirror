Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 091162089A
	for <e@80x24.org>; Tue, 25 Jul 2017 21:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751526AbdGYViq (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:38:46 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35052 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751397AbdGYVio (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:38:44 -0400
Received: by mail-pg0-f49.google.com with SMTP id v190so75305664pgv.2
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=cag1YCTqcYEDnXPUe4VhEXVPlz84A+IUcfrGrSrwP3w=;
        b=Bdnz6gyNLbSiVUnug8FwMwJ0fxxXrJ9cUZxp/pH60QcY/wIftn+j1CCBNk0do+N2B1
         fzScHtILL0ha/UpYX3pIB51I2+WhHYY8gloe4YLF7UM/ZE5O9a1mBRHFbNvhsvb9t2e3
         8G2WMnj8D7/Lpjv24Xc5Fl+tYOflwuIOGbXG/d2WV33SvGGObais+2W0U1b+75vXvYWU
         ektM8tmEDIbdAy30Z6dls6bFRKWJtt7E8/ciuChj9R08RbA/DF79w2hGZI3FmsiCMxwE
         FhWNMiu03soOcuC88rakXeqNIByH4WK6G2xQUfRyK41V9JCpT+/g55zVmfKuzj3ivjEF
         3L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=cag1YCTqcYEDnXPUe4VhEXVPlz84A+IUcfrGrSrwP3w=;
        b=SMbqBBkP4yfxWoG7khn1WoiVE3h2oKKbOcB6CdOjpmf+3UWA6+6RGGEiSECGd4WvRT
         KP108m68rQITuuLXH1FmDoRIwLCrlcW6O6KaGjkWyE4wyGpxaQKkWAHJ2+ea6RtLiEBh
         zyfzcOxzAinclRBUMafIAXyUn7wEJQMRzDJB+SSOh1ytDhyiJ9Ha/etw+2xh0TDcgTBU
         evzo2xDbPFvGDRVsHAlNu6sj/GGOlQ5eLbG9B4LhkOGr8bYHuldDWafEy0p/bbsjcN35
         NxsZCjNc4DWEFrYP/GJHF3V2Vv8K5re343Atl6qmTWTYkMdd0758DVqfIH9J4JtN8V9d
         qd6w==
X-Gm-Message-State: AIVw110VoszVpG6HUccjprOi6eHS87DlKcWPA/2oNmr6ACTVS20u1/Ua
        TfuV92PPh2pxeSNw5IEC66z3nLzTNnZe
X-Received: by 10.98.32.195 with SMTP id m64mr20597227pfj.66.1501018723873;
 Tue, 25 Jul 2017 14:38:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.165.44 with HTTP; Tue, 25 Jul 2017 14:38:43 -0700 (PDT)
In-Reply-To: <20170725211300.vwlpioy5jes55273@sigill.intra.peff.net>
References: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
 <CAH5451mrL=GE6WrX6juoyGPV6trcQhXXthKhjT2=qCDCiffeeA@mail.gmail.com>
 <CANENsPr271w=a4YNOYdrp9UM4L_eA1VZMRP_UrH+NZ+2PWM_qg@mail.gmail.com>
 <CAH5451m0P4eZMXj8ojgbd+q-8scoJpwn9UcZLvqYKM=+8hhWPg@mail.gmail.com>
 <20170724181118.ntqjqfihhblbvwmi@sigill.intra.peff.net> <CAH5451nbY+Xo0Fpe2OdsxwJeRV1ddZmYX7v-bPYgRsbS2kNJSg@mail.gmail.com>
 <20170725191347.e2p7goxho2rcemz4@sigill.intra.peff.net> <xmqq7eywutlt.fsf@gitster.mtv.corp.google.com>
 <20170725211300.vwlpioy5jes55273@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 25 Jul 2017 14:38:43 -0700
Message-ID: <CAGZ79kaFR0d4Z2kcUawHw8PmHpa9gaj4sBMktZjYoeAc27ywyQ@mail.gmail.com>
Subject: Re: Should I store large text files on Git LFS?
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Andrew Ardill <andrew.ardill@gmail.com>,
        Farshid Zavareh <fhzavareh@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 25, 2017 at 2:13 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jul 25, 2017 at 01:52:46PM -0700, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>>
>> > As you can see, core.bigfilethreshold is a pretty blunt instrument. It
>> > might be nice if .gitattributes understood other types of patterns
>> > besides filenames, so you could do something like:
>> >
>> >   echo '[size > 500MB] delta -diff' >.gitattributes
>> >
>> > or something like that. I don't think it's come up enough for anybody to
>> > care too much about it or work on it.
>>
>> But attributes is about paths, at which a blob may or may not exist,
>> so it is a bad fit to add conditionals that are based on sizes and
>> types.
>
> Do attributes _have_ to be about paths? In practice we often use them to
> describe objects, and paths are just the only mechanism we give to refer
> to objects.  But it is not actually a correct or rigorous mechanism in
> some cases.  For example, imagine I have a .gitattributes with:
>
>   foo -delta
>   bar delta
>
> and then imagine I have a tree with both "foo" and "bar" pointing to the
> same blob. When I run pack-objects, it wants to know whether to delta
> the object. What should it do?
>
> The delta decision is really a property of the object. But the only
> mechanism we give for selecting an object is by path, which we know is
> not a one-to-one mapping with objects. So the results you get will
> depend on which name we happened to see the object under first while
> traversing.
>
> I think the case you are getting at is something like clean filters,
> where we might not have an object at all. In that case I would argue
> that a property of an object could never be satisfied (so neither
> "size > 500" nor "size <= 500" could match). Whether object properties
> are meaningful is in the eye of the code that is looking up the value.
> Or more generally, the set of properties to be matched is in the eye of
> the caller. So looking up a clean filter might want to define the size
> property based no the working tree size.
>
> -Peff

I recall a similar discussion on the different "big repo" approaches.
Looking at the interface of LFS, there are things such as:

  git lfs fetch --recent
  git lfs fetch --all
  git lfs fetch [--exclude] <pathspec>

so LFS provides both the way to address objects via time or by path,
maybe even combined "I want everything from <pathspec 1> but only
'recent' things from <pathspec 2>".

attributes can already be queried from pathspecs, and I think when
designing from scratch we might put it the other way round:

    delta:
        bar
        everything <500m
    -delta
        foo
        binaries

So in the far future, attributes may learn about more than just
pathspecs that we currently use to assign labels, but could
* include size
* properties derived from the 'file' utility
* be specific about certain objects (historic paths)
