Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B79C33C9A
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC6642243F
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 09:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="YNfsI6sQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfKTJBO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Nov 2019 04:01:14 -0500
Received: from mout.web.de ([212.227.15.4]:45617 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728049AbfKTJBN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Nov 2019 04:01:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1574240470;
        bh=QLwLQU53zI80JXhg8TpbKl3SdFvGiQWC9KOi89jNqR0=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=YNfsI6sQc7R2ScKPNpGIqPSKXa5HlUjwW/CCVSQCgcH/4hn7LejNN0LxTP37OfTJT
         elT/wMctizSElug9ZGUD4kMBiTQEU28pfFIrEXv3XCpR0WlPY1opLLhIWwfHU6gYEa
         isMg4TbveZ4E0iNPoznkTLLb33N2oAIqYYCJ88J8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.132.176.80]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHYHE-1iYSr427X2-003OZX; Wed, 20
 Nov 2019 10:01:10 +0100
Subject: Re: coccinelle: improve array.cocci
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
References: <50c77cdc-2b2d-16c8-b413-5eb6a2bae749@web.de>
 <5189f847-1af1-f050-6c72-576a977f6f12@web.de>
 <05ab1110-2115-7886-f890-9983caabc52c@web.de>
 <fd15e721-de74-1a4f-be88-7700d583e2f9@web.de>
 <50b265f0-bcab-d0ec-a714-07e94ceaa508@web.de>
 <f28f5fb8-2814-9df5-faf2-7146ed1a1f4d@web.de>
 <0d9cf772-268d-bd00-1cbb-0bbbec9dfc9a@web.de>
 <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de>
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <d053612d-107b-fdb2-b722-6455ef068239@web.de>
Date:   Wed, 20 Nov 2019 10:01:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <d291ec11-c0f3-2918-193d-49fcbd65a18e@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sbee5d9T1Vn4vZXdVF25xx+hxIbTWr0OQnhIzqgnEHxbrPXYhKi
 0w01ocylgdqowZjMBvFNN4GEEoWCaNvMF4RDT3B56mTEC/xSpyfLoZZJICDaVaaE/H8FJui
 L48d+gywHKjV/9eLP6edzlHRpEQjLhd/grILdjQ9S0wH3Htpwarl1TFyEEX7k9qavU0FtCF
 t3b1wlOVA16LEA90lQozw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:um7P/kFp6Jo=:NyON9vmIeQ2NaYnApz1Xw4
 pRteX2KwnZnM05om99IGxHTRhZJz12WTE16yCZ8gsKfwGcFdnT56PWT0fclXp+HhjyNy3GZdY
 B0NcmW61SQ+D3ZdcaKy4emOBv+O54zE4hdNKcUaj6wQy6l0dnPWaPYVSiRxBJ0G7GqMz4iGNs
 MHc+XSrkebYNfziQ7kSC32PEN8ySJsaKzrJEOPEBcHpZ2t02tJteMDvQV4E9VHO19QzED4OC7
 btbRg+6JIeM1s1Ns04HtGhEX8/iVXEWDyFtyZHpSLOf1A4Mn3bl4Ajg2P+AqTyWIJTjaJqn4t
 WXhmQvENRYi5nscibiD/f1Ho91Zuq4vi7XTFTkNALFhaoTgXjL8aw1xNgFh6MQS2fcGRedf5p
 BV4n/Vr4Ip/UybMjvhFI5Gz5T5CbD2QNT+HMfXUWMcNBRt+C7q2MC2xlYxWJQ4J/zIHSquD4G
 kC2bwsM4LrpG1t13E1ylWn0eaHm4vrq549jX8WLL5daC8miZQxeduxpXlCJrXeKG83DbW+zBZ
 wpFLQBDCTIfHzO1+IKKwSeP6FtrdTcVEiBKIOS/X0RWKyTJ8mZ8U2/B2jodpLGXKJE7OXJw7Q
 1EnxIIWHulWP1FlRcuW5hsFifGtMiElin4a887kbVUDlnzRUzwbwmn8E2etDCycO+BCQvxQQX
 yRk74x9w+bcYITdl5fZU39ncnFVshZSaGSopYGX7GhYm+DUc61/cN0uRzztk7cBzWRu1tvzbY
 Jjoaro+Sift8CJw2r9WjSyRi6kX9ZePwuqAPFTaWU/pMLw+ZxJZSpaEIS8CazH1pUErXv85Hs
 NGFEqVjehKhUQ5Fu5iZQGjKVFPsXCkuUUNKnmMfkCsoDOW1XVppsb4axTi6nnDwdlGahamxFa
 EaL//2f7o90U4Rzt6uh6tSzmC2dzbR/qRjBVp7lFDYyy5AJObJOGnLRXZQYVgNGwXA7xdD/r2
 LTknGFahRrEe1+VoDp90BD5/Cjc8maZUsUdrwxa6WFXAzBjxgEysfc2tC/Ayi9gkN7phs9ayB
 OuE5zRkcsSrX90YCRUrJqMW+QnSAAKDBu8MVdtYSpusMj8ijxEpwEfrJqO///TCQUyiMcya+x
 vnsA1da+mxRnaJBaSSmMjOfwfiqaeiYPKMrxbMqzk/mank0a5+B+wIS0lB63aQ4MKSeP0NTqZ
 ibzghn1URf1L2pK1fFKJlNl3+73P8qHIPjVFFiVPEY9/m171XxHvSFatEDP0OvZMRUB9FSQA0
 48cCNSv5AoSwDShm6AYjYm0Vwb/UHKolPqAydjYmYx2/cnHxC34pJ2P8h8TM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> I like that COPY_ARRAY and MOVE_ARRAY are handled in the same rule,
