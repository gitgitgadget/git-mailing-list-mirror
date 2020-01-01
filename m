Return-Path: <SRS0=Tp/o=2W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB71FC2D0DE
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 22:20:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9550120722
	for <git@archiver.kernel.org>; Wed,  1 Jan 2020 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HFwXpHDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgAAWT6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Jan 2020 17:19:58 -0500
Received: from mout.gmx.net ([212.227.17.20]:55111 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727290AbgAAWT5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Jan 2020 17:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1577917195;
        bh=g3ZRVW0+VoHkkpzBO2rlen44RjwiuB4rMzBWByyoC0M=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=HFwXpHDu6hdxhxI6OpbmbEIxMMkcz2PVgj9uLK5GKUSOnHQFH91pTjazSKb0iIprR
         RJNbWsLPCir7CS5NrQXwFuq3tk41fH/ly8x9RnktQUxG6tHZPZgSCGNq/CjYCZ4h1Z
         krzQGvKJZr7zfHvlsTvVsYeHZ5kiwzcdFwoZFp1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof57-1jWqXq0O5Z-00p64z; Wed, 01
 Jan 2020 23:19:55 +0100
Date:   Wed, 1 Jan 2020 23:19:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] t3008: find test-tool through path lookup
In-Reply-To: <2dc0b0f3-19ce-62ab-5af9-fdb2d05b00bd@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.2001012319200.46@tvgsbejvaqbjf.bet>
References: <2dc0b0f3-19ce-62ab-5af9-fdb2d05b00bd@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nbkkTWFfWPzPxAKKsoOzFJOS2fveW5ygOijPrJex3LD6hCzq+uB
 M7rncCVqZM1tzz76I/9hVtlF2Tq0TwHcEYDS+6GBs1KcbL0mPEeTB210HKpQv7MqlEj1luA
 uRV8LBNt5+6Uw4I2gUivRv8AbudgYkMGiZLCnSuLCwRv8sUOdSp12oLD5pq9UQESdujonsm
 0KPfBfLFizk9bmYpQ0dtg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rKvxlHZFJ60=:6VnDmLMN5iOpEYEFtG+B0J
 DGTo2WYDm9+DjZOMESXtGRxYQlx09ELBmoArOm8UF76hH44hOPssy4pXLT6iWFkjnhOR23+Ij
 ZoMJf/FOXWd/X24qPy081wrkG5cHoDSrPwX4zzGXPoIGUjq0POiM+wPDRFCRIB6Rw5XbU0t6X
 3OBmO2fjqUSAndnDyNuqi4n8aS7/Rm1gOrnlEajV6oZXpbNjYbr6xrvb66YycvoFf8E3/WNEp
 AGV+PYRxYpGpE+b7xj62+0sBwuIqA4A0bSLziUzAHIaaKA3DjRc1ospKIkP5C1rQ949oo/j+b
 8KXQpXRBbus3InqmoLkTruzgdFWCZpZ8Ksn76rmxWNlBQSa5U0NiJaSceUm7DSF+IZKUzfL2I
 JCrzSN1xal1cZui+FIxUmUpPIRePAasLR7UBfNk6gFp8wpFNjze5Tovm3FhYmLhz0Y/jyVB1T
 NKTuaM3TQKDbaFmwNe9ohtCD2saYdPznOlmU/wq37aGM9r6yy04Kpq4TZFpR91TsHmi/HOaXL
 Kxee09inKX20F1+v4SCl7nAJ8knBlhV9AZMWzeFfhMiL76aLur/Iif63D5aShJJsPGqHO0gzA
 sV25T7QSfEXpeJNMM0c4yjHceFxY+QGe60Hto6Xh6XLkX7PuMTDHCazcL9JIIkj2XRBsp7iW2
 8sVpcVAk3kiU6nFmk5qtO60Mc73YNTp2rKWJhTHY+3q8Wgs8Bhz6e8nGRPWWjJR7ZXNW6fUkg
 vYujsukhjTbza6CMbwwS1obSNg92MmGl2vMiknooE4/KBSs1wDs7LQdAHowVxjz9+HMcopHjX
 AAFkRc2XCninqOB4o41r3sKnyV9VNk2g50fdTn+aR7vyZPExylbreqtksfHGUBNYyarR35wQ0
 QS2fhUKWbs05cgnhwDgtmQ+jaQgCXugFJJtr27jxA07Xu5eDboUODbFDt6Hm5GpA7pP/tdAeZ
 bqypr0xs8JXi27urem3iEDypxRiCeRs1F3LrdfrGXaoH4hOgHCRe7jDK7q6RSRWOmn+t8YObV
 TqNpB4VVjgDba44p2EPIgPmJR8WM0Kw21S3nfpYGcWLnEGLe1ZAdgMzbiOoAkJxpIMRdyY6SW
 74OoZL2fKpG/pvheesEPpa2/tOMSanW9qxNCxNXLIwheikYrt/B5k++rKH/Y6X6EWidV0dQYT
 tH5W+s36aEPLX+kSB0XQYpvauLc6FXXdKdFOPbjoC01/lgx+lTTaMuks/wECsUXHGjo4g02D2
 NkR5UwNbF0UHS5cB0pHNVERFXkNH0Db+Lj4aD0y+nmsrYdVr+oDvKE1wFG80=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Sun, 22 Dec 2019, Johannes Sixt wrote:

> Do not use $GIT_BUILD_DIR without quotes; it may contain spaces and be
> split into fields. But it is not necessary to access test-tool with an
> absolute path in the first place as it can be found via path lookup.
> Remove the explicit path.
>
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  Found this today coincidentally when I happened to look at the terminal
>  with test output at the right time and saw a suspicous error message
>  that included just one half of the build directory path.

This patch looks good to me.

Thanks,
Dscho

>
>  -- Hannes
>
>  t/t3008-ls-files-lazy-init-name-hash.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t3008-ls-files-lazy-init-name-hash.sh b/t/t3008-ls-files-=
lazy-init-name-hash.sh
> index 64f047332b..85f3704958 100755
> --- a/t/t3008-ls-files-lazy-init-name-hash.sh
> +++ b/t/t3008-ls-files-lazy-init-name-hash.sh
> @@ -4,7 +4,7 @@ test_description=3D'Test the lazy init name hash with va=
rious folder structures'
>
>  . ./test-lib.sh
>
> -if test 1 -eq $($GIT_BUILD_DIR/t/helper/test-tool online-cpus)
> +if test 1 -eq $(test-tool online-cpus)
>  then
>  	skip_all=3D'skipping lazy-init tests, single cpu'
>  	test_done
> --
> 2.24.1.524.gae569673ff
>
>
