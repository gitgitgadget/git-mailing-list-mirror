Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BEAE2095B
	for <e@80x24.org>; Tue, 21 Mar 2017 18:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933749AbdCUSva (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Mar 2017 14:51:30 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:36643 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933652AbdCUSus (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Mar 2017 14:50:48 -0400
Received: by mail-it0-f68.google.com with SMTP id 190so2505266itm.3
        for <git@vger.kernel.org>; Tue, 21 Mar 2017 11:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mnnQGv5A85mIvwX5M3He/nH/zRaxny1IwCbb3a3xW6Q=;
        b=ktUYLCRgfJaK4vO4VwRZOoeKl2rACvehvMjs/OkSxhwRUQBg1rgQdfkoYIhLH0I/fL
         luCNzTKpzkd3QGxZiICGTt+DxoeVxorIRT4qNKLIb9lVVrOj+JZjWsmSusxXyAGkbJ7u
         EYG6CrsPis9RFQcbm4lZ4hEC3AsYg7oCMrqFmcsab3nxj0A6h7BdOvjiinezuhq6d82g
         DLTPgwfPoqsZMY56uvdmdTCdjDiLSry5FdKDe5ZP8Fh9SBdYjIc13QWKjeHkk8hGkV60
         03fL1KoqwcsxEyHsb9KfiGy7YYiJq47VIlR63Ocy1p3/j8HFvIQGNSHCs0P7b+/mgsfm
         us/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mnnQGv5A85mIvwX5M3He/nH/zRaxny1IwCbb3a3xW6Q=;
        b=j4ocbE4bimmVmcjR4C4vl6UorCe4Oifp5oyhMX9/c7Qgz92rrYp7G+7XIiWRQqaTkB
         UGZVBIXJToIlrsDYn1pSLevKnnzshTY+/GoQWIcAnTAi2hVUQwkBozJSpVpE7rc5CQ5H
         h2Y9wQ2KOYecU5w0vS48N3kSFa/Fdua3NYe6tjg4QNXpnqscoQUA11RkZSxwk1YuY8Ws
         c5MqJEktxxNGLNQe38skcGK3FPH9mSVr7gFe6CLuytN37PuPtT0dhABw8plkUHJdueJv
         x5POAxRG0uMVh4ZFFkUi3872CB92fKM1LAEVhSKz9SHULZeywmZmM/vb7kyX4JU1GjEt
         77Aw==
X-Gm-Message-State: AFeK/H3//wRX9GrArTtLXG8CcXiSrjzaiaRM80mkrIE9MrFzSwYCMhfItPCiGi8WZrqosFFaNo8vbJA6Ejp10w==
X-Received: by 10.36.29.66 with SMTP id 63mr3985161itj.91.1490122235760; Tue,
 21 Mar 2017 11:50:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Tue, 21 Mar 2017 11:50:15 -0700 (PDT)
In-Reply-To: <xmqqwpbipjk9.fsf@gitster.mtv.corp.google.com>
References: <20170321125901.10652-1-avarab@gmail.com> <20170321125901.10652-9-avarab@gmail.com>
 <xmqqwpbipjk9.fsf@gitster.mtv.corp.google.com>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Tue, 21 Mar 2017 19:50:15 +0100
Message-ID: <CACBZZX6VxxYD1ev0K4jxyUmqxFpALopkHTUFp4iFtYfSuOgrjQ@mail.gmail.com>
Subject: Re: [PATCH v2 08/16] for-each-ref: partly change <object> to <commit>
 in help
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

On Tue, Mar 21, 2017 at 7:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Change mentions of <object> to <commit> in the help output of
>> for-each-ref as appropriate.
>>
>> Both --[no-]merged and --contains only take commits, but --points-at
>> can take any object, such as a tag pointing to a tree or blob.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
>> ---
>
> This definitely is a correction worth doing.
>
> Do these strictly require commit, or does any commit-ish also do?

commit-ish, but that's a good point, and could be the subject of a
future follow-up patch. Right now most of the things that say <commit>
really mean <commit-ish>:

    $ git grep '<commit>' -- builtin|wc -l
    18
    $ git grep '<commit.*ish>' -- builtin|wc -l
    3


>>  builtin/for-each-ref.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index df41fa0350..1a5ed20f59 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -8,8 +8,8 @@
>>  static char const * const for_each_ref_usage[] =3D {
>>       N_("git for-each-ref [<options>] [<pattern>]"),
>>       N_("git for-each-ref [--points-at <object>]"),
>> -     N_("git for-each-ref [(--merged | --no-merged) [<object>]]"),
>> -     N_("git for-each-ref [--contains [<object>]]"),
>> +     N_("git for-each-ref [(--merged | --no-merged) [<commit>]]"),
>> +     N_("git for-each-ref [--contains [<commit>]]"),
>>       NULL
>>  };
