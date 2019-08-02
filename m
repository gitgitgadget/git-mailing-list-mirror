Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91A111F731
	for <e@80x24.org>; Fri,  2 Aug 2019 20:36:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728669AbfHBUgy (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 16:36:54 -0400
Received: from mout.web.de ([212.227.15.3]:58415 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbfHBUgy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 16:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1564778207;
        bh=S86mqXVDJTODT55kpSde/dm8Q7j1e6Ax/uPQM5oUnH4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Xu15tX/s1NUKUQ+15vuqAsc8I9dkbMMlNdgTanmpy1bXWMI+VPpsS3mG8xmKu5yXx
         NuC9sT8t4FaZHRtZh86q63REMdD0sDpMmfNHTT9fdyEACbVf6GKoIi5UJFe6c7leXh
         B3vsOlRtWav1DGbh9LFh50go2GLfb4jGgWaz6PE0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lx77p-1iQrV01MF7-016jvM; Fri, 02
 Aug 2019 22:36:47 +0200
Subject: Re: Simplify-by-decoration with decorate-refs-exclude
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?=c3=89tienne_SERVAIS?= <etienne.servais@voucoux.fr>,
        git@vger.kernel.org,
        =?UTF-8?Q?Rafael_Ascens=c3=a3o?= <rafa.almas@gmail.com>
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
 <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
 <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <5de287e9-a8e8-780a-7d39-2229b61914ca@web.de>
Date:   Fri, 2 Aug 2019 22:36:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M3meMP3XS6hZ0Rxmm5aIaUcTL1mzc1SxndN7OvLkw1g6OldIoc1
 voDUC9fKePokLIlVBEBQOAFiox5FvwjvAEvBIPtWXvwV5R4JakRCEP675O8agBKxoav40KN
 ah2AnAynVClYVn3IGih5/tLhrAUju4uX604LdE94JmHbN5iOxT51pv0dnCujDJUHxmNdEkN
 kg4pk3xa3Sd4fyk1fMwQA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:k3qO652wXa4=:6+7e/w/W0QZCQBXhlOvykO
 H2Tp9yi2hoQLIQSAEvpyeXMCa+8kgj0Iw2IN8ueNZU6kkpX33lNGBuXIhsVPETIcPpAEcTI8L
 PDbP3+Xx3sBlheOKvjhOKoulVcwyruz8U0QiXg0XrFL0fkH3vt0BSoUktRaZbLFAuwprXfIgo
 gLbzcCdiFOMNswir3ttBeKsBLs3E8vOrn5PKhXgAABWtAf9hdV5awlkne6A3rFM/R63LC3lzE
 C/nN4k0u+3Cpex8ktC/o1UkYxi0FZBY2yqVHnXFaUeEplncxBeuUM6NwtWTeSASz2GsZC5S29
 MFB08voB5B2NXrNNN9zZMprDazqDprDgOU3DJ1Ie+pp3yOc9ljtWMgIf9TCu50CnB5W5/no1t
 F1emWAlYTNC0U7urGKKnSdzRuKzDlX5wfIfMF05w34aPYoVYRjnS0Cy5IZ3OF7Gyc5qxoFsAI
 MpqQ0GTyJpr7Sb3QZFS+LiTgKX14jcb1US4R/CNbmdFG2qDzqqFs3YjvYH1MdB7YJcHiGUvdk
 +0V4YQInF52WnBTCz5WqvoRgd9PckR0BQKa9OEyibBgdRIWbRuJKv8bqLfQFj/yqrSpfevez3
 NL5bwijd8gGPy+guPTJV6cWpf1V07Ph0jc5RUoUfsAnVKmcZ69Tk1tUCd8kGLxAvT++wC3BCU
 Q692c95J0vsdRra4jHJgyaMb50eCH66EmRSb89zSc5xphGe7z3ygOkHNXRrcQvVA4T4rlxLEz
 +MwuADZRHd/YG6TxqhMB7HW9nKOnLwEDIrlOuo3CqMZYUYwHsk9/SEr5Trk6or+H903M0thzm
 b5QJL2gXGMotsIt0C5GrT9PNwYTsy1Jo73ismqq9jU+Ykd91xVMrZcTedloMT4N5G66Rich2v
 VUh0PMBKYzQFXgXmbQYWSkKgUuQ+gV5VDQplA4loNehCycsbOSp5YK2XovYbRX+k0yD4el15V
 uXMcDN4Nk6mD+XHqa5mBfLiuC8Zat4mIIxgMeFYrwk3Eu3uQ0Md4RUxRXDGAwd/oZOTyTtrnn
 l2YkWw3MNXX08bLcM0il7hSd8U5VqZppxJ8wUbl4Y//QsuOXB4+xxK2pUkG4c8wSiWmIAUuk5
 cz/aW4Iimgzmu3+utAbeXc9x3kwGzo+EKzox0SpJ8a1WdWl2nFsYWPbc2CaT4mDNMoUjbJhW3
 924QY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.08.19 um 21:14 schrieb Junio C Hamano:
> I can see how this would help, but it somehow feels a bit brittle
> to rely on where the decorations get loaded.

Right.

> I wonder if it would help to move the ability to handle decoration
> filter down from the log layer to revisions.c API layer.
>
> It looks to me that this caller of setup_revisions() can prepare
> decoration_filter before it calls setup_revisions(); we can let the
> revisions.c layer call load_ref_decorations() in setup_revisions()
> if that is the case, no?

Having cmd_log_init_finish() call load_ref_decorations() before
setup_revisions() would indeed solve the issue as well.  But we need
to call the latter to check if --pretty=3Draw was given and avoid loading
decorations in that case, don't we?

> Other two callers of load_ref_decorations() are deep inside pretty.c
> but I wonder in the longer term if we would want to turn them into
> an "a lot higher level should have already loaded decorations"
> assert.

This would require that higher level to parse the user format to check
if %d or %D is present before formatting the first item.  Hmm.

Ren=C3=A9
