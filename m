Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 408E020209
	for <e@80x24.org>; Thu, 25 May 2017 05:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968490AbdEYFm1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 01:42:27 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:34177 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968162AbdEYFmX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 01:42:23 -0400
Received: by mail-pf0-f180.google.com with SMTP id 9so156727145pfj.1
        for <git@vger.kernel.org>; Wed, 24 May 2017 22:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=avXzWGV883v3/Re1XZraGoAgQdIBUgK7IiIVfPMuyYA=;
        b=dxdHrc6auS7rzDdTQdqeBPJztBH1l+R5YYK5w4SiUpLwNpQP6x1U+fH/w9aUTtzBwH
         KFKX8dsaWtFzf9vVlPXfextDONLzpyB1kyZaPrN1CT+w/S1Jt9McbmPOEmI8frn7V2Kw
         Yc3RNcHt6BbaAzONroeR8snDgNmdztROCSwpET8OL468/UFwyOmPBAYseYiw93aK2jpZ
         ffegGKZ0DW0Di9QzHp/vFxQBARHxPYEinpAehp9PPuCXRowQRNjLfCXHAf5xcvMAbqOe
         Fyjn9wxEVnAaFTevJZos3tXhGMfsHgcgrwXFrPvttXCeVAetWVes2Jnq5PhVT31n71cc
         jcGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=avXzWGV883v3/Re1XZraGoAgQdIBUgK7IiIVfPMuyYA=;
        b=rHHXSrfB7kPxpyjnotrxyTu+YbeRVX/8pV2fx5EGE0SzBklLhJeO7B7Nryrt1IbIQO
         i90H7zpdwe6IsrywosEVOk1KemMYYCVCGjfvKZeXYSZwLE3MtQ6/rL0qdEdf2EAhUZ34
         a8knIDoy8Vzrc9Gita44gXfTHmgLy705maWlV42UrPFF849vcIxrx/qUzHAVFsM3nZZv
         UMhEQArxbZ3etSdgoWasTTfjDiQBI0dP9gxibNzvJHZxW0kZs3RF7WKYQWjSYmnfEF3F
         YJAcLT5S+h7RC3COVujIr0VkeSp4MgU9gZJ+fWiFoWHyCmfTF3k7WSqu5S37e95OSelK
         Lyug==
X-Gm-Message-State: AODbwcDLJU3Z0eHVlWzTL1UAXTFd+StO6Gx5aEVTyXcC3DgK+iTyJd1j
        uS1Amp+anUbaPmmBi6vxcQj/c25JYfhY
X-Received: by 10.84.241.132 with SMTP id b4mr48074303pll.107.1495690942567;
 Wed, 24 May 2017 22:42:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 24 May 2017 22:42:22 -0700 (PDT)
In-Reply-To: <xmqq60gpfvqj.fsf@gitster.mtv.corp.google.com>
References: <xmqqwp98j8q2.fsf@gitster.mtv.corp.google.com> <CAGZ79kZMJP7K5MU0UujuEatZ2MOrSnFpfD707aSGa64mKyCZbw@mail.gmail.com>
 <CAGZ79kYoHYz6hi5kDjQBcN-35c0kXE6mf6NNV_Z_F6-UqZ=3cw@mail.gmail.com>
 <CACBZZX4adLy6Xumicu3Qke=g39EEe3iBa5ShsGvTBAYFqXENPg@mail.gmail.com> <xmqq60gpfvqj.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 24 May 2017 22:42:22 -0700
Message-ID: <CAGZ79kZexcwh=E6_ks83=pJh=ZvKnLvJ54eLsn+HURsTZOpvqg@mail.gmail.com>
Subject: Re: What's cooking in git.git (May 2017, #07; Tue, 23)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 8:42 PM, Junio C Hamano <gitster@pobox.com> wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> The tests added by grep rely on the old content of
>>> test 2 'grep correctly finds patterns in a submodule'.
>>
>> Sorry about the fallout.
>>
>>> The (whitespace broken) diff below fixes it.
>
> Ah, then, this was an example of maintainer not doing a good job.
> When I see a topic that pass its own test that fails when merged to
> 'pu', I usually try to see where it goes wrong myself and come up
> with a fix in an evil merge, but this time I didn't have enough time
> to do so before sending out the "What's cooking" report.
>
> Here is what I taught my merge-fix machinery to apply after
> mechanical merge of the two topics.

Please evict (or stop paying attention to)
sb/submodule-blanket-recursive as it is fundamentally broken.

I hoped to resend a fixed version today, but it took me longer than expecte=
d
to figure out the config machinery playing with submodules.

The diff below looks correct to me.

Thanks,
Stefan
>
>  t/t7814-grep-recurse-submodules.sh | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-su=
bmodules.sh
> index 14eeb54b4b..7184113b9b 100755
> --- a/t/t7814-grep-recurse-submodules.sh
> +++ b/t/t7814-grep-recurse-submodules.sh
> @@ -36,18 +36,18 @@ test_expect_success 'grep correctly finds patterns in=
 a submodule' '
>  test_expect_success 'grep finds patterns in a submodule via config' '
>         test_config submodule.recurse true &&
>         # expect from previous test
> -       git grep -e "bar" >actual &&
> +       git grep -e "(3|4)" >actual &&
>         test_cmp expect actual
>  '
>
>  test_expect_success 'grep --no-recurse-submodules overrides config' '
>         test_config submodule.recurse true &&
>         cat >expect <<-\EOF &&
> -       a:foobar
> -       b/b:bar
> +       a:(1|2)d(3|4)
> +       b/b:(3|4)
>         EOF
>
> -       git grep -e "bar" --no-recurse-submodules >actual &&
> +       git grep -e "(3|4)" --no-recurse-submodules >actual &&
>         test_cmp expect actual
>  '
>
> --
> 2.13.0-491-g71cfeddc25
>
