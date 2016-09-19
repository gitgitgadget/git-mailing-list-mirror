Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A49E72070F
	for <e@80x24.org>; Mon, 19 Sep 2016 23:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752607AbcISXq2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 19:46:28 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:33179 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751685AbcISXq1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 19:46:27 -0400
Received: by mail-yw0-f173.google.com with SMTP id i129so669990ywb.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gVK2GpVD1Ptg0lcFrbGwIR2M91witd24g5az+eJ+KYo=;
        b=ebikUUfPjCcaaF1kXQbAuf1Zp3EC0aOVurrAsmCe1OwsFARteBnm/xfD1k2u3tJadz
         ShS29bvTi/CWp6IZrIfnkxYPlUJjadE/JF0PVo0ArCvHcuN/JAPG/pOx7OKvBt0iU1FL
         GnWz+XoNrFEMOqfKxde/fywk3MFg5CCIMK24bNMh08RkfzwpZVJj+xuwGflzfXFTz01p
         hHlqi9cNkbegAcjCbcJ7i2zwPrp27+7FDp5O+gveIpmQFUWIm6L1xgJXYxU2ZKWH2+Yp
         47rM5OMdBcFkRzs20D61hxuB7MpRCl19Z9WRsF2rrb5mPcFUuq853oFV9RvFah/CSnBg
         bGdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gVK2GpVD1Ptg0lcFrbGwIR2M91witd24g5az+eJ+KYo=;
        b=SrG5bQdlh8yVs1yV8gF7XWQcdadWj/zzIr7xlHZfDjWp3kHnOJnBoYYtbSAXE7uZuN
         2QKWvSEQIczm+Y+/S1zXKV1F0yyfrjGAdqcriOVUVXBAkysNU4jjwqFD3GjQz3FcFfRz
         GUjGjxjmp4L1eQdyJOh+cPm5d78PHp90ZmIy5Y3PcaAWR/7k61mb7d7Eu0CnDUGQC3JW
         pXn2G6eFV0jlA3+KZlonnLs7FQbv6Dwn/dPrrUPYodEre8TeGaKZuxY54FeStO7THx8z
         kjL9+cc3KVdNkiQFNMuz7kR3k74WWpBgAOem9xbz9N7hN5oOjMi6kC8U8tFR3I/Pi5cg
         998A==
X-Gm-Message-State: AE9vXwOWZro4wZfAuhVSJdbYopgLBw2zEnjWF8SgmteVZAegw0QZyCpK7ROhKfg0h0j481sS+jycxw1Zv7KGVA==
X-Received: by 10.129.74.2 with SMTP id x2mr27332447ywa.59.1474328786666; Mon,
 19 Sep 2016 16:46:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Mon, 19 Sep 2016 16:46:06 -0700 (PDT)
In-Reply-To: <20160919234022.GA29421@cloud>
References: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
 <3df15bbb-7eac-86ec-2ccb-74a973482e8c@au1.ibm.com> <xmqqa8f3g4pu.fsf@gitster.mtv.corp.google.com>
 <20160919204408.GA28962@cloud> <20160919233434.fhkikksi4cxzrzb5@sigill.intra.peff.net>
 <20160919234022.GA29421@cloud>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Mon, 19 Sep 2016 16:46:06 -0700
Message-ID: <CA+P7+xp-CupfFwQv+U-KNh4bxG9Mxkbfip5RJebKX9gjffoOsw@mail.gmail.com>
Subject: Re: [PATCH v2] format-patch: Add --rfc for the common case of [RFC PATCH]
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 19, 2016 at 4:40 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Mon, Sep 19, 2016 at 04:34:35PM -0700, Jeff King wrote:
>> As far as your patch goes, I'd be OK with defining:
>>
>>   --rfc::
>>       Pretend as if `--subject-prefix='RFC PATCH'` was given.
>>

Would:

Shorthand for `--subject-prefix='RFC PATCH'`

be a better reading? I feel like using "pretend" is a bit weird here.

That being said, I'm not super strongly against it, but just find that
it sounds weird for documentation.

Thanks,
Jake
