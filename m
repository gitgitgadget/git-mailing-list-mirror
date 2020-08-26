Return-Path: <SRS0=bNai=CE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB540C433E1
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:02:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 721772074A
	for <git@archiver.kernel.org>; Wed, 26 Aug 2020 15:02:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Sbk2+hby"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727821AbgHZPCc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:02:32 -0400
Received: from mout.gmx.net ([212.227.17.20]:34697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbgHZPC2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Aug 2020 11:02:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598454130;
        bh=NAVzfw5VJHUTmrIn2nkqcl5J4gQAerBJNQa/10o2TXk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Sbk2+hbymqVYGONZELjqJykh6AiWiTNP+C6Tfib0czH5oqNbLqigtKbpGXqGEezQS
         ABgeiG3poRRC5698yErbpYxDOF5S6+tUiArUcLKlRYE7PXt9qPBZ8P9YOio+bM8STW
         fdFXCUtY26ABE8dLpIIawzmD24EWZl2Si0DJUUzk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([89.1.212.143]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMGRK-1jrddU0UNy-00JM6o; Wed, 26
 Aug 2020 17:02:10 +0200
Date:   Wed, 26 Aug 2020 10:02:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 2/3] cvsexportcommit: do not run git programs in dashed
 form
In-Reply-To: <20200826011718.3186597-3-gitster@pobox.com>
Message-ID: <nycvar.QRO.7.76.6.2008260956380.56@tvgsbejvaqbjf.bet>
References: <xmqq1rjuz6n3.fsf_-_@gitster.c.googlers.com> <20200826011718.3186597-1-gitster@pobox.com> <20200826011718.3186597-3-gitster@pobox.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hkHL4C5AXov6h34GbCZW+yeiycrZH76qGUmP7XDFgWCRnVc2CeK
 1V31XO71uxdnBvnGqfbMzIv44qq6FK1pRyfGBae4Hx0PiBfN4TZ8lzPo4H/vADtQwzhRKY1
 aKYSVUVo5WOkvUTnWMpwx7HjKbxOMwQOI0g5jDF5tYBn2xxVqqu29vJmSk4a4SW5g0c7hFM
 Zny2A6X8HH3WeaJF4iOLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ijQrBegu4gA=:cRt34SKjopDL694gmyhJoe
 MjPQrjNm1z6R0SRhHCzlusqv85MmvF/Nekhb1jYidW0XxarBGIfG6KWYcAW+YYX2A5R+n71of
 NRq+7LmFJJdcWLmep2cwKGUpZ86BzW8Sn5kFT2Bhlfc/5xecDQiGdQVArLF/QM21N5V11byOp
 I2mdoKZYWS3XvyjrqkLB6x4jDwntpNVQ4DrsQcPb86af5LHrygFIIgJZt/sn8l1vGr+T95TCX
 f5gujTenbcnHdwnNuOwAJdk7KOXZQBvkbqlpceREknxza/+z3j3BwjGL1HPjhlq4jORSX9zc4
 +1hy/biVnwebylWJtXwc8zcuJEpln68EjXKYPCmhyRXID+b1mUxw9Hx2Xbb2qh0bh3JnwscnE
 RTC5zuoJNuAhxUhffj9EXlnOCcezGF3Z2Nmx3nPflvHlqVsoGl2vU7z6IMiKByyXMBBN1SWej
 hRetxKf7CensqiyL3RcKbzt+0NIGGcL2ZeKEgM1LTWt/sNMJhexIpzkTSkgjfI8m0vEgCPfOT
 YDU3XXAo+HgU7HopezQo+hD6CpQC6nXAdDILP1PyK4phZKfnhfB//ISA3g5GhDwYbiJ8WdaoH
 +W9Kp0y6NX4Dk7BeYI5YG2uF9s5S7EUcbcyiz6tYQxWp+xzfE308Hb4270CsdDsbkqR9mSaJV
 S3zoCrKECRm12DMuR04qfWsdN0NXBiiFRLHaiWHGb9/z/06TolxtYm5fxhoK6HRwPpzZQaG8j
 F3xBzlMFyrWhNflTkb6lQ7lGb9feo/72GEBXD/9CUrV5MGLwKW2+Vyi3aR2WK9Q3eaX59gKM3
 xdUWJ3156jDau7IvAfNk5E97UaXODLwc/q4KVqje6LTVR1GVO8cZaINPM+PDqt7SQTJUpu+UV
 saxOZcDeQZEUHI5JY1uIjWUQ4iT93agdIpZeolusU/AFuFWG7q8wmJd/nzPVjlvN3VSl18Y03
 VR6kSlaHWHNADIHYjx1E3NO6r3nznq7426J0VO7bH/Rara/BBL+EZwMT7st3Q1fvusu/DsYK+
 Gep32aa5NUCj753mse7DxU2n324mT6odk2ILakBJgyT0SjeRCJCQBdT7KzldaK/HnrLI2ud9N
 N+jCXIyhoO3dstkpJJJ/CaUWO2GoPyxbf8xNJcs1OJmQWOjiSEdF9EnHG+LPvWpIvxT1piDYt
 vbS+Hc/UQySLuBiCQbbNJY8NMjhxDatjsd8763tv5FX1KYpQFggVEmsw68ptJgwOI+bOFjhny
 BCBCjihYjUBP9FYVFEC45y9VJnH8tpDtHsJ+BhA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Tue, 25 Aug 2020, Junio C Hamano wrote:

> This ancient script runs "git-foo" all over the place.  A strange
> thing is that it has t9200 tests successfully running, even though
> it does not seem to futz with PATH to prepend $(git --exec-path)
> output.  It is tempting to declare that the command must be unused,
> but that is left to another topic.

Not surprising at all: when t9200 runs `git cvsexportcommit`, it actually
runs `bin-wrappers/git`, which sets `GIT_EXEC_PATH` to the top-level
directory of the Git source code, then calls the `git` executable which in
turn will set up the `PATH` to prepend `GIT_EXEC_PATH`, and then look for
`git-cvsexportcommit` (which does not exist in `bin-wrappers/`, but in
`GIT_EXEC_PATH`). And of course then `git-rev-parse` is found on the
`PATH`, too.

Slightly more surprising is that my PR build did not fail. I guess we do
test `git svn`, but we skip all CVS-related tests, eh?

Slightly related: it might be a good time to deprecate the CVS-related Git
commands...

Ciao,
Dscho
