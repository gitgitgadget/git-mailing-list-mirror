Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A9B920137
	for <e@80x24.org>; Sun,  7 May 2017 21:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754046AbdEGVxY (ORCPT <rfc822;e@80x24.org>);
        Sun, 7 May 2017 17:53:24 -0400
Received: from mout.web.de ([212.227.17.11]:49878 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbdEGVxX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 May 2017 17:53:23 -0400
Received: from macce.local ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MAvKi-1dF76y37sC-009xEb; Sun, 07
 May 2017 21:12:00 +0200
Subject: Re: [PATCH v2 1/9] t7300: skip untracked dirs containing ignored
 files
To:     Samuel Lijin <sxlijin@gmail.com>, git@vger.kernel.org
References: <20170505104611.17845-1-sxlijin@gmail.com>
 <20170505104611.17845-2-sxlijin@gmail.com>
From:   =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Message-ID: <22e44a7d-0e9a-3e49-14c7-d69d6c6d733a@web.de>
Date:   Sun, 7 May 2017 21:12:02 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170505104611.17845-2-sxlijin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:newjm/yyGjCZWxFee/0Eh1Hu1XHxCAWkn+pgalmiNGhiqQs0K/X
 RIE8Xtfwvqe8r68KtS1m7r/jNL/rcZgVK9wulbPIbbSPQzWTuBvNr/AAODZh5ujMAR3H5UT
 0qdOudp0xA4qFTSnWRdDMQGJYJzpVcK4y5rFYgTEidc2ogx5SztPGQWNParGFGm5KeF4ZXH
 BQWRItyIKKHvjYkjgGabg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lvHcTUrZC8M=:FY3RfM9nwFRiFiky+4Fo0z
 eSKyfF+o8LhTOKrttDzhqIQgc1NdQQUPkEu25WOs3CLD5j185fuApZMXuv85MQaGgT7vwvUqF
 lMVucXhmW5tRMZClRTBQC6adVDCPtgn/VXUZVoymnSZj3b+efUKfawHGA2Bm+0e8J/IppNIu/
 VuFK4HxfGKYDAaRBjC4E8JKf/lxlNUNC7lxdfcAWuxRUMRWHY4AqENdwC5vmP/mY/hjVS2HA6
 9DpVEn2xMuE8blJEDtJVDVt2Wfc2rFYqaocDl7gSMqfZ8T+hwYziD4TUszHbypsovwOhHp25b
 NVOm5txp/nUuRhdIX+Bc5PQxZBiZw2cVcLiuUbKZN9otutj1xG8+4ut/sdTFch4fWQ0xDcyKO
 4DPny83n13ujHmoue5Nw8feR6HcqRxeXcrckYC7VDs6Nueb0gbnRL2rzJ65E87K5QyMhZvBSW
 akonf1fU2AdqNq7mZQcqHJzMiVgZrGPm3D71KeK9d2NkOC6rxepVZZuByA/BlJGLW37sfQVFx
 eO7RJRRaRebsD1THBclwjwflqfEughZe/49dYRZS4+J6690Ex7/TutMb+w+1RqWSwaNRwo/Sx
 ZiP608QuU/Zh+ALNte+xuGd327dKyiKbGwbVubWADoxqMP0dJkPTyV2IfQX2a96UzOJq7SfSU
 HBfwixbVHG2PzZAha5k4DHGa0yOmVPuDh6L5HQUKwTnnGyv2X2ofeKkTjAFPunN2b3RaeNEk3
 XHjPrVTg9Q2MpOryR3iXaOHXL7/UsVSFiVnn5pZgucO/7IPB0Zqtm7SZNCeMVjhuH7IeQhIZT
 ZwRUzLq
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2017-05-05 12:46, Samuel Lijin wrote:
> If git sees a directory which contains only untracked and ignored
> files, clean -d should not remove that directory. It was recently
> discovered that this is *not* true of git clean -d, and it's possible
> that this has never worked correctly; this test and its accompanying
> patch series aims to fix that.
> 
> Signed-off-by: Samuel Lijin <sxlijin@gmail.com>
> ---
>  t/t7300-clean.sh | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
> index b89fd2a6a..252c75b40 100755
> --- a/t/t7300-clean.sh
> +++ b/t/t7300-clean.sh
> @@ -653,4 +653,14 @@ test_expect_success 'git clean -d respects pathspecs (pathspec is prefix of dir)
>  	test_path_is_dir foobar
>  '
>  
> +test_expect_failure 'git clean -d skips untracked dirs containing ignored files' '
> +	echo /foo/bar >.gitignore &&
> +	rm -rf foo &&
> +	mkdir -p foo &&
Minor remark:
Do we need the -p here, or can it be dropped?

> +	touch foo/bar &&
> +	git clean -df &&
> +	test_path_is_file foo/bar &&
> +	test_path_is_dir foo
> +'
> +
>  test_done
> 

