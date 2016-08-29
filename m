Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A671F6C1
	for <e@80x24.org>; Mon, 29 Aug 2016 11:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756777AbcH2LEz (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 07:04:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:63562 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756663AbcH2LEy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 07:04:54 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MUTSJ-1bWSHR1SnT-00RLzZ; Mon, 29 Aug 2016 13:04:26
 +0200
Date:   Mon, 29 Aug 2016 13:04:10 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Dennis Kaarsemaker <dennis@kaarsemaker.net>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/22] sequencer: refactor the code to obtain a short
 commit name
In-Reply-To: <1472463570.4265.24.camel@kaarsemaker.net>
Message-ID: <alpine.DEB.2.20.1608291301350.129229@virtualbox>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>  <4b99922194d97f012459a473da48ec31d18c687f.1472457609.git.johannes.schindelin@gmx.de> <1472463570.4265.24.camel@kaarsemaker.net>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:K6N6mTLtb5Oepwb4vC8XTzKUOhGBlMOHbWh+ecstaMP1tM0XhsT
 K3xjHkcSA3YBb0aLJT1WrmWB5MnEMcw/o9w+Yrw5LjProNBpc614zRPJmeOo0+cE7PAYkgV
 MLLa2ocFhATWoujBdywoJXaoB5O2PEUPXzIEy9ixoLfIEmS4D/MqIZCpDan2sPBN4fAehFZ
 lezr/UdjZNmc6hV0tOHkg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:j6pIOryg8KU=:vSmT85jwTvaiTE5OADHtnm
 csv7U7pFH4uzVq050KqlJPtQBCnIw+BE6FHoicNzl2tBtnZfOdG6w0uEliHi1lyb8eyAkqJI1
 iEMf6fbze+711iiJnA5rgXdOxKEhLxGbyQQVPWSGAD+ilKTByjoTFV56KOXSpEMoQ3NYu7PLJ
 Q2JD9J53KHiZE9uKd+vDYHTiCu/lFLLFs69pHbjXFsNnLmU85+Xs451jGWRD1MtI7W5KiAZC7
 e2RJXh3C7hAzyazk/QnGJ1MdAezmrKFAH35WHYvW0TLf7HnO1LlR74W/JrMJI3YooLbvPYoa0
 OgjQrEEMKtHaHKiHAJyNv9Z/aQmTYDcpQU2uhssR6SqxuRyhuXoBOEH9gJAZsioFrmPx+GcCc
 UKUpjg5+jSqKb/FKJLzDxfFttMwxKLzEl+wY85a3FE2zG1TcdOI64y2LlmzYBnaY2VVcHZx3Q
 YIqe0/RJrEHzd0JpPnyqqxUfo7gV+AUHLFwrr3t3uQj3mHdqMoGatuGxZ2tvhLOAXh93KcKVQ
 WGjfIdTJCFpC+t0BuA/JntRxmcxZ9jznBmb1ltr5Wdn81H717YGr50zmQQUxLV4UhjKSS0jLc
 lvLIcin0fatvfmuYuelAiGekARFKXkT99100zHl037+UKQqHMF1FL/8yrT31a3VGIwtHiwO2F
 gDwlhxoVGxiNK4yj3q2tLgXL0+Va34Bo/WSzY+83bU8i28nZa4ErNJfsjZE94SDfXHg9yVpSp
 b2UJ9conKhMKDb0Tu+KNT8QanA2lMkzi7UuGEBhCFYGVCf7+wiHOaDIfFyMVyCcdX0sx2DaAW
 iqZRCFj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dennis,

On Mon, 29 Aug 2016, Dennis Kaarsemaker wrote:

> On ma, 2016-08-29 at 10:05 +0200, Johannes Schindelin wrote:
> 
> <snip actual commit>
> 
> I fail to see the point of this patch, would you mind enlightening me?

Two reasons:

1) by refactoring it into a function, the code is more DRY (with all the
advantages that come with it, such as: only a single point to change if
changing the behavior)

2) it is easier to reuse the code in upcoming patches (that would be in
the next patch series)

Will amend the commit message.

Ciao,
Dscho
