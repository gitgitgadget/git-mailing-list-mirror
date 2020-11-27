Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8800AC2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 11:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE3F208B3
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 11:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="fenHXhbm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726417AbgK0LHU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 06:07:20 -0500
Received: from mout.gmx.net ([212.227.17.21]:55529 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725865AbgK0LHS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 06:07:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606475227;
        bh=t1RUYRAAK8oIz27bI+sejC0kPHP6LLGQEnXKOPkkPbo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fenHXhbm7sSeBy0/2UGi+jP49HP2sLgZ5wnR1Rk7cNBLEojeP5v6oIaYzInBSzSvY
         FxQDOHuPZget9NG+OvR9uvyBvcwzK9DK80nctMUCFQiGc4ril9vx++4O8Tey0aEkj4
         2o+HMOPuWfK6fXvavFWstQVkLxLFIkxio4XOeGGY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.88.62] ([89.1.213.133]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mo6ux-1kPVGC02Rf-00paYz; Fri, 27
 Nov 2020 12:07:07 +0100
Date:   Fri, 27 Nov 2020 12:07:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Tomo Krajina <tkrajina@gmail.com>
Subject: Re: [PATCH v3 0/3] refspec: make @ a synonym of HEAD
In-Reply-To: <xmqqtutdatqn.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011271205360.54@tvgsbejvaqbjf.bet>
References: <20201125233443.63130-1-felipe.contreras@gmail.com> <xmqqtutdatqn.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:GtqqMcrXJt5nAoNJqJmTluZiSDwAaNmxu6z/3whM6rwB0BlDe1T
 fQxN9hWAKJsgZc3SzFZWC9JUmdfeiUAdsEWq4cY3yBGu6b+BzpcFHeS/TM65Rxxka96AWqc
 jQO2hLmaGGclK3fBWmdGvTlXucrDTOBG1PicA+HK+hEpS+zwVHmaIbGpt9bHJ7JddZL97ii
 COvt94FaxkCE6P5pP5IBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dB1p7XQT1cY=:Ie8Pp27+7eVIw2FkzEA4zJ
 pyVToTPlvFnPHPa43qhhCE87koA1cfvpjWjzF7YPLtfWZkIJIPhA0/G+QywjyNXzpdH0610Xf
 nt2zISqBxkb0TlIUP+RSIvvp5ZyHhRbUdq8GtAeNl1WV1jvTTGZvFmxCx6fnZhPyoBdM1KPjT
 Ou3KvWjHccZRrZucnMMn/5VqpnNo5E31iUAwwTFaFBBICnZcUlSrEVbjE15YqwZSF2e1dNvoE
 mSOkVqcmV86E4BTk+jQlln/vCM7UL1O7Xbttqtt2kfGyZ5/CI4ORKr38A5SMdZXJyIToxUOGt
 CXDjhGtKhD3wolfigP9yjzLUPnS8/TzhXMVsKZTe2YZ94YbtoW323jgrMYbxzZo0Qbde5S1I1
 AQ8TdA0lklyiF2arJUbxY/ECmvQ0VKu4mlV+Hb2pRwJNgQzodpzqrJqIAjKrf/C9FARa0u7Y9
 appe5mfcXv8xH+XMBJDHKvXbl5N2l3yNr4gnvv0VDCjETM2D/RNTODTJPdS8QQ4Hp7LxK/NLm
 GDUOfFVkmVZR+DPEyVZS7YkXMHojxhV+8bsFLfC14P6AG7WwGdn+4ncfGVmBqS6BvxFoXkh17
 p4Kdp0/CLk24OeOefCYF5O5fZYnMsHCMzmECaloHW7cLL8TYndkXkxDkfkIlVlZhtgT9S0zR4
 0z4MeVqCwsKB9WRFho6H8U1MG1iaQahdcady6OQeZ0bDfKqMtH/n0Tv8nhlpdh49MWHECAKMJ
 u6eSyrIC95BClHF8wbB0Q04A5meMFbeW4XNeVX2oz8AgzFL6cJ5S78ewZQBYVmeHIGzkoLCA9
 Cyb2GlHzIB4eLLVVyoqZoCMNpRPhw3ghTpVbKfk0Z/n3NaKAea4ne6NN62L5HWfhwBcT/huNd
 pfZB+CFb4y7ktRMF0/T0HLnI0NOlSX/Tq4UVdLdh0=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 25 Nov 2020, Junio C Hamano wrote:

> Dscho, heads-up as this series will add more references of 'master' in
> the test suite.

Thanks for the heads-up,
Dscho
