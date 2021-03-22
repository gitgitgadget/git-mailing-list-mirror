Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16471C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 21:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8EF3619A3
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 21:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbhCVVhO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 17:37:14 -0400
Received: from mout.gmx.net ([212.227.15.15]:42809 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229647AbhCVVgu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 17:36:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616449005;
        bh=IqpPXd8HpmIJ7PcluGPYPvS7gMyZreW1BQ9yqVIEzMw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ItHvgZlyImSMajfdEJOSMLDHpxdoF7Pg2xM3hheDyq4XUSJPpgpDdnRe+/cY6sNU4
         HxF1h/E9m6Iz/EmEa5SXuRLTWziovyBHvBdVFTwf3bk9fMKZApIi0BgI9BDH6PG2p4
         iGSf7VD43PLzPzdDRWlgblNoHG70Zuin95RlaDnM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.144.62] ([213.196.212.127]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGhyS-1lTSQw46wk-00DnSB; Mon, 22
 Mar 2021 22:36:45 +0100
Date:   Mon, 22 Mar 2021 22:36:46 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v7 03/15] t6060: add tests for removed files
In-Reply-To: <20210317204939.17890-4-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103222235150.50@tvgsbejvaqbjf.bet>
References: <20201124115315.13311-1-alban.gruin@gmail.com> <20210317204939.17890-1-alban.gruin@gmail.com> <20210317204939.17890-4-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gTnbjehJ2ZX+qj/DJdrb7x6K1rkfP7FgVP8Y0PcEVylXsKvBWmo
 XNcXbIRykJ4sc9oVj/cFjliapal7QcSZj5ZoF90T0ZLQ3v+auCZZudFzk/HixhpUUpXAPt/
 kqZznX3PjKDthER77YhWoaDuay/FWXpQKQnoC4rvgcCXO9fsQVVRSX25P5ipsVDDKZnHwXs
 C7d0R8cdtoL+qvziSYPAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:u7pzhn3ettQ=:KECbE89V4wBOuYG2RZjwMP
 M7WoCi71jKMwTRcuE0XxBfRNdx554XigrIPKXRUwldnFqXHaMtv8WafuUriJpjXqbWC/kCs0z
 Pl37BkJ+ynHf76BCsLW3H5nphzmF6swrV+K5/qGK4nU7CJdwM8oYMsubyCoRWMPHDMGWgGUex
 Y1qs01FiepgfPvdvsF/VV6Q8CYYbf2Kq/nmbzz++fEyYDxPvpixRTsg8vnOlcA/7wssk5esih
 b0S8ZBj1RZxpWF2wpgqA63fSt0U9ZcGowYCD0VDG1f/kFsGLhFxDPFMnqrDcx0F4qg+1njfBh
 /1KGDIDzp4bN27DdADLriiUSRbAnzd5uKpL5xQFhibkF/jcQMTYt5zAigISMH3B24ElHqog2p
 LkZEdu2/Y3Dh8iYvVzEvfj+nRfAHktdO2ZTRBS8f2eUHimVJePjNoZuMlbg53z6vZZQQEoZSL
 NZtRR70CMFcSMxAJ2so4VeMUqm8F+D5gEgKM2m+ciMEf8wtq6VvImpItR1GY0zzoC7lwwtiSO
 0LQDCSH/BGSFO4/9WMchoAWBHwZ/7kauGtB4O8NeqA9AizcGtGMn2mY1UMw3o1ruuALRpS/LB
 yTWabB7yRKLc64NFolc+GelyC3ehZ2EDS2R0vnrGtHmv88xwpgT8/BFTxLnnrVyTfZPJ3yso0
 oRibm7sBx0y14KQ19FJybUrAdoc9XeaKqS6m8OfA+qMtFIKCCu13Y69+bcLLTpBacqLX0a2aj
 cDrtMCRUmvq18K0/Hw96dZEdX3ZvM76m3/DcEP+0aZKTyq+13TCPWH9gwofl6FHwCeElbxq40
 aMba83q32ZT7+3bH34g3emEnANDpOaek/pe427Fc6J7I7NRCs76KFt4cbuT/7I4vYPSstHC/c
 00TUoADlnXftLoICU+LxKSmeaV7UArMxTRiUpUZGg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Wed, 17 Mar 2021, Alban Gruin wrote:

> Until now, t6060 did not not check git-mere-one-file's behaviour when a

Channeling my inner Eric Sunshine: s/mere-one/merge-one/ ;-)

> file is deleted in a branch.  To avoid regressions on this during the
> conversion, this adds a new file, `file3', in the commit tagged as`base'=
, and

Maybe "during the conversion from shell script to C"?

Other than that, looks good to me! Thanks,
Dscho

> deletes it in the commit tagged as `two'.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  t/t6060-merge-index.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
> index 9e15ceb957..0cbd8a1f7f 100755
> --- a/t/t6060-merge-index.sh
> +++ b/t/t6060-merge-index.sh
> @@ -8,12 +8,14 @@ test_expect_success 'setup diverging branches' '
>  		echo $i
>  	done >file &&
>  	cp file file2 &&
> -	git add file file2 &&
> +	cp file file3 &&
> +	git add file file2 file3 &&
>  	git commit -m base &&
>  	git tag base &&
>  	sed s/2/two/ <file >tmp &&
>  	mv tmp file &&
>  	cp file file2 &&
> +	git rm file3 &&
>  	git commit -a -m two &&
>  	git tag two &&
>  	git checkout -b other HEAD^ &&
> @@ -41,6 +43,7 @@ test_expect_success 'read-tree does not resolve conten=
t merge' '
>  	cat >expect <<-\EOF &&
>  	file
>  	file2
> +	file3
>  	EOF
>  	git read-tree -i -m base ten two &&
>  	git diff-files --name-only --diff-filter=3DU >unmerged &&
> --
> 2.31.0
>
>
