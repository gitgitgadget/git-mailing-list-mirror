Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6567C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 14:04:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238528AbiKOOEr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 09:04:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiKOOEi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 09:04:38 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DC72A400
        for <git@vger.kernel.org>; Tue, 15 Nov 2022 06:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1668521070; bh=2oykKmtWa2ycwzpsQFEGZyQyveLVACU3wYE0zx4i2eI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=id8DwS2+kWHSQILkkKuqkyvT6rC2e/442qNvXnymch53IcO2wsTGNsE4gVmTVbjuz
         Sq7tJq0/+yho9lAYJiXrMLYCxPokHBxnC3fOPF48RdvFOLiPbDt7LaMliYYFoaz6SP
         D5cpfDVL26IieX4GFjoPL6KfThmqx4uj8IiVeVLE/6f+ho6SUrO5he9H7FKItZ9eIg
         yrhF7qENw12DCPnH4oENHpITj+Rv/Vak27VSZHNOLKB68v69IDzNSV/bA9cGbjDBq/
         ODy3fJByqel5LUv/KYKdsaOrIXklcLlORouvgnpluHkyPX1f1/2zGeZv+Ca9njvCEs
         ep/Q2HYNOA1nA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.20.115.3] ([213.196.213.188]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1p8sXL3aQH-00wpfd; Tue, 15
 Nov 2022 15:04:30 +0100
Date:   Tue, 15 Nov 2022 15:04:29 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Taylor Blau <me@ttaylorr.com>
cc:     git@vger.kernel.org,
        "Strawbridge, Michael" <Michael.Strawbridge@amd.com>
Subject: ms/sendemail-validate-headers, was Re: What's cooking in git.git
 (Nov 2022, #03; Mon, 14)
In-Reply-To: <Y3Mag8qG2D3qjlmg@nand.local>
Message-ID: <4p90qnq3-580o-9n59-34n0-rs3pp635908o@tzk.qr>
References: <Y3Mag8qG2D3qjlmg@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:VvtEZqodZ4uILYdZKMvfumREkvtxDBSYkxvT0FeGjttSuCEPN7w
 Z2s6v9EolTMWMNn0t++zJEvavDFlX4rmBSGVttTNmCkgdbKyMh8C2sppQfpOQQb8H7rUpV4
 NRinA6H8tCGzTpZphdOJKPnz6LIfUjz0pBxOHuLyN5Pe342YIuKTy7kyl8Mah0ShWP2fFEk
 7pLUAxi/P3PBZiouRWnqw==
UI-OutboundReport: notjunk:1;M01:P0:N5QSf3bz9Nc=;cMxcKREm/i0pPnZLEGSHNkXR5Do
 evJJZOYyACOHFrc+xVRLmgDcIHvblOJ1xHWEk4G5agsgS4hPTTTnt69PY2E4dn6W/wGcPlcg6
 y3b2d3d5m1nw1wsD76rwX1xZ2TYeSYRci1KJlDbCLxVwcNe742haCbEo9rQV27kTl4eY6idGF
 nnz4K6O1t8qm2ne2t+AGW+LMM+WBb1/wRmjsxAYfHyR6PJlEr95mzGzEzpIKFpDxWbvi4O4Mh
 efkPp0EPLKnngtPRFw98+ByGNPa/jOc5lOALqkzEEUdfRWvMHDrOQLIbb8L3V4UlP9X24XhRP
 H2BBgWF+uw3noLU2LkpcYa1hz3aHJ2DlBUaiD9nGSgKlkQI5AW7GvaCyd8JL6f8Km3Krs5Yko
 vVZn+B5sZTprC+CZoj8554TMJ/lCBQk2kk+rEtEl/vzgijL2PUtRTI2GV5nUlxXDN8sbDUE7r
 YAVqBBNy870sif7zNLO1YCP5MTm5AAlOaMBRBkwyP2F1bWdJ6rPnhSrwxdcG1kuhCCS76hIVJ
 Ee/NbBnf9j+u2llnA9AS+rPGT8ErINJbQyNVeKRWvJNdl6rpPaLuCxz3d1Cwj+5/s0Ks+wr1g
 1NB6IKbcwQFLCEccLj9E+EF16ckwCUHM3OgGl9ckSVrUectrwlPDxqBDz5BVCUBGtc3tqUSZ6
 Nqt2QdAKE+cAyLM9g1jq83JCzM6CkGjlsTQMVJtuOwQm9d6OkRMZDyWgiPv5YW3YbGstuz+go
 JBtIBTpZiYWDW2u0hxmZaR5d3YALsJe20zH5qeBnuVfMX9aSwC/F3ywVI1F8vJQMCy3ZLGUjU
 vwFQz3ylH5wAv2LFhT+AzIQ8/Q3Blqj6I4AV6T+dN5mAs5iPLF6XbmOCOQ0eTaOAIVZIrOMQk
 cx3DSuiuY9oaD5I3nYVn0wMqTm7ho0G5ZcqkouQlSvQVWssrnHBLWdWD1iTKUs0LUXboWJg49
 GCsKNQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor,

On Mon, 14 Nov 2022, Taylor Blau wrote:

> * ms/sendemail-validate-headers (2022-11-11) 1 commit
>  - Expose header information to git-send-email's sendemail-validate hook
>
>  Expecting a reroll.
>  source: <20221111194223.644845-2-michael.strawbridge@amd.com>

I see this mail, but no replies. Is it really appropriate to label this as
"Expecting a reroll"?

A more appropriate label would be "Breaks t9001", I would think, and the
reference should probable be <36s0r4s9-n21r-pop9-o7rn-q0qrq487p831@tzk.qr>
instead (but I sent that out only a couple of minutes ago, so I would
still be curious why it was marked as "Expecting a reroll").

Ciao,
Johannes
