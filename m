Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BBB20966
	for <e@80x24.org>; Tue,  4 Apr 2017 08:24:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753045AbdDDIYQ (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Apr 2017 04:24:16 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:33782 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751101AbdDDIYN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2017 04:24:13 -0400
Received: by mail-it0-f41.google.com with SMTP id 68so15304034itx.0
        for <git@vger.kernel.org>; Tue, 04 Apr 2017 01:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1G3bA7lGTUsAGKa2bKCsL7LcWxm5yld08yRLhtWvLgA=;
        b=m/Hns1B1gPVFivzlVmD/ms+TnQxazeqXJdV8ryZbkDUbRfPDt+EM8wYNgk91UNGSAE
         /G3/QhGmNsXywDhIAZHcbQbhyVvFFSAviw22DVfGlqeRlHT9zPvGBZR1HcWQoMI8UyO0
         q8tPKMIqcTiK4GNuu5VaCbpIxb8VEMXAJ5Vg9Y0pKDMebSilW6mENQ2MzzxjsJMZZfTy
         B5YiEmTa4xiYh+HjJzuv+36TdDDuQijeAICdkPBtnErfNWit0Nd/HtmjPwIk+7Bmsu7g
         Su7+DZUUkKvyyZPCko0zuxxW255QwR6GiYt+1W3Cf/WIqKB/NwrgUKG1lBrNyhlomD/E
         JMFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1G3bA7lGTUsAGKa2bKCsL7LcWxm5yld08yRLhtWvLgA=;
        b=adcM7R2EjUEoGj8GnvNgQalUCOOQtZeTfGdxOOAhthVoeymoNsEf87qbO/ogXJ8EP4
         +kZLHk6nPj260yuD7AfYS0OQ+Y3yRpf7MdqwO/wUtqOagyztDJKnT8KEiHwJdXoUHA5b
         R5O59aR4IckI7QIaWoJTREB1LCVCrc5VA0VCx+WToj8NoO6jaopx8PhmGWd+ClPKXGq7
         Y/vtzbR8o510tt7cF9Bps4O+gOZF4N/aFaPmVYQOELkyTr/fbRVstn+Eajf8A2Scom3h
         g3hEfWFR4M+npNKLjqxdBn1QZnSR00K25KX0QzD0adDFSxq4pF1M/blZ7sTECT1XKqbr
         xAoQ==
X-Gm-Message-State: AFeK/H1DJBpePJFe+GAndPCEV1vyYCoEZsRlwsuJ+47deOm//nt44qkz3UlPKx6fipAH5iXN5TNk0Dzkd9BlXg==
X-Received: by 10.36.131.201 with SMTP id d192mr15316657ite.60.1491294253027;
 Tue, 04 Apr 2017 01:24:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 4 Apr 2017 01:23:52 -0700 (PDT)
In-Reply-To: <20170404022945.nmadthjzovmjplyb@sigill.intra.peff.net>
References: <20170403185306.36164-1-git@jeffhostetler.com> <20170403185306.36164-3-git@jeffhostetler.com>
 <CACBZZX7DFuLia8RzB908EG7+oWQiFGkFEq14bzT77A75msM98Q@mail.gmail.com> <20170404022945.nmadthjzovmjplyb@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 4 Apr 2017 10:23:52 +0200
Message-ID: <CACBZZX50+Mpj-GY11KNmh+BkNkWCX3OZjHFQ3iK8c8Hib90_Xg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fsck: force core.checksumindex=1
To:     Jeff King <peff@peff.net>
Cc:     git@jeffhostetler.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 4, 2017 at 4:29 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 03, 2017 at 10:31:03PM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> On Mon, Apr 3, 2017 at 8:53 PM,  <git@jeffhostetler.com> wrote:
>> > Teach fsck to override core.checksumindex and always verify
>> > the index checksum when reading the index.
>>
>> Sorry to only chime in about this at v4.
>>
>> I think this patch & the documentation you added for
>> core.checksumindex in 1/4 would be much less confusing if you made
>> this a on-by-default command-line option like e.g. "full".
>>
>> With this patch nothing amends the documentation to indicate that the
>> core.checksumindex is magically overridden when fsck runs, I think
>> something like this (needs amending to integrate) on top would make
>> this clearer:
>
> I think that is the wrong direction to reduce confusion. We don't need
> more options to twiddle this flag, we need fewer. For instance, in your
> proposed documentation:
>
>> @@ -61,6 +61,11 @@ index file, all SHA-1 references in `refs`
>> namespace, and all reflogs
>>         object pools.  This is now default; you can turn it off
>>         with --no-full.
>>
>> +--[no-]checksum-index:
>> +       Validate the checksum at the end of the index file, on by
>> +       default, locally overrides any "core.checksumIndex" setting
>> +       unless negated. See linkgit:git-config[1].
>
> That tells us _what_ it does, but I'm left scratching my head with
> "why".
>
> I don't think there is any reason you would want fsck not to compute
> that checksum (just like there is no option to ask fsck not to check
> pack sha1 trailers).
>
> I would go so far as to say that the config option itself is unnecessary
> in this iteration of the series. I only asked for it so that we could
> test the verification code paths (both for correctness and performance).
> But if fsck can exercise the code path, we can check correctness that
> way. And for performance, it's probably enough to test two separate
> builds (which Jeff has already done).
>
> Junio also asked for the usual "add a config, and then later we'll flip
> the default" procedure. But IMHO that isn't necessary here. Nobody
> should ever care about this flag. It was largely useless to check it on
> every read in the first place. And if you suspect there's corruption in
> your repository, you should run "git fsck".

The part that confused my & I found unintuitive is that there's a new
core.WHATEVER config that'll get silently overridden by a specific
command, git-fsck.

Nothing else I can think of in core.* works like this, i.e. it's a
namespace for "applies to all of git", core.editor, core.ignoreCase
etc.

Having git-fsck have a command-line option that's on by default as I
suggested is one way to get out of that confusion. It makes it a
special case of a CLI option overriding some config.

But yeah, another way to resolve this is to get rid of the config
option altogether, or document in git-config.txt that
core.checksumIndex is obeyed by everything except git-fsck.
