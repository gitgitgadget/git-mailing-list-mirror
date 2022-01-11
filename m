Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE33DC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 19:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346073AbiAKTGi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 14:06:38 -0500
Received: from mout.web.de ([212.227.15.14]:33643 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243166AbiAKTGh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 14:06:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641927962;
        bh=vtq/yt/cHpLbM3nOgoSsx2yu2eoQlR9djA3kkShe+j0=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=F9wWey6biG656WovKMMsSzVraZ+2d6oIyhYtNdER5kBaoyAgM08uFjfMuO7hWNedp
         CUpc3/ZvLyBW2WqHyb533k8x3h3BnIkb2eKmvYoJM5XAxXsauXNBsSw8WeXQcZOTpW
         8sD2sLjDF9sR5qTxjnDCdkFaw8WS5+E2uIt95ugA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MRk0k-1mwtAO2uJ0-00TVZs; Tue, 11
 Jan 2022 20:06:02 +0100
Message-ID: <78aa8c28-d78b-7dee-6616-7708c363a244@web.de>
Date:   Tue, 11 Jan 2022 20:06:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v9 9/9] cocci: allow padding with `strbuf_addf()`
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, congdanhqx@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <cover.1641440700.git.dyroneteng@gmail.com>
 <8dafb2b3779715aa277eb825a94af87b72f3e093.1641440700.git.dyroneteng@gmail.com>
 <220110.86ilurzcxo.gmgdl@evledraar.gmail.com> <Yd2zXOrf+4qX8VLD@nand.local>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <Yd2zXOrf+4qX8VLD@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0/2/v6h31cAoZXiqCOktAQmCp0bPWq6DbK1ctpuOhEppltghENe
 YQUwE03+AMBMS7hHHPva7oXD2+/Q0cJNqmTrkykFM6dycPE0WQXHV0mA4aRY4U12OvBn5z2
 N/CzG7p5ePGeg1Ct4vn5sPHhvlzyVIbdvhtzizqISqg9lwQaQINaT/w3jkUQwxy6sLOooII
 WqFeVw/+bp0nHGkcA7iOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kiiOjUFFyjA=:mlplCfgb1AzOk8p8mTRlAD
 PfVXMpf6wHY4nGKoj4wEdclR2lbE14ztbHRkgQpdL3x74wxbqbxR8OIicRGOnqSiwOOWoUI7L
 bpCXApi0djhHNcXbDQOwyAvpOq8ObdVlMvFH3GIMlkeJ1rTI1YQtUDHL3H+1i5XDJKBRxGGrb
 p2419tJxlAnBw/ICJXdjhFler9VkK7P+5o075HjMS23EBacX/RDiNUGz+vC4CkWHDLhjAK417
 Vpzgn42aeHNMdcpergCwCATce/XxY03FKRshhznRPjs6agYLLqV976KWGZrRnSHMcNbZ9uwxU
 2NsPz1e08OJDrSE2AIY66L+FPLt0NGAA4FJnhf6nPCDTvrPDyPamAY9cNEvlThONz3fO0GXau
 vBhGL+gq+sVvhQ1tYHl3tbmzvoBjSQt+bKocU1bkMGQ+8XxykVdBnMx5vgA8zldXALm3JRFwc
 mrqz3n5NMVETQMoUhykUKqK1uqTGVOrpc3+usrdaaSkn8+Epz7YMz0MWm9ttttI8IMcQSv4fA
 eRNx2dB/GL2nQ60a0iGhYL0zAyBCTH22segrBa5AI47ZltWYmAMSjD6G5ZFgjmTeaRG017Feo
 6eVklvfslSFqmoEAe32bUey1xEve6V+fptlz+fQgM8fd7rNYzvBczIQwOfnsrwAhTzwoLOpDr
 oIXevfs0hBiNfcSFPWCO0ghHKqzVSHOzrTiFLyZ0Tkr+HE+NOT0hLWszi3MLApgMH/W6K/Ctt
 MBn4muT4tCPWlbk5Qf9onwze/OGMvhQo8OXuSN71MOL/jRpaxyMLve/3Y1US5GxTJHtY6nL/y
 nlbUyIgCfoLTe98akCikDm2KGknh4A/PVQTGPoviaZyVx61CYkE0YKbAnR1USnIefhnidU7BH
 qO/IIp10nZWWGCVn0X5iKa2RkXxYeqyr1KWXt/7v7quwX+zm9+31XLZnve34zdvN1trL4BIGR
 BdEOqJuM0eu4nNwbqVF+2JxHE+Zn8KqFlAbFavzDGWyDrrlTpY8GXoiTVtJruWo6nCGlfiszI
 HQERqI/I0n3h31LaeSyQwERtCOxC+CvVzFmFmEDmJGwVu5erYWmLb2YEWsy+UdvGu1RpqAQyK
 tp/mpORUaZj6Fo=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.01.22 um 17:42 schrieb Taylor Blau:
> On Mon, Jan 10, 2022 at 07:00:59PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 B=
jarmason wrote:
>> On Thu, Jan 06 2022, Teng Long wrote:
>>> The original rule was introduced by commit:
>>>
>>>     https://github.com/git/git/commit/28c23cd4c3902449aff72cb9a4a70322=
0be0d6ac
>>
>> Let's refer to commits like this:
>>
>>     28c23cd4c39 (strbuf.cocci: suggest strbuf_addbuf() to add one strbu=
f to an other, 2019-01-25)
>
> I find it helpful to have an alias like:
>
>     $ git config alias.ll
>     !git always --no-pager log -1 --pretty=3D'tformat:%h (%s, %ad)' --da=
te=3Dshort
>
> in my $HOME/.gitconfig so that I can easily format commits in the
> standard way.

You can shorten "--pretty=3D'tformat:%h (%s, %ad)' --date=3Dshort" to
"--pretty=3Dreference" or "--format=3Dreference".  For me that's easy enou=
gh
to remember that I don't need an alias.

Silly question, going further off-topic: What's "git always" doing?

Ren=C3=A9
