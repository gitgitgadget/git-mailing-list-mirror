Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4DC4332D
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD6E764EF2
	for <git@archiver.kernel.org>; Thu, 11 Mar 2021 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbhCKTN1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Mar 2021 14:13:27 -0500
Received: from mout.web.de ([212.227.15.4]:35775 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230196AbhCKTNR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Mar 2021 14:13:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1615489983;
        bh=tq/DprAyUeeoyCFrQcW3v59JgQEa6Alk2LwIoRUN5vE=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=qgbF6BZltBRrCHqvbcV1qMWOA4eds6ASVjFwtZR2Y0ZDVIo0ceFcQZVk2I+gj9jEr
         Gtf04PqLe/AivdcD3Wa1C1L/MM/nYa9qntg9m8JkxCHOLzVasZTgwYx+P9sJfiLTrG
         09ad3nF4FVbDF7hS2/qf9wcbWo37Gug6AGJsbjQs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.24.70]) by smtp.web.de
 (mrweb002 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MfqWi-1l8Hff1upY-00ND94; Thu, 11 Mar 2021 20:13:03 +0100
Subject: Re: What's cooking in git.git (Mar 2021, #03; Wed, 10)
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>
References: <xmqqmtvafl62.fsf@gitster.g> <87r1klhq3y.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe=2e?= <l.s.r@web.de>
Message-ID: <bb5f06df-226f-8c2d-93e1-7e55aab73917@web.de>
Date:   Thu, 11 Mar 2021 20:13:02 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.16; rv:78.0)
 Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <87r1klhq3y.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1l9duRFJ29oOGIwqj5WIpDQDEQv+rq9hsGPz1YQh3qAY6+7z10Z
 PxP/2XbUn4BGjbzA7uarBvUEU7pWK4LiyGWzC/sL9t+tSxUpm03xkmEhv3OnoxEz5k8HBKz
 V8rQSW3u/W9HOBbKYZhfJM8M5nVn3/ds5TWfjM1UpUDsru0pwdf2Ha2Nl2dF/js+b1qtJcl
 OObYujc2SpQNMGoMqg90g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E3vDF9aRBng=:4Gsp+Tu1mLxlWNQWhBLmcM
 wB708HzlHNeklCgZ/ZWo6rMJtwW6MDRlMNOx73zYYKjL0otb1KLT1buOF6BzwPR/rmvWViBZT
 v1gZx5TeU1zltfr1GD8KceFJUz9hijzJwxbj1Gq3bJ3YzvYHLH+E+7Hq2GYVc+IkHqrlfcPte
 7Hvh8qxE6hqzYdi8e8h6A7HLQGQum5RnJbIeC3a0lrHDnvxaw1j1sNKFMgnlEvTjMIDAtSHgC
 x0pzaAOa6oXSjD3XMFRtep/G8KpbiZWuvIz7932get2bu5sEmWZ/7Dviv/jTtXMbDWQkE3oSr
 8M/UUGxfbtKPYsO5nFsp8ky/15rxjckCAGusPzA0iW3vkvgxvEiRwwBEVzr5eu4LfIGJFevUN
 xzMrFUrJlKaMsOp/1GzVVHm6KAdlH9mGgf7oJlGS+pfp5OURwzn6lVorr2iEiX928/1OEEasE
 DXGq+T4/iywboYDcH8eRwegU5raAw/3WU44giXBqnfAvBhsgfaZGEC03Jh7qcqlI/i7rQRy1m
 VbBEp+syZKZRa3DW9Gd7K881UYEVFS/+gnf5g0g1oHZPHbmpag6eMtWNNBkS9mjYKmb6AJXtI
 4ItM+EDv7W40hQFRUUqW7CHqC0yUVYQbQ9anDRGzeFl770J4v6WHrTLDONznNJXOZjNZ7zmlf
 RqofKnnv/I/E7emWCZVouk9htxupwJBSwQGP002NmKspDH6/FxoL+9rweu0YNcD8v5OmAMuQs
 zlc5ayQhS51S0/5riCarpUd10P/hDBc7LS24Y/OIoSbrFCzQ7M9N4ptb/nQYK+g+OLq8m9cTd
 tic2FWFK7sEFd39wgK+U8mMdpP2LR3FCpfdZbIG+PIl2+rqWinLDlm2a3VHDxWu4J75cjSLFj
 yTDvnRI9B60xGBxw2rdA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.03.21 um 12:44 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Thu, Mar 11 2021, Junio C Hamano wrote:
>
>> * rs/pretty-describe (2021-03-01) 4 commits
>>   (merged to 'next' on 2021-03-01 at bee9248828)
>>  + pretty: document multiple %(describe) being inconsistent
>>  + t4205: assert %(describe) test coverage
>>   (merged to 'next' on 2021-02-25 at 2347ed8fe6)
>>  + pretty: add merge and exclude options to %(describe)
>>  + pretty: add %(describe)
>>
>>  "git log --format=3D'...'" learned "%(describe)" placeholder.

This is missing the patch to limit %(describe) expansing to one per
archive [1].  I think we need it to avoid hosters that generate archives
for user-supplied repos becoming vulnerable to a DoS attack via this new
feature.  Demo script in [2].

> As an aside did anyone look into making most of ./builtin/describe.c a
> new ./describe.c library? I had a quick aborted attempt at doing that,
> but it didn't seem like it would be all that hard...

That's what I thought as well, but combined with log --format it
produced bogus results for some commits.  No idea what went wrong
there.

Ren=C3=A9


[1] http://public-inbox.org/git/b7e1f6c0-6b13-efe4-74b5-ec8249855644@web.d=
e/
[2] http://public-inbox.org/git/a28592c5-4a70-1ea8-fd73-959e28b4278d@web.d=
e/
