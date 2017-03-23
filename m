Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15C1120958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755688AbdCWPHt (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:07:49 -0400
Received: from mail-wm0-f47.google.com ([74.125.82.47]:34973 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755486AbdCWPHr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:07:47 -0400
Received: by mail-wm0-f47.google.com with SMTP id u132so63977299wmg.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KAYcwdEpoVrSTjqjj2bz2wiUuAL3BQElx8kbSmUncfs=;
        b=ds/LylkvF3frbjU+Iaauo2W2wgI1bFaYzSPgwd7NTBV314j8kutkMvEr+CrM4yA7Mn
         a2bf/dH5HJwwigMQTycqt1GyAjrfHPJSDWvnEoOFPlaVxTevkYu0LCnoAHtB8uWGYt/X
         OQvc4lzFuYVM8ZQwFg/t8Vh26wG3awkAPbuOAakd7OEpVbNRaS6/JySnrx6wBQs6pdh1
         BcaHRA9txJuf2XDecRcw130W1mjSchYZwk966wZryx+JqFyYeVyjB+wTQ9m26iU/fOi+
         Tsj8fynIi6hIymiBXEbqMomFRIF3z5ibGzUHXMvjQcGYeOmEVeW+oT6+4JcyC9tIkGsy
         1/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KAYcwdEpoVrSTjqjj2bz2wiUuAL3BQElx8kbSmUncfs=;
        b=PirVNwDS+ZO08LEWhiZb+xAauL1kmc7v5ij38WmnYjgpe0nQUwzwqUIpXTX9rkjl6X
         Uc/CmPUSIztnqjFOFgu+F9IP7g0fvZZEagiyXV9p9qETYccon1KTWvGv/mu9cj1qKWyj
         t01qF3CciCKnLXBMYBtnTP7ggiuqQXRi4Q4feLd3kGP3GB5hRxmfsUwa5WYXJeL/t8HT
         NlMyddKOEfI2idGyIowezeT/xVpzV93P0UAST66L8gsAQuJD84PkJgA4je68G0/v9jG7
         eo/s8EchkzF0ypNc2vx2h4WxuBj33UvCudX1wX2onXCSYzzEKXVabX1srTfi4XqRbit4
         NMTg==
X-Gm-Message-State: AFeK/H0igEUzJRXHeYy3shbv+2ur6QNGPbDvtYhMBLkJeIKATH645qo1MRnVxehBCzR3ZZWL606/jjhhNBgmVA==
X-Received: by 10.28.199.129 with SMTP id x123mr14103917wmf.7.1490281655704;
 Thu, 23 Mar 2017 08:07:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.91.2 with HTTP; Thu, 23 Mar 2017 08:07:15 -0700 (PDT)
In-Reply-To: <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com>
References: <20170321055203.26488-1-alexhenrie24@gmail.com>
 <xmqqinn2sfdw.fsf@gitster.mtv.corp.google.com> <xmqqzigemfij.fsf@gitster.mtv.corp.google.com>
 <CAMMLpeQZXzPtN+mmtRS33vbT6hFz8p0qqjFMhz9tUHk747=Z3Q@mail.gmail.com> <xmqqmvcdmeuv.fsf@gitster.mtv.corp.google.com>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Thu, 23 Mar 2017 09:07:15 -0600
Message-ID: <CAMMLpeR-zCpL5Gx=BoK8G9_wL2TBe-wD3VnsAShAuVVzS=Nirg@mail.gmail.com>
Subject: Re: [PATCH] log: if --decorate is not given, default to --decorate=auto
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2017-03-22 10:54 GMT-06:00 Junio C Hamano <gitster@pobox.com>:
> Alex Henrie <alexhenrie24@gmail.com> writes:
>> No problem. Do I need to submit a second version of the patch with a
>> test for `git -p log`?
>
> You do want to protect this "without an option, we default to
> 'auto'" feature from future breakage, no?

Yes, but I need to know whether you want a v2 of this patch with all
of the changes including the new test, or a second patch that depends
on the first patch and only adds the new test.

-Alex
