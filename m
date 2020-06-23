Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B582DC433DF
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9130520780
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 15:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Z58SgFMh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732946AbgFWPRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:17:16 -0400
Received: from mout.gmx.net ([212.227.15.18]:41297 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732902AbgFWPRQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 11:17:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1592925432;
        bh=caxygGslm0uzTSEwaJZF3uyJN4vf0EYBYwLwD/48Apk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Z58SgFMh2CaO0fJSSgnC1NhifZjpAls0ber1J76Meb5ZcRZSADBVAId4bD5qScP0C
         sauvQzk67YK2Y0Lo8qkEvD8wdCovRsKAVIP67wWs0PcH2FByXpFBXCw6KAI7G6UIy0
         9hUo3xllwah6vgqT08K/WzvyZwdH9Lj5YnM7fcuo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.227.237] ([89.1.212.7]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mirna-1jBMyq1AUm-00ewFI; Tue, 23
 Jun 2020 17:17:12 +0200
Date:   Tue, 23 Jun 2020 17:17:12 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff-files: treat "i-t-a" files as "not-in-index"
In-Reply-To: <20200620163845.871-1-shrinidhi.kaushik@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006231714450.54@tvgsbejvaqbjf.bet>
References: <20200611161640.52156-1-shrinidhi.kaushik@gmail.com> <20200620163845.871-1-shrinidhi.kaushik@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:V/tnJecgbH2G4jujTUMowTN7QOlEqkgJUxpAo+NxxnHhX1lSizu
 bjg+sYjcbtynH/yJU9Y5Jb5Fk2ZNNSpl55uNLgNEoN8Hj4mSqwMEqjXJnGHoNGPwJrBQsPm
 shW+S3xk2HhJy0pwyrY2sO68MYNtTaBtAykbIpmAUq3eVW3xU2lINmFc6WM9f67Sb8KvFnC
 Lh3Et/SZgsC1v+wL3mwhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oe6OSFmH3oo=:AJqWMqdF9GLnBYhq3P2/B7
 p22pl4TVuUwM15Y/yl+Vm7Yd22vV0LF01KteypYTpSTWdKoJ+OoQTdkIO6ifZIbrcEJeKoFc+
 80lGOxRISWv6Gbb5vvi9f2KW4Nwe3u6LeEoTZN0z4W3yp944NVmmmU8gej2afs2+974p1XFLc
 WRy9iD9oB/W7RlvFf5BF1EY3SDb5pkmuK1iepbTCi0zFoCOvmGT2uDJ86M+QpH+jntb2usuNp
 5fPsTGzwlW7zBq5vFh2dcLBFISK0xSaqKlhbaeabqZ97qgyrKQtPn4UK08kxz3VXwxymJAZdr
 Bi/lowBk5GccRB3HO+i1IAPD1Znzp78dHhRPZIYEJEPAVPeNCZM9HupVmIPexeZXz8hrgjibA
 NbUa37sA6FN2ezt7Ak/BaCK/7nElWRsIBMtDIsCartnUUIQXjRgL0hH0HVK8M0wl+gliFWEJ9
 gTfk4V796Vj92WPh6s8ZOKmVga0KAzIZLpcKtrByTlzgUgQSMwfQF4vGP9ye3JAPAiwEkXQgb
 zIzaP8jDOsMW4HRF/me48o89XEjljrW1+IaUwnqIyDDhHF1/XYv1RlQEUjihDzM3RTOyZEN1D
 6impP99+toW8SxLh0eAW+Z7ePFREf7LorAf2XNEJMeZNWsSvp9MN/7Agg9HueQEg9qxb28maN
 NMqN1PaOTQq/ejsXl/G6hRVNzCSxc2I2DUK3pQ5Abo+KwNJQvW97qVLsp5LM4vrTi5o1Eukpj
 R2zuDVCF97bVrCKlSgi8aKFFcxU5r7XyEies4b72rlIEMMBmOmCqmZ2Vmc4Cy2U8pC+KUcxoB
 n85DklKhyJRx6z63aMOGAJrLIucl75RK8eAPBkxcYVMBSddFTyOf16kddpQV7vIeYBnxVy9Td
 6I8rBcoC16gT/G3r0Iv0o5kZjPAkzSMM2UJRHnFhwqp7XnPMnQgiDSZFXlv0Z20ag4rTYTelv
 icWhpCTgE484zl0k1Mc/N9VmhWunctN277u7fLnZcaEb3/AiT3691zDvsdH3xLPYb/NoZba50
 uL6yUtxq6PIVMuq3neeZvSBp/SeQr8J/rbY0zpC/XJlq+xWRiSmtK7oGPMEcI5GdfqM8rqWIt
 q/Ls+7UD5d3AkBhe0khGNsz0/wI5F5+Ks0/vtTdYSvIWJHYhmC4zVg7YpTbIaGRiNjNONZDTH
 EXimi5B4cfGskbq/HDNmEpGk2x4le1duFcA+fKqwfFaPKU012PimK56FKVbRy6gGJ4imWDQc3
 /cb8OuZfAZK6t291o
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Srinidhi,

On Sat, 20 Jun 2020, Srinidhi Kaushik wrote:

> diff --git a/t/t2203-add-intent.sh b/t/t2203-add-intent.sh
> index 5bbe8dcce4..8a5d55054f 100755
> --- a/t/t2203-add-intent.sh
> +++ b/t/t2203-add-intent.sh
> @@ -232,17 +232,54 @@ test_expect_success 'double rename detection in st=
atus' '
>  	)
>  '
>
> -test_expect_success 'diff-files/diff-cached shows ita as new/not-new fi=
les' '
> +test_expect_success 'i-t-a files shown as new for "diff", "diff-files";=
 not-new for "diff --cached"' '
