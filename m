Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 986B81F461
	for <e@80x24.org>; Thu, 16 May 2019 18:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfEPSPL (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 May 2019 14:15:11 -0400
Received: from mout.web.de ([212.227.15.14]:41661 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbfEPSPL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 May 2019 14:15:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1558030504;
        bh=Jgbs2cIcYPCz3Nt+F3E2ymNLVFffGY5/DeG3uJnyWQo=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Dj/jHLm12Kc7nfRPZxqIZytfFCDEqVRC63cp+hrZYDcxWB/EsgAUV2lNFoA2kZWRe
         AiFfvIklS4HQ67YuJVPhs4olfCIAVKg1/S+n4BIaHQXTkZWbS0nLcxL3jgI6Rs3iyo
         HvdQwKCoIS2gN112R62OMyNAC/0pOFn5gJ/UrtVw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmuMO-1gkJWV3cs8-00h5wN; Thu, 16
 May 2019 20:15:03 +0200
Date:   Thu, 16 May 2019 20:15:02 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v6 0/5] Fix and extend encoding handling in fast
 export/import
Message-ID: <20190516181502.zjucws2d5hw4sviv@tb-raspi4>
References: <20190513231726.16218-1-newren@gmail.com>
 <20190514043102.31979-1-newren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190514043102.31979-1-newren@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:X/iC8d5Pl29J/pRxkFrG1N50vsBlNvhx8P6qLLo5HCmBGQGpCZ0
 9g4UKRKCr/06E0XFYTNTz4ZlrVtgajNx37sySXxUc1PeQGdvjBjZ7KngGO6ntvx8wElEv8p
 THnu+VRnyuJipZNiQs790RWZLj6XKwCYf4JJYDtlirWgJ3pE15OosTr7s2FO6/AnSrzW6xg
 fqwFg8Ecu1ba0iKiI5cNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aZ949d/k7aE=:sant3W8L8UGDbp0+jy7o3t
 Ll4YYYcjoySMcOb0mR8Ij0hOVU81oHz7HdGLCUgp9fJRk5ToW4Qj+EA8UQV8BE0wQaWrfol0Q
 OtqD2D5ctSaw77ExQJkgARXL687QRb5/adLbbTXWThf6/X2eeXjlomOE9FF88bhSHFnAOjrir
 Ze7sMeQrvym7VUuCwb18n/zNiH09vERxBbGmV9Y4uYGMb+D/+CUKVGsMMmzlBF9X45zdMveKx
 mpC/Xf9HEoEpFm/ak0hNbTzAqL7euC43RKYHgLaV8butISAwH4yXbM3roQwfPNDB1241LG0zv
 W6Qzo+I8Dp5/T+3muBFM7FjQ+LByupqK6T1IupmFJL79XWMte0dCO2i3kbt15o8eNowPPu7+M
 3n42kucmQ+3tRg/5uKZLsvW06mg3z1DWak1IJbONgwmfdgwNHvKAa9o6ztDMsCV3MtwILLcPC
 IunSGDkuHH/XDdaFXjUcw903g6ev0iaH+ZOjpRVo6iYvj4iWRL1T0aKH3DUN0J0GUp2rLCph0
 7CoJbni/QmWYl5LumB34W5oWIwiB3V9nJhRoQYWgboULTb7MpqVgsZsF/r/9h25BgEmwkVbGn
 dKM2loJKOreDC3rC+1wT8sYqlju9FRXh+nErRN6ielOwoCGyMctnyu0sg+ULrHdv15AfneWMA
 3PTBWdoFEKgqlKVgxLtTBfSdXCsvbFNm0MKIlnv177Hh92ECYCTcKVt760xf3HHveF1/H6/F4
 JhHkIjVYT5GlZ5cksCQrGmf4mIDZ6vxZJtjOkZ/6Hk9QNpxgFbdaRhCO8bGzg1bVccuazGPJQ
 OT2+B8yt/d3osHW/uaaYW/69xFJNNUS6jzESu9CbEULFr/01Aq7Z13QZOd4TiocnnQF4lAavq
 qAI8NuqMo/YeUHhffIBONm6Z9TsqXxXBuqM9bKh9NUS4zgp9erkCF5HgP7gqGXKy/VilwXI7F
 FfNO8nMFn9YEBbH1jgV4lzfFeCoQRzF0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 13, 2019 at 09:30:57PM -0700, Elijah Newren wrote:
> While stress testing `git filter-repo`, I noticed an issue with
> encoding; further digging led to the fixes and features in this series.
> See the individual commit messages for details.
>

No more comments from my side, thanks for the patience.
