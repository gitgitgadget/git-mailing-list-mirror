Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CB201F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 10:15:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfJGKPB (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 06:15:01 -0400
Received: from mout.gmx.net ([212.227.17.21]:36009 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbfJGKPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 06:15:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570443284;
        bh=cN0HdNvAdo+a+My++etIQzvtWOZgO4CY9zkGDPhuFV0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=SQYb+dL2fhJ5PNq7wnXkAg3xVoZ6CCQBKNRSLv0fPbi3RveBnaXU3tJ3OIYX/1Nuo
         ddxTuVmVaWyoqiDU9pVjw4nRJ6PosWQtmp4JSLpnbP5ZKmt/VzkqSEPwhjCHaPIsvG
         807ImogH/ukPFUL5WPtxW6LRIWqSyFi+2RaL7Ab4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnakX-1hs1WI3lKf-00jYMW; Mon, 07
 Oct 2019 12:14:43 +0200
Date:   Mon, 7 Oct 2019 12:14:27 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/1] fetch: let --jobs=<n> parallelize --multiple,
 too
In-Reply-To: <xmqqwodh4ann.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910071212170.46@tvgsbejvaqbjf.bet>
References: <pull.369.git.gitgitgadget@gmail.com> <pull.369.v2.git.gitgitgadget@gmail.com> <93a155a000571df3f3f3a63cd8d886d68fbe8403.1570301198.git.gitgitgadget@gmail.com> <xmqqftk67r6j.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910061151440.46@tvgsbejvaqbjf.bet>
 <xmqqwodh4ann.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:BtKo3m/S74GF/hQleRx5l3JlmkTcagIgGVCwNHzAmfpr/bShYKz
 NAfDwSmkcDdoUAkshGqDgzL74EDLzZDg58l4+11FzI/Yf7qdNvWnFKisLF9MMbFYOyxwBX2
 3kupi7a6eGhZv7rObNY07UbQbNMG3gmmUi4OKjSxR7ZFQ/mSmUw0xhFjxHMNU/lZzwVTYMb
 sV1SDTmTca8x/qKkieTxQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:euyrNk314Qk=:HUMEH8LEldWxfHonZfbguL
 f8X1GzoBuW2rLNXeiXe0qt0gIThsxLrMk3c5BajkNoWCYrpL7yqcVBIy9AcRHKc2QtCxqDG/m
 GnRtKM9HWajSqm6R4otnGjUd24x7mYfTaRjdFrK4qvGSz1Ry79K7t+9qbOec4sN6vF6Za5v1s
 0O4URL2m4FZGPNci320U1odAHyq8BddLJWjdqA2nn1zr5AuM7M4TR1FAsfvhXrSsK2f9yrsrs
 07aD5cU62AU1gqP5gnTXp0cP/H3ND8/7qtrUFWf2SWT+f0iCYv+ZiNDlwELar7rfH7wlAmfI6
 bKcLFz1/qyFGay00OV/TbMg6j5wVORoPZ4lc+VPpz3i2iur3+1PlX1EHFuTVgjS4oP2hJ0jo7
 L4Q4p6fQT7oH40ANlbZo1iUZVB10t0Ps+qMYJKz/9ZViEirzaoJlHG8XN0yNXLBp2MjZR3rs2
 swB3I2i9dpFM1EM550Lz/TudRvBTuqhXylaLuSSSjZ+iPznnJ/BU7lRPS3OMVwGGLk/kZn1ai
 +w8FzyYihkD1QVH3U36EQ8zwi13vuG9/4jTJeRtqLmAIlgcMw69ITd2wy6cp5fEDFiG0VLlre
 6qra4m4zhJQraEyO0neBcp4jNlRLp+mFglzBGy+PpMxO3myU85QDAiiEWWP8PVFCsy3ZJ756j
 G8OJ9aFb+xDGTW9Gs0EIvN1Y+Az3CiIW5tkUQdIpjeV+52WOCGORn6gUvkNQj1rWLhu/8eaBQ
 IsIKbqkq+b8z05tUKGw2o1uiJg3JImMAQry30QzkQcVpQeQbbhNerKVg+Y4+fdvycw2gLZw3i
 GpoM4GG9yjmxoERxeWUtUf/+znmWFON8x9kTbwVQ+UcTohKTmffMk1iKSzBiYAcpXrm4pLJkU
 m/XlJI27rwQeDwNzp0nyf1qb1P0v9NMelkY64vyWKZX7+BIrsLyzmS3mo7T3Djir3Vk9u7Bzd
 oaphq9K4q52vFAvZcxaeDIqxAmd2qcda5xbxFMOSUiwEG2PBYv/yK6aKCq+es4bPTWdvjJSUb
 BJAL6V5VF4+hgvVUGD5HtTqT4IoZq04VCm2q3HzfFy7bxUl/LdR1sbXw2DrTXlHZGTGHu4y4a
 gxIJx9NXXpU9pVwLjnrIf6Q9TDdMoQbsWudmoX8ELJ3apdHFA3sBTlx6vxrHpIYzyiJbme+9c
 GJHvmUuICUQDGgJCFGwAOoL6ApHGHMrfFdY19vh0YVL17NWBjVYkSxc+iJO6TDK7BgAy1fHxu
 8Pao+5YIsH3hZlZOvWISg35JWR5byvnn1uyDuDOZYMcaVjPfzoWaV+VS/VB8=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 7 Oct 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > Hi Junio,
> > ...
> >> Thanks.  I think it is much better to prepare these tests like this
> >> patch does to be broken when phrasing changes---that would give
> >> feedback and confidence to the person who is changing the message
> >> and/or the logic to emit the message.
> >>
> >> Where does the constant 128 come from, by the way?  If it is from err=
no.h
> >> then we will soon hear breakage report from NonStop folks, I predict
> >> ;-)
> >
> > It comes from `die()`:
> > ...
> > 	exit(128);
>
> OK, so hopefully we wouldn't see any platform specific variations.

I am certain of it, as the matched `128` is not printed implicitly, it
is printed by these two lines that I added in this patch (as part of
`fetch_finished()`):

+               strbuf_addf(out, _("could not fetch '%s' (exit code: %d)\n=
"),
+                           remote, result);

Thanks,
Dscho