>  	git reset --hard &&
> -	echo new >new-ita &&
> -	git add -N new-ita &&
> +	: >empty &&
> +	content=3D"foo" &&
> +	echo "$content" >not-empty &&
> +
> +	hash_e=3D$(git hash-object empty) &&
> +	hash_n=3D$(git hash-object not-empty) &&
> +	hash_t=3D$(git hash-object -t tree /dev/null) &&

So this is the hash of the empty tree object, and...

> +
> +	cat >expect.diff_p <<-EOF &&
> +	diff --git a/empty b/empty
> +	new file mode 100644
> +	index 0000000..$(git rev-parse --short $hash_e)
> +	diff --git a/not-empty b/not-empty
> +	new file mode 100644
> +	index 0000000..$(git rev-parse --short $hash_n)
> +	--- /dev/null
> +	+++ b/not-empty
> +	@@ -0,0 +1 @@
> +	+$content
> +	EOF
> +	cat >expect.diff_s <<-EOF &&
> +	 create mode 100644 empty
> +	 create mode 100644 not-empty
> +	EOF
> +	cat >expect.diff_a <<-EOF &&
> +	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t"=
)empty
> +	:000000 100644 0000000 $(git rev-parse --short $hash_t) A$(printf "\t"=
)not-empty

... here we expect `git diff --raw` to claim that the contents of `empty`
and of `non-empty` are actually the empty tree.

The underlying problem is that some time ago, the (already incorrect)
empty blob constant was replaced by the empty tree constant, by mistake. I
contributed a patch series to fix that, and Cc:ed you you in v2 that I
sent out earlier today.

It would be helpful if you reviewed it carefully, as you are already
familiar with the code in question.

Thank you,
Johannes

> +	EOF
> +
> +	git add -N empty not-empty &&
> +
> +	git diff >actual &&
> +	test_cmp expect.diff_p actual &&
> +
>  	git diff --summary >actual &&
> -	echo " create mode 100644 new-ita" >expected &&
> -	test_cmp expected actual &&
> -	git diff --cached --summary >actual2 &&
> -	test_must_be_empty actual2
> -'
> +	test_cmp expect.diff_s actual &&
> +
> +	git diff-files -p >actual &&
> +	test_cmp expect.diff_p actual &&
>
> +	git diff-files --abbrev >actual &&
> +	test_cmp expect.diff_a actual &&
> +
> +	git diff --cached >actual &&
> +	test_must_be_empty actual
> +'
>
>  test_expect_success '"diff HEAD" includes ita as new files' '
>  	git reset --hard &&
> --
> 2.27.0
>
>
