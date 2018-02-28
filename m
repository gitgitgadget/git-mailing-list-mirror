Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 840681F404
	for <e@80x24.org>; Wed, 28 Feb 2018 20:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934817AbeB1Ux2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 15:53:28 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35090 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934745AbeB1Ux1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 15:53:27 -0500
Received: by mail-wr0-f196.google.com with SMTP id l43so3879154wrc.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 12:53:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ez5w9KfmeFeYvt2EBqnp8Vfv/oMLk4xkV1lScNkxXy8=;
        b=MNG0q1PWt2CqYpiYEaGWzotmWnT6G74m8u6HgDJWsZ0/om5MumD4m9KWXnmmS9+mct
         5VwJ8HSY1YV8VQzrmPHT6qA+HxXbx72Sg+vY9pnQOubVYoVpSPzb/5BRl5Wk4t1cyZ21
         AqGbHWaFr/zPIvGGI8zKTZWIvr5ojGXqwnQdff3txtliIJ1I55jnxe4DZ9255zTk1ftT
         598H2aX7IX8DNHrp4dxeke8HuAn1G0BLGrHfoLEfGItjhZWJ6LbxSFaVUiUFIqy1dk3x
         owWMG0ZKKZrmhoN1FX89jbux+8FXVEHnsU/qBEVRnPqC2+NV1VYdrLcyEEqt209P31FF
         /Uug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ez5w9KfmeFeYvt2EBqnp8Vfv/oMLk4xkV1lScNkxXy8=;
        b=kO8w86uGTyew6Q7nWSghmg84X2ALetIx4D4RTA5nF2oWFQuaZl1NG5FlIZTkpfpM3j
         h4oQZ9rvFL6iesQaSuOmXOpU4loIQfAQMcT0Was2IVHJpNlHAdm8x/snP4NTzDuL72aq
         s/kBO1rXtxG10IHsxu7XCreaD+DSCg1EllrgU2LfriEZds84MaU79+UAfo8t8rzVzRwZ
         Zo9ol1iiT/untLKesG679/BzAjbWM7KwgBEx9xXPfU6llmQodlO1yNvynjFmv/sxe1am
         vNnQwb4Zoe5KcAj7jqKtYWHR+XH5p72rjHy6HhMTaYeXJuP0BLF2jUYsvwe1vpUqOAqP
         ABaA==
X-Gm-Message-State: APf1xPCgvMDnXx50M22qaKUdk8srg5+qRtlmV5rPMFT3q1olvBUxDhEH
        CvdzZ2rYqQj8jjaMe5soYrb1EFdOZD8=
X-Google-Smtp-Source: AH8x226dXgTDp3c4E8xdE5FoMbVU62koOx+kv3UwS05ShoVDROBrefWCfRguUu/T5yEt5rMqFx9hig==
X-Received: by 10.223.208.132 with SMTP id y4mr15964828wrh.185.1519851205929;
        Wed, 28 Feb 2018 12:53:25 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id e67sm2846337wmd.7.2018.02.28.12.53.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 12:53:25 -0800 (PST)
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution (Road
 Clear)
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git mailing list <git@vger.kernel.org>,
        Jacob Keller <jacob.keller@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
References: <87y3jtqdyg.fsf@javad.com>
 <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
 <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
 <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
 <nycvar.QRO.7.76.6.1802272330290.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <3b562b51-2f1a-48f6-d6b4-8e0fbddd3a40@gmail.com>
 <b4367bca-79a0-879b-9503-ed4e667d8a64@gmail.com> <87k1uxmyib.fsf@javad.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <d06dcf02-6b85-c4b3-936b-5bf3ca1c4b98@gmail.com>
Date:   Wed, 28 Feb 2018 21:53:24 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87k1uxmyib.fsf@javad.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sergey,

On 28/02/2018 07:14, Sergey Organov wrote:
> 
> > > Would additional step as suggested in [1] (using R1 and R2 to "catch" 
> > > interactive rebase additions/amendments/drops, on top of U1' and 
> > > U2'), make more sense (or provide an additional clue, at least)?
> > > 
> > > [1] https://public-inbox.org/git/8829c395-fb84-2db0-9288-f7b28fa0d0d1@gmail.com/
> > 
> > Anyway, from (yet another) ad hoc test, additional step mentioned in 
> > [1] above seems to handle this case, too (merge with `-s ours` 
> > dropping B* patches, plus B1 cherry-picked between X1..X2)
> > 
> > ...
> > 
> > And not just that - it worked with additional interactive rebase 
> > adding, amending and removing commits, on top of all this still 
> > preserving original `-s ours` merge commit evil-merge amendment, too, 
> > all as expected (or so it seems) :P
> 
> Great! I do believe that once we start from some sensible approach, many
> kinds of improvements are possible. I'll definitely need to take close
> look at what you came up with, thanks!
> 
> I'd like to say though that nobody should expect miracles from automated
> rebasing of merges when we get to complex history editing. It will need
> to retreat to manual merge, sooner or later.

I agree, and as I really liked "the feeling" of the original approach 
you described, it felt bad to (presumably) see it failing in what 
doesn`t seem to be neither too complex nor rare situation of dropping 
a commit during an interactive rebase, thus motivation to try to 
improve it, if possible, wasn`t lacking :)
 
Eh, might be I`m just naively ignorant at the moment as well, but I`m 
trying to work my way through it... ;)

Regards, Buga
