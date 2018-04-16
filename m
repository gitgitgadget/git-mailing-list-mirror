Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D77D1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 13:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeDPNPw (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 09:15:52 -0400
Received: from mail-ua0-f174.google.com ([209.85.217.174]:35723 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753479AbeDPNPv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 09:15:51 -0400
Received: by mail-ua0-f174.google.com with SMTP id c3so10025380uae.2
        for <git@vger.kernel.org>; Mon, 16 Apr 2018 06:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MRgrQT2BVcMk8p1w5rv7+3C4ip8SE+4940c+cz0qwXQ=;
        b=PLHEBhu3EsJydsnPl+8CKK9GdigAs67XjJlqr0h2irRxlDBM8PXP9ip/LYz7HzF6DE
         GyG06qyKQcgag04cOvjEhimAkjnDQtEvaMybqW2i9krD+nUybw/q5M4YLSvBwC2xeBdg
         8y+QVPMgj3mJ9mv8jCJ4EHD8ouRsIvSUjsJZyLiakV55h2pc5uuhPCxsx9I6ezuan6+z
         jaLmHQC+v3N5wiJrDtHS/+B+GBRfD47j1nyoi9tbUiAgz8xa3i8bX45mv6WqVUULMH7U
         pzpZtBjIPELrjlM/q7Tq3EDGDVEl00EOqTdMtxFOuDAiAEHlG1nihWt+6w/ALgHeUwHX
         cfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MRgrQT2BVcMk8p1w5rv7+3C4ip8SE+4940c+cz0qwXQ=;
        b=VYkCL5zDjXMP/SIXKaAXx6ZAuDzhHXJvM3K9iVLb/Uf87VDNFYE7Vsm8dogrgKYVjI
         wljwam8I/PEjNEiy2RBVcJwKQ55Aw2h4FHCpQ8fSCEAKDjk9j4Y+Fh85ubZY9uqvlo1t
         NzvqTT9ag8C+Hk+hgzIM1jx5AYzA9zcQrYnCkb67oClqGzheMFo6WccfJMSk98oI4prB
         jcDKUjJg9/G0/V5bRv56q1jYudO0/VzqOuux1zRJ+du+x7xTIseL/+ZP5ayKb2t0pUCB
         PZYbnXVSabnlIvY/hRw0pFmQ6xQxvhbMWxhePXF7P3ErdhnxtNqMM05Ai3NzzEl47ip2
         7+9Q==
X-Gm-Message-State: ALQs6tC92zsWOZLrWBIqcKTtP4dcCTB12BuQr+SunBC2mYpDVjoAIrKe
        mWMRs1rr6mJjEhnGQ0RNBl6Q7ji1KZ5nc77JOXQ=
X-Google-Smtp-Source: AIpwx4+NJcf1jJ7Ws8S4sNZTV9M9/ySEQqab5+N8tCbDyUzvOgCNC+MxGc3FojMirZhcJfsqHQ1Q+PAvrlJW0MtRUZ4=
X-Received: by 10.176.67.229 with SMTP id l92mr11332450ual.27.1523884551111;
 Mon, 16 Apr 2018 06:15:51 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.159.34.195 with HTTP; Mon, 16 Apr 2018 06:15:50 -0700 (PDT)
In-Reply-To: <xmqq7ep7ybw2.fsf@gitster-ct.c.googlers.com>
References: <ACE8F169-7700-4D60-85CB-786C6BEBF0B7@1eanda.com>
 <20180413103005.671-1-szeder.dev@gmail.com> <86604un5mz.fsf@gmail.com>
 <CAM0VKjkKE695mMPgmfgzWJPaJThdLDSESV9KmupQX_bm-6MW-w@mail.gmail.com> <xmqq7ep7ybw2.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Mon, 16 Apr 2018 15:15:50 +0200
Message-ID: <CAM0VKjm=jyetT9ucNbOYxQ19BGYr8nWzAi+WUnsHPuRTrSG9SA@mail.gmail.com>
Subject: Re: [PATCH] completion: reduce overhead of clearing cached --options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jakub Narebski <jnareb@gmail.com>,
        Matthew Coleman <matt@1eanda.com>,
        Stephon Harris <theonestep4@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 16, 2018 at 7:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>> On Fri, Apr 13, 2018 at 11:44 PM, Jakub Narebski <jnareb@gmail.com> wrot=
e:
>>> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>>>> In Bash we can do better: run the 'compgen -v __gitcomp_builtin_'
>>>> builtin command, which lists the same variables, but without a
>>>> pipeline and 'sed' it can do so with lower overhead.
>>>
>>> What about ZSH?
>>
>> Nothing, ZSH is unaffected by this patch.
>
> OK, do we want to follow it up with [PATCH 2/1] to add the LC_ALL=3DC
> thing to the ZSH side to help that "sed", then?

No.  'sed' would only need need help when its input comes from a buggy
'set' builtin of a particular version of Bash from a particular vendor.

As far as I can test this in Travis CI's OSX builds, ZSH doesn't seem to
be affected, neither the version Apple ships by default nor the version
installed via homebrew.
