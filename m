Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6624E1F51C
	for <e@80x24.org>; Mon, 21 May 2018 14:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751724AbeEUO2X (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 10:28:23 -0400
Received: from mout.gmx.net ([212.227.17.22]:44267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751133AbeEUO2W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 10:28:22 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MNMyz-1fRdQT0wg5-006vi8; Mon, 21
 May 2018 16:28:20 +0200
Date:   Mon, 21 May 2018 16:28:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/5] merge-recursive: clarify the rename_dir/RENAME_DIR
 meaning
In-Reply-To: <20180519020700.2241-4-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805211626240.77@tvgsbejvaqbjf.bet>
References: <20180519020700.2241-1-newren@gmail.com> <20180519020700.2241-4-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:MZYIvHBCHnVqhFdVd4osxml2lL3gByGgDv2bLKhz6dxSNP8U3cS
 MgU2dQYE8dRAEDPJtQ5kXSKLHTk0Ch4jiFgdvG1anJL8yWZV80sbOQDECiUXAH7MUfXDObT
 1eKPje0ofGWu+GwioiqUH23s8nCohTdORUW7xJ5EowuJn+KhtgfpaHhMSP4RMslrzU26E3w
 FTktTQVJ2i4CQlwL1jKsQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RGUm/3Sa8eU=:OCRCi7rX/0ENG9wLvIWRtl
 017ee+OhBcZwmFcpA9GWmDrGvMB/ZpptCqUOm902RLlzvVp6ZUEFFfkyPt6M0IxDXqDUp+YFH
 NJjW6ZoQEax88GkwCrOn1ueUU1VOZoXVcYSXN47jwD0OWQ5Pdpvk8AvzFaAa3u4GTxegFSpR4
 +qGqHlLYRUoxQQDloLIp14n+pykG0lmucrS5v/5ZM+Tcuj989o+xb2/yb8eoVlGVE69kZR40W
 fVrZjeCUStE9zDNb2CDe2Wxxj0HgcnE1ZU1OBUfswhkPojuh8yAgdvPGDcbWIAg+fdH5435c2
 KOMIgto79lidn1rt9LHhkbA0B3dtIzAnEs9lwxiQn6ZXhLQ6nIObo3XTRsX/YiiF1CaWgWiXB
 dnFsT9EU87iLHGHeWqHbJS1k6DgUna906OeG9DfukvHcvA8fhxaXSGOkxaKh1cKu5rXf3DW72
 1rgiw4I6OTvdHCPtAtntxiVyGTp4dGXP40GcyIGm08u+EbxvAKlALtm5fmnBmfNIJ4SYHRZJ2
 J0q8s4uBgJSNuIlpn4LpMTNF2Xa8n7koVEXUZTLO9hkAfdi/0WknXJo57lkvsWYDmEVfsEJR0
 FDMAb2hedjqPH8LbXTrdBLnZw8FNu7GOMp5+AJCTq3AT6N+jcoydEBPH+tpmHT+FaXXlK3gg+
 LlbN1TKIlBNKAV7zrKk7Fzt8xWxkW9di31UvMlPt61pWY0fuBMhRISWdz/BDI9tXstrI8tJds
 genFOn73aCQTH21v4zkfloY0wPd2bTZ27E0aVpYFMiWR+ik9HTbOXntvUNi9+yY183X1IP3CZ
 Puk3cIm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 18 May 2018, Elijah Newren wrote:

> We had an enum of rename types which included RENAME_DIR; this name felt
> misleading since it was not about an entire directory but was a status for
> each individual file add that occurred within a renamed directory.  Since
> this type is for signifying that the files in question were being renamed
> due to directory rename detection, rename this enum value to
> RENAME_VIA_DIR.  Make a similar change to the conflict_rename_dir()
> function, and add a comment to the top of that function explaining its
> purpose (it may not be quite as obvious as for the other
> conflict_rename_*() functions).
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---

Make sense. I think the reading flow could be improved a little bit by
splitting this paragraph into three.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 01306c87eb..d30085d9c7 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> -static int conflict_rename_dir(struct merge_options *o,
> -			       struct diff_filepair *pair,
> -			       const char *rename_branch,
> -			       const char *other_branch)
> +static int conflict_rename_via_dir(struct merge_options *o,
> +				   struct diff_filepair *pair,
> +				   const char *rename_branch,
> +				   const char *other_branch)
>  {
> +	/*
> +	 * Handle file adds that need to be renamed due to directory rename
> +	 * detection.  This differs from handle_rename_normal, because
> +	 * there is no content merge to do; just move the path into the

Technically, we do not move the path, but the file.

The rest of the diff looks obviously correct to me.

Thanks,
Dscho
