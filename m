Return-Path: <SRS0=xyTh=BY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 991A8C433E1
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65E042087D
	for <git@archiver.kernel.org>; Fri, 14 Aug 2020 12:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="DBFtGyQB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgHNMIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:08:44 -0400
Received: from mout.gmx.net ([212.227.17.21]:48899 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726185AbgHNMIn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 08:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1597406910;
        bh=zBqZwVXb7Je1LVlV7Z2GeKEixYrKfQWFe2UzO2o2jMQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DBFtGyQBkTN+MFmM17Ykdg/EeLT6UOdvFf6fHwwLP21n/tOjpAL3Umce0UzVTzk5N
         sIswOvC4H35PK+2o8f7cSl7pmMcbFzSKvAetrTwSvj8iHfZrlKnvLnnPfHAmHUjXGU
         MWN0YjyWDvuIDFEoVdTKvOezNkDgnpsJt3YgPWQY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.231.116] ([89.1.213.40]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MpDNf-1kTRys3z7n-00qf8M; Fri, 14
 Aug 2020 14:08:30 +0200
Date:   Fri, 14 Aug 2020 14:08:28 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     Sibi Siddharthan <sibisiv.siddharthan@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2020, #01; Mon, 3)
In-Reply-To: <20200812160653.GA42443@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2008141352430.54@tvgsbejvaqbjf.bet>
References: <xmqq8sevt1lf.fsf@gitster.c.googlers.com> <20200804185057.GA1400256@coredump.intra.peff.net> <xmqqr1sms0f0.fsf@gitster.c.googlers.com> <20200804192053.GA1400936@coredump.intra.peff.net> <nycvar.QRO.7.76.6.2008121516560.50@tvgsbejvaqbjf.bet>
 <20200812141958.GA32453@coredump.intra.peff.net> <CAKw82xxOZFcsMw47TSrD7-pXpqO7O0_m84o96iH6+ZVeN9j1uw@mail.gmail.com> <20200812160653.GA42443@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:xEs5TYrw58FhZhODUv5zb6n7r3BK9Ey9R5xrmIeXiKwaSJWbYOp
 Okd6nCmZIzTCQsb4/4KSwdV29IIJ2Chp30d26YyRk8RBRoE/Qg57hmVAtF2uonkdDE8rDAA
 kQH+6yawY8eqGfD1zE/sh4nyyQZdnAaBC/IkoDCiiWwL99R6QQqWTyIUAuRlteVDiFH/U7o
 +tvz07l7U8w32rKSepX4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MmTE32YlooY=:3tw4QSRSWzBXdUvBpMsBHL
 /0EmLwAHzaDbzEg3SuywbawTKBnimX38OjTq8Z88zjRndUZijllJQWCpyvr8Vw55Bxxjw+I81
 m4exvdaq/OVwH9Pr14604V8s//YfSp22jzqddCSUwSm2GNXT40MUECIxDlFELXqGYbQ8uoQdG
 cjAD6zIkIUjq4NBhwoNgTwazpp+VOaJH8b723uiZ6eKOYzMl1nnePAOIOIKW3a3OakzfozzxG
 P6+AH3YSwU1IrLdU3aAo8r0punDOkH9pO7H3xEuFjhnwNA9alpK/34/tw2SlB24cphaTK3uIF
 fk8Doq4bI8ADBjjod1ih+D6yQz72+ipgAAaYo2dyOX6nuDh0bER05P0jAMgCRe+rvzn9yfTDe
 QVHJyobDT5m9k33t6BciCFS4IpuqGEWxZSiSUi3wbzqlvrTr40AuvRKfdUJI2OK/odVPxO4k4
 sN9x8bVQpeA6OgwOVCC6LQhuczQLNuAXbLxv+tbL3VrOuhQ8bb9tG1ESmC40FUkn7niD4mtvO
 0AhZrVAxpgcG3fr6m+nUM8k6/28kd2qUK99YjZA+3ISDYAd0731LAJBWzdL7LOG135CKoWIxP
 u3wRzK2YBNdGtYNei03MAEUi5AAogBOoCHNx/3KTsgn4nDv2Qr3bI7kTLZZH+OkUpCCY4vJyH
 MuUDNAlyinZQW23Hxe5g6Rop49ws8Os4CJDAVplgLwz/YmuOYTp4PBs1wvTvOoorLvzKiUKa7
 NGKFtyP4bjVpU2XqNi/wNteHQMVJ18xp5kotQvCn/JD+lNFyYpkImO6sGmQVS3E4755Kj5Yhx
 qt2OFMRmzZCWjIC1E4izaBqwdODd/+mo6c7nNRVBRLiJnjxP7dT6QMj1Bj7pBKdy3WTYztS6y
 mn02YDhPgBp5UGKVFaw7Lc6t4gnj8YvWHz6cCkVF2rxmwvAql8B+VeVQDDAAbbaw4HZ+oWq9g
 zbRJ9OPAFbL9qRW6Hbhtqn3yHjJs/dAafOppMh0vBPDyrUr6Vc/WfmVADMIthWnJhIIOLfGqM
 crgkRi9eGxxcE9AvkdffARJV2UJfYnd43A5OdOAcqtJLT0lRhiAGXVP2XxOLa1V/Ph6qmWbzO
 MN3p/GFrgPQy1rjv6pHEmaBnKNA2BxYGjW37S+oVQwd3XR1VotECV37PFK4OJweyr6W+sz6hr
 uez2Ea8QfZhVwNUx9ZTH+ngcQ/QivU4EQyRGpdiRCP6OUqQOfUUtykKT2SY8HkSvecmq75M5r
 0J0T+oHEHGkuVzfoQCNLLsp7mr1SaV3ApSPyjRw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Wed, 12 Aug 2020, Jeff King wrote:

> From my perspective as somebody who does not work on Windows, I wonder
> how much value there is in running vsbuild _and_ Windows CI for average
> developers. I have certainly gotten information from these jobs (e.g.,
> when introducing a portability problem, or missing a refactoring spot in
> Windows-only code). But I don't think I've ever gotten information from
> vsbuild that wasn't also in the regular windows build.

There have not been a _ton_ of these instances, but there have been a
couple:

2049b8dc65e (diffcore_rename(): use a stable sort, 2019-09-30)

	Here, MSVC pointed out that `qsort()` does not need to be stable,
	yet our test suite claimed that we expect it to be.

116d1fa6c69 (vreportf(): avoid relying on stdio buffering, 2019-10-30)

	MSVC's code demonstrated that `fprintf()` prints out messages
	character by character.

c097b95a260 (msvc: avoid using minus operator on unsigned types, 2019-10-04)

	We relied on some iffy behavior of GNU C which allows negating
	unsigned values (which cannot work if the high bit is set
	already).

dbcd970c27b (push: do not pretend to return `int` from
		`die_push_simple()`, 2019-09-30)

	A non-void return type in a noreturn function is bogus.

fdda1ac62d7 (t0001 (mingw): do not expect a specific order of
		stdout/stderr, 2019-06-19)

	A test that might even have been flaky on Linux failed frequently
	due to an incorrect assumption whether `stdout` would be flushed
	before `stderr`.

I cannot find any more instances, so yes, I agree that the
`vs-build`/`vs-test` jobs might not be _all_ that necessary. So maybe we
should do something like this?

-- snipsnap --
diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 30425404eb3..2549fff8edd 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -122,7 +122,7 @@ jobs:
         path: ${{env.FAILED_TEST_ARTIFACTS}}
   vs-build:
     needs: ci-config
-    if: needs.ci-config.outputs.enabled == 'yes'
+    if: (github.repository == 'git/git' || github.repository == 'gitgitgadget/git') && needs.ci-config.outputs.enabled == 'yes'
     env:
       MSYSTEM: MINGW64
       NO_PERL: 1

