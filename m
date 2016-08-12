Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2DB651F859
	for <e@80x24.org>; Fri, 12 Aug 2016 15:51:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbcHLPvq (ORCPT <rfc822;e@80x24.org>);
	Fri, 12 Aug 2016 11:51:46 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34990 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752365AbcHLPvp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2016 11:51:45 -0400
Received: by mail-io0-f177.google.com with SMTP id m101so28224389ioi.2
        for <git@vger.kernel.org>; Fri, 12 Aug 2016 08:51:44 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PcUGw3PyTK2t81BduUP9b28nFW/AeTeGxYXr5fqje9o=;
        b=BTYh4yQyK2zLeW5Vx6ZxZk7IleEu1JbJy/3LNDzCiUKCVpIMhz59W0/+xt/1QzJgR1
         Py+cDrMaPlmcv6WqTtanKcVf/nFC4vcogxV19ywDE1WVqPf27z00oZCH0Bi03qKo6TwO
         DRtOv4p7yARD/mbG9kxaeUXkaVQ0K0PeDM7yMyDX9oGFfn5h3L2HLhGjz2+RjEGjLZmI
         t6w6QwBaSMX2ED5Uw0aP/eg0Qqd09PIqWr4iGn6Mu2saXb/vsvYo6z9sHHTr4/SNS/OM
         ry71ZfXPY3V2pa2t48Yde+Tgtt1TEi+9tpn9YbIsrDKPiOAA+WpjRDk1aKZ7MTMj3BCS
         86lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PcUGw3PyTK2t81BduUP9b28nFW/AeTeGxYXr5fqje9o=;
        b=SgGsWXqwUCkUKEcdhkuZ5eTzTvatbx2MIIPllhGcFkrnBHe5eDgmu4Lh5ej2Qrxjsf
         jYbOFAGmZCFgAS+DuY9EqaB/JZbI877T+f/r/escry1so/NIg9GdfSVqU5xK/W/d18X3
         8Ast01y3nQehw4g0yw3sHJlvxJQmmaiAWf8t9+/Gc6x7GSNK3mVbds02LRmOIcbwUWo7
         6gw/QKgLD5FlWxoQQldy3qET0Z+AtzKK2x5GvXY6dUGk3oPieQ7+oeeADv5Fbu1EwYos
         Wkc4rPIsOCZesLRhNW8a33hQ4U0zkZYmd8qZ6J7t5k7pyuSe4Tvg3Y3bCVi2hejYUpEv
         aKow==
X-Gm-Message-State: AEkoouuOHvyjw0rbT7B2fe11zxqbg+c4WFKfpy5gDPTdmHXsQzQKrz4GkNhBYYx/8IWIjcLAnmmuVUweE1FMtwuk
X-Received: by 10.107.178.129 with SMTP id b123mr19161701iof.83.1471017104087;
 Fri, 12 Aug 2016 08:51:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.128.66 with HTTP; Fri, 12 Aug 2016 08:51:43 -0700 (PDT)
In-Reply-To: <20160812154331.y2z6pv2w6cwsdsqw@sigill.intra.peff.net>
References: <20160812153744.15045-1-sbeller@google.com> <20160812154331.y2z6pv2w6cwsdsqw@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Fri, 12 Aug 2016 08:51:43 -0700
Message-ID: <CAGZ79kaOHdLrPownWdnZQSEzG6P6-iZqx2xu3MEG51DZU1U+Cg@mail.gmail.com>
Subject: Re: [PATCHv3] checkout: do not mention detach advice for explicit
 --detach option
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Aug 12, 2016 at 8:43 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Aug 12, 2016 at 08:37:44AM -0700, Stefan Beller wrote:
>
>> > Is there a reason for not unsetting `advice.detachedHead` at the
>> > end of the test?
>>
>> done
>>
>> I did not consider to clean up after myself... what a selfish world!
>
> The right way to do it is:
>
>   test_config advice.detachedHead false &&

okay.

>   ...
>
> so that the cleanup runs whether or not you may it to the end of the
> script.
>
>> +test_expect_success 'no advice given for explicit detached head state' '
>> +     git config advice.detachedHead false &&
>> +     git checkout child &&
>> +     git checkout --detach HEAD >expect &&
>> +     git config advice.detachedHead true &&
>> +     git checkout child &&
>> +     git checkout --detach HEAD >actual &&
>> +     test_cmp expect actual &&
>> +     git checkout child &&
>> +     git checkout HEAD >actual &&
>> +     ! test_cmp expect actual &&
>> +     git config --unset advice.detachedHead
>> +'
>
> Hmm. Using "!test_cmp" seems weird to me, just because it would falsely
> claim success if something else unexpected changes. Our usual method for
> making sure some particular output does not appear is "test_i18ngrep"
> with a liberal pattern.

and I advanced the liberal a bit more. ;)
So maybe we'd be looking that no 'detached HEAD' occurs?

    test_i18ngrep ! "'detached HEAD'" actual

I think testing that we do not give out advice (i.e. behave the same as if
not giving out advice) is best tested to just compare the output to
the output of "git -c advice.detachedHead=false ...", which is what I do here.
This seems to be future proof to me no matter how we reword the advice or
the actual message on checkout?

Thanks,
Stefan

>
> -Peff
