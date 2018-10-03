Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 100FF1F453
	for <e@80x24.org>; Wed,  3 Oct 2018 17:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726989AbeJDAhF (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 20:37:05 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:33219 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726884AbeJDAhF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 20:37:05 -0400
Received: by mail-ed1-f45.google.com with SMTP id g26-v6so6175443edp.0
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zji74gYChqZ4UDkGsjQ6rK5LyHj9Bto1RPFrI5T/pR0=;
        b=Vv0Z7jVIpT0pMbTjCByeWFHxT7R/UHlqzcuco0MpCMi3cQYSx2RN/gdy+52h5o7YJh
         Wb4wNgdeIUlkkRQdRMaquoa5cIxU0uHeDPNI9kpgftTZsYX/KzdnNnfV79OP0yBJK/oD
         9Y+1G27nk5/B7wv2IVMTC1FPWsTXgcJ9Pi1wJupA3tMwsyQt9EpuV6+z/stmkYYFOUtY
         y16ngvvZH1IHBJLrSfTfOml6av8tLe3TbBjN0WHupWSdXc20ZAWSIjd9rJ8M+qEtc0c2
         F1q86x+PTWoVzit9VeR+CcekC16fRW1+RsiVqoTv9rIQuOf1mKk3nZcrScuWNsYW5olq
         6JMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zji74gYChqZ4UDkGsjQ6rK5LyHj9Bto1RPFrI5T/pR0=;
        b=VHzvb3lrK3RHZ4eDAKpJYkvyrjMzRsTaXUHmDaSieeFXRJWgwAKfnsNzVPlo7lose5
         /jtL44L3Jrw2g492O3+sJ54NPK2WzYAo8qqX1epg3r4WREe3n4zzoLrlkl7XofSQWPCL
         49p6U7j+be1sjhXK9g3TYweCZT0DY9lNnQV7PZqnHXn6sP/i3r1QA94aSPMeAjI1l0pd
         e1YGQo+JNhSyWP1RolNawlLUDRyK5pqWsyV1goxeMZRxk6OwsnW//nBIMWi+ncqbKhNZ
         4hpH0+sUIXMhRfUSpfm61gbOBvtFs8gw+eqpgXbuovdutTJM/moceYwk/d1rywF7aUJv
         jKQA==
X-Gm-Message-State: ABuFfojQOZ9F06gRt9pjDoikn1MFI/b2xNl7NAHBv+VLeFknEGLcMuF5
        RGDitevs9ak8gG0CMYqi8BV6/P6wUQvRB9bn0reQpA==
X-Google-Smtp-Source: ACcGV62k8CiHMlv2lIFo0bqIivTllo4W33nYe2gA5IBgS24rCa+jh4UKs4QGGgsbBuGXEtoTKk31/5k/ivslbYh/0jc=
X-Received: by 2002:a17:906:1910:: with SMTP id a16-v6mr2954253eje.19.1538588860018;
 Wed, 03 Oct 2018 10:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <87tvm3go42.fsf@evledraar.gmail.com> <20181003133650.GN23446@localhost>
 <87r2h7gmd7.fsf@evledraar.gmail.com> <20181003141732.GO23446@localhost> <87o9cbglez.fsf@evledraar.gmail.com>
In-Reply-To: <87o9cbglez.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 3 Oct 2018 10:47:28 -0700
Message-ID: <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
Subject: Re: We should add a "git gc --auto" after "git clone" due to commit graph
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So we wouldn't be spending 5 minutes repacking linux.git right after
> cloning it, just ~10s generating the commit graph, and the same would
> happen if you rm'd .git/objects/info/commit-graph and ran "git commit",
> which would kick of "gc --auto" in the background and do the same thing.

Or generating local bitmaps or pack idx files as well?
