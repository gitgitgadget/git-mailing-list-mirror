Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 661E62036D
	for <e@80x24.org>; Wed, 22 Nov 2017 01:41:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751436AbdKVBlB (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Nov 2017 20:41:01 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55703 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751353AbdKVBlA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Nov 2017 20:41:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 20559AF61B;
        Tue, 21 Nov 2017 20:41:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wwxZUcySI+sB3PeLtQ4WZFuJKg4=; b=cTVJKz
        7phL5heTniGmvjiZ4ZfNtTiXZJ6nH0eiAd3Z0suEheamGdMfWuJ7F3rv5hxHJ65V
        2DNOmGlal+gdvbKm5XfyMdbXErOXm++TNDn3qRsOVh43NVsLQ+buyoXVHmV7QeX6
        CeJYjoKdkarKPf0UN4WThfWwvPoeKTFxPUWtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bs4Grsk6EEIQa3KIitUh7BgRkDx1AqSF
        4Vzk8+qhpgqtEsZ/qHW/zQRhGxkg3Q3uRhQyjyqkrySNPt3hJsYqZB8nxSk1Urb4
        EOnsXGbVXoPk7Fv3NHRAF4GyCHGanNZfINaffpRZj1ejTl0rwpBKyeL25aBwHsFy
        r7mud34b3qQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 15B2FAF61A;
        Tue, 21 Nov 2017 20:41:00 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 621CEAF617;
        Tue, 21 Nov 2017 20:40:59 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Stefan Beller <sbeller@google.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: t3512 & t3513 'unexpected passes'
References: <73f0fb1e-5b55-1049-7706-652f1f9deaed@ramsayjones.plus.com>
        <20171121104404.GN20681@dinwoodie.org>
Date:   Wed, 22 Nov 2017 10:40:58 +0900
In-Reply-To: <20171121104404.GN20681@dinwoodie.org> (Adam Dinwoodie's message
        of "Tue, 21 Nov 2017 10:44:04 +0000")
Message-ID: <xmqq1skrytsl.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30EFD53A-CF26-11E7-A37A-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adam Dinwoodie <adam@dinwoodie.org> writes:

> I've seen the same unexpected passes, and had just completed the same
> bisect run myself, although I fixed the build failure by cherry-picking
> 82921316a ("SQUASH???", 2017-11-18) onto commits that wouldn't build,
> given that commit seems to exist entirely to fix that build breakage.

Your assumption is correct wrt "SQUASH???".  When I am in a hurry
and cannot spend extra cycles to pinpoint which one of the commits
in a multi-patch series breaks a build, I just fix the breakage on
top of the tip commit, and leave it to the original author of the
series to apply them down to the original breakage in individual
commits when the topic is rerolled.

It seems that the compilation breakage 82921316a fixes comes from
its immediate parent, so I'll squash them together, just in case a
rerolled topic does not materialize.

Thanks.

