Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1092F1FBB0
	for <e@80x24.org>; Mon,  5 Sep 2016 19:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933557AbcIETr5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Sep 2016 15:47:57 -0400
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33906 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932319AbcIETrz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2016 15:47:55 -0400
Received: by mail-wm0-f45.google.com with SMTP id w207so29099974wmw.1
        for <git@vger.kernel.org>; Mon, 05 Sep 2016 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Shluen3XOHaTJ+xRNMKbTPUCHuPdNnvo8SZT8DpFIJ4=;
        b=yviBGcgj2qG+4QrQ+BKs0TfBqdgYxboU26PDsy+ZQwqZaW90/PIU0sz/15VbcyGY6I
         h6f5BbsHNBhClXRn3eV3R3FAOQr4DQL9pqwvqu+ZAIV8x8KEQC1BFFAZT9G7bjZ1y3c+
         iIpFYy8O371Jys65/rfCFCRvw4eUjaiKJ5N5KpaB90sHVee5r1abMT+VYSmaH4mT9+yo
         yAnJbl3DE8eDeiB1xqgeI3LvkQDvOcU5iLiayrau2sJ2M70cT4HLvhFOO1zMggZnMrUL
         j8ZjIfcWJxgROmBg7ZHwobkK3xTZm18+8P4gFptd5KdlvJVXsD2V0OILLaSBPlRg6786
         wSow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Shluen3XOHaTJ+xRNMKbTPUCHuPdNnvo8SZT8DpFIJ4=;
        b=PSN8mAP4pKl90+6rjqrz84yPgisPCTiMIlgXhjLwPeMQ0eIcCXV0r7SJwbuZj2R4si
         YC2wcF2gzCW4rQn9utwchnmf04Vf50NilzC9XPjmPrm7rxnMdp7Yr/o2D0BYoLbBKbTO
         1N0d1q12tqIaQMi2Y6h4C2Gw67VudsjxdgaczgiCbN68YSfk3zjRPnJb3gyHA2VK1JrL
         4JbV7O+6hCl9Uhf6TqXDoWiGRSxzge+yYOcg3MGldZPqxtxlvYW+z1oLO/iZSCdzjskY
         7qeeQ7Z/W+y64nQYr8EeS2gbyw0yNEX7TO4KKTTw9KSweTHKZ819oNFGDWITkwlZpsKM
         00YQ==
X-Gm-Message-State: AE9vXwPrbPkGzDbzunbM9vkKe1UEive6zhwJY+uICRu4JoAy9iuRr8q87+rfUviesNdIcw==
X-Received: by 10.28.50.199 with SMTP id y190mr17791436wmy.61.1473104874033;
        Mon, 05 Sep 2016 12:47:54 -0700 (PDT)
Received: from far1pr3662.ads.autodesk.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id f187sm22477398wmf.15.2016.09.05.12.47.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Sep 2016 12:47:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v6 12/13] convert: add filter.<driver>.process option
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <7fbd02a1-ad62-7391-df2a-835aae8a62a7@gmail.com>
Date:   Mon, 5 Sep 2016 21:47:50 +0200
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        peff@peff.net, sbeller@google.com, Johannes.Schindelin@gmx.de,
        mlbright@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CCFE4E4A-0724-4AE0-9356-6E95B7C331AF@gmail.com>
References: <20160825110752.31581-1-larsxschneider@gmail.com> <20160825110752.31581-13-larsxschneider@gmail.com> <xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com> <7A378528-58DE-4C17-9F00-9708947716DD@gmail.com> <xmqqbn0a3wy3.fsf@gitster.mtv.corp.google.com> <7fbd02a1-ad62-7391-df2a-835aae8a62a7@gmail.com>
To:     =?utf-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 30 Aug 2016, at 22:46, Jakub Nar=C4=99bski <jnareb@gmail.com> =
wrote:
>=20
>>> The filter can exit right after the "error-all". If the filter does
>>> not exit then Git will kill the filter. I'll add this to the docs.
>>=20
>> OK.
>=20
> Is it explicit kill, or implicit kill: close pipe and end process?

