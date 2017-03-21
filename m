Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9132095B
	for <e@80x24.org>; Tue, 21 Mar 2017 19:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758096AbdCUTE3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 15:04:29 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:33126 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758075AbdCUTD5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 15:03:57 -0400
Received: by mail-io0-f173.google.com with SMTP id f84so54108197ioj.0
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 12:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u92E5+bT0cVjwox1HhMofkE6Td3nGif7FwgpG8MILG0=;
        b=KsqgOiry/X4T36haZkjGD4Op7TNCZYcWHPdQcKMWO3tKUtGE5hdF0dTXifFnCu5G2F
         T9NGg1n0Kzs80s0FlS0jtiXaKbldrcrg/gXs8QeyYwbBDYONOSpiJqRj1jI98Ab4kzVe
         kMJF8A1gAKpf+dol1Y8f9P/CJxuvz7gEWTtE/nUlWDg+DJKaqP2X0ydFKut2VRDs0fvF
         M2C6kdwUkqk2x6L+x1WdxZYa4p/6SzGF+f4OfA+BGcAOUv+IfiICWmlsOAgZQ2p7aoyy
         6wFChFQi+fs64IwiyL5IlAmg0JEC3XXMHVsHQLo1GhTihxvBcrRBn/gn7RHxz6nBZhQa
         epgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u92E5+bT0cVjwox1HhMofkE6Td3nGif7FwgpG8MILG0=;
        b=HlEkWXvgw+FaRqPcphSVXn45XhxywIVnGheIxSvQW0MD4x0hPfuwNgdqcf0v6t1RHq
         VHqC26tpUOAZJ6RQO1REswHdU0NgzE2fnKXae2Klzn+vaKZQY9+UxL3yXq2XVRugTdx6
         dleiQYbLgcnOxsEH/KaRia0EnvK6wSDFboMi6cdlTuwYq1ZMLTGrKlJHbxmXD1lrNVFJ
         069ivBfQnAtF7/N/36c4GnZgeHUCeX4ADuvIyPQGeDhGIPAMQXhJ5WBm1o+Czs7oSvvm
         16OaU8T3vv9Zf3ZwftBjKSd3Oi0X8WmWQltuYITn47KbsC8wDZO8YNTGB3QD1fSuVF2T
         PhQw==
X-Gm-Message-State: AFeK/H3N5TL3RMOwgioaiQqC9cltdcOnNUHdeEZxmnp3l7aOon5bCtWZ/9gTHEOndaHJRTE/7QgK2QsEJ52yTw==
X-Received: by 10.107.150.201 with SMTP id y192mr38919800iod.33.1490123035744;
 Tue, 21 Mar 2017 12:03:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 21 Mar 2017 12:03:35 -0700 (PDT)
In-Reply-To: <xmqqbmsupinm.fsf@gitster.mtv.corp.google.com>
References: <20170321125901.10652-1-avarab@gmail.com> <20170321125901.10652-14-avarab@gmail.com>
 <xmqqbmsupinm.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 21 Mar 2017 20:03:35 +0100
Message-ID: <CACBZZX5-RRrWZfPAtMon_WnioG-9AwfhTFC174=4uBx_QCcEGA@mail.gmail.com>
Subject: Re: [PATCH v2 13/16] ref-filter: add --no-contains option to tag/branch/for-each-ref
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Hjemli <hjemli@gmail.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 7:51 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change the tag, branch & for-each-ref commands to have a --no-contains
>> option in addition to their longstanding --contains options.
>>
>> This allows for finding the last-good rollout tag given a known-bad
>> <commit>. Given a hypothetically bad commit cf5c7253e0, the git
>> version to revert to can be found with this hacky two-liner:
>>
>>     (git tag -l 'v[0-9]*'; git tag -l --contains cf5c7253e0 'v[0-9]*') |
>>         sort | uniq -c | grep -E '^ *1 ' | awk '{print $2}' | tail -n 10
>>
>> With this new --no-contains option the same can be achieved with:
>>
>>     git tag -l --no-contains cf5c7253e0 'v[0-9]*' | sort | tail -n 10
>>
>> As the filtering machinery is shared between the tag, branch &
>> for-each-ref commands, implement this for those commands too. A
>> practical use for this with "branch" is e.g. finding branches which
>> were branched off between v2.8.0 and v2.10.0:
>>
>>     git branch --contains v2.8.0 --no-contains v2.10.0
>>
>> The "describe" command also has a --contains option, but its semantics
>> are unrelated to what tag/branch/for-each-ref use --contains for. A
>> --no-contains option for "describe" wouldn't make any sense, other
>> than being exactly equivalent to not supplying --contains at all,
>> which would be confusing at best.
>
> Nicely explained.  Thanks.
>
>> diff --git a/parse-options.h b/parse-options.h
>> index dcd8a0926c..0eac90b510 100644
>> --- a/parse-options.h
>> +++ b/parse-options.h
>> @@ -258,7 +258,9 @@ extern int parse_opt_passthru_argv(const struct opti=
on *, const char *, int);
>>         PARSE_OPT_LASTARG_DEFAULT | flag, \
>>         parse_opt_commits, (intptr_t) "HEAD" \
>>       }
>> -#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, 0)
>> +#define OPT_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("contains", v, h, PARS=
E_OPT_NONEG)
>> +#define OPT_NO_CONTAINS(v, h) _OPT_CONTAINS_OR_WITH("no-contains", v, h=
, PARSE_OPT_NONEG)
>>  #define OPT_WITH(v, h) _OPT_CONTAINS_OR_WITH("with", v, h, PARSE_OPT_HI=
DDEN)
>> +#define OPT_WITHOUT(v, h) _OPT_CONTAINS_OR_WITH("without", v, h, PARSE_=
OPT_HIDDEN)
>
> Doesn't OPT_WITHOUT() need PARSE_OPT_NONEG (in addition to HIDDEN),
> just like OPT_NO_CONTAINS() uses one to reject "--no-no-contains"?
> Does the code do a sensible thing when --no-without is given?

Yes, you'd mentioned this before but fixing this got lost in my note
taking process for v1->v2. Will fix for v3.
