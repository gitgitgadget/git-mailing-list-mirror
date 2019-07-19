Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E0771F461
	for <e@80x24.org>; Fri, 19 Jul 2019 15:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728011AbfGSPHi (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 11:07:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62897 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727535AbfGSPHh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 11:07:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD14615FBC8;
        Fri, 19 Jul 2019 11:07:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ADjTPfCDaP6a0yf7taDpcbPE3Ro=; b=e8tuxt
        2k1pYBExaPmOBAWNAKdUlo9oZVu8p5AWn6bhpoLWh680v49a+H/RmOcF9wwSQBBQ
        PDizz57ufRqioLZMiDeRyUiiS80VcjYRAt/XmeKHEmwYWLEcQSw6wZtWNHjrzEed
        5tpScYuGVCSidR/N6arh7W1Tj2kCp8VqtuIzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rQ3vlbI0ofY2UYb+9G7K874k9DDVKCxk
        YJqm4wkU1mzsj6PdQRnSiEeXS77Yc1dBEPp8NA0XGzAnGjX2DyIVolpuvq1piet4
        B2ZF4NW4FG1R/17B+63WUkPuippbD+2hiDWsSCft1upGz3YXbt15Ia2BUDUbx3bX
        cjLKFsdT+4A=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A589B15FBC7;
        Fri, 19 Jul 2019 11:07:35 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1391415FBC6;
        Fri, 19 Jul 2019 11:07:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 23/24] t5505,t5516: create .git/branches/ when needed
References: <pull.287.git.gitgitgadget@gmail.com>
        <db69b33ff4a583f75e07f15d10dba70bd99fcaf7.1563455939.git.gitgitgadget@gmail.com>
        <xmqqftn3xet7.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1907191555180.47@tvgsbejvaqbjf.bet>
Date:   Fri, 19 Jul 2019 08:07:33 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1907191555180.47@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 19 Jul 2019 16:52:00 +0200 (CEST)")
Message-ID: <xmqqpnm6vz9m.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F0797D38-AA36-11E9-B5BD-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Without this patch, and without removing support for `.git/branches/`,
> you force the Visual Studio build to _not_ pass the test suite. It's as
> simple as that.

I see it as deficiency of the build procedure.  What makes it so
different, compared to "make" we type on our boxes, where we do get
the .git/branches/ directory anyway, even without having any file in
it?  The patch in question is to punt solving that and instead break
the test suite.
