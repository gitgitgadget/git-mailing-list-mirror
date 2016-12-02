Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62D1D1FC96
	for <e@80x24.org>; Fri,  2 Dec 2016 19:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753113AbcLBTX1 convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 2 Dec 2016 14:23:27 -0500
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:50917 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750842AbcLBTX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2016 14:23:26 -0500
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id D1C4B100059;
        Fri,  2 Dec 2016 19:23:24 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id COVZVaJ7Z04w; Fri,  2 Dec 2016 19:23:24 +0000 (GMT)
Received: from exmbdft8.ad.twosigma.com (exmbdft8.ad.twosigma.com [172.22.2.84])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id C1DE680035;
        Fri,  2 Dec 2016 19:23:24 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (172.22.2.43) by
 exmbdft8.ad.twosigma.com (172.22.2.84) with Microsoft SMTP Server (TLS) id
 15.0.1156.6; Fri, 2 Dec 2016 19:23:24 +0000
Received: from exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955]) by
 exmbdft7.ad.twosigma.com ([fe80::552e:5f62:35e9:7955%25]) with mapi id
 15.00.1156.000; Fri, 2 Dec 2016 19:23:24 +0000
From:   David Turner <David.Turner@twosigma.com>
To:     'Stefan Beller' <sbeller@google.com>,
        "gitster@pobox.com" <gitster@pobox.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: RE: [PATCH] unpack-trees: fix grammar for untracked files in
 directories
Thread-Topic: [PATCH] unpack-trees: fix grammar for untracked files in
 directories
Thread-Index: AQHSTNDIAT/8O47vZ0GDPW+i9/1YKaD1CRUg
Date:   Fri, 2 Dec 2016 19:23:24 +0000
Message-ID: <b2fedf5bad754cd0b6f23e83a415b731@exmbdft7.ad.twosigma.com>
References: <20161202191741.12693-1-sbeller@google.com>
In-Reply-To: <20161202191741.12693-1-sbeller@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [172.20.60.10]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

LGTM.

> -----Original Message-----
> From: Stefan Beller [mailto:sbeller@google.com]
> Sent: Friday, December 02, 2016 2:18 PM
> To: gitster@pobox.com
> Cc: git@vger.kernel.org; David Turner; Stefan Beller
> Subject: [PATCH] unpack-trees: fix grammar for untracked files in
> directories
> 
> Noticed-by: David Turner <dturner@twosigma.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> This was noticed by David when reviewing the submodule checkout series,
> though rolling this as an independent fix is better :)
> 
> Thanks,
> Stefan
> 
>  t/t7609-merge-co-error-msgs.sh | 2 +-
>  unpack-trees.c                 | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/t/t7609-merge-co-error-msgs.sh b/t/t7609-merge-co-error-
> msgs.sh index f80bdb81e1..e90413204e 100755
> --- a/t/t7609-merge-co-error-msgs.sh
> +++ b/t/t7609-merge-co-error-msgs.sh
> @@ -105,7 +105,7 @@ test_expect_success 'not uptodate file porcelain
> checkout error' '
>  '
> 
>  cat >expect <<\EOF
> -error: Updating the following directories would lose untracked files in
> it:
> +error: Updating the following directories would lose untracked files in
> them:
>  	rep
>  	rep2
> 
> diff --git a/unpack-trees.c b/unpack-trees.c index ea6bdd20e0..7a6df99d10
> 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -78,7 +78,7 @@ void setup_unpack_trees_porcelain(struct
> unpack_trees_options *opts,
>  		xstrfmt(msg, cmd, cmd);
> 
>  	msgs[ERROR_NOT_UPTODATE_DIR] =
> -		_("Updating the following directories would lose untracked
> files in it:\n%s");
> +		_("Updating the following directories would lose untracked
> files in
> +them:\n%s");
> 
>  	if (!strcmp(cmd, "checkout"))
>  		msg = advice_commit_before_merge
> --
> 2.10.2.613.g22f2156

