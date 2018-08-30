Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DEB71F404
	for <e@80x24.org>; Thu, 30 Aug 2018 21:43:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbeHaBrX (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 21:47:23 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36448 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbeHaBrX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 21:47:23 -0400
Received: by mail-wr1-f68.google.com with SMTP id m27-v6so9375509wrf.3
        for <git@vger.kernel.org>; Thu, 30 Aug 2018 14:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=eHIHSOG2W1i/I5dOnRf438c2glop7qS2SqBLsh+dFVI=;
        b=q3c/xfc70w6Yj01zpY1zucgvvOLLw7zbAKoNYIreLIPHZlTekxaYtia1YRgFOWqdxq
         236g2nr5JCS24ww+t9x5LN32bbQxdaidl2Cf9c/zuR6/1YoVnJfdLjDiBXChM6aeI2CL
         YdOUF1TOcMHzq2URlcbKv2G4D1036DbaMtN71+p5xZiL6vr1ApUgeDT8s4y5tyQV6m8C
         rSqebURq2MU1zB1Wy7RIH2cYQLELANQBlXoTNe1aTqMPQxPco4/O9MjmELNRUUzoKN3g
         V2/VOeJ/dk5rN6qi/bcrnqU5WiV1Vf2ldxvqwdaheKw6rQozm0gmP8XKCRWgIMIOUGRM
         cgHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=eHIHSOG2W1i/I5dOnRf438c2glop7qS2SqBLsh+dFVI=;
        b=f7j2URfxZ4bo5/2lESll11sOga/YZ8iN+H46RX56HOIdiAjnf0BfFzWOCgWEd6MuHu
         FxTTikJ39ss9iJHEFWwBXEi7lUTMNvBWsxmbcX/F5C7WqQEcPaQ41cg1F7HXtn2dFPR/
         C4YKD0zDT1JQ121NimMkaKD7i+oSPUbdVOVYkSd4WgTttTo0mh3fMiOmY9rGGqBM9ZDU
         vbgykkIesOVAjadiE4RvVM9Yd09gUaAMkeO9+HDRB7NF6jAbD9Sdh0/V2Qr3hVs7pirf
         9QtPrS2YSU0ecRrC+7XAWDcBklLTr8yip/Idos1dj1Z5ut6LZ5rMYgVrJ6TCnnDPue6w
         /6zw==
X-Gm-Message-State: APzg51AJuUarYTj3FbICkyptN3ruHTrr7BHlT3VHW+NdjE4LE6QNVIBm
        HVC6xCt4p94eUNb39RfhvLE=
X-Google-Smtp-Source: ANB0VdZtjkwyVMhqrl7xI8kgL6BDnKgC6lONSGe5HjEaB9EFoj6PUad2ccUvtiUQd/qV2oC7Rdx05Q==
X-Received: by 2002:adf:eb47:: with SMTP id u7-v6mr8741666wrn.22.1535665389598;
        Thu, 30 Aug 2018 14:43:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z14-v6sm2682432wma.18.2018.08.30.14.43.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Aug 2018 14:43:09 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Wink Saville <wink@saville.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Bryan Turner <bturner@atlassian.com>,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Kristian =?utf-8?Q?H?= =?utf-8?Q?=C3=B8gsberg?= 
        <krh@redhat.com>
Subject: Re: [PATCH v4 6/6] fetch: stop clobbering existing tags without --force
References: <20180813192249.27585-1-avarab@gmail.com>
        <20180830201244.25759-7-avarab@gmail.com>
Date:   Thu, 30 Aug 2018 14:43:08 -0700
In-Reply-To: <20180830201244.25759-7-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 30 Aug 2018 20:12:44 +0000")
Message-ID: <xmqqwos73503.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:

>  +
> -Unlike when pushing with linkgit:git-push[1], any updates to
> -`refs/tags/*` will be accepted without `+` in the refspec (or
> -`--force`). The receiving promiscuously considers all tag updates from
> -a remote to be forced fetches.
> +Until Git version 2.20, and unlike when pushing with
> +linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
> +without `+` in the refspec (or `--force`). The receiving promiscuously
> +considered all tag updates from a remote to be forced fetches. Since
> +Git version 2.20 updates to `refs/tags/*` work the same way as when
> +pushing. I.e. any updates will be rejected without `+` in the refspec
> +(or `--force`).

Have a comma after 2.20; otherwise it was unreadable, at least to
me, who took three attempts before realizing that the "updates" is
not a verb whose subject is "Git version 2.20".  Or

	Since Git version 2.20, fetching to update `refs/tags/*`
	work the same way as pushing into it

perhaps.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index b0706b3803..ed4ed9d8c4 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -667,12 +667,18 @@ static int update_local_ref(struct ref *ref,
>  
>  	if (!is_null_oid(&ref->old_oid) &&
>  	    starts_with(ref->name, "refs/tags/")) {
> -		int r;
> -		r = s_update_ref("updating tag", ref, 0);
> -		format_display(display, r ? '!' : 't', _("[tag update]"),
> -			       r ? _("unable to update local ref") : NULL,
> -			       remote, pretty_ref, summary_width);
> -		return r;
> +		if (force || ref->force) {
> +			int r;
> +			r = s_update_ref("updating tag", ref, 0);
> +			format_display(display, r ? '!' : 't', _("[tag update]"),
> +				       r ? _("unable to update local ref") : NULL,
> +				       remote, pretty_ref, summary_width);
> +			return r;
> +		} else {
> +			format_display(display, '!', _("[rejected]"), _("would clobber existing tag"),
> +				       remote, pretty_ref, summary_width);
> +			return 1;
> +		}
>  	}

A straight-forward change to turn an unconditional update to either
an unconditonal rejection (when force is not given) or an
unconditional acceptance (when forced), which makes sense and has
near-zero chance of being wrong ;-)

It is a huge change in behaviour, but in a very good way.  I'd
imagine that users will welcome it very much.

