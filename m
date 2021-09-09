Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8B4C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:08:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAB3B60E94
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 11:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234886AbhIILJV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 07:09:21 -0400
Received: from mout.gmx.net ([212.227.17.20]:52367 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234216AbhIILJU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 07:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631185687;
        bh=adf5ernARKfAtG45gsuF+gF6aKRX1MV9upzDXtN5giw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=iuKCWwmTxgW84dnxGsl2AJG4vzMDKiqYS8iYFZCNlbxeUzjjs8L5DG9CP2/DOE+FB
         xEi78yWfUeXb2oN5JhPAV/d9qitgaI8go/02t96rCL7eSoX/JxWcVZwgNsT3waU6EF
         +a9L37JFO9u71HOdK+E1Jmt/3r6niu1heDvQouUU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.86.174] ([213.196.213.44]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1mgvFz0ZJU-00IpTW; Thu, 09
 Sep 2021 13:08:07 +0200
Date:   Thu, 9 Sep 2021 13:08:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/retire-preserve-merges, was Re: What's cooking in git.git (Sep
 2021, #02; Wed, 8)
In-Reply-To: <xmqqsfyf5b74.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2109091307070.59@tvgsbejvaqbjf.bet>
References: <xmqqsfyf5b74.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:wCJMWyfxsimE2XytzW0oWJgl4QtB3DY+IHyTHOqcP3WgTqMuUlf
 OvDPQRzRkL9Mpa0R1ybrZ3sFUXSFWql82LN8qEJjoEFbJ5DsleR2MOaFIcIuWAdeO9ySZER
 sTA4DCF0qZoVB/+hKD4UuAYOwQyfVf1Yt2s0EahcEuu+847FoHIvf+SRoT4dFcdmqmHJqmK
 DMpaBqZx806bPv6auNAZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/42YM3gyZIE=:XwFC5otqMZiDsg5WbICKsY
 jzaRS3TEAXBko068RkBjRNbfNtWiRAQ5PdPaGkn4rjY9Fu1xZ/fMj5YAnE2XuTJ/6xoPyaD3V
 CODycYGYKI7nzTlwRRLWO+PS31BN3KRm4ShMSzxkwWnSB7vO9NZjs3YIxRIpOyFzyEMkGYui8
 bYeqDxvMJf5Hrucw8HHlMs09wjvaV7KcLu0wIPpKJ0p2GT5WXRpWzC0Z2kWChZjQfv+0ezK9h
 byoefyi/qeIzyXQ6deB5BIeuhhzxCy+u2+xZcqORnqb7kKYNFLrD5KuzTuv0BWSe1xpzdXgIv
 OZT6Zn+Y1Ia2GOMVjfXxYQ6AwW1wWJ+uJ091cbnTCNPWYICLuJO0oWAP2PLNoAFl7sfdr4xdY
 ft8WcO6SJ5eECn4ysxMIliW/f0rLEN6dh/J5TLENUjQt8EE5XOx3y1qc1YnhIzfzSxLqpvj5Q
 aGyY40dPm5zLD2779Up/Y8WeWtSxHZohnSG0xSTzAHTAspwwMOsGajLFUZexlr9ydZ9YlQrVa
 WIdSAT59tAQnNg7123l5VQ8OGajZxH+izxBoe0UXEP8GoVGyEbweTFo1pHrReazjOjcvAtZ7t
 Df7TJsap42bzGcvW+JTe+0PiIJsXGBCJDkrsRvFJNuNdmKAlGkwuQdR5oFJgBfFkUgyFVXefq
 MEjRdtJmsTPmNA1mxktFc6d6P7RepkTYdVmtG9q5DkDMsy8C1oPSYwAb+UvDrEhQBO4TZt/UH
 mp4ZKWxHjVTV65i56+10bPBDcjMiAPwZR7/NiY5nGqpH2DSfGY938Bdg3B6+gppH3o9ny4DTD
 KVJ9pXNWYHeIHDU8xnRdTFRLEWgGbse2QOg4GQgvaM5khc3Lya0GP9potHZGtwsRjN1mDk17y
 eqPqYEkM1TIvkSORK4syOjdAzNMbwkRmNGwI2LYicB7w6KCwHttNeS6C9IzDV9RmuZp+bA58b
 MllL5vRKPcF/liysl7OGvKXkspjkHGFC4fNInWMDRPzxy00UlSaG27sPUPr9DWm/LlYrlGKWn
 S4H197OXHcoDrSKvp3WMjBoa6RabDc329mSyMimoWNalN7PtbHra082jAsBi1TI8Jrrs33num
 GK5Dg3pAumXmEE=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 8 Sep 2021, Junio C Hamano wrote:

> * js/retire-preserve-merges (2021-09-07) 11 commits
>  - sequencer: restrict scope of a formerly public function
>  - rebase: remove a no-longer-used function
>  - rebase: stop mentioning the -p option in comments
>  - rebase: remove obsolete code comment
>  - rebase: drop the internal `rebase--interactive` command
>  - git-svn: drop support for `--preserve-merges`
>  - rebase: drop support for `--preserve-merges`
>  - pull: remove support for `--rebase=3Dpreserve`
>  - tests: stop testing `git rebase --preserve-merges`
>  - remote: warn about unhandled branch.<name>.rebase values
>  - t5520: do not use `pull.rebase=3Dpreserve`
>
>  The "--preserve-merges" option of "git rebase" has been removed.
>
>  Will merge to 'next'?

I think so, given the rate of reviews still trickling in tending toward
zero.

We probably want to keep it in `next` for quite a while, too, to make sure
that people get the memo.

Ciao,
Dscho
