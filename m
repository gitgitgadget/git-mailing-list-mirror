Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A0ADC207D6
	for <e@80x24.org>; Mon, 24 Apr 2017 17:22:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972102AbdDXRWL (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 13:22:11 -0400
Received: from mout.web.de ([212.227.15.14]:51443 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937624AbdDXRWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 13:22:09 -0400
Received: from [192.168.178.36] ([79.213.114.92]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M52ju-1c3qzb2LAk-00zHKF; Mon, 24
 Apr 2017 19:22:05 +0200
Subject: [PATCH v3 0/5] archive-zip: support files and archives bigger than
 4GB
To:     Peter Krefting <peter@softwolves.pp.se>,
        Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, Keith Goldfarb <keith@blackthorn-media.com>
References: <37eb7c14-eb61-7a63-bdf0-ee1ccf40723f@kdbg.org>
 <alpine.DEB.2.11.1704222341300.22361@perkele.intern.softwolves.pp.se>
 <a1504d15-36d6-51f8-f2c9-a6563789bb6f@kdbg.org>
 <alpine.DEB.2.11.1704231526450.3944@perkele.intern.softwolves.pp.se>
 <e0d1c923-a9f5-9ffc-a7e7-67f558e50796@kdbg.org>
 <alpine.DEB.2.00.1704240901520.31537@ds9.cixit.se>
 <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <85f2b6d1-107b-0624-af82-92446f28269e@web.de>
Date:   Mon, 24 Apr 2017 19:22:03 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.0.1
MIME-Version: 1.0
In-Reply-To: <b3f2f12c-2736-46ed-62c9-16334c5e3483@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:kVi7lvgypqULPkHDH7285l5GixvrDD/mHm9vtm60PH0Lqk8OhON
 I0F98c69fatSACOmN9Zc42u6XO+gJ16fSEzYb+PFmj6m6HZZygIU8FTd1yX8r4ejl1Qusn0
 RewPV6oQ1y37TJWlQnheEWvOCL7j/FMtycwcL0ffFEEfcNI+QrQLDjyb7WKHXNQzZ8J9DC0
 era+0Hv4ZnQSB8wW7IfsA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:IibmqlWW03M=:drIFR14o5PbsN66u4ijHxj
 TOWEwTusK7eDpS7gMIldwttpHUSJtU8EJgAhLRjsYhvMq5Zrv/Ftv006/wh0UXy50EKjirTUh
 2T6+CfQR8xFXL5tu6N+Td2YK4dMOWV+4tCseh7AtGGOPla4zVgKKw3FepD2VhgfgVPoG2fNQj
 F1AVOOQR9BT97xzEIH7WOm7YTk+tUMpMZBtDZf1DvltsALKImfkYjG8Wxx1P6XHLRauW6Ju6i
 JZXkPtsIOqUQtcRV+uIvEIIHW08Ns9mx9f5qgm7WAVPA44IK+5JivjFqT3zN/tUZYx1oajPhI
 nADtNLJuJUyAUNipp2dArOaBDFLJ5bajAFipsxrEfzFGAOGEfdAwUrPIIiGbdxFt+/NiARQdx
 VNefTompD/alXJnn7fesD4hCUiIpVoy5dxyzcyCItVSS3eeDjANfSTF2lDE5gzPsUxUWs5x9t
 wo2Fe6JE9xTKGYpLUwJh92g2zgeUxwFIhBL45TVwV+W/ZcPFSJgCEzb7GlIm8HTbXs8yUmCpR
 ZXEyP7DUi42fNDszOfbSk6+gvVzsWuRLausi04ndyqtFQWXi8+E4JT4v9pCpXs44W36xR+0AL
 6LxY+tbW56TBCft4gsjHVMbFGZBYgyeKEVKtaMfz4/ONdAzq8mQduHZu59moSPPGuJpEc7xVX
 UFH+0rbi4HP/filnnX7YdUQ1kCL5wirh+VxmiaO7G4FOlpcmrR4nifEKe0kkMmf/THE4drXdq
 nD8U9xI5He9yVxGYUxW6qosViZwG7zQFK4pyJObB1d4WNWfHCaHs5m5v0HNH54ikG9U61mJxo
 imo8tZT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch adds (expensive) tests, the next two are cleanups which
set the stage for the remaining two to actually implement zip64 support
for offsets and file sizes.

Half of the series had been laying around for months, half-finished and
forgotten because I got distracted by the holiday season. :-/

  archive-zip: add tests for big ZIP archives
  archive-zip: use strbuf for ZIP directory
  archive-zip: write ZIP dir entry directly to strbuf
  archive-zip: support archives bigger than 4GB
  archive-zip: support files bigger than 4GB

 archive-zip.c                   | 211 ++++++++++++++++++++++++----------------
 t/t5004-archive-corner-cases.sh |  45 +++++++++
 t/t5004/big-pack.zip            | Bin 0 -> 7373 bytes
 3 files changed, 172 insertions(+), 84 deletions(-)
 create mode 100644 t/t5004/big-pack.zip

-- 
2.12.2

