Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29861C433F5
	for <git@archiver.kernel.org>; Tue, 24 May 2022 11:47:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbiEXLrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 07:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234317AbiEXLrI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 07:47:08 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A373422BCA
        for <git@vger.kernel.org>; Tue, 24 May 2022 04:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1653392807;
        bh=hrY/T975zZu8lQmjJS5fW71TqX3WM4VGPYRruPUtCWY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZU8OIgwVhcAiDPered3MSB+Hod6YCaIpSCU0eIcUMlyE2KmJ/PBYmfm//SnZpPKKI
         UGskkKVbyJ4/K058VA8e8o+zdZ06Z0VVGhGOVVXB/3POAXoKqCPoHTkybbrGN1j/QN
         DsHqvz72dd3NGN5VlbyjAlktQArqzLZc0xmE1lzg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.242.215] ([89.1.214.24]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mdeb5-1nKPA61eOP-00ZiLr; Tue, 24
 May 2022 13:46:47 +0200
Date:   Tue, 24 May 2022 13:46:43 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <derrickstolee@github.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, me@ttaylorr.com,
        avarab@gmail.com, christian.couder@gmail.com, jrnieder@gmail.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Robert Coup <robert.coup@koordinates.com>
Subject: Re: [PATCH] urlmatch: create fetch.credentialsInUrl config
In-Reply-To: <7495dac8-0241-ad56-59e3-100673c88c52@github.com>
Message-ID: <nycvar.QRO.7.76.6.2205241343390.352@tvgsbejvaqbjf.bet>
References: <pull.1237.git.1653329044940.gitgitgadget@gmail.com> <xmqqr14kqdag.fsf@gitster.g> <7495dac8-0241-ad56-59e3-100673c88c52@github.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:y1UBBSe0sfbhnQxEyaD1CqYEzSp/7kbNQa66KpzwYt4aLUdYDJG
 2xScpcx7JDP2Tt8PwyUZpGqmkbMPjTsXzGcNt9clwzncltxEne1sNoTL7LtJH5AsgngdcJC
 C9Ia69SdqAh9cBAWiO7c1ivQYCKX4g1TakvMAqCcJKx6bEmqwQKzZDIDirVzFk411i2+GNp
 kiP1qgMqIeqNwh6YNYaug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E7m8Ug/Kf8A=:Mp7dpkxKtitA25UlxYvB2q
 +ha3YUoU6FprCAHq31KKgXQXz799m35G/nYSQ8W2f4scmeeXZSfQshlom5Zqeap0CxW2IKnu8
 TFiBdZUzlh78NbIjM6+zqDb4Kl6l7K61kxkHwgj9MiYUxYM3QZvskr39VE4PTPdszkzPQC3QO
 S5+v0UAjpgs3GzoLxePWOfrK1LWlnYH8b4XQTtkTiHkQiNrMZ948TsL0Y+XTNeTsLpfO0aEc1
 kjhrRePzsp+TIglC4glT8TOzN8s3boQor7fJZVywYGHQgf5ZsBx29Ew8Xgot8iAfQj7zO0/94
 G95ej6a5BYsuD+FsfWeRkR1GLI5wecTsx/uWSR701HKDBRg1u74/L11051Cfvccz5Ym7+XjhG
 Mb8DVn9khiUVgw7MsihJTslqsf6+tVSf5UFzlgz6xGvnoCnJuEZNgfWJyK21Zf6FEtb2feNve
 hag6/g9ICzuo5bxtXWtQD7DFWcRfA+dJ+jNbJ1Dj3mPUP2h1xGNAjPheN0R9YSyio56WsDBzY
 q8g9oYjXMf2l5aLvf7ZL5o0gvOuHsa9cMV4tGOli5rqbaKi3d2G2c5KP4SiNCKnuCb3MpYevl
 nxt7viUn5K1HfgnYum6hi0oU9lWNdtsOEiGT++nJ2BTpAl1+UyUDFJHYqLGESed8HhE4GQumT
 Cp54HYh69jYWHs9O4z2/kqcX9da0LYnDHlfEljxTtwINcws0CIuiplQLd3+QRwLHWU8aaMxw7
 nBGfdprDtzIfrpt8fJlrVjyR34gGhqPbroH/rp6mnVG13l+q7Phj7mib3Ya2deXtDUDESrC/b
 cpkHG10+ALjvmHI9qNiDNnZN4zosgqyHdikBYZlXEKwQN6NFz5tCQNzufbxp94Ai5AEWn7Fys
 uRp6Wz5Pw6kgFueoRCc3aXMgP1RWKwgsC6MP+oegIPpF69pcmWpM40rxO3CM3jvaR0CbuO5BR
 tLwPQ8wSS7jVJeUUAo9JBnotsFSrqInetSpZSHwEW2PAt3dEylkP++KHU+U+n4zQ+QbSNLX3p
 +jk6dBDVPiLVT6vspVcG1vl1c7W12VjwVrbatONIhRb/01y1r2h+IkSAKyAzNl8LOloJIvbDk
 oQiEwS2LXkPTHkwO70FpfswhflpM6TE/BuHLgBQ+oIKwIPhihjcciofeQ==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 23 May 2022, Derrick Stolee wrote:

> On 5/23/2022 3:06 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> >
> >> +static void detected_credentials_in_url(const char *url, size_t sche=
me_len)
> >> +{
> >> +	char *value =3D NULL;
> >> +	const char *at_ptr;
> >> +	const char *colon_ptr;
> >> +	struct strbuf anonymized =3D STRBUF_INIT;
> >> +
> >> +	/* "ignore" is the default behavior. */
> >> +	if (git_config_get_string("fetch.credentialsinurl", &value) ||
> >> +	    !strcasecmp("ignore", value))
> >> +		goto cleanup;
> >> +
> >> +	at_ptr =3D strchr(url, '@');
> >> +	colon_ptr =3D strchr(url + scheme_len + 3, ':');
> >
> > We expect that at_ptr would come after colon_ptr (i.e. in
> > "scheme://<u>:<p>@host", no @ exists in <u> or <p> part) and the
> > while() loop below assumes that for redacting.

Careful here. https://me@there.com:9999/ _is_ a valid URL, too.

> > Are we better off if we assert it here, or has the calling parser
> > already rejected such cases?
>
> This computation of at_ptr matches the one in url_normalize_1(),
> so it at least agrees about where the "username[:password]" section
> could be. That does mean that the password cannot contain an "@"
> symbol (unless it is special-cased somehow?).

The password cannot contain a literal `@`, and neither can the user name.
They have to be URL-encoded, via `%40`.

Ciao,
Dscho
