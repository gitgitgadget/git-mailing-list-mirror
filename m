Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF08C433FE
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 22:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbiKUW4o (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 17:56:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiKUW4m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 17:56:42 -0500
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6E76B239
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 14:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1669071397; bh=D5VXPshA5Osou9OZt76qssQ136jqX/5iw/dfv/xCKso=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=O0C2OdVY9KNE2RY0YgKwS+djZ4tz/cJn4Vr5mvHhPZ/tkp6jPz9o+CT2cmKPMPWcg
         JSI3d4t0MLOAlxMmXulLpOPOhWNdo84UYPil6aprsaaToRz1XsuwB5KpqmyJinEyYz
         L7n+PHgZufi9C98W4CxMp2ZuHpmzgJtzVE3IDjKjWzS7SuA8JWKSQMJYM5K14E/6cr
         iWeRVUsRYqvZQgxaLTKkPfCVxQePHXoEE5s8OJP2I+zsXAbH7+d3YAoBBfJqR8xeLx
         sL2eqwrDj1zX6hpjayqd9swddckVsyYQBjgqx4SnWf67m2F4EaNoLvGLQdNMu4RK/7
         XaiuCKlaP96xA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.154.159]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M8T7E-1oss0D1xHE-004WZy; Mon, 21
 Nov 2022 23:56:37 +0100
Message-ID: <eed47577-1e47-2fbb-6344-fd4ae324f6b6@web.de>
Date:   Mon, 21 Nov 2022 23:56:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] t3920: don't ignore errors of more than one command with
 `|| true`
Content-Language: en-US
To:     Johannes Sixt <j6t@kdbg.org>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <febcfb0a-c410-fb71-cff9-92acfcb269e2@kdbg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:BExNedGNkZ8++VYilq5W4S8arQs3TRHD74Po1iVT4jKncMJUVHY
 q6rKnx1bv+40ReybNzIJFNP5cbyWLgLXD47kgLQ5eZqvl221nmC5D7l7Z2WAFJhNZGrFMn/
 rA28oKjpGZNMUI4yfGGM7I2FUdt+rk2yKmIRDwGHNRWBI1OQxvtG2gsgl615y8d4ZlHTD1W
 l5uNH/sOOpQPUwDbojAuA==
UI-OutboundReport: notjunk:1;M01:P0:LprL5SEzSZI=;4irdW8IMShMD7yD/DZgv3EZaawE
 NeImMqhasBKCF2PUVJy+/AjYV/hLqFOVs3FM8Juxi41HmpuEVlBr+YSfRCd+5O/YTVP+RQnR0
 t5zXoPCBz08kvrn2XQxEOWJSgyG7Nuz8Auhw4LCt7lEOPv5aCIVOAGqgoxdQzmvwBIOid5H9m
 yzy2Si7ndzX7fkYN1ba19T4ymMCYIqvBLX6to7PbmZX5rT7Ar/OipO9oToDc6QBiuuXFQLznF
 NXdUEKUyN4z0tENqwx2tDpNe9OH84v5v0tjIvC/ITglwRM3X6GdzYtyOTBO3Zsb/nFavEVh0X
 ui1sfJYouWLfJB0uTNUuugJGUualWo0T5pvMV8NuBbm6XB+8AYg3swflf8kNO3o5yhD8ul4VC
 c+UAKTg1/tKnYmoPd9XEVi3sPmxT2uyN+Hw9JLz+33gCNBU6ScFdNREBhsjpBi7El+xZ0RX9P
 xmD7+kBM5ii/nkZbZq8/hQclJXoF5GQ5pGOyDvsyryO79Ada1BaoPasib9PCLAZdbxeIm/LaS
 1r2oZIOj7cR94kF0Rv+syyFsR5OoqOtZ67oMsVlbQj07Br96abCKrIWVQHNNrhto7RDfsvNE1
 8a9t27z4N0z4s6Kh8yxPVg88PN+Vng6DBkWreBPPfP1dexaux67FqfuapbSRiGh5CAkx84HNx
 YmUUAldSwewdxxSAaNLb4zi++/fNsJtheDSe0mOOzw/M7TdcTw/ywBNMs4K2gAtRO8Hm/fn4u
 bBLz2hv+aSzi0LXDGaZc/HqI9wnt9+iPu0DzikCRi/2F4uaXu1Vl+d8nA75M7q3mPDaq3U0H2
 05tTfnvZao3HOmAteaV45895g9v6fk/b3ATdoQXO/Lr5sKqpYcNDIfGR9lFt/qHGM+gijFgoz
 BdWGPH2G6jAGDCjUinPbPcyk8AoCq57R8z9qRWshVBc70h//D9C99vvMhITp5pQ0cdxyUxUFb
 Ma6g1g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 21.11.22 um 18:58 schrieb Johannes Sixt:
> It is customary to write `A || true` to ignore a potential error exit of
> command A. But when we have a sequence `A && B && C || true && D`, then
> a failure of any of A, B, or C skips to D right away. This is not
> intended here. Turn the command whose failure is to be ignored into a
> compound command to ensure it is the only one that is allowed to fail.

Good catch!

> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  t/t3920-crlf-messages.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
> index 4c661d4d54..a58522c163 100755
> --- a/t/t3920-crlf-messages.sh
> +++ b/t/t3920-crlf-messages.sh
> @@ -12,7 +12,7 @@ create_crlf_ref () {
>  	cat >.crlf-orig-$branch.txt &&
>  	cat .crlf-orig-$branch.txt | append_cr >.crlf-message-$branch.txt &&

Useless use of cat.

>  	grep 'Subject' .crlf-orig-$branch.txt | tr '\n' ' ' | sed 's/[ ]*$//' =
| tr -d '\n' >.crlf-subject-$branch.txt &&

My knee-jerk reaction to long lines like this is to pull out awk:

	awk '/Subject/ {printf "%s", sep $0; sep =3D " "}' .crlf-orig-$branch.txt=
 >.crlf-subject-$branch.txt &&

This is not a faithful conversion because the original trims all
spaces from the end of the subject for some reason.  That would be:

	awk '/Subject/ {s =3D s $0 " "} END {sub(/ *$/, "", s); printf "%s", s}' =
.crlf-orig-$branch.txt >.crlf-subject-$branch.txt &&

> -	grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || true =
&&
> +	{ grep 'Body' .crlf-message-$branch.txt >.crlf-body-$branch.txt || tru=
e; } &&

OK, back on topic: Adding CRs explicitly instead of relying on grep to
pass them through (which it doesn't on MinGW) also ignores the return
value of grep as a side effect of the pipe:

	grep 'Body' .crlf-orig-$branch.txt | append_cr >.crlf-body-$branch.txt &&

>  	LIB_CRLF_BRANCHES=3D"${LIB_CRLF_BRANCHES} ${branch}" &&
>  	test_tick &&
>  	hash=3D$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch=
}.txt) &&
