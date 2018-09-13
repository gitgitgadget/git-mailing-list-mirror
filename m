Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 396F11F404
	for <e@80x24.org>; Thu, 13 Sep 2018 02:38:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbeIMHqA (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 03:46:00 -0400
Received: from mout.gmx.net ([212.227.17.20]:45557 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeIMHqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 03:46:00 -0400
Received: from MININT-6BKU6QN.attlocal.net ([108.198.118.51]) by mail.gmx.com
 (mrgmx103 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MWCKz-1gJmLN3i3d-00XOQ5; Thu, 13 Sep 2018 04:38:37 +0200
Date:   Wed, 12 Sep 2018 21:38:34 -0500 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Thomas Gummerer <t.gummerer@gmail.com>
cc:     Derrick Stolee <stolee@gmail.com>, ryenus <ryenus@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] linear-assignment: fix potential out of bounds memory
 access (was: Re: Git 2.19 Segmentation fault 11 on macOS)
In-Reply-To: <20180912190108.GE4865@hank.intra.tgummerer.com>
Message-ID: <nycvar.QRO.7.76.6.1809122136020.73@tvgsbejvaqbjf.bet>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com> <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com> <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com> <fd241679-2283-4e01-315b-db27be8a794c@gmail.com> <20180911163419.GB4865@hank.intra.tgummerer.com>
 <20180911172903.GC4865@hank.intra.tgummerer.com> <20180912190108.GE4865@hank.intra.tgummerer.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:uFW6ojxvlKPRmzr/YXDJOGmXFbiGI7DrwIgw0DdBUMooFXVffT3
 vMTaFrK5L5kMyB0nIzQgUu2EM64R+pRumPeDSnC93fRM5Q30QF9d5L211scuobBJjz90ny1
 9OAKoWy3ubicw3mO20K/UfKd8zTe8nMI7CR9mzTpwG53AEap/F6XFM13czvZ6ibqNSQWdM2
 qSYdMfjlgLEwE0SakZQ5g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:vz40pbOD5hM=:oKx5AvEx0KcyzRNjfOFmop
 P91yGGJL0LmuRsvzh23NNihvt0ZgGf38c1yNXSDS1PUp3efHLtlYzsA1C5e9HL+c6G683LvXY
 DeHmW9Roxm4IO1P9w4e0cEBjx+RVe/UJal0aNmF/YhNX9iu/W8JM0Gy/a/WjaYOzsksBvTivE
 j8qc89JPmMCjBL9NTx5gkfHGb2JZRNvU34i5fGT70PRlM3dV5Bbyh5XD7ZVhVpi3ydanDCMts
 OSOAPCd9YpwYvihmH2teBRYBKPrBIVq0oGK3puijwZkm0FYl2vXk/2dqsBIX1uQqDdHRVcytR
 53rf06GKJCd9BviEnybX65Ev19djSBK3CbXAs8doLdUWu/Zbo7H/SqcizCvMfxUYnIKrDHFw2
 fzM0XZNqO3EQDvEP2AjO84FtqsDQVGGh1DIW65BRKb1aWR4WiIy/wbQfYCEhneqWULMdXtR48
 94kNOayEWU0W5gZAzI2Xe+dNlXmlH/E3EEDSILf+/xexP9pQQejNaf1DWYO5fBwIcFDlvsJup
 UQKDuEW++lvsqJe+UzcFgTqgv3wgePlXBoRjma982UPrtDXMt4PGLnObz2r+YIK19SoNnCE7S
 b6s+/6lLv5MCoPvL1xySAXSiBzrq004tqksxDb1TlhpS/NG1qUP5Z+KD6qrWlczUIHy476T+i
 61TNwCcnCV0hvWDmYJHFgGrrJhAY4MCGUAmSGq8WgYaYKzkP/EEmAzmGl2TwATNMxcqrRyJS4
 K6X+pr2WcloRZR9cbjQjN2KhTNebx4EAYYmpC/2zK+QAKNgxlarkdMHvYCqiQX7wfm1DZGbxk
 Y82k2a32qtBoBSAr8dXLoVS/NX/vMPVWYvE7cC9UjUXw29IpAk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Thomas,

[quickly, as I will go back to a proper vacation after this]

On Wed, 12 Sep 2018, Thomas Gummerer wrote:

> diff --git a/linear-assignment.c b/linear-assignment.c
> index 9b3e56e283..7700b80eeb 100644
> --- a/linear-assignment.c
> +++ b/linear-assignment.c
> @@ -51,8 +51,8 @@ void compute_assignment(int column_count, int row_count, int *cost,
>  		else if (j1 < -1)
>  			row2column[i] = -2 - j1;
>  		else {
> -			int min = COST(!j1, i) - v[!j1];
> -			for (j = 1; j < column_count; j++)
> +			int min = INT_MAX;

I am worried about this, as I tried very hard to avoid integer overruns.

Wouldn't it be possible to replace the `else {` by an appropriate `else if
(...) { ... } else {`? E.g. `else if (column_count < 2)` or some such?

Ciao,
Dscho

> +			for (j = 0; j < column_count; j++)
>  				if (j != j1 && min > COST(j, i) - v[j])
>  					min = COST(j, i) - v[j];
>  			v[j1] -= min;
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index 2237c7f4af..fb4c13a84a 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -142,4 +142,9 @@ test_expect_success 'changed message' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'no commits on one side' '
> +	git commit --amend -m "new message" &&
> +	git range-diff master HEAD@{1} HEAD
> +'
> +
>  test_done
> -- 
> 2.19.0.397.gdd90340f6a
> 
> 
