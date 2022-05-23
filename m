Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087DBC433F5
	for <git@archiver.kernel.org>; Mon, 23 May 2022 12:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiEWM7G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 May 2022 08:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235806AbiEWM7C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 May 2022 08:59:02 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180B853A72
        for <git@vger.kernel.org>; Mon, 23 May 2022 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653310721;
        bh=k/1EnOxV3B3stN8kE0R/MhiSH1VCvBq4LHLH9Qs06Fk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YYGmmhQ2MoprOgv4sX3qPEUoKgsvyiXvxVOTpTJU7LwAXpOAxmv+gh0tG2gsNFrr+
         UVkETPsw08QA4rGeMdbOSNEhK4t2TeF2C4qh8Ypfz4gUhDCgfKTWAh0BwWVzmDfUsm
         x7likSQ8EcBVbwB+x3O71oYhaBODHrSsMufMT9FU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiDX-1oDHtn3CU3-00QFbJ; Mon, 23
 May 2022 14:58:40 +0200
Date:   Mon, 23 May 2022 14:58:37 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Victoria Dye <vdye@github.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/9] ci: make Git's GitHub workflow output much more
 helpful
In-Reply-To: <xmqqfsl1bcy6.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2205231455200.352@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com>        <pull.1117.v2.git.1646130289.gitgitgadget@gmail.com>        <6b83bb83-32b9-20c9-fa02-c1c3170351c3@github.com>        <nycvar.QRO.7.76.6.2205212307090.352@tvgsbejvaqbjf.bet>       
 <xmqq35h2cwrm.fsf@gitster.g>        <nycvar.QRO.7.76.6.2205222045130.352@tvgsbejvaqbjf.bet> <xmqqfsl1bcy6.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:o+VEyvyaEXscBsxJNbtD9s5NhcEzFOToQCMZWi3Ti8WQRkYHP1A
 3DxozS1ZxlpyvOlOsnQ/29pYStznBNaYNF/MLNaQEu6GH//F784xaghPEQxFeiUn2lUkUSn
 9H4PyR7+uv5EKnY/OlyABxq6xJQJOmS5tSXKk2jUL34eBB5P5UJYNWsfB2wHhuMs+/dRUyU
 ltfit3RnYaiNRQb2qQLoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0o3B195ZFX4=:dgvf6+rxlnULeSey2fn5iR
 IIe2u+mpIoT2/88DtyZvh+EMkuCdMb0y0HJyHsHJpZSf9NQC+FIFAZAX9nhE8rexXijodSjUq
 BF/aNi/cv5qU8aCW4mGk0DwRfImCfcTwBYqcMKRt8kgoZXmqt5RkwBWR07SklHmH2mHf7lgNQ
 uY0NOe85zPLi3uhfxMuzmDDt5U5QXXTDDbJvbLLd7vgkRQnRmleJzTJr4RGVjfW+lBxxziQvQ
 /c5HHv+9Cp/x/MvKgg4tYdISPbEIeVjnDP4sysEVO3xsowR34vMuUIuOKyDGyt7OBBteJJgVY
 VvLWN8l63iNmmBeqbZpUdHNWKx8KYMPY0tF6rvqPxXFZqVujHOKKu/dAEM7YG2u3KfyMe2rUF
 i+QjFKYKiZy86jCtiANrc0FkNMuTvDOUUNE9BHl9kJAlofSVb2cnkHu0XyQvjDWPfV5VaDb8d
 tKQK4tge2Kq8fPd5kNNAbC8a2UnUWntetvLfCtVIsq2JSwGA5M4rRNH9ei4a6TXZNj4TRnC9y
 F87anEs7xBTMDKcHS3ciEepMrNWMfYM7YFu+BovxiLFc/BTMAKcEfGEGn4Bx0d6BDuJmoOSOC
 Rw8llyD90NMokjSYh/BPQ10zF+ecig9NOnMBozug3IVhRsUvN9T98awGX+mvB15aBrZxNiYPG
 7HqiifbMgDBxEQZqBeFGvGZKRa9yVbjABIdfxt4zNDShNzIfht6vIacypTDB/Na7Okm22kKyn
 QcpYcoGk90MoMd99KPEFTs3iaLFz61FRrfPtF2/LxrLnQ2/wIJZu3GZeMefFo56uks4P75ZW9
 TG7x4xgWFhUAxufJXCvLgqXnv5b6OaQ4CQa584icD70wg0x6TNhjccZKDaYWDtwehzib8meXf
 MvpsR01ZSVMGA3caHxeyl9u4fIu+xbinpfWQISuBhxMebwwgB3qW2pwcwW9wzb+5ukHyWcaXr
 UiSIhKAhgKJPQDcf08TNOcsPJZaXC0+gx9p2SmDY0NuoWA1ZA0qXvFVt1xH6iTyu72JY7GoGj
 agE66fp3M8tQAQAgTvRGQnlZDPFahCZzHgZv6yZOsLfFt36eVkGW9smsz3/s+0TYy+i2ptbEx
 8Fcm/LQ2N/fxzfFQDQ1XBPdVeULwKkSDU4aGjZ5pMEo4it+xSY/Ym/HSw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 22 May 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I see that this is still with the previous iteration, and therefore
> > exposes the same speed (or slowness) as was investigated so wonderfull=
y by
> > Victoria.
> >
> > So I really do not understand why you pointed to that run, given that =
it
>
> Simply because your updated version came to my tree a lot after I
> prepared two trees that are otherwise identical for comparison to
> write the message you are responding to.

Oh sorry, I only noticed that your mail came in after I sent the new
iteration, and I incorrectly thought that you had put the patch series
into the Stalled/To-Drop pile, so I assumed that your mail was in response
to my new iteration.

I had missed that you replied to v2 instead of to v3.

> I do not appreciate that you have to always talk back to others in
> such an aggressive tone

I apologize for that. As you might have guessed, it was not my intention
to be aggressive in any way. I merely meant to express my puzzlement, and
your explanation resolved that very nicely.

Thank you,
Dscho
