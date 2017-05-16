Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2FF1FAA8
	for <e@80x24.org>; Tue, 16 May 2017 16:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbdEPQFb (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 12:05:31 -0400
Received: from mail-wr0-f180.google.com ([209.85.128.180]:33241 "EHLO
        mail-wr0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbdEPQFa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 12:05:30 -0400
Received: by mail-wr0-f180.google.com with SMTP id w50so79921660wrc.0
        for <git@vger.kernel.org>; Tue, 16 May 2017 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iSh4nFauMuDNfZcDcwO4DmZGcaFQbdtWuMZ6FIPmDDo=;
        b=TJ3TMapycmGU49okdH/s2QopGOtF/ZxQP/QDRUf5kgZShNjiXgigS8ZBOYVFE+Rt22
         ELeVIBGe3dm7p3qtGWXyGGrsFBkdStFnR4hlOiZkVkyyjH3lKYHJYEs3fti2ynJpdj8z
         HIwQEZx6but8C6fgcyqif710STep6IvbmMflmtD3kP5ZcR9mgM58DCIBFahjuGfv2BoR
         HbI6YsAn7i4z07xhDUvKDcXTqjNGNp31VCtz28ivM4P03opNicadzsUz5sDSmu2td4QP
         aXNtV+1H2PPyFjboSVdBWgKB0d+DWzvMvJk1S48pg+qfez3L86tF5e8fleWw3ybfn2bT
         GeIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iSh4nFauMuDNfZcDcwO4DmZGcaFQbdtWuMZ6FIPmDDo=;
        b=sqLAU+jaHSY3Es532zjNjYU9j2ZzZN1XXLQoKJToP8dC3NFiJW+5N7qQYRCW4EAu4W
         LM/RxQCWkBJENNTXvCOO31UwAVT0dA77AeQTN3qC7hUHq4uj6kHdrzVNjOKqRq65YdaH
         j5jnYdFrpgmQZrzukb3Nni7IzwFxqs8AiKhN9WEPbiDCmd+d0566733dKrovIZzDux2p
         GfH0dUCAapDsvvMm6+6ojgoLnkwiQZjS3BHSB5RLYef5AM1IQNYHwKC2E9mlSH4qJX+M
         juOhWX5HeGpvLpSqkGW9Dd27aE346BYL5v53aBOHvB/tzxR2kyqcHfqga0+MeYZcPFOg
         nYEA==
X-Gm-Message-State: AODbwcBH7NH6sq5pQGVUsyP2O8LFCzPwNZ7L3KXNw7JyIRCtihkcPK3t
        vq19EJrzmygSFpcd6v66CtLnZ9stduvChXI=
X-Received: by 10.223.176.83 with SMTP id g19mr7845002wra.12.1494950728626;
 Tue, 16 May 2017 09:05:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.18.149 with HTTP; Tue, 16 May 2017 09:05:27 -0700 (PDT)
In-Reply-To: <CAGZ79kZSixaG2CoO-WV47=-eE96yhtoCm82KFbZ=-=8c-VPXcA@mail.gmail.com>
References: <20170514040117.25865-1-sbeller@google.com> <20170514040117.25865-4-sbeller@google.com>
 <115f4d30-5c97-9ee9-e56b-3cf955a5454e@google.com> <CAGZ79kZSixaG2CoO-WV47=-eE96yhtoCm82KFbZ=-=8c-VPXcA@mail.gmail.com>
From:   Jonathan Tan <jonathantanmy@google.com>
Date:   Tue, 16 May 2017 09:05:27 -0700
Message-ID: <CAGf8dgJY0=hr9_M3LijZnEhv7rEad8XHAjcpjG425JtKNjweHQ@mail.gmail.com>
Subject: Re: [PATCH 03/19] diff.c: drop 'nofirst' from emit_line_0
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 15, 2017 at 11:33 AM, Stefan Beller <sbeller@google.com> wrote:
> On Mon, May 15, 2017 at 11:26 AM, Jonathan Tan <jonathantanmy@google.com> wrote:
>> I also don't understand the meaning of this paragraph - if you mean that
>> this patch teaches other callers to hardcode the sign, I don't see any such
>> changes in the diff below.
>
> The last two hunks of the patch switch two callers that call with a sign
> that is hard to reason about.

The last two hunks don't hardcode any signs, as far as I can see. They
do pass in a "first" character that may or may not be a sign, if that
is what you mean.

In any case, can you reword that paragraph into an imperative
statement (e.g. "teach X to...", "make X...")?

>>> +                       char term[2];
>>> +                       term[0] = options->line_termination;
>>> +                       term[1] = '\0';
>>> +
>>> +                       emit_line(options, NULL, NULL,
>>> +                                 term, 1);
>>
>>
>> If options->line_termination is 0, this is actually a zero-length string
>> (not 1).
>
> So passing in !!options->line_termination should be fine?

Yes, that would work. I slightly prefer !!term[0].
