Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 040E81F859
	for <e@80x24.org>; Wed, 24 Aug 2016 06:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751042AbcHXGaT (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 02:30:19 -0400
Received: from mail-yb0-f175.google.com ([209.85.213.175]:36477 "EHLO
        mail-yb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbcHXGaT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 02:30:19 -0400
Received: by mail-yb0-f175.google.com with SMTP id e31so2454607ybi.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2016 23:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=HmhMoYlLgCWqi+j9AZiJwF6oXIaix+xJsdCXle60IGs=;
        b=akbzq6E9/I7xUXjnYgJX3qWXzy2E3hdP3l80wAGvgiyTjkqPH1rliWZEwU+EBSi4L5
         29mwo3vJ14gh5dCQjV3YRDh5CNE+/l9y1/RZH5Wzw3RwP4l0bUzmfPJrejGql776Myyg
         UqWqez5FutFssSXbEGgKP5cnK6vaUiAhW3Nx7Ffp6ywevNMC9bu2tIoiDBEfMeNRbR8U
         v4CF60dbmNYBCe9jI4yOKEh0wFfIgIzWpLqt+lBnPOtcN3S95x9vN5Kvdt2OLp/fUS+g
         FsybNKPhhvq9gNpsr8hmiVkCKnvS81ayEUTgAJzG8BccgvGBSfJL0yZJGccHWcOkCSId
         OpqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=HmhMoYlLgCWqi+j9AZiJwF6oXIaix+xJsdCXle60IGs=;
        b=hL701QRLcFTwLCsB3NXH5H4uFkRdzDBkpi3yXuSha8GamwpmgZbkELekAi4xVkj6rl
         7K/L8KrsxVWKfq+vhONtfVfX+bQnkDQ9ObEGkm8aiuiKGfdvBeuAxnaKBUB8GW6oJlI1
         e00FNRZbLDdGT5kXw4VEnZ9eV3MJJStJAzlxCnLrnTI3GFlFLtJIfwqdH5UBnK2yE2z4
         y8pa5/aGPl3sTCw32VQzeAEMOAhxnL3BAVivdDr6FEOz/Cy0VAwyAm64JSk93lO02kJ7
         dL+YqgwWoowGuXjNgdZog0DbiXhV4UjjilsvaZrIZPXrHlPEMIcs4MEn7k8wQ1vvl9zn
         cVvA==
X-Gm-Message-State: AEkoouvfVpfjgzpwbtbQ2KVQ5gSRjrV9YaFQlCxXS3YFUI7xWuaJwCSYr7190WNBvBeoDM/qnK2bbAkmjSzEgg==
X-Received: by 10.37.110.86 with SMTP id j83mr1078706ybc.136.1472020216189;
 Tue, 23 Aug 2016 23:30:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Tue, 23 Aug 2016 23:29:55 -0700 (PDT)
In-Reply-To: <CAGZ79ka6nwYjBRcUKAxCqAodq=Hw6f86J0Mq6GWyKgMO_PNi4A@mail.gmail.com>
References: <20160815215327.15682-1-sbeller@google.com> <20160815215327.15682-9-sbeller@google.com>
 <CA+P7+xpDqkTFLUJBhSwWiVnXw-iy1fmGBWzVBLmybOcPOmevBw@mail.gmail.com> <CAGZ79ka6nwYjBRcUKAxCqAodq=Hw6f86J0Mq6GWyKgMO_PNi4A@mail.gmail.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 23 Aug 2016 23:29:55 -0700
Message-ID: <CA+P7+xpmyx+QsdOpS7JC1i9Z6cdsy_=MK7J_rGYiukPsqAJBVQ@mail.gmail.com>
Subject: Re: [PATCHv5 8/8] clone: recursive and reference option triggers
 submodule alternates
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jens Lehmann <Jens.Lehmann@web.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 23, 2016 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
>>> +
>>> +       if (option_recursive) {
>>> +               if (option_required_reference.nr &&
>>> +                   option_optional_reference.nr)
>>> +                       die(_("clone --recursive is not compatible with "
>>> +                             "both --reference and --reference-if-able"));
>>
>> So if you have multiple references that don't all match we basically
>> just refuse to allow recursive?
>>
>> Would it be better to simply assume that we want to die on missing
>> references instead of failing the clone here?
>
> The new config options are per repo (or even set globally), and not
> per alternate. And as we communicate the [if-able] part via the config
> options to the submodules it is not feasible to transport both
> kinds of (reference-or-die and reference-but-ignore-misses).
>
> That is why I introduced this check in the first place. If we'd go back
> to the drawing board and come up with a solution that is on a
> "per alternate" basis we could allow such things.
>
>> That is, treat it so
>> that multiple reference and reference-if-able will die, and only info
>> if we got only reference-if-able?
>>
>> Probably what's here is fine, and mixing reference and
>> reference-if-able doesn't make much sense.
>
> I think the reference-if-able doesn't make sense for one project alone
> as you can easily script around that, but is only useful if you have
> submodules in a partially checked out superproject that you want
> to reference to.
>
> Thanks,
> Stefan

I'm not sure there is a better design.  How are alternates stored? In
a config section? Or is there some way we can store the is-able per
alternate and look it up when adding them to submodule?

Thanks,
Jake
