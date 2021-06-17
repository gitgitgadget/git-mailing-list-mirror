Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF3EC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D8B66117A
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 09:40:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbhFQJmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 05:42:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:53093 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229716AbhFQJmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 05:42:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623922802;
        bh=0mxofJw28ZZ3QNMRNY0oaSn1BCy0iG1+znLPG2Spx8c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b04Id831a93aDWWH62hymF0cUKiu61M3AYzuVJYVvg8RhhWC6g/Y8NC8WMQssB7IE
         T7B1HOTl3m9rhZo+PgOQZunDFk/1kYQsU3sVAx6k1tcyGGhLRXebJvHz3Ex8il3iLx
         fMcjt0fHLmQFE0cYGaBh8Jj5049LqK7qJlizVxiU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.214.113]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M26rD-1lrKbD1fUf-002WFw; Thu, 17
 Jun 2021 11:40:02 +0200
Date:   Thu, 17 Jun 2021 11:40:00 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: js/subtree-on-windows-fix, was Re: What's cooking in git.git (Jun
 2021, #06; Thu, 17)
In-Reply-To: <xmqqr1h1mc81.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2106171138110.57@tvgsbejvaqbjf.bet>
References: <xmqqr1h1mc81.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:6nGDKquhc7U32BZVUIGcMu7wtWsDAXOXCCVHS0dz9jZSL9UlXQj
 AFO+Kw/VQT4hUzGdi84ce7RdgDNcvIFNBveBgx30uyktdDhpNOXmks6BFEatNtUEBS1YvlK
 MNSsEjDYlU6t5b2PHa8bVr+w3opgWdEym4816hCheM2O7ODb4FQbO96NsDqy3NSZLEPBgUe
 97tcOxIQPaTUeFfdKy3RQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1e18fukpBgU=:6SEbPEldk8+w8ShcWjCeOL
 usszU9Ws6PLmUt0gzKOySONtf5OsIo3gG/klMfJCaTU3Ndqm8iw9RtZSEfJiu7nLpw91lunHN
 oReNy3S7mMQSRiicSZs2kE7erBH1/W5DL56pntKF1ke+Wo42nYRGyAf13RjRs0CQJEw1XUG7Y
 7kAYLJuJWI/rC+8hmz4Exq71vb1s+3zEUX1SzN+7uv5MK+KNKTJiDJNyzoLRMMRLzBYejOYmq
 kxh6IqM4qgtiEBcWKGBpn40ZJQHFdaAnBZm1n8C+bZqtp+nnGKu060QtisIFct+LblHLMYe2t
 IE9pryzAW0OzYwEAesGSIkLBurmYmjpSzShBX6GCw9F89gjfW6KGLq1dkCRtKW02ajolb/ihF
 y/PD99HdBKKr9azxj9vCjpOvIbPEfg7f4jwaSn9xgZzCp6JLhSTG+4dunf2Z9p1vbtIWan+D8
 dtsh5p6xalaAGuZrFbu2beu3tK9gBEoYNgnr/Jk4rIvVU+Fr+vtVj3aj2hyUknf6EYcIYrWT0
 Zgya6ylvlljGVHrkKQHPKD9oefNqd53paAylpGw9wDcxs/fwlYjfQ7VOB3UlHO1g4A/0klE74
 HrqXeAgGm+5oTVliRuze6LLOK7A1gAeSnaXozxcF9sgB7tUHgpvIpSs3wdOjAAX3rJVY8VoA/
 rRWF6Dp9g6W4zA65Sqr2k5rFqd0thLp04Y0xXLi5Vwy9XJz4XKLMnwKwpGLyjX3ftjRQ7OpW7
 0mYE+/Df40kgaDpviMkWfvuon2RFyD+g/7+eKZVZiM5HRN3Yj2e6EcQPersrWArt6tX5weo9Y
 DFIcxguvUXWdMCdZwGG6qJ5cY63ZiRGG+ZrJ3EogrMcas2bI1KYSfocZHwDUnzHF6QnSWU7lu
 GVk/hqZosVpjZfZuJ2ESf1Kn1I5tKszxdxdejqgbdvnig60eYoKi7vJg+aGGV5EiHIERKOLbb
 5WYdztAQroTCol7HZRnrZWfTPqtsVbMrzbp8Bu8flLUtIp32717+4J564Ed3vrBhYfssMFdz+
 JiQKuhh55mGcVTToa5oBJKXw87I3NJdxrAquSgQcix1MXrKFq71tLQPppBQarcvWEqZfEFVFg
 62PPmoncmnNlL0nwhuXHNj7dK3H3YEjbPfwiVG9fy78xLg5faP6hUbvhg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,


On Thu, 17 Jun 2021, Junio C Hamano wrote:

> * js/subtree-on-windows-fix (2021-06-15) 2 commits
>  - subtree: fix assumption about the directory separator
>  - subtree: fix the GIT_EXEC_PATH sanity check to work on Windows
>
>  Update "git subtree" to work better on Windows.

Technically, it is not "better". Without the GIT_EXEC_PATH fix, it does
not work _at all_ on Windows ;-)

>  Will merge to 'next'.

Thank you. Once it hits `next`, I will merge the corresponding PR in Git
for Windows so that a new snapshot is available for users who rely on `git
subtree`.

Ciao,
Dscho
