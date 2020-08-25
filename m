Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA159C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 12:11:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E7032071E
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 12:11:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="ZWhDUYMN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730180AbgHYMLl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:11:41 -0400
Received: from mout.gmx.net ([212.227.17.20]:43865 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730178AbgHYMLg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 08:11:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1598357484;
        bh=j1du163yDWMz+e2ntKdAvFNMjidn2vMMhLQcs+ttwe0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZWhDUYMN3zNPc+kZkeDJYXl38T6GSy1UiuuMl5wydklJB3QVzLYtiXUPgryKgbG8f
         8S5Dku27T+0MrRcvr34xhBwGGq1VSZ7rxWPUasXEHiSxcdyOMtsPj8rXg5lHk07MEJ
         YuX6cSI8BCc0r1DZVYVH6koeBbGsWQfFfX31Nw4g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.183.59] ([213.196.212.184]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MGhuU-1kOEuM1KSY-00Dl0X; Tue, 25
 Aug 2020 14:11:24 +0200
Date:   Tue, 25 Aug 2020 10:58:03 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: pw/add-p-allowed-options-fix, was Re: What's cooking in git.git (Aug
 2020, #06; Mon, 24)
In-Reply-To: <xmqq7dtn3785.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2008251056290.56@tvgsbejvaqbjf.bet>
References: <xmqq7dtn3785.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:i3hSQ9fX7ERQMlg2DvQOW2PHH/SEQy89yZwxNV+aRFimwKYyE7n
 zZYB4FE3UuBfychUVcFOyNyQBiXOA7eo4PKs+MGyRgCtomHdXFVrmcHp+TgyLY3TQchmu4S
 Q3W/mylR5RsKPswQkaMU9VmWe6RxTM0Y87KXDt/pMLp1Vr2WFD4fugScfxSA3TCtErUYF26
 uoqnYaeM6cl+eolggBpBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:r+0FWC/HVuA=:JHKyyEJJVQ2lfoVYFdZWoO
 T4MuXsPng4jX6Zaidf92Q+esPN5zQIYgeLgdq+mqZG2qLIc6KF3U/il3m4Za2+XiRcFkX4lSe
 nhd0645Ks40Wrvc12HgNbuXptzWcJMpKPoNVxGJMSGlx9OJhI2sioBy631YSNoz7YO+zz3ufs
 kKbO0eAJ3cjELjwzPa//oGBCqFJpw6rq4j6mr4DZ//1z7SU20hkMSRBt+Qfkj5E4kl/I5yLQE
 cKuCL/be80GH//LlNbBD6qi7jOJD0r5oHzqnhCiiTzofLSW8jTf7Sg9b5CQASy5xdfeHFSXv2
 cbJ6rvdaPar/WnjnldNUcj97Q2cez87O4FGwHeTkXZWWedE5ldUQ00V9yV8apo2+VJb49T+dY
 M7MgnYNEPkWuDhJduOpdX4QqZmLXMD2dVZ8LnC19uVEvMTgjihfkbLEeNF1FtXGwYCFOvMqRi
 BfRb2WqNa5sLuLek81V3rNtU/w6BjQRWxrswhsBtogf+9gsEHtt/7tE56u+OBCzRW8HuQcB/3
 tW47ZUySdHeKGmtLcDYiEmsZQCQXDicdzRBIOAfUZ4jsfOfaNniWTDLCae46auqPQ1imRNjph
 tmBH99My7KJIg+zxScnJaO5PhmgHh6jFYNf8coqlROrsOmWwrlblhlwGPx6LU4ZitG4qGTcIs
 N8wdDcFl66oMmZHR9CCI5XG1AOh+8pTXYP+Jj45P6CMNwu4UYpiY5D8YP9TZCEMAF/Gi8K/Zu
 IFSXicAmeTLlwFIyTCiA8S6t+htf2+jyO6ie34eORmXDj2hcbRvfqaefRjffmrnWlwk3yOWNr
 iN75BV95hRMIrbvOy1agWuEz1rPpjzQdiEF3Oj6jp8HnFGJVhGDr4t8OeO8tMISVTIqPWOTwb
 lG6hkNKe1BuxsDGeFdDq7VeG9bu4O8QZyDyMyL42oSx6WPztRC+Px57dXF+A9wiKa4MwmCwhW
 OW5mdti5wIer4xpUwvZEPDBowD4ymHB1Xuc9hok6W7AHZOYLWG4MdVWqmUc3KgOd3UQ8xQocE
 OCjFT+45GGBE6DMG6/WZ41+UrsrRKKEK8rP0jPvp84ip/VjvxaRO8IwoxsLe3/FCp1lpVfpOZ
 aVZpO/rbm+13tpWhw9zVsCJVr60IOXGktqgH3serbfx9AzlPaYpLXsZuXljJP1H1MtagR3ACO
 Gf5lUCKOitzkGDb91ojYZwMdp6UV5lKXPv//VUbmAIaRYszT2KoGoH7LKwPF6MModJnth7WVQ
 uva//LyIThjAu3rR/edxHw1YX9jMs/yy4f+NSSQ==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 24 Aug 2020, Junio C Hamano wrote:

> * pw/add-p-allowed-options-fix (2020-08-17) 2 commits
>  - add -p: fix checking of user input
>  - add -p: use ALLOC_GROW_BY instead of ALLOW_GROW
>
>  "git add -p" update.
>
>  Will merge to 'next'.

I thought the consensus was to untangle the refactoring in the second
patch by first fixing the `e` case, and _then_ refactoring?

With Phillip being offline for a couple days, however, I think we can just
go forward with the patches as-are. They are in "good enough" a shape.

Ciao,
Dscho