I close the pipe and call "finish_command".


>>> "abort" could be ambiguous because it could be read as "abort only
>>> this file". "abort-all" would work, though. Would you prefer to see
>>> "error" replaced by "abort" and "error-all" by "abort-all"?
>>=20
>> No.
>>=20
>> I was primarily reacting to "-all" part, so anything that ends with
>> "-all" is equally ugly from my point of view and not an improvement.
>>=20
>> As I said, "error-all" as long as other reviewers are happy with is
>> OK by me, too.
>=20
> I'm rather partial to "abort" instead of "error-all", or "quit"/"exit"
> (but I prefer "abort" or "bail-out"), as it better reflects what this
> response is about - ending filter process.

After some thinking I agree with "abort" instead of "error-all".


>>> A filter that dies during communication or does not adhere to the =
protocol
>>> is a faulty filter. Feeding the faulty filter after restart with the =
same=20
>>> blob would likely cause the same error.=20
>>=20
>> Why does Git restart it and continue with the rest of the blobs
>> then?  Is there a reason to believe it may produce correct results
>> for other blobs if you run it again?
>=20
> I guess the idea is that single filter can be run on different types
> of blobs, and it could fail on some types (some files) and not others.
> Like LFS-type filter failing on files with size larger than 2 GiB,
> or iconv-like filter to convert UTF-16 to UTF-8 failing on invalid
> byte sequences.

This mimics the v1 behavior and I will explain that in the =
documentation.


>>> B) If we communicate "shutdown" to the filter then we need to give =
the
>>>   filter some time to perform the exit before the filter is killed =
on
>>>   Git exit. I wasn't able to come up with a good answer how long Git=20=

>>>   should wait for the exit.
>>=20
>> Would that be an issue?  A filter is buggy if told to shutdown,
>> ignores the request and hangs around forever.  I do not think we
>> even need to kill it.  It is not Git's problem.
>=20
> I think the idea was for Git to request shutdown, and filter to tell
> when it finished (or just exiting, and Git getting SIGCHLD, I guess).
> It is hard to tell how much to wait, for example for filter process
> to send "sync" command, or finish unmounting, or something...

I like Junios approach because then we don't need to wait at all...


>> I personally would be reluctant to become a filter process writer if
>> the system it will be talking to can kill it without giving it a
>> chance to do a graceful exit, but perhaps that is just me.  I don't
>> know if closing the pipe going there where you are having Git to
>> kill the process on the other end is any more involved than what you
>> have without extra patches.
>=20
> Isn't it the same problem with v1 filters being killed on Git process
> exit?  Unless v2 filter wants to do something _after_ writing output
> to Git, it should be safe... unless Git process is killed, but it
> is not different from filter being stray-killed.

Yes, it should be safe. However, I think it is probably nicer if the =
filter
process can shutdown gracefully instead of being killed.


>>>>> +Please note that you cannot use an existing =
`filter.<driver>.clean`
>>>>> +or `filter.<driver>.smudge` command with =
`filter.<driver>.process`
>>>>> +because the former two use a different inter process =
communication
>>>>> +protocol than the latter one.
>>>>=20
>>>> Would it be a useful sample program we can ship in contrib/ if you
>>>> created a "filter adapter" that reads these two configuration
>>>> variables and act as a filter.<driver>.process?
>>>=20
>>> You mean a v2 filter that would use v1 filters under the hood?
>>> If we would drop v1, then this would be useful. Otherwise I don't
>>> see any need for such a thing.
>>=20
>> I meant it as primarily an example people can learn from when they
>> want to write their own.
>=20
> Errr... if it were any v1 filter, it would be useless (as bad or
> worse performance than ordinary v1 clean or smudge filter).  It
> might make sense if v1 filter and v2 wrapper were written in the
> same [dynamic] language, and wrapper could just load / require
> filter as a function / procedure, [compile it], and use it.
> For example smudge/clean filter in Perl (e.g. rot13), and v2 wrapper
> in Perl too.

I'll provide a simple Perl rot13 v2 filter in contrib.

Thanks,
Lars=
