Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04739207E4
	for <e@80x24.org>; Fri, 28 Apr 2017 19:16:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755942AbdD1TQ1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Apr 2017 15:16:27 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:35938 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1425470AbdD1TQR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Apr 2017 15:16:17 -0400
Received: by mail-pg0-f43.google.com with SMTP id t7so19162720pgt.3
        for <git@vger.kernel.org>; Fri, 28 Apr 2017 12:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Vcukc5c3dwA6lJuBujl3NVgL5V0g+S2yy8B2Xh3DEmM=;
        b=HoiOGN53GrNQYraKB53yI4qF46uXrtop2STusBE3Q0tsXEIKHP61nI5CI5lNa4g16v
         6efoYUhznwnKxLVOnCZoBHohxK/DP3TelMNzN9ltyPr7CeAipykdbBtLzX9ynMh8WDNc
         8z9z+vGjyb/CDNWJpP9XlGFiXovt/64d7AUs4rWGvTtAp8wY68krNerE1hECPrxG/o9k
         Z+7oziiiadpcoreFcf88KUyZz3XB2CzSeB+sZ3lYw+Phg0OwXfcJ66+GNKU5SeiSrhb+
         UBeDCHnWLsWm2en1c8fkJMUQ1e1kB8sSGU87pkw8/hm74qv/VqhJVZHyh0GE9xBhlrxr
         sllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Vcukc5c3dwA6lJuBujl3NVgL5V0g+S2yy8B2Xh3DEmM=;
        b=djYzoFBTebgPsJax6K3bYk7ndmECtK70lUyU4NR8TlsflU3R7GZgQXD/8tVd4A9YW2
         U1xXoVJ4LsJ/wVZXCsVkgcgC4EcuoN/skt72B8T8stlShsChVH1xT4OW27FgXqo+/+DL
         amfRsIdsKDmViyk1j1XE9B/0ZX+LtYJJHlvGTjLoMgdIEc+Za64hmBuN9FlFpUAPdILS
         GRYNaWjItA2mi1VtVJYCo6MNHGUniM+haYaN7NA2ktZ9v9+3V4dqa9c6Ue8ppCaRbmbE
         Lu7WsVRSNwKq1mrT4MEBHW6m+oK/kgG72QAjxaWQvjLdhyNRZj9Dcgv+boAQ+1E+qXT8
         /0vA==
X-Gm-Message-State: AN3rC/53/iYFXsYDLpZB3BKtLQ+5j0DAjy8wBJyQdGpzTTcy4Tv+azAs
        Ifg4cGhy1acIQ700RdmMfFB47RPSss3U
X-Received: by 10.99.126.23 with SMTP id z23mr14105041pgc.63.1493406975225;
 Fri, 28 Apr 2017 12:16:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.153.156 with HTTP; Fri, 28 Apr 2017 12:16:14 -0700 (PDT)
In-Reply-To: <CACBZZX7bHai-CTiO1G1vOP41Uit3zeMAn64NKvA73aouoBWMng@mail.gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com> <CACBZZX7bHai-CTiO1G1vOP41Uit3zeMAn64NKvA73aouoBWMng@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 28 Apr 2017 12:16:14 -0700
Message-ID: <CAGZ79kbrn-wY27V+DQ2h0T8Xm02rFuXhw0rnP_0qo_q5oBd8TA@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] clone: --no-tags option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 28, 2017 at 12:11 PM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Thu, Apr 27, 2017 at 1:12 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> This is an expansion of the previously solo 02/05 "clone: add a
>> --no-tags option to clone without tags" patch (see
>> <20170418191553.15464-1-avarab@gmail.com>).
>>
>> This addresses the comments by Junio & Jonathan Nieder on v2 (thanks a
>> lot), and in addition implements a --no-tags-submodules option. That
>> code was implemented by Brandon & sent to me privately after I'd
>> failed to come up with it, but I added tests, a commit message & bash
>> completion to it.
>>
>> The WIP 5/5 patch implements a submodule.NAME.tags config facility for
>> the option, but is broken currently & floats along in this submission
>> as an RFC patch. AFAICT it *should* work and it goes through all the
>> motions the similar existing *.shallow config does, but for some
>> reason the tags=3Dfalse option isn't picked up & propagated in a freshly
>> cloned submodule.
>>
>> I'm probably missing something trivial, but I can't see what it is,
>> I'm hoping thath either Stefan or Brandon will see what that is.
>
> Junio, can you please just take patch 1-3 in this series, i.e.:
>
> DROP:
>
>> Brandon Williams (1):
>>   clone: add a --no-tags-submodules to pass --no-tags to submodules
>> [...]
>>   WIP clone: add a --[no-]recommend-tags & submodule.NAME.tags config
>
> KEEP:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (4):
>>   tests: change "cd ... && git fetch" to "cd &&\n\tgit fetch"
>>   clone: add a --no-tags option to clone without tags
>>   tests: rename a test having to do with shallow submodules
>
> I think a fair summary of the discussion so far is that the submodule
> interaction I copy/pasted from --shallow-submodules isn't how we want
> to do things at all, I defer to Stefan & Brandon on that.

ok. In that case we'd want to discuss what we actually want with no-tags
in submodules.

>
> The only other objection to the patches marked as KEEP is from Stefan
> saying it should be --tags on by default not --no-tags off by default.
> As noted in <CACBZZX5dxaJDN18J5fAhjKcaP8cZSTtRw5-eScr2oq8OYyhKuQ@mail.gma=
il.com>
> I don't disagree, but a lot of flags in git now use that pattern, and
> this change is consistent with those. Makes sense to discuss changing
> that as another series.

Ok. I assumed with that next series on the radar, we'd not want to intentio=
nally
add more of the no-OPTIONs as that would produce more work for that series.
