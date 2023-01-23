Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A7EC25B50
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 18:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233477AbjAWSDU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 13:03:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjAWSDR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 13:03:17 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC80CA0E
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 10:03:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674496994; bh=A5c9UeYIK1wa49ejprpkc4Qhl2q/hpEz9Lw4t+SE3a4=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jdd3VujZX5tcT8cBCWs2LnJ/ZRbigy2+77pCKToSju1m79Gl0+/eEqbhVzMCl6Za1
         xTSuJy/UOm+5JoiJ3VR58FjR6Zr8cQdwZ/7wBMD5OuzpNammUhzpPQx6rHXpnRGAbb
         64tsMm6ARyqGcKgT9Dusn0nfpTMZ1TTtp1g80Bc6iHBRl840RXxSYl+Igx0xVNH1M/
         pigzCu2ykaL/RQTyjvwoZ/QCe2n798AHTBgcWuiNDLxzkFHCF8pn9KlI3ajVKfTqbR
         1HNKWeGBsZH+HXztx+RGM383IYJ8wPZK6j1CpSOGdfVkWE4sIMYQMRoawxaRJF97p9
         wJXJJfUwgvLZg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MgRMB-1olW8w1gjP-00hsZK; Mon, 23
 Jan 2023 18:58:05 +0100
Date:   Mon, 23 Jan 2023 18:58:04 +0100
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] MyFirstContribution: refrain from self-iterating too
 much
Message-ID: <20230123175804.2bkcr7yawyz5fhkb@tb-raspi4>
References: <xmqq3583uyk0.fsf@gitster.g>
 <20230122071156.367jwwt3d5txvkl4@tb-raspi4>
 <xmqqcz76tv6d.fsf@gitster.g>
 <xmqqzga9opdu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <xmqqzga9opdu.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:v88nBuaFpeVdB8uzYO8TCPrNc8oaQS9df4L2GNfJrOWAImqh2aj
 yC7TnE95Du575oAqLqTvn7ygGxlwP2BvYVeSArmJsQmjTsRm8hDl79DqXiHuXfZ4Z7kkPPG
 sKdbYgNuE5Y7Wsk4wDRQ6W9GNHYCpasH5Kgci2dnrSVlCwoFik2ORtP3msFSRsEV4ZqDdig
 poHZzzvbTgdhFUHv0ejJw==
UI-OutboundReport: notjunk:1;M01:P0:N3BGb9QfQRs=;7QOLFhZh03pjmHkryKJYLd3/wIq
 Y00cjUSNsGyRA1R000QlEg/h+SS1qTqIMbIzXqXo19tPeIbJPGXeduDUyTA1sYD4usm3lLocM
 M33vc9+JOIAmWSF/jvgURYjTk75QytqwYasdHREcagyfRi+g8M7YkuZ/ar5Q+d5WdgMsKCBcA
 iE/5dzkyk6ofpc5xVf3KHLNm1RouhIO9cUHDU8SlNepwFx7mi+O1x2ePdudD/5x0VK/hhVciZ
 c3lDuJOL0z0bWaL9TuqEZyJjDBsW+QpY6OgpBmyJISkkFFrpZZmM0Ceny+ihrTQwXfqMathjS
 c6N6Ov1ASDnQw0hjuaaAUF2oAQvwCJ6Sk3rSCgo9NxXWHbvw1MY+Yny0iNMCTI/7b6XQ0K0XO
 rsAuYxQdvP85gAj5K8AGOUzQzfD52K2OXlRCMovk5iwKgICLzoRqNYH+nbfLPYPju5XwfLvOh
 AT72p36PoHmSnzBgqPCqmoO+PZ6LgVxdzYREjVFqbkzlCQs3JdChkhZs9bflc004bLzVcn4nw
 3kJAaxctMWOEakW+DGlYKmPNqU0lAM9W+pwbXl3ug/TFqmfvdV9QhN2XjzuIhQNyxtOA9s15T
 prPkpzGDfbBKQCLbjvwElxXaG+oPg2htWKvKk/Tq5jRvEibAZef9jutheeqHHgWwfYshy/qDx
 2jk2nxS233BvcHB7IhaJq/abe0gdFG538N6DkBsc+W7Wd2M5AKmIpAI3uGbByNja+CP0DgI+T
 x69bC2FXZ2Dmkk6276OEAdxvS+H5JXG5xFVJAdiuOJk7DERk6mFO9I4Rm+rRElXMIrsnJBSxF
 13yrjBz06IJxjYinUnk8RSdSqjuHFnDhiZNcXwglH4ci1HJddRuD4teec8JQOqjtZ4OBXNsso
 DWHlOsM059Lh7Z9TkKRZbnucwR8LTSoSPQ8SAfaxh7GWKE+UDengzwoj55HC8glKkoWzXj+RF
 j3KMSQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 22, 2023 at 08:18:05PM -0800, Junio C Hamano wrote:

The whole thing is much more convenient to read, so to say.
Some nit-picking inline.

> Finding mistakes in and improving your own patches is a good idea,
> but doing so too quickly is being inconsiderate to reviewers who
> have just seen the initial iteration and taking their time to review
> it.  Encourage new developers to perform such a self review before
> they send out their patches, not after.

I think that this is what V1 was about. Review first, send then.
Is there still so much focus on this ?
Or is it more about "what to do when it went wrong?"

How about this, or similar ?

...it.  Encourage developers to wait with a new version too early.
But if they plan to send one later, they are welcome to comment
their own work as they where reviers.


>
> Helped-by: Torsten B=F6gershausen <tboegi@web.de>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/MyFirstContribution.txt | 30 +++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>
> diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFir=
stContribution.txt
> index ccfd0cb5f3..3e4f1c7764 100644
> --- a/Documentation/MyFirstContribution.txt
> +++ b/Documentation/MyFirstContribution.txt
> @@ -1256,6 +1256,36 @@ index 88f126184c..38da593a60 100644
>  [[now-what]]
>  =3D=3D My Patch Got Emailed - Now What?
>
> +After you sent out your first patch, you may find mistakes in it, or
> +a different and better way to achieve the goal of the patch.  But
> +resist the temptation to send a new version immediately.
> +
> + - If the mistakes you found are minor, send a reply to your patch as
> +   if you were a reviewer and mention that you will fix them in an
> +   updated version.
> +
> + - On the other hand, if you think you want to change the course so
> +   drastically that reviews on the initial patch would become
> +   useless, send a reply to your patch to say so immediately to
> +   avoid wasting others' time (e.g. "I am working on a better
> +   approach, so please ignore this patch, and wait for the updated
> +   version.")
> +
> +And give reviewers enough time to process your initial patch before
> +sending an updated version.
> +
> +The above is a good practice if you sent your initial patch
> +prematurely without polish.  But a better approach of course is to
> +avoid sending your patch prematurely in the first place.
> +
> +Keep in mind that people in the development community do not have to
> +see your patch immediately after you wrote it.  Instead of seeing
> +the initial version right now, that you will follow up with several
> +updated "oops, I like this version better than the previous one"
> +versions over 2 days, reviewers would much appreciate if a single
> +more polished version came 2 days late and that version, that
> +contains fewer mistakes, were the only one they need to review.
> +
>  [[reviewing]]
>  =3D=3D=3D Responding to Reviews
>
> --
> 2.39.1-308-g56c8fb1e95
>
