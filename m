Return-Path: <SRS0=ZKiS=2H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B3DC43603
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 09:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 175E4207FF
	for <git@archiver.kernel.org>; Tue, 17 Dec 2019 09:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FKu7MG4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLQJ2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Dec 2019 04:28:38 -0500
Received: from mout.gmx.net ([212.227.15.18]:55793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726164AbfLQJ2h (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Dec 2019 04:28:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1576574916;
        bh=zYnF4wiJEC96+WuwlIptDqcf2p4Wopr7DJDdA2RKRjk=;
        h=X-UI-Sender-Class:From:To:Subject:Date;
        b=FKu7MG4tiJcmzmnRo2+NmsajLiBFtxcwEoAgMLDVMIJcxbcIGaw+fRqH+cOq/j22D
         1Eucvh8Khzda8MuxWJQDjAikALpz4UD8xJqHfBDWW+uux9p661ou53PP7nL1yiYqUs
         ZX+bxYr9koBSpfH4c336OwobhvH2n0QbCIt8vqtM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [194.114.62.126] ([194.114.62.126]) by web-mail.gmx.net
 (3c-app-gmx-bs62.server.lan [172.19.170.146]) (via HTTP); Tue, 17 Dec 2019
 10:28:36 +0100
MIME-Version: 1.0
Message-ID: <trinity-c6dbf360-5abe-43df-8428-85514195a7a6-1576574916643@3c-app-gmx-bs62>
From:   "Steve Keller" <keller.steve@gmx.de>
To:     git@vger.kernel.org
Subject: Merging two Git-Repositories
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 17 Dec 2019 10:28:36 +0100
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:QwLEfMMs+sr+Erk8KOIGIajK6lf1BIAom8tFKiqPvHeslRjHswGPrnnkJ3+OHmonQBGM5
 ysHNMqFh39EhnjxTFIY5BEcsc6GkIiF0MTn+DGCSm9NRm0GPgwHceL5q4yQ2Q9/7r9YGNGFh/W3a
 wcPxhgG0oA0sF+HsK5/AZ9nfs7KO9+Yi0+4OymwsLcW7p9mPntkipVI0x3NNy9iGWLx82wime8RD
 9kUMpu/ZdPOvsD2Nzz8b9hbF+9vGEdMSmfrDSV5nQC3drVnzxTqvtVxeCTX7LMVL/YB5O/rux5uZ
 JM=
X-UI-Out-Filterresults: notjunk:1;V03:K0:A16UyUni+2A=:kekET9XJwN5qV3/3Ce9lIH
 EUbLvvP9s5PbehsjVPL+Ice4MyRfrKeBfwOlErk9rddL1Fds5FhBZdRUTYbIWCRM1l49ugZo/
 0rvZaAxEyuRp+ZtsKayBUcyp6R9Gp9ZbpHiqwjt8FgyFQr7W31+6rQH5WYAKMOa/6pTGlkwnA
 NK8+yz5mSAm+5eNynDxc9xdlZfsh9kO0UKjb5QJZQFT/CwHZhCMKhrEVwasgIRHEUYEhUamoU
 jshSeDwISYGodYWSKnENHsMZXZ/v8lcOyd51xbLuT0K64EE/lMwxUJ8JxUR1l/TzilBxJRZPg
 Q712KGEDPYUAeFptaRHhAgETeegDl6Z+tU0Cs6liLLI2dBPedl5+erQ6X+7qASxu806zmo0FU
 unIbLXhPgAXh9Ft02uB9Dz3uASOCCcRaWeIHcHtV9P5vr6oSVv4fxX8XutOgJ5LddNB1ao+0f
 YCLmbUWpoYT+33DTi7K6mImn5QT4usuYQezZ3ASpSz5lAzTBYTbR1g3e+64Hwbi8PEr9lZ0un
 vRMmdkD7YY4YwhX+dyPyQDpluFTvpmRBWGrAmoeaKwfLUOVIfCqeQXU4W6pCLrjjpob/Omudf
 AFr51yhtfC/mEJCIgNT+8Hiy1UGOIV8BgmgK0gX4cNZyJVJXpC/rtYN+6pnQOcxXXAUDUJ0Tp
 7nmqQjvx4X8qM60INApAJWhTnmqDnOo6r9rt41IOWOgmfzQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Is it possible to merge one Git-Repository into another?  I have
developed two independent repositories A and B, and now I find that
B should be part of A in new sub-directory, e.g. A/B.  I want to
move B into A while keeping the whole development history of B.

How can I do that?

Steve

