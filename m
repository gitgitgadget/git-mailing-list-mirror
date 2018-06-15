Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01EED1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 13:56:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756195AbeFON4p (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 09:56:45 -0400
Received: from avasout07.plus.net ([84.93.230.235]:46443 "EHLO
        avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755925AbeFON4p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 09:56:45 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id TpDWfjlBjjlDzTpDXfEblm; Fri, 15 Jun 2018 14:56:43 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=GrdsBH9C c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=gybmruYfPMvlNMoESngA:9 a=QEXdDO2ut3YA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 3/3] ewah: drop ewah_serialize_native function
To:     Jeff King <peff@peff.net>, Luat Nguyen <root@l4w.io>
Cc:     git@vger.kernel.org
References: <20180615032850.GA23241@sigill.intra.peff.net>
 <20180615033228.GC20390@sigill.intra.peff.net>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <afbd5335-ef0d-5ca5-84ab-bdfa8bdc50bb@ramsayjones.plus.com>
Date:   Fri, 15 Jun 2018 14:56:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180615033228.GC20390@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDSHWRIGPkgl/MPcnijTfZFJNHzgfDKTvLe5DGWe7w82YpklEQ0hj3L8/zw50Bgl0aRx2f6ST3lxbCWZ17/Gvwp1PTvIKU33ZNiAYMOC3nNXqBeRTuMp
 ZPASd0mHZHQgfbRdftHP31rM1EwGLZFv+30Q3M3fH37O6UEZ18AMPimuDvJE2BRMbsEESAUbDLm6BA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 15/06/18 04:32, Jeff King wrote:
> We don't call this function, and never have. The on-disk
> bitmap format uses network-byte-order integers, meaning that
> we cannot use the native-byte-order format written here.
> 
> Let's drop it in the name of simplicity.

Hmm, if you are in the mood to drop ewah dead code, how about:

  ewah/bitmap.o   - bitmap_clear
  ewah/bitmap.o   - bitmap_each_bit
  ewah/ewah_bitmap.o      - ewah_and
  ewah/ewah_bitmap.o      - ewah_and_not
  ewah/ewah_bitmap.o      - ewah_not
  ewah/ewah_bitmap.o      - ewah_or

... in addition to these *(de)serialize* functions. ;-)

ATB,
Ramsay Jones

