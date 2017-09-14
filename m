Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D07A20A21
	for <e@80x24.org>; Thu, 14 Sep 2017 13:15:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751444AbdINNPf (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 09:15:35 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:63129 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbdINNPe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 09:15:34 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue103
 [212.227.15.183]) with ESMTPSA (Nemesis) id 0LbgPT-1d7v1B2aD5-00lCMj; Thu, 14
 Sep 2017 15:15:26 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Ekelhart Jakob <jakob.ekelhart@fsw.at>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH 0/3] merge-base --fork-point fixes
Date:   Thu, 14 Sep 2017 15:15:17 +0200
Message-Id: <cover.1505394278.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.712.gda4591c8a2
In-Reply-To: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
References: <68633b20-9e2b-ae23-2ede-8728283250f0@grubix.eu>
X-Provags-ID: V03:K0:8ecOj3TCHkx0oedxxeHHbOVhJCJxolGPOQaYCOaOWZsxeaik/S1
 /2XUJSKeurFevkefWqa/ligJz/frGuf07+nJIrNkADfuMVlm2R7L4ySCwl04rHBbY9eF4rh
 4OmLtDmCHetaUyRSXnCez+SfMxBI1u4StrkpSUn/Z02E8GDcuwnJG1YqvE6BhNyd2hbo8ae
 xeTMJvxn4XAm6A1aIFBGA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:1MlObawYx2o=:+Ly118NgQSY1WKsPsRAFyl
 UFfjMf09u3e50m3fPe8OpCIoR84hyxhTVDogaskl4yb7aC1z5Or/IsF7FGRyezlUX9Kd0GSAY
 GLskaOsY8t6YWHHdt3f6T4ySVoKukKmzHv0nkI4nmvLTQyQ0M3gdFS5KgFrpPjqwO+q9FT6t3
 rtxvLSjD7VMsXdj5TZMkZdqYVrntiINC/01LfbEsm9hbw0bV7POeaPansqANhTVHFu3IvsEpx
 uINZhH4KUB1P7YuG7njOBPElgKJWjV+EHM+LlXIVFnMfbGTjMFgH77qQu+XX1vOAphEFn+Ult
 oBarQZ1DVl0FvPdvA5mQfqP7/as+r44mSznA//HW9t+/fE3DtY9Oypq3A51l4WDzYZVpM4X6f
 YrV4r8f0SHrmaZf5kwoOFsIwJyg/6qAsouB8LVwUtMKHsfmxN45GGHQsHtx1etIYK7Y3vFunO
 lKiIQSg3+WBPUT6DsV/jFPeMgG2GVfR9NQdzgvAaFxQG8Qf+adRaHaxj7tez1boG/sYE1u+2W
 7ToruAtUmz8RGS72A36XWHYCjsUgKg26mIu3h9s7T4/kgWwvrW+ZED66LvGNySVNRN8shpee9
 HDuHQuvq5MxN044798BCEAntvlwj9ocG2F4j5wx7nQqKneIZ5sRZKh/6k52lQIB000AGL3at9
 K7n9SbkeTbsDUkBMWfWLlObPIFNbrHIAc/zXh/JvxCCDJzJ31E8qw082d4xUe2NBR1A5huAXw
 8QaWmPBQt47LK64/XsZMOZI+PYWM/j471QMBvg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge-base --fork-point does not quite work as advertised when the
reflog is empty or partial. This series brings it in line with the
documentation and, hopefully, with the original intent.

Michael J Gruber (3):
  t6010: test actual test output
  merge-base: return fork-point outside reflog
  merge-base: find fork-point outside partial reflog

 builtin/merge-base.c  | 20 ++++----------------
 t/t6010-merge-base.sh | 21 +++++++++++++++++++--
 2 files changed, 23 insertions(+), 18 deletions(-)

-- 
2.14.1.712.gda4591c8a2

