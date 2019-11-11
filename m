Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 921631F454
	for <e@80x24.org>; Mon, 11 Nov 2019 18:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbfKKS1G (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 13:27:06 -0500
Received: from mout.gmx.net ([212.227.15.15]:49013 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726821AbfKKS1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 13:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573496815;
        bh=XFwSZrt/mXOxbwDHm6AaxI9muxv7CknKw0yyjb/M/30=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dD9CNoiva1FJqGXqcVjQN2AwT5lssmraEr7h87Yj59g8SCBtb1vHNKC/NMDXAa/Wz
         8o7M3FX4edPpC2WHoNFyIFl4sFdMl6pRD9ZgrBe+nIJwhNQxFUV/aui3IJN0iQqwe1
         kGieXI+Nslw/i6AzHr22h3mM8VFmemC6Z02RO1uw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxDkw-1hfagp1fwm-00xYQR; Mon, 11
 Nov 2019 19:26:55 +0100
Date:   Mon, 11 Nov 2019 19:26:39 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Doan Tran Cong Danh <congdanhqx@gmail.com>
cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: Re: [PATCH v6 9/9] sequencer: fallback to sane label in making rebase
 todo list
In-Reply-To: <78daf050de8c0cdc81fed4adc8fef92d1768c63a.1573452046.git.congdanhqx@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911111923060.46@tvgsbejvaqbjf.bet>
References: <20191031092618.29073-1-congdanhqx@gmail.com> <cover.1573452046.git.congdanhqx@gmail.com> <78daf050de8c0cdc81fed4adc8fef92d1768c63a.1573452046.git.congdanhqx@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hJSnMHPyVHvuZuiaEp4s2p+SmYVTnKHNgMF0fU/eR/2Ustvk5W4
 fBUCpY5ylOUP1s+R3aCnDiK8XVJ9V37svslll5/V8il0f1pBlAcq8AXm9w5bdC71VcwRwwS
 DVkvxOCL/DUerRjK21Mg3eVffHqO2443XF03soaYF/WF7geTQeuOPkQo86oVtBZNN2e+7zk
 HHkXVrzrMTGWI9IAwEbNw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pUJyqKKE4lg=:aiILWzzAYfyY9RSmqAazsC
 aY7Ya7AxNJ3/50rt5nweSutIZdEp8UpSakLJWweaPAHq8zjTakKJlI7LQHfoMlsuSUQi/+N7N
 6JPWbxaLPkujW5EWjuc0L4sj2/j2Ae1fyawBfKxzOUmZWByRCQKnj9t3HXTbYxi3Uesno6rPd
 gW6T54NdaNJVgZE/88/oZ1LjJPNh6NS+hddnmn5rci9K7ZrAmsHCcOUI7+GkrV03i4YMFGIVI
 W95yZ2nVG42of+92b1sQMOpZ6s4erEtfyljDPB9T/mj2JNfmSCRedg43YS8HI/bGIhVB9mAkw
 pG6ohSxwGD7i8Spg6kZEjJQPg8+SDGE2CLiwY2LyLuPGjl690CybYcUWasn8hc4SXDOBkx+Dx
 X9Jto0Eo10GoK2r5ZjmS9JJalGN7RV7n9/yqQKYxUrcqY3rdkCWC+v6G1dubmOpzPsbswvQcF
 UpzGBGbuKqyt6hD7yJLkJn/ucFzn9pcpvQRzIcJmwKqn3F0CLOMcW1qEMAE+FeUyBAEgkGg9W
 i7GY/xhKDCAeuvGTCq8bmV86rWzCjodl5HcQvEi/M0lOmkDj/BDpjWjcLSn6+80d/buZZRErT
 TWcF1WixPcXK9zF+3jZoBFdO3lXsFlnF+n4/5NZQz9cckz3HB0TcVYj7NOP1W9CayzEIEjktv
 bTGF3cq50WEhvCUepoeLj77Aoqh46LbkDxsnpj8fHtLbcQM/LQQYVAUTdxrhivEM4zTWEgqZW
 86IGVwbvh0AnejdngtGjjCxi8e7zwCxC9/CbMaK4Qu6krFJ4sE0gorUbx5U43KKadrBkEKYM/
 lkzFjPggr26cXNWqDFNV1Et5e92YmlRpsCnDCAg7pfHxUDB/Bavxm51oO2yg1MVKq3+fSc8Ow
 ZdZsE6csMDZLmP4GUZ99nms/PXLf8dFc2R7MSJzpYtotjA5V8j6Oa+5Nxac0CTjvhmFOZK8Al
 RljKMkZZGLc8QGc7pFS3SccXiI8VuMXriUIsAZcgryujAHDQQDGMdRsX8onVu/lmcMtqZspYF
 5wReFKLNYzEif+AhNzRe1s5uJaAH3Pgc/ByTnLTnYOiJy2L/9oc+gn2C6IvExPjmplKI02SPW
 F+R9WqrUbbxiPZdONjsmeJwDHVyCulesXC0ipAl5LP+WcmDL5irhYtvv0Qz32K+G8i4CFKliR
 FsPDNKeLtaVIYFRO2koirUoo74a+rUocDt2Xdwi6IGX3UyhsR36R2MMbXR8WtgNmX9ZKXLd+w
 kNoawPp7nd+Md/YIXaqeJwCMZQmMt7h3+riQOMJ2o7YHDFusQXdZyx6QvXnQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 11 Nov 2019, Doan Tran Cong Danh wrote:

> In later stage of rebasing, we will make a ref in
> refs/rewritten/<label>, this label is extracted from the subject of
> current merge commit.
>
> If that subject has forbidden character for refname, git couldn't create
> the rewritten ref. One such case is the merge commit subject has
> a multibyte character encoded in ISO-2022-JP.
>
> Provide a sane fallback in order to help git-rebase works in such case
>
> Signed-off-by: Doan Tran Cong Danh <congdanhqx@gmail.com>
> ---

There was an alternative patch under discussion, one that also addressed
problem like e.g. characters that are illegal in Windows file names:
https://github.com/gitgitgadget/git/pull/327

Unfortunately, the reviews asked for an extensive revision for which I hav=
e
not been able to find the time to implement them.

Having said that, I think that the solution proposed over there is more
complete, and maybe even more robust (nothing in your patch prevents
`label-<hex-oid>` to _already_ having been taken by another label).

Ciao,
Dscho

>  sequencer.c            | 11 +++++++++--
>  t/t3434-rebase-i18n.sh |  2 +-
>  2 files changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/sequencer.c b/sequencer.c
> index 2f32b44f52..f664ba727e 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4560,6 +4560,7 @@ static int make_script_with_merges(struct pretty_p=
rint_context *pp,
>  	while ((commit =3D get_revision(revs))) {
>  		struct commit_list *to_merge;
>  		const char *p1, *p2;
> +		const char *hex_oid;
>  		struct object_id *oid;
>  		int is_empty;
>
> @@ -4607,9 +4608,15 @@ static int make_script_with_merges(struct pretty_=
print_context *pp,
>  			if (isspace(*p1))
>  				*(char *)p1 =3D '-';
>
> +		hex_oid =3D oid_to_hex(&commit->object.oid);
> +
> +		if (check_refname_format(label.buf, REFNAME_ALLOW_ONELEVEL) < 0) {
> +			strbuf_reset(&label);
> +			strbuf_addf(&label, "label-%s", hex_oid);
> +		}
> +
>  		strbuf_reset(&buf);
> -		strbuf_addf(&buf, "%s -C %s",
> -			    cmd_merge, oid_to_hex(&commit->object.oid));
> +		strbuf_addf(&buf, "%s -C %s", cmd_merge, hex_oid);
>
>  		/* label the tips of merged branches */
>  		for (; to_merge; to_merge =3D to_merge->next) {
> diff --git a/t/t3434-rebase-i18n.sh b/t/t3434-rebase-i18n.sh
> index 4b5b128cd6..c7c835cde9 100755
> --- a/t/t3434-rebase-i18n.sh
> +++ b/t/t3434-rebase-i18n.sh
> @@ -45,7 +45,7 @@ test_expect_success 'rebase --rebase-merges update enc=
oding eucJP to UTF-8' '
>  	compare_msg eucJP.txt eucJP UTF-8
>  '
>
> -test_expect_failure 'rebase --rebase-merges update encoding eucJP to IS=
O-2022-JP' '
> +test_expect_success 'rebase --rebase-merges update encoding eucJP to IS=
O-2022-JP' '
>  	git switch -c merge-eucJP-ISO-2022-JP first &&
>  	git config i18n.commitencoding eucJP &&
>  	git merge -F "$TEST_DIRECTORY/t3434/eucJP.txt" second &&
> --
> 2.24.0.164.g78daf050de.dirty
>
>