> as they share the same parameters and do the same -- except that
> the latter handles overlaps, while the former may be a bit faster.
>
> And I like that it's short.

Thanks for such positive feedback after our growing discussion.


> I don't like that ALLOC_ARRAY is handled in the same rule, as it is
> quite different from the other two macros.

This case distinction can share a few metavariables with the other
transformation approach, can't it?


> Coccinelle needs significantly longer to apply the new version.

This can happen because of a more complete source code search pattern,
can't it?

The data processing can benefit from parallelisation (if desired.)
https://github.com/coccinelle/coccinelle/blob/66a1118e04a6aaf1acdae8962331=
3c8e05158a8d/docs/manual/spatch_options.tex#L745


> Here are times for master:

The SmPL script execution times can be analysed also directly with
the help of the Coccinelle software by profiling functionality.
https://github.com/coccinelle/coccinelle/blob/66a1118e04a6aaf1acdae8962331=
3c8e05158a8d/docs/manual/spatch_options.tex#L736


> ... and here with the patch applied:
>
> Benchmark #1: make contrib/coccinelle/array.cocci.patch
>   Time (mean =C2=B1 =CF=83):     43.420 s =C2=B1  0.490 s    [User: 43.0=
87 s, System: 0.273 s]

I got an other distribution of run times on my test system.


> The current version checks if source and destination are of the same typ=
e,
> and whether the sizeof operand is either said type or an element of sour=
ce
> or destination.

The specification of metavariables for pointer types has got some conseque=
nces.


> The new one does not.

I suggest to use a search for (pointer) expressions instead.
This approach can trigger other consequences then.


> So I don't see claim 4 ("Increase the precision") fulfilled,

I tried to express an adjustment on the change granularity by the plus
and minus characters at the beginning of the lines in the semantic patch.

The SmPL disjunctions provide also more common functionality now.


> quite the opposite rather.

The search for compatible pointers can become even more challenging.


> I think an automatic transformation should only be generated if it is sa=
fe.

Different expectations can occur around safety and change convenience.

Would you eventually work with SmPL script variants in parallel according
to different confidence settings?


> It's hard to spot a weird case in a generated patch amid ten
> well-behaving ones.

I can follow also this development concern to some degree.

Regards,
Markus
