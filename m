Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C89BF1F404
	for <e@80x24.org>; Mon, 16 Apr 2018 15:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751002AbeDPPDs (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Apr 2018 11:03:48 -0400
Received: from mail.javad.com ([54.86.164.124]:48183 "EHLO mail.javad.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750709AbeDPPDr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Apr 2018 11:03:47 -0400
Received: from osv (unknown [89.175.180.246])
        by mail.javad.com (Postfix) with ESMTPSA id 41FC33E8B8;
        Mon, 16 Apr 2018 15:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891026;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=PBs2aX7OHYRZrD3gGOhvENxTEdPZercMOXnGSp37mBMp2chB2/iQAdxq425urptVA
         ZkK9c/lLX/PgqPvRc6OT3VOqGC6PSjwmTOiu9Fb63y1byocBuHjkz7e222bqNcsWwn
         r6AvKbn1dfWmdjFy8XJ43Biwhk/ZeYHXogxXqi8E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891026;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=PBs2aX7OHYRZrD3gGOhvENxTEdPZercMOXnGSp37mBMp2chB2/iQAdxq425urptVA
         ZkK9c/lLX/PgqPvRc6OT3VOqGC6PSjwmTOiu9Fb63y1byocBuHjkz7e222bqNcsWwn
         r6AvKbn1dfWmdjFy8XJ43Biwhk/ZeYHXogxXqi8E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891026;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=PBs2aX7OHYRZrD3gGOhvENxTEdPZercMOXnGSp37mBMp2chB2/iQAdxq425urptVA
         ZkK9c/lLX/PgqPvRc6OT3VOqGC6PSjwmTOiu9Fb63y1byocBuHjkz7e222bqNcsWwn
         r6AvKbn1dfWmdjFy8XJ43Biwhk/ZeYHXogxXqi8E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891026;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=PBs2aX7OHYRZrD3gGOhvENxTEdPZercMOXnGSp37mBMp2chB2/iQAdxq425urptVA
         ZkK9c/lLX/PgqPvRc6OT3VOqGC6PSjwmTOiu9Fb63y1byocBuHjkz7e222bqNcsWwn
         r6AvKbn1dfWmdjFy8XJ43Biwhk/ZeYHXogxXqi8E=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=javad.com;
        s=default; t=1523891025;
        bh=CNjDGdWMBAKRxZi01j4XvC/q5EMTG8MPDcB5DAX3KUg=; l=912;
        h=Received:From:To:Subject;
        b=gCFXc63kX3SiC0pwAAcztkwkepW22yOGilGQ1LO6itskKSRmT8Q5AhW7bt0gyeDyq
         wHfP7gw7FxgMaX0+1O49Ij2Z89s/o30vtOJEt1KE39jrbUVmuC2lJMpYNSjiWJmqei
         SZ9bHLeyW5daCVIH+UNJZm6G0xlE8wW2IvoZt67Y=
Authentication-Results: mail.javad.com;
        spf=pass (sender IP is 89.175.180.246) smtp.mailfrom=osv@javad.com smtp.helo=osv
Received-SPF: pass (mail.javad.com: connection is authenticated)
Received: from osv by osv with local (Exim 4.84_2)
        (envelope-from <osv@osv.gnss.ru>)
        id 1f85fT-0000ei-ID; Mon, 16 Apr 2018 18:03:43 +0300
From:   Sergey Organov <sorganov@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Gabriel Alcaras <gabriel.alcaras@telecom-paristech.fr>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Igor Djordjevic <igor.d.djordjevic@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: Draft of Git Rev News edition 38
References: <CAP8UFD0DagacfeismKoVgo=O1guRUV=u1=EbbwRyrY3g1MeQ8Q@mail.gmail.com>
        <CAP8UFD1vFM8k-1Po=2QXZdBOuCca1Dg_FGaPnSi85hKp1je54w@mail.gmail.com>
        <87in8rz65t.fsf@javad.com>
        <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
Date:   Mon, 16 Apr 2018 18:03:43 +0300
In-Reply-To: <CAP8UFD3JwHfyr=bByvjDrxboFL+yHVdZnbkXztsUuOU0aRD-9w@mail.gmail.com>
        (Christian Couder's message of "Mon, 16 Apr 2018 15:08:33 +0200")
Message-ID: <87sh7v6vn4.fsf@javad.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Hi Sergey,
>
[...]
> Jake wrote the article below the above line. His article summarizes
> the discussions that happened following your email that is linked to
> in the above line. The above line is actually the title of Jake's
> second article.
>
[...]
> Here "the above article" means the Jake's "branch -l: print useful
> info whilst rebasing a non-local branch" article above the current
> article.
>
[...]
> You call it a reference but it is actually the title of the article
> that Jake wrote. Yes, it contains a link to your email, but that is
> just because we want to make it easy and straightforward for people
> who are interested in all the discussions to find them.

Yeah, I see now, it was confusion on my side. Thanks for clarification!

The rest is also fine with me, and thanks for editorial changes!

-- Sergey
