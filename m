Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F010B1F404
	for <e@80x24.org>; Thu, 15 Feb 2018 17:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164792AbeBORlq (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 12:41:46 -0500
Received: from mail-vk0-f50.google.com ([209.85.213.50]:38878 "EHLO
        mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1164615AbeBORlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 12:41:45 -0500
Received: by mail-vk0-f50.google.com with SMTP id z9so307774vkd.5
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 09:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=82fECh3woqOVXU9MOo2kNTDoHK1usGcBU12MtqDVoCE=;
        b=R8DbCn/g1T1sLH7nL71Is32ZC6L046GJhLk1agzyu2R0AygNtYFamdN3SUW9EEORUQ
         KR/LoA8kq6iN8tPUc2gbhCt6PNH6xEFqk+tpW1DjX8PBO7EZARL2wS0pM3q1/uim5v4I
         0wdJkqNvCIrLc/5kSxMDqZPhZBe4hp1HMI0ftQi4n91Ni3nzdD+10y4EV6T+Hpekxwa5
         /zJLM44VOcGkKOHQej03x1Rcy0n5WyvVFtaxiDFFFfLJzptNuTzPs1igLUDS20rPYcCX
         FD/B4ifOhoP+MnwxY1y/NCkrFETUt3RtDCyw8jgdSC0zpjDrVucs8nDQdKQpjbGythd5
         xYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=82fECh3woqOVXU9MOo2kNTDoHK1usGcBU12MtqDVoCE=;
        b=mWmV4iEKTgjSi/P0dTTs9WttNWayLr8cTjUGYJdx89HxEKagOYnUilxdw8UXu+yDtr
         YinFaGWjkB+JZI3iYdrwFgejyBTpZIpYiXFkQXvKffShktWs9W+YXAZLTCHMRea32A/+
         sLivW+wdFYN0wUKKYVZEv/d84j2NScxfcu/ZPaym0mjbnNVvBL1UaioFI3mxjNcsMbm5
         1j0FVuzvrIQJNIzMHmyj+mH45GPxr6MFz9fbVvNUw/VIBQ/nhe2m0NhW0B2jfngyEXx5
         xQnm195/RiBNaZpwYo3WTDiSAducTraHWUiL8PmrXqakw+EPPJZdp6VJAvC7MyPOS+iS
         hRHA==
X-Gm-Message-State: APf1xPBfm7/M5dUgBhInM7ZhPdTXfzOY1z7YlKozaTiKyR4Vk/KZVktq
        T6x26putjQ1T30QEyfqQYbYiBwmbwFRaUtFq1A0=
X-Google-Smtp-Source: AH8x2240q6JCfGOLWizX2ScVBfu5VlrCU/qw6TYYH2ciEhqbIp10/T9m52p/InQqd39Sh7OfSRSpILRBva6CntcEn0Q=
X-Received: by 10.31.99.130 with SMTP id x124mr2469087vkb.155.1518716504345;
 Thu, 15 Feb 2018 09:41:44 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.32.12 with HTTP; Thu, 15 Feb 2018 09:41:43 -0800 (PST)
In-Reply-To: <20180215165218.GA7635@sigill.intra.peff.net>
References: <20180213003601.7396-1-szeder.dev@gmail.com> <20180213222247.GA18401@sigill.intra.peff.net>
 <CAM0VKj=YPkS=YLtEz93RWS2=cvyy6LcyrBsCyBCg14ihxuKzjA@mail.gmail.com> <20180215165218.GA7635@sigill.intra.peff.net>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Thu, 15 Feb 2018 18:41:43 +0100
Message-ID: <CAM0VKjmW6_3z49uVMFUpwsK5khZ_bNALDgkKkPUQdvu2PEogfQ@mail.gmail.com>
Subject: Re: [PATCH] t6300-for-each-ref: fix "more than one quoting style" tests
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 15, 2018 at 5:52 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 15, 2018 at 05:39:28PM +0100, SZEDER G=C3=A1bor wrote:
>
>> On Tue, Feb 13, 2018 at 11:22 PM, Jeff King <peff@peff.net> wrote:
>>
>> >>  for i in "--perl --shell" "-s --python" "--python --tcl" "--tcl --pe=
rl"; do
>> >>       test_expect_success "more than one quoting style: $i" "
>> >> -             git for-each-ref $i 2>&1 | (read line &&
>> >> -             case \$line in
>> >> -             \"error: more than one quoting style\"*) : happy;;
>> >> -             *) false
>> >> -             esac)
>> >> +             test_must_fail git for-each-ref $i 2>err &&
>> >> +             grep '^error: more than one quoting style' err
>> >
>> > I suspect in the long run this ought to be test_i18ngrep, but since it=
's
>> > not localized yet, it makes sense to stop here with this patch.
>>
>> I thought 'git for-each-ref' is plumbing and that means that it
>> shouldn't be localized.
>
> I always assumed stderr was mostly fair game, even for plumbing. At any
> rate, I'm willing to ignore the issue until somebody actually proposes a
> patch to translate it.

Ah, OK, will keep that in mind.

Anyway, the first GETTEXT_POISON build will fail if that error string
ever gets translated but the test doesn't get updated.
