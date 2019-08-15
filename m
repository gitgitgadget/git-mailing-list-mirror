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
	by dcvr.yhbt.net (Postfix) with ESMTP id 291D91F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 16:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728575AbfHOQqj (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 12:46:39 -0400
Received: from mout.web.de ([212.227.17.12]:36251 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbfHOQqi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 12:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1565887593;
        bh=TebyL+OL571WUzHDD2jFxXWdPeiwJ0zT60EDVo7I0Q4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ZRcGC8LrmoSZ/6GyHByOKd9d7eRaC84g/h0amtKKGxhdUI6rDGKzIKstA01ztp9Af
         f7IUN+Tss+5uW6u6O4EIDDe3EtY1luneM+VCIGVLns+QwnUi/rrhICXdt/m6bZ0Zyu
         li0qsIbNbvVCAhX/SCFjnfV5sOvUsXYWFg/dNfqA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LzsC7-1iKZ0F47Sl-014xgT; Thu, 15
 Aug 2019 18:46:33 +0200
Subject: Re: [PATCH v2] unpack-trees.c: distinguish ita files from empty files
To:     Varun Naik <vcnaik94@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com
References: <20190813160353.50018-1-vcnaik94@gmail.com>
 <20190815162115.65008-1-vcnaik94@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a19fd436-b5f3-462f-6f9b-f8eeb46c78da@web.de>
Date:   Thu, 15 Aug 2019 18:46:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190815162115.65008-1-vcnaik94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WOHRXccTGppyFcpTxafUB4hnn1q6h5i8qRzt+9uXLjWPQ/REHss
 RFAG4hQI5yNcWVhYSjKtv6/2iTeXak4CnQW77DnXHw+X1WHYYKOTJDWBZ4HMO3+2xyebyCd
 U9UIEswstu6806TwZzGfKnWugfCcHGUK2xrFQinnt9b4cZO3AaP1OQmGsTPcmdgvE6How4B
 WecJaKnVRUZgnPDtcgzGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f0vVJjySr0g=:pe9GK1p3pIjBu/liKh1RLK
 CYEZal3x5Ki3Kx5lSIE7d8ACergZeNXkhSxj8AftHDci8XuZiZ6OVsBbAZ4jCyO9z/IBISeES
 D5Fji4FfN7Moy1Ji202B669HceRFiZ5VWkZlSVL9yKxaJxH+BtnZ1OK3vU6/shd7xJI1wgltG
 RqZyZJx0OImsS0+rIAtR3U6rcjqvioMuh+Wo0eWQxaIAUiX8vmFo+iAhesoCFVBVmCSJFHW2N
 WggZmGz0/zrmhGTO7MjLBaicndl5Leq4VUm2ilUbctNh/4mYw3ofRLHo597uQ3uBtaayFsJeu
 TUGYTqSk1MLoX4YQIEC+xEzKdrvpoRG5d4T6k4epTbmssmTVoFTD0e1CcD09TzrJ3YMbzZ2bX
 m8TSMuHlVPmnEQYqXSn9tWGKOMpTlfCEvnH2RxryMSNTa2nL6X8BYSmMBnNtaTPpgO54k4DX9
 pDvpX6ZhBpqs0MNCW8rO0E0j+P30uXIl0W9tnhnfvg+098uHEF4YQw5UOcrmxvlWUTfMWmcRI
 WYGqDPVI6ovRD96nMOIZFprU/Am7eoFNSmHJujOJxWgy5PDx/bK8MjqbxaqQqJQ8Gr7SkSyOB
 VtUODiV4hnAQUsOqhfxrKh3TLzI4eznmP+WBq9SfP6yh6PqrbfOSd3YJW2oLsGcqGuhow0BWN
 xUdKO2hq4/4F/PV5jcqVRYbSnPoRYBng5FhgDauNYMetdt6GMmGKnTu42gpX2Tw2D3jTWDf0N
 zJd8Q0IgAlcSARytAJ025POYt1/+wH40dI+kvfRI1VP2ug64+dO0U/cp3dq4j67PvCNal2V4q
 Gf2J93VXqkLjFFiEdjgArvMhUnI+kskam7//tosgO7MA2cjwX6rKxI0C18+cs4Dp2nSTd3FMF
 WlBUake72hpsVBl4HeM7YGMa31+TQHm8xFQLEY9uBp9t/oo6sZLSxNEM1QsTkVhwujtdqSZX9
 cQXLcttK0JBHYGpxkvI3T3vxrgc/mdTad4E6GttsyxsejojhYd5w5EUs3T/ww3xxzipbo1NmN
 d8zQx/4tqHQk14Cf95uwMCujmIWzGoYYHtj+xyBNp9jQ+a/TvQEZ56qABaSRdxa3YbMpnV0vv
 gXiqZbyvA5lAIwTVxx7CcI1SnehdaXsEdvWFJrVkLhlk6tEBKfh+FY7Vu2H9yot2o7/+eYtr6
 3J8Ac=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 15.08.19 um 18:21 schrieb Varun Naik:
> diff --git a/unpack-trees.c b/unpack-trees.c
> index 50189909b8..5e6d88f36b 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -1658,9 +1658,10 @@ static int same(const struct cache_entry *a, cons=
t struct cache_entry *b)
>  		return 0;
>  	if (!a && !b)
>  		return 1;
> -	if ((a->ce_flags | b->ce_flags) & CE_CONFLICTED)
> +	if ((a->ce_flags | b->ce_flags) & (CE_CONFLICTED | CE_INTENT_TO_ADD))
>  		return 0;

If any of the two entries has the intent-to-add flag set, they won't be
considered the same and we exit early.

>  	return a->ce_mode =3D=3D b->ce_mode &&
> +	       !ce_intent_to_add(a) =3D=3D !ce_intent_to_add(b) &&

So if we reach this point, the flag can't be set, ce_intent_to_add()
returns 0 on both sides and thus the added condition is always true.
You might as well remove it.

>  	       oideq(&a->oid, &b->oid);
>  }
>
>
