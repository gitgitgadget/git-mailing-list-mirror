Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174C9C19F2D
	for <git@archiver.kernel.org>; Sat,  6 Aug 2022 19:22:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232650AbiHFTWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbiHFTWl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 15:22:41 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74472DFB2
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 12:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1659813748;
        bh=WPjmx8tXMVMZONANG7ngSz7rJhVRWlaR6P5YeeclKMs=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jRIJ9YRIM/REw+NDFqn52LOeKddvJZuqvwIblHcGI5Y9jCQKPlw+M4hfgZbP0uB2i
         3NuMMzxphSfvVmchyZGqJtBqyT7LwaNvbpnGPrVMO0jnsDzNdKPlHKxe4b99XU9u6y
         2qhnlng8gOiIIjkkQ4FlC+D1dWDR5hBFDThIWphA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1My6pf-1nUKp23Zh1-00zBNi; Sat, 06
 Aug 2022 21:22:27 +0200
Date:   Sat, 6 Aug 2022 21:22:25 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 4/4] doc add: renormalize is not idempotent for CRCRLF
Message-ID: <20220806192225.gu7o2avekbtcg6py@tb-raspi4>
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <d3b8ed97a105ea1d7e656c964b7eee378e11ede6.1657385781.git.gitgitgadget@gmail.com>
 <20220710074848.ku2zobuck6vyim5d@tb-raspi4>
 <1b90edd0-3d9d-a741-8865-3968826da315@iee.email>
 <xmqq5yj6z5rx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq5yj6z5rx.fsf@gitster.g>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:XW1sqnGZENI7QzU6TfmaziIOa98kbE3Hf6BR6ibhjM1+6Riu9WJ
 lsRYh4yBv93bPNWd8NWgzKnWcNOlO3F2um03sPIS7bqQs/5DnlfsnZAZqSd42FYvVpV9lX4
 Id0ZZZQ6AqIXFss6WV9LgJrYRhUkn3zBTv281kATaE0TL5LrcOlgvRQgI1TxnJjPqqw/q+r
 YY270wtpBRvYGoIVkYpgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CgtU+hpGI8A=:DENJFK83UJwVwTyaL8nrI5
 YGEzOYllAcnaJXRxQYidLaj9Q44fTv3pTciPmPTv/tFlUc4HaxpfFUdelTPvBU4q83R43kgaC
 eTLwFxmw88pMJ1Fnkzx34xg2xkupuUMrgGH71DGo2hbpTSaia+8yAB2hRRHZOdwzw3JsUM00f
 xesR/SaS9AuOHxuvZ25PZeIDQ6itBQML5Y3G0hrUjhYBcNVkv8M8gjw6I3QVhlEXXOw7vPSU2
 e9OHK0XLRMxqbZq9uVPJpG4/BL6TEp/bXaxc1WJ3++lc1XRA5/SLOsZAmIyEzO8KCOjm08G8h
 kmZB08Ph+48oGRedQtUdmDxeajzcZuyZQhsiW89KYaeuJO7JAvzDeI9PlKx6EdsTwT/DtAfyj
 0RuRaNom2Sgo3dv1ql99dAfJHVASmDSoQ4ZV/9z2kJjp2d5+q9z0tnHjsFWTANAGLGE9ARTfE
 aHyOGGOtX1soElZMHrk8XSHGBERtOBJv7PxFgq4yS8kLyrDKERP+aYinLEmMrWI4oxioMmrKW
 Ne/L7n1mHRP1+Bp3wYYxLq1KK/ax/YYrNmYh03n0ZNCPHqmUE7vldR8WoTzm3Lw79IfmNXjIL
 7mQcOiqvNxzn0GmQHailq4WDRoPbCW6AgWHYPXKZUlheq4klPu6ou/Wt6u+BhsIRnmT0bt2LA
 crNHHtEplM0VPpRzpSVvxS3M2r+GybCSTg+jFRF8rvHkrE1WmEgpUrN1obU6okrzo/P6sgUWm
 7zlhxvI84z7Qt3x0LYy2VN3v/19S1xB8lPtbnN36ENUFpOM1DM8LHnwRx/rn1MoleDDp5lWR4
 tqtHb/Tbttw/+IKYpl1myqhxpAP91CNbcR9VuoZwzVOBuwyKpaRJH3nyG3nJnIpGigWVN9sSI
 pKXYK4yYNcwn+Q/1J9Lq329nTiyPK2FRJqalhzeo4xDRdg6j+LtHC2RJ1veFXkMFJrM0X3V76
 93YM+bSRUoVprlZEpFcGNz5E/YI+EtLlARjfTK/pZXBS3OjSJjPs1TcM0d2kjLCRFNy91dy8d
 xBj1OuSnwitb4TXPE1ULodz1CV7/I+w/KLN2HZqQo+VYN+nq0ZAUdfJsyQmsBgpj5x+pOel8u
 eqWJmie6hAegW2ZOljScSBUyquVl8YBhKCJGiHxpP62LshUR8g05GNOQA==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 05, 2022 at 03:26:10PM -0700, Junio C Hamano wrote:
> Philip Oakley <philipoakley@iee.email> writes:
>
> >> How about this:
> >>
> >> This option implies `-u`. Lone CR characters are untouched. CRCRLF cl=
eans to CRLF.
> > That is probably sufficient. It drops the awkward 'idempotent'. And
> > indicates this edge case, though doesn't highlight that the resultant
> > CRLF still leaves the file only partially renormalised.
> >
> > I'll reword.
>
> It's been a few weeks since the last activity on this topic.
> Anything you guys need unblocked to move forward?
>
> Thanks.
>

Not from my point of view. My understanding is, that the short version is =
OK for
everybody:

This option implies `-u`. Lone CR characters are untouched. CRCRLF cleans =
to CRLF.

Is it OK to ask you for a local ammend to push this further ?
