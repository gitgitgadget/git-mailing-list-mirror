Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C496C00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 17:11:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233231AbiHJRLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 13:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiHJRLe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 13:11:34 -0400
Received: from mout.web.de (mout.web.de [217.72.192.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61A379EC1
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 10:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1660151483;
        bh=K/a4r1XsuZOq2vyPDbwNyUYnnunTOuKV+7LDlCOX67A=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=WVHf9KgX93L6AUC6xRLeknaRpMok3G8moKDu5Jvk8YlilmGRSxwv5HvChfp2Wm9/R
         bTdw2lVNZm0zvRtdUw8erEZvfoQe6qkpyOowybz77Na37KR6Y9z5s9wi5S5Wgn6+Aq
         +7nTmUQJ4JQM3IPZEUFwBQSidixDlAsB1pKZr/mU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6JxT-1nJXYg1LmD-016e1J; Wed, 10
 Aug 2022 19:11:23 +0200
Date:   Wed, 10 Aug 2022 19:11:21 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     gitster@pobox.com, git@vger.kernel.org, gitgitgadget@gmail.com
Subject: Re: [PATCH v2 1/1] doc add: renormalize is not idempotent for CRCRLF
Message-ID: <20220810171121.qwuiipheotx2bwaq@tb-raspi4>
References: <xmqq5yj6z5rx.fsf@gitster.g>
 <20220810144450.470-1-philipoakley@iee.email>
 <20220810144450.470-2-philipoakley@iee.email>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220810144450.470-2-philipoakley@iee.email>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:nRF1OU3Y4Q6mozp4E+lZnXzKXDxnZzKSgB3XurP2pboghOTtBZm
 FPtAoG430wukDtq5COG6x6+FzP/xUKkR5a55gzaY2IbY+eOtte4QzGZB/8FqwtvFkzGQsTp
 l4NmzFUIPKTWG9AzNjS2DWFBcv0O1gZRZ179KIa6Awe1H9Eg7axdd/k62i6z82/XhmKos78
 FvGrHDviOyP/lSq8wCr0A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8q1g7uzK1wc=:1IhLsVP5CqLTEVGxgMtH/+
 94gdbd/EKl774gjb41e/dLtYJL0ht0A96rpQlYBwJp2E47Ik1aJRpO1BeN7+1eRJKCHTWBM9w
 USgN/YzjAerTH8tMrfZQOeTDzxyczl3IIlu5PguVjfyEiy/GYeRtdUjT9p8HySW90C4sSR2Io
 jiIkfjiXYSPuPG0rZg1jyT6IqyQhSSlgkEdrkpNRd7mGJ3cMqy3nDLvOeKyGikJkre1KqAVHg
 nCeYmEpLT9F2umRRcKe7OQn6SBX1yi9UJm3qpiM0sTRm24CNfmj5HNrFgiXWKIIRurGJDR2NB
 /h9SwthAlj3pyqYF24G549czpHjZkbHeuQvN1QG/eqQQZeztHhHzTNgtqw/AhRWu/x+0be1uu
 TXmdNsddrX9nLQ+EMSNbfaBkEL50K0/dNDCDKlvfEEgpDN0UgrlKOFilUErhtoSMsaf9U3xFt
 Qv+2XabNl296TWG6/htlql34YuvcFGMt3D8v0FuFUQaRPeeClG5RAWRU57NlK/xuBZv3Z11Dl
 wUSp7tAlLu0vNTR17Ej0u9elLo3Yiow4W+gGU4Uz7pLpCI3tGwhuvuxYr7/DnpA+6uE0x8LbR
 C/c4+QfsVM49D1YRe0FIc2JYumQonCqhpzQN3rl6l+CGvyX9S0DFwrHNoHsFaIGBK+DUOLivX
 Fh4djFuoG2q5Sv9BRzcSQTS5we/3IAyzH7NMkuQ/K1lRLbMRHcznyBPRj2P3GXd/PCd2bBS85
 1M3yc0PkyL9kGS3lyRYfXqa5KmG77k+tvvdTffbfCkUlpluzgX3qUlc4T1uJfMdgfK2bAWRJs
 +Bv8DnXhoOMv595Ls2mX6IGxhec9tPSoiVrDE9Vjn/tUzrSEii3qPE2K8csCxL9hmFhlEVSMn
 nq2Xu2TvaW/4fXkGaWNLC8iEGuIaebVXTllIzedhUTZvlX9rOx0zIN+DT/FPALdRYA9NMoHBc
 +FYCGMqxvZHZ6gknwOUfbELFlHtdz63QG6WSgLnaLa/RQF3c1JYmabrKZxTgkOHY3nqFLtqcg
 FuT8zFw/n/vdk4kiwC1vPCb/Nb//ACVC2JJoCdVPA+ZtulThYhJgq4pCvgthqDHUE399CK8xM
 C7qUrgpo0JYWzeR5n9hKqL6YIARIO/VD20UzocTkGuH0Zqtfz7KbfJ/6Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[]

> diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
> index 11eb70f16c..9b37f35654 100644
> --- a/Documentation/git-add.txt
> +++ b/Documentation/git-add.txt
> @@ -188,7 +188,9 @@ for "git add --no-all <pathspec>...", i.e. ignored r=
emoved files.
>  	forcibly add them again to the index.  This is useful after
>  	changing `core.autocrlf` configuration or the `text` attribute
>  	in order to correct files added with wrong CRLF/LF line endings.
> -	This option implies `-u`.
> +	This option implies `-u`. Lone CR characters are untouched, thus
> +	while a CRLF cleans to LF, a CRCRLF sequence is only partially
> +	cleaned to CRLF.

Thanks, I think this one looks good to me.
Reviewed-by: Torsten B=F6gershausen <tboegi@web.de>
