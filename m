Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4631F404
	for <e@80x24.org>; Mon,  5 Mar 2018 05:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeCEFf0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Mar 2018 00:35:26 -0500
Received: from mail.javad.com ([54.86.164.124]:57391 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932476AbeCEFfZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Mar 2018 00:35:25 -0500
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 62A26407C1;
        Mon,  5 Mar 2018 05:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520228124;
        bh=aAMb2qjuqXBzfVL4cYqQ4m1zYWU5MfGJ+i8sVj7GulE=; l=1000;
        h=Received:From:To:Subject;
        b=jCty4ky8NKFQLap2S3/S6lNmROJzUG4I9Bgp3r6tgXhuwxts8OQu0Gq9IrOV/UwTn
         QR29l5f5H0v9CKn694qPWhKTvTtmwewl5vFOTQiFr/z8CvgyWepW6+4VMzRURflFbC
         vHvyk8c1Q0HDGazQ9Pd5lX6FV4jHAo5HbLCBj7gM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520228124;
        bh=aAMb2qjuqXBzfVL4cYqQ4m1zYWU5MfGJ+i8sVj7GulE=; l=1000;
        h=Received:From:To:Subject;
        b=jCty4ky8NKFQLap2S3/S6lNmROJzUG4I9Bgp3r6tgXhuwxts8OQu0Gq9IrOV/UwTn
         QR29l5f5H0v9CKn694qPWhKTvTtmwewl5vFOTQiFr/z8CvgyWepW6+4VMzRURflFbC
         vHvyk8c1Q0HDGazQ9Pd5lX6FV4jHAo5HbLCBj7gM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520228124;
        bh=aAMb2qjuqXBzfVL4cYqQ4m1zYWU5MfGJ+i8sVj7GulE=; l=1000;
        h=Received:From:To:Subject;
        b=jCty4ky8NKFQLap2S3/S6lNmROJzUG4I9Bgp3r6tgXhuwxts8OQu0Gq9IrOV/UwTn
         QR29l5f5H0v9CKn694qPWhKTvTtmwewl5vFOTQiFr/z8CvgyWepW6+4VMzRURflFbC
         vHvyk8c1Q0HDGazQ9Pd5lX6FV4jHAo5HbLCBj7gM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520228124;
        bh=aAMb2qjuqXBzfVL4cYqQ4m1zYWU5MfGJ+i8sVj7GulE=; l=1000;
        h=Received:From:To:Subject;
        b=jCty4ky8NKFQLap2S3/S6lNmROJzUG4I9Bgp3r6tgXhuwxts8OQu0Gq9IrOV/UwTn
         QR29l5f5H0v9CKn694qPWhKTvTtmwewl5vFOTQiFr/z8CvgyWepW6+4VMzRURflFbC
         vHvyk8c1Q0HDGazQ9Pd5lX6FV4jHAo5HbLCBj7gM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520228124;
        bh=aAMb2qjuqXBzfVL4cYqQ4m1zYWU5MfGJ+i8sVj7GulE=; l=1000;
        h=Received:From:To:Subject;
        b=jCty4ky8NKFQLap2S3/S6lNmROJzUG4I9Bgp3r6tgXhuwxts8OQu0Gq9IrOV/UwTn
         QR29l5f5H0v9CKn694qPWhKTvTtmwewl5vFOTQiFr/z8CvgyWepW6+4VMzRURflFbC
         vHvyk8c1Q0HDGazQ9Pd5lX6FV4jHAo5HbLCBj7gM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520228124;
        bh=aAMb2qjuqXBzfVL4cYqQ4m1zYWU5MfGJ+i8sVj7GulE=; l=1000;
        h=Received:From:To:Subject;
        b=jCty4ky8NKFQLap2S3/S6lNmROJzUG4I9Bgp3r6tgXhuwxts8OQu0Gq9IrOV/UwTn
         QR29l5f5H0v9CKn694qPWhKTvTtmwewl5vFOTQiFr/z8CvgyWepW6+4VMzRURflFbC
         vHvyk8c1Q0HDGazQ9Pd5lX6FV4jHAo5HbLCBj7gM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1520228124;
        bh=aAMb2qjuqXBzfVL4cYqQ4m1zYWU5MfGJ+i8sVj7GulE=; l=1000;
        h=Received:From:To:Subject;
        b=jCty4ky8NKFQLap2S3/S6lNmROJzUG4I9Bgp3r6tgXhuwxts8OQu0Gq9IrOV/UwTn
         QR29l5f5H0v9CKn694qPWhKTvTtmwewl5vFOTQiFr/z8CvgyWepW6+4VMzRURflFbC
         vHvyk8c1Q0HDGazQ9Pd5lX6FV4jHAo5HbLCBj7gM=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1esimQ-0005LP-BN; Mon, 05 Mar 2018 08:35:22 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Igor Djordjevic <igor.d.djordjevic@gmail.com>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Rebasing merges: a jorney to the ultimate solution(RoadClear)
References: <87y3jtqdyg.fsf@javad.com>
        <bbe64321-4d3a-d3fe-8bb9-58b600fabf35@gmail.com>
        <nycvar.QRO.7.76.6.1802270051470.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <CA+P7+xq8UUcLWomUi=PS_hTKfJd3dMAxMmhioDS1bixwcmKAqw@mail.gmail.com>
        <nycvar.QRO.7.76.6.1802271718090.56@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
        <4d7f3406-b206-cc22-87df-85700d6a03d9@gmail.com>
        <33da31e9-9101-475d-8901-4b6b3df2f29d@gmail.com>
        <940d959d-151d-68dd-0f13-320ebad0d75b@gmail.com>
        <87606hoflx.fsf@javad.com>
        <0ac3a3fd-4053-e32e-75ed-8829f22c2e1f@gmail.com>
        <87a7vss6ax.fsf@javad.com>
        <f1a960dc-cc5c-e7b0-10b6-39e5516655b3@gmail.com>
        <ed4d2b30-2dea-740b-6283-973c798f619d@philandanna.no-ip.org>
        <CA+P7+xrkAKB621Na3V-tE9cMtbnADX94FvTrJf26SkQYbXqMGw@mail.gmail.com>
        <f26cdbe2-1bc3-02ff-7b99-12a6ebab5a70@gmail.com>
        <39aebd06-6022-7803-e27d-c1793fd72955@gmail.com>
Date:   Mon, 05 Mar 2018 08:35:22 +0300
In-Reply-To: <39aebd06-6022-7803-e27d-c1793fd72955@gmail.com> (Igor
        Djordjevic's message of "Sat, 3 Mar 2018 18:29:35 +0100")
Message-ID: <878tb7m6ed.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Igor,

Igor Djordjevic <igor.d.djordjevic@gmail.com> writes:

[...]

> Now, not to get misinterpreted to pick sides in "(re)create" vs 
> "rebase" merge commit discussion, I just think these two (should) have 
> a different purpose, and actually having both inside interactive rebase 
> is what we should be aiming for.

Yes, if the user has an existing merge that he intends to throw away by
re-merging from scratch, he should be given a way to do it during
history editing session, no argues.

What I argue against is that this mode of operation is the default one,
let alone the only one.

> And that`s what I think is important to understand before any further 
> discussion - _(re)creating_ existing merge commits is not the same as 
> _rebasing_ them, even though the former can sometimes be used to 
> achieve the latter.

Yes, indeed. Sometimes creating new merge instead of original does the
job of rebasing the original, only it does it by pure accident.

-- Sergey
