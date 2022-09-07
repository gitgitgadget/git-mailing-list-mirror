Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88572C38145
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 10:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiIGKEH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 06:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIGKEA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 06:04:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCDC1AF0A
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 03:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662545033;
        bh=tUUKfk2UXvPYc36BL6/UHmA4qZi1Cp4YE1VmRyJH5lw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Es1rAN/fg8qQC4mdt5DEAvqQt6fvN4GEHpyWnt4OEMFcp4WcjIoT03RxllvPE06lf
         o4mdGk4Ix5bbfKO5s0Z0dcagggL9b/Ui5yd5S65qtV8ey6sI4NZRwPI9m/5PQhaHc7
         kOm+fv1gbWND69OIctDhEKsbH46nrIoZ32M3rivc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N2mBQ-1pUNzZ1Olo-0136nO; Wed, 07
 Sep 2022 12:03:53 +0200
Date:   Wed, 7 Sep 2022 12:03:51 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
Subject: Re: [PATCH 2/2] diff-no-index: release prefixed filenames
In-Reply-To: <df5f8305-79d5-2c12-bdf0-961428c0bdd1@web.de>
Message-ID: <n575rrn9-5p4o-r40o-snsq-197p242q10p5@tzk.qr>
References: <xmqqilm579hc.fsf@gitster.g> <xmqqilm51gn6.fsf@gitster.g> <181c029b-8b36-4b04-30f9-97a3f252bfbc@web.de> <xmqq8rmx1saz.fsf@gitster.g> <df5f8305-79d5-2c12-bdf0-961428c0bdd1@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-754941380-1662545033=:189"
X-Provags-ID: V03:K1:r8b9LYMGhN+WtmTNmUOs2N2jU8Op1t1tXYUCq3ibFVcxK1UWKNz
 vuJJjqvHIzHE482jH2wn8eDr3gG2tP7P6pjR+sEfGwTWrl8SxXWnu4guGYsDV5ORFzqOOK6
 MQRYyrs5QAryI6/tmkC7wnS95G61h6I/ix2ldUf0meCbiQ2DHKKlL5k2m/GuTiTRgSQ11xV
 5Z+CKT4ee5Nw2FASQzS0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zDm38AbjoOg=:19+TTZiGKl5C8kX4lvId2T
 sKKwMjvbFP/t86scDXnJbQ0wH0ddhJzevAQkvGkcSBKHzPSyJS9R8dryANx+wi6nJy3glg12v
 8LXKsGYGOobyjNrmaYx1aHf5qiWnSX3vv+KP+WFOk0PU2eaChq77U4kILXojyhmExUuZxy256
 qKwSesN5D+xKpiFNsUdTQJu1cauxAREADFoX45A1ROn7ioAs2nTU48xH0aaA4mAl61F2xUgji
 iQ1ie8jtQeAWSbJk/mwxuCI5tCZzUZoVUkJjX5iM8Gn+eYWSSu4sfU8umaGJdkRLKTU8ezPTy
 RMOPkX7WH6T+j8AGcc6snrfCnTm4cCDQrMvh2c+JqfQKrF/Yi+JjqSIgXaRIuTx+ZgnFhW8aE
 QYSeNMsGMi2SSv5b+pm1/hjlCC3j9zPvkyxeiCYsOtrsqXEa0dSte1k7igtINpyXiye29B25a
 BeeYTO+Zmr9I5jKLsWQewNWYux2sYYAQZjbnNTMGBBqLWEHA0+Lksp4+mQfoZ48iJInZq79+N
 0LEKFmHSgXr2Uqo6kGjVvTXbl7+nD1L9FYOJbL3uhwo2VirVOZkH6X4kByOvM9VpFfRBVUxeD
 mSUU0AU+lafxZXWwHtKkOSVLT6BsCNgu0hqUz3aSZbPC4OY4i818zkRFHDmY4azY26UYmvXyD
 C06/UKbVKmssmfRG1CieZd8q5vwP3C20efdW+aT9D2z7wZN8qTFrrscbAxBAeD0ayEHCGFy00
 tVYL2p3Pq0qqAxySdaEP8JlLfIEKLaXSu9SIpqWvr7k4EFwbVZUuFEC6VR5oI9OL9c3IY+G7g
 KtYep5o8mx4MktbI2Y4iwk+ibfmSFLTqFyBZfhbvH0nIZt5NMKcrjqnntyZKZdXFSzML+ESiS
 dGM+Xp45t+z7XTzL9PTvCOt4iEvNwllDmyxPkLRcPVuJja+q5FPNdAhHMbwaBfijXC44Tor7N
 sS9c6oMiZZTvoNEqpmOmPfxGt+vMM19u+jbE2GDjQ0KuVMuj/EMlrPA3BAzMcxxMWKVbxtgug
 4UakMah9b0vN/f+qXXasbcScVFdcVn0+064cFieG4tbv1enztcs7ZaIio9TKXjGsX4XxdBCj1
 tpEIYG06NoIbNsxUDRXOINAcU5CC6PpJLTOI4l6EU6VaWIf1MIWcTUMcW2AIbajmbKMHMPXE+
 N34fMdRUpZ6k0ZWFT2YePO311F
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-754941380-1662545033=:189
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Tue, 6 Sep 2022, Ren=C3=A9 Scharfe wrote:

> diff --git a/diff-no-index.c b/diff-no-index.c
> index a3683d8a04..35809f26d7 100644
> --- a/diff-no-index.c
> +++ b/diff-no-index.c
> @@ -245,6 +245,7 @@ int diff_no_index(struct rev_info *revs,
>  	int i, no_index;
>  	int ret =3D 1;
>  	const char *paths[2];
> +	char *to_free[2] =3D { 0 };
>  	struct strbuf replacement =3D STRBUF_INIT;
>  	const char *prefix =3D revs->prefix;
>  	struct option no_index_options[] =3D {
> @@ -274,7 +275,7 @@ int diff_no_index(struct rev_info *revs,
>  			 */
>  			p =3D file_from_standard_input;
>  		else if (prefix)
> -			p =3D prefix_filename(prefix, p);
> +			p =3D to_free[i] =3D prefix_filename(prefix, p);
>  		paths[i] =3D p;
>  	}
>
> @@ -308,6 +309,8 @@ int diff_no_index(struct rev_info *revs,
>  	ret =3D diff_result_code(&revs->diffopt, 0);
>
>  out:
> +	for (i =3D 0; i < 2; i++)
> +		free(to_free[i]);

Heh. That's long-hand for

	free(to_free[0]);
	free(to_free[1]);

If you do want to have that loop, please replace the hard-coded 2 by
`ARRAY_SIZE(to_free)`.

Otherwise, both patches look fine to me.

Thanks!
Dscho

>  	strbuf_release(&replacement);
>  	return ret;
>  }
> --
> 2.37.2
>

--8323328-754941380-1662545033=:189--
