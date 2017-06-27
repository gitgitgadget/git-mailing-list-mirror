Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81EA520401
	for <e@80x24.org>; Tue, 27 Jun 2017 15:53:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752108AbdF0Pxs (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 11:53:48 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34716 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751499AbdF0Pxr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 11:53:47 -0400
Received: by mail-pf0-f195.google.com with SMTP id d5so5289897pfe.1
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 08:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1r1x8rENZE/DnBDhJdbsSRwr/c6IVVlKENn0hlcEYIE=;
        b=lfLI4cYqOAhPTgmie9M6SAL24pU/pNpXyYrltBDM5sbFCTHIvv424dm1EcGX29wYbY
         FAJaECq7mgufBxHRhqUjb15Lp3u0NBlsmauv8DjfC4JKqizPjVFvF2Fx7vc4F8DHk0X/
         VPwajrBMZz4mX/xgXsgtyvd8tlhMU4TGWF1ZRyGKCtq66Xa24+C9QKX9+BHqBr5yPkT8
         ld8A8ExpvYOv/y9eA7D0zmbFHU1KztvjDlvmjff5oSLpOY8Qets2q/ROmxeivb4toAwR
         T+RqymrHvYKOpkAYf4i53lvb+w0HoXrvzfjQENDoB1oyjOQNjHVZ15CKpEfTWFjyIcU4
         WSyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=1r1x8rENZE/DnBDhJdbsSRwr/c6IVVlKENn0hlcEYIE=;
        b=J+j6DheqPoxk2NcfRtZ0lFn/Gz+aV3UVh68p5XQ1Bp6hLEaW8RnA8wc5u69egwxwzU
         tR95ZOjDTgbjYER4FfNnnOSdQ1GEoBv0Z1I5pIQNL3FMfrQoYQS/p5k6wBhHRoEYNfT+
         PGrx/BK7CyXUozCDtlKkzqzg2IV6puj0YWSAgyxU9+zbTLuCgi64/52nfJYBLxU8PT+5
         2dwL/0j+rE8eOk31p54DKCBb6+oXPKXG1ooOd8cZv355JtG5uWrRg2SkUCraNYwXxRAB
         ASWlTt2hDEpva8nkGlL/ec7XF2+MmQYP/L3dSfJfXjLSVFwBueTT7MwDHfVByZPAsznP
         Lbmw==
X-Gm-Message-State: AKS2vOygQcCNd7S85Z+TkJS7Gm1cWG7JaSXL9vVCiQo4Ld38alUJOC19
        cWdYY6T0F9qmwV5aDfs=
X-Received: by 10.101.83.197 with SMTP id z5mr6019068pgr.256.1498578826600;
        Tue, 27 Jun 2017 08:53:46 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:3095:bb54:d256:9ca9])
        by smtp.gmail.com with ESMTPSA id z82sm5517092pfk.1.2017.06.27.08.53.45
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 27 Jun 2017 08:53:45 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Michael Kebe <michael.kebe@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@Oracle.com>,
        Adam Dinwoodie <adam@dinwoodie.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/3] sha1dc: update from my PR #36
References: <20170627121718.12078-1-avarab@gmail.com>
        <CAKKM46tHq13XiW5C8sux3=PZ1VHSu_npG8ExfWwcPD7rkZkyRQ@mail.gmail.com>
        <20170627121718.12078-2-avarab@gmail.com>
        <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 27 Jun 2017 08:53:45 -0700
In-Reply-To: <xmqqmv8t317c.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Tue, 27 Jun 2017 08:22:15 -0700")
Message-ID: <xmqqinjh2zqu.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> +#else /* Not under GCC-alike or glibc or <processor whitelist>  or <processor blacklist> */
>> +
>> +#ifdef _BIG_ENDIAN
>> +/*
>> + * Solaris / illumos defines either _LITTLE_ENDIAN or _BIG_ENDIAN in
>> + * <sys/isa_defs.h>.
>> + */
>> +#define SHA1DC_BIGENDIAN
>
> This makes readers of this patch wonder why we assume platforms
> won't define _LITTLE_ENDIAN and _BIG_ENDIAN at the same time, just
> like we saw in the section with __BIG_ENDIAN above.

To be a bit more constructive, I'd feel it MUCH safer, if this "If
_BIG_ENDIAN is defined, set SHA1DC_BIGENDIAN" is done _ONLY_ when
we definitively KNOW that we are on Solaris, something like:

	#if defined(__sun) && defined(_BIG_ENDIAN)
	/*
	 * Solaris ...
	 */
	#define SHA1DC_BIGENDIAN
	#endif

> Thanks, but this is starting to feel like watching a whack-a-mole
> played while blindfolded.  At some point, somebody upstream should
> declare that enough is enough and introduce the "SHA1DC_FORCE_ENDIAN" 
> macro.
