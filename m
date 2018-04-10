Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75C691F424
	for <e@80x24.org>; Tue, 10 Apr 2018 07:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeDJHcc (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Apr 2018 03:32:32 -0400
Received: from mout.web.de ([217.72.192.78]:45285 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751778AbeDJHcb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Apr 2018 03:32:31 -0400
Received: from [192.168.178.36] ([91.20.52.220]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lmu2K-1eXqzh1xym-00h8ax; Tue, 10
 Apr 2018 09:32:21 +0200
Subject: Re: [PATCH 05/16] replace-object: eliminate replace objects prepared
 flag
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        sunshine@sunshineco.com, pclouds@gmail.com,
        sandals@crustytoothpaste.net
References: <20180406232136.253950-1-sbeller@google.com>
 <20180409224533.17764-1-sbeller@google.com>
 <20180409224533.17764-6-sbeller@google.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f960fdfc-ccd7-5b72-794b-eba4a09757ed@web.de>
Date:   Tue, 10 Apr 2018 09:32:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180409224533.17764-6-sbeller@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yUPGB8bGMNesdxZkVYImaWsEs98qD3RFLhSpXZCyjMQ8rq9dB6n
 qeyBpd336DGBLPI0MWH7v6fEluLNsAWxrh6p4rR13DSL8VLCMMNhqEBZRmYKYc6inmEXpte
 vR2xbwSivCl0TpVTEGIJAKqdKuYSl1Px1p6yY/ChVh5rN4Qld15CDj0XMtGnvJgh0djURlb
 HYXkXJqcUWDa+MDYR2pxg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:sPmiL5Tk/bk=:O7He9/WJPEEvzMKl7qVSLQ
 MNk9C3LTdBlaXxvL11VbdgDlVMgBpl4Ze0RQDpfXBkUnXRnMK1/0PmCD4T9eMIN4yAq/Xx1vf
 9hoW0XSopAC0vihQHjqHa8Eab4VrynHVqKsRrqMUip3YBxELnwl72Ati7fJxHVhe/w2dUDbGR
 bngcbzwEO/k3n7MDrVIjR2V7DGqALc2s++7WNh7DmeoWQfCP+iWRyw1qN7WDeixrELreI2T3b
 D1M/WDLAVdv4yvW8prYMZsho0CJ1rR/0zdZ0Eqp+dFNi+JXtHXvDtSek74lH/1z35YBdK08xO
 JM6coSiu6InBaN8lwwKb9gc37pAH1ceqrv51lqOInwxIB9h62i4DuPN/nIaja5dpUMxuQm9IY
 TXtVPM9jeOm8g32LMar8dGYgqhVdxKIQQVExe1o9idWNJGtgrWQqOLrecg6pEl3RJa6JMb3YM
 D2ZnQK/aLigSjJs8NNyW8XQuLDSZR4qQkMDL6R5WBsrrFBdAntpG986I6Fu/eD2vV2f57A6gu
 o/wZxSVgRNVXEg2iP/Ey6Z+on+L98ScKTz22kV1j6XoTsg1pHX5Ef0gn9eyr3KqqR5vvPJG/F
 b3T9nKPiBW60818uO9yj+sKceae9PqMSeRW6SrJyV+GC/yYmIqMq0TEfR9zgDpSd+89/CrLS3
 JB6FrACe2bViYe7tQ8b0gLdhM8mf9ovsRplSqBCqCpjD+ZgL1fuSOzfd+au8+29TOAZ1T1hTU
 wdRbHUNLN0RbgUxl8ifvifrAwon+NvR3f3ZUWkawdchrueLWFBlLJalDMDaOL8ngTHfLLvMNA
 /UjTtOYEJe/6n5p8EKFX8je3JKKR3xk2647KYvkdykwkkMjd18=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.04.2018 um 00:45 schrieb Stefan Beller:
> By making the oidmap a pointer, we eliminate the need for
> the global boolean variable 'replace_object_prepared'.
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   object-store.h   |  2 +-
>   replace-object.c | 16 +++++++++-------
>   2 files changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/object-store.h b/object-store.h
> index c04b4c95eb..1ff862c7f9 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -99,7 +99,7 @@ struct raw_object_store {
>   	 * Objects that should be substituted by other objects
>   	 * (see git-replace(1)).
>   	 */
> -	struct oidmap replace_map;
> +	struct oidmap *replace_map;

This also allows the '#include "oidmap.h"' introduced in patch 3 to be
replaced by 'struct oidmap;' (forward declaration instead of include).
Keeping the type opaque discourages circumventing accessor functions;
not dragging in other headers avoids some compile time overhead.

René
