Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 047E41F461
	for <e@80x24.org>; Wed, 28 Aug 2019 11:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfH1LbE (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 07:31:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:56105 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726253AbfH1LbE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 07:31:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1566991854;
        bh=bbRYed7RfK4ZCK1mg7kMoI814TJ1+3WiVmKI8fUZGI8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PDN1hRW0h1AuiVgztvWI81jVpexLwRdHYWCJBdK+zE15FP9mCMlCkX/Nyt9cI7w6w
         5fnDMYJg+54yflvnKW1CeMvdIhqiTrDTNA5mQdvbxKkZYmfYr4Gs14WPA0c2vgweEz
         RYJXLveBnY5oSEc+ZPK2o2IrH5jd/sDQDFKIiMPo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lev1D-1iYgXS3ZHj-00qkDL; Wed, 28
 Aug 2019 13:30:53 +0200
Date:   Wed, 28 Aug 2019 13:30:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v5 2/2] am: reload .gitattributes after patching it
In-Reply-To: <20190825233340.10894-3-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.1908281327180.46@tvgsbejvaqbjf.bet>
References: <20190825233340.10894-1-sandals@crustytoothpaste.net> <20190825233340.10894-3-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:shgHIRNaOMdvfMFxM0oscmloI0Y1An4GjJRPc0lA5bY8rMuaA/K
 3srB4YLyAq8PX5H4+7N88RDzjCU9iVhJubvu/HC0jF4xKHZkuIU+Aef5jDl1aF2YqLjeFxF
 nH8Npoi/EopNy/mtwKkBn96C/FvkkJsMvK9cKZ46myh09p+/VL4MWYPYNehyghKwbQZqtnA
 nSHTiZ39yWAN6pAqNZo3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DellbslUf4M=:t/kvghdv4vDnsUFWs1r+cw
 JVC7V2olcZCQ+XiWqeBBZC/HxEzUh+jmuUwC6JF4tpHYuIla8WIa2RPqxcDMLWygoF//2ioi/
 I1gevPi4nvKT/19jJ7361mGn0U+HuYkxK+NT7xVaNqwzd+o9wEPaYXtaAVyCY8gs4pbIFgC8t
 glX7IQQRZfHDHBIsaOxfzHxZ0+U90SXfS6zW+YMyXR001+hzbgyWnNOSOmyMHQ2eKKZ9xSaz0
 G9JC6K0v6HerZi6C/rFVP9rvOSMz84OqobO8/dCoL89efQwy7oplENw5Z25Y89fRT0vPTa5n6
 iM9qZ7NJDho3W34FejwasA0WkC4D/RmXHAjsP4pxqAu2Z73yPXXnyPIcTbREFXZAVjnOEu/SG
 UJc+hDVKeZN5o1iq3Mtwml2uAO5dbugQRadlnc+81PWE+D1Q7F/xwJxJP7+S5IKbc6xIBRCU2
 EIPnLwqvuPzFUUPdk0kufN5NKhUZdV6ioT5qMcb9MoZtUbJujeKE4A8kR1kqqwn92yN6/+uqF
 37pcLY5YuKJ3YZPhsA+QW3whot5bxiGYDXmNoyp8hrw9tazhuH7f2je2YGgYxpw62UcpLexwo
 4PbAag0I6L+mJGq0jfsgsn+cmKSTjCRHu/qNK0goFQYL808qQ05QFpIZJnzqgwP9g2w7+X4/S
 OZz3PS+YRD9Q3tO/H17kec5zfOlyvCcc2lai9eWm1niv6tbjB8LMA0ywMGLKRgONdiYlp+nM1
 DBiZz54gL7+yfJFyCOkJTU/IasYhgRlq8yT4PemArX4zShLFR4tMjvAkPxOZHtiFtu2CEwx1Z
 4sj/JKl+OG28zEhgjYxfHtrabiy4ev5NJfyzkc9n2g3snNrFDpn9v3zV/qW94T8L9hm+C0MTl
 sS3ZSYUGKnQEadLIAYgg/uXXuhpDgG0VziGj7mb3jHqep35js798QSM+oj4aXu7FUfMjX3bBe
 nSPPhMn3plsMnFGiQ/ar6swLMDfYkQaopNNrTGuv15FTPTVSTJ7nbiHmC9isOpluRC/uAekXM
 KwVDXkc+to17JH9EhFSfKY1f1VJya0yyUrpItZAER2NtSndF/eoY3ocF/VXCrR3NW+fYhgq6w
 wXRw2pGlpQ/YsK+2mhP9NjkjMqy7JPr/aorG8Cl1lXw427vU/QX+dpWfJJY8MBInH1eVHOkSo
 Tq7Wc8WHEFbM0agrXySNSD7Z5AtTYdWkmAXevSiZ+Wa0UdVQRsC9OA2T8STm3vvZIE1YA=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

[chiming in from the peanut gallery; if my comments don't make any
sense, please do feel free to completely ignore me.]

On Sun, 25 Aug 2019, brian m. carlson wrote:

> diff --git a/convert.c b/convert.c
> index 94ff837649..0e6e9d2d75 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -8,6 +8,7 @@
>  #include "pkt-line.h"
>  #include "sub-process.h"
>  #include "utf8.h"
> +#include "ll-merge.h"
>
>  /*
>   * convert.c - convert a file when checking it out and checking it in.
> @@ -1293,10 +1294,11 @@ struct conv_attrs {
>  	const char *working_tree_encoding; /* Supported encoding or default en=
coding if NULL */
>  };
>
> +static struct attr_check *check;
> +
>  static void convert_attrs(const struct index_state *istate,
>  			  struct conv_attrs *ca, const char *path)
>  {
> -	static struct attr_check *check;
>  	struct attr_check_item *ccheck =3D NULL;
>
>  	if (!check) {

After this line:

                check =3D attr_check_initl("crlf", "ident", "filter",
				"eol", "text", "working-tree-encoding",
				NULL);
		user_convert_tail =3D &user_convert;
		git_config(read_convert_config, NULL);
	}

I am a bit worried about `user_convert`: it seems never to be re-set.

Also, how thread-safe do we need `reset_parsed_attributes()` to be?

Ciao,
Dscho
