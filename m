Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC99B20133
	for <e@80x24.org>; Fri,  3 Mar 2017 15:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752315AbdCCPma (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 10:42:30 -0500
Received: from mout.gmx.net ([212.227.15.18]:55627 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751920AbdCCPm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 10:42:28 -0500
Received: from virtualbox ([37.201.194.68]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MRXSK-1cqWN20cFk-00ShRa; Fri, 03
 Mar 2017 16:42:20 +0100
Date:   Fri, 3 Mar 2017 16:42:04 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Lars Schneider <larsxschneider@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, christian.couder@gmail.com
Subject: Re: [PATCH v2] Travis: also test on 32-bit Linux
In-Reply-To: <20170303110125.43332-1-larsxschneider@gmail.com>
Message-ID: <alpine.DEB.2.20.1703031641290.3767@virtualbox>
References: <20170303110125.43332-1-larsxschneider@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:v9/2a4FIsDR8A/6gBVpr8HOMJ6LMbdQSvDvtrDSjr5kTaPIFCBf
 KE/0v+4/DALl6q0hnjyO5VlOWCplkjeFREmYBIJ9lpE2g5cy0f2LxP+B7AVslnta5ioIkFU
 iNMGi3AOpLpmo+Ogum3CXx1gSPLLTgKopv2AADaiVvobfLBl066XvMw27jn5pDhuZd7dfY0
 Ri3XR3PxAoj755YfXPYHA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iXME4GWXQO4=:5jS4IFqdn0bw8bu7ScQfPD
 VaggA+7jLwG8VX1FmYBWfayvZPB8cCZlz0t1Nuy7A8oK7LUS2/Y5EZ4XkbWx3HeKjLbhVVGQ5
 ArGufyTeBxqKbCJnlaU++BcdhLY8Gatm3PqmfxI6fkuv2jB9puXfabP61efpY9JUtXJAwjrne
 LyJYGKORotLydE7k/pg+oLxant1EB0MwUTJ5+v44ttp1TZVwhkCtZ4DvqNu8zqSp1V7aj3QG5
 R8Zp0QL2puI5uPCIMFxlMcAmi57ZIse23LlVq7gkbZ4zDVCjZwC4xypojB/2CseGBduN8LzsC
 4v5qxg1Z6vJBEPoDE2YHMbGR4stXH3DiVYOkjnHGu8LXTEKJT6H80Cg/BoeFSqq3TST2hLnCW
 y/p6/AGYqJR/hmY2oo/on+6SlRPYroHZq0gvQxBXrQmaHhggNmjGE3KaIyXGQxIYnMdmy/POK
 LoA8YtADQKngdyA61wJltOV5/8J48i7SyaKlGHAFUqMHZOvIuEqg7Ijr6gAmFUw6i3d3HfWPY
 EP/JFGtJTMX04r6vxS3E9OhCEmiLu3Wrgj3Xu0XI6n5splKw/Hanjvnq1VVgg8rtHEcaNrSM+
 wW1emnaZ5z3a5uD021zKL5HIeRLZbWfULl6RzSbKYz8FxuVUoaNgqOUPKPJNmKA+o+9RsT9xe
 IHU9XOxYGo+0sBeNM/wc/71GAehEkThRAasSAZYT716XPgrJY6p1z+0FauCX+pEljgo08AoAw
 7G7IJ7buisw9H9ON91xyuEQDquKaK67Ozkv4X6EpiuSmrGcaY7jfI3BtQjRP2bgmEl6Vg3PMq
 viiaji5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Lars,

On Fri, 3 Mar 2017, Lars Schneider wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> When Git v2.9.1 was released, it had a bug that showed only on Windows
> and on 32-bit systems: our assumption that `unsigned long` can hold
> 64-bit values turned out to be wrong.
> 
> This could have been caught earlier if we had a Continuous Testing
> set up that includes a build and test run on 32-bit Linux.
> 
> Let's do this (and take care of the Windows build later). This patch
> asks Travis CI to install a Docker image with 32-bit libraries and then
> goes on to build and test Git using this 32-bit setup.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>

Thanks for keeping the ball rolling! I am totally fine with v2.

Ciao,
Dscho
