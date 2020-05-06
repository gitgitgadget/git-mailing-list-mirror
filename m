Return-Path: <SRS0=4z2X=6U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFA3C28CBC
	for <git@archiver.kernel.org>; Wed,  6 May 2020 12:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 660A42073A
	for <git@archiver.kernel.org>; Wed,  6 May 2020 12:54:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lxfXOSGB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728650AbgEFMys (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 May 2020 08:54:48 -0400
Received: from mout.gmx.net ([212.227.17.21]:45555 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728081AbgEFMys (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 May 2020 08:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1588769681;
        bh=aCoys6phG0WVncgQcI1Ca6ZF6G7KkO11J9fdnA3uBN4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=lxfXOSGBcGlGyPDvCZIDmDWbDuUmw937S9IYnxO1R5SnIF9awM1e9UvgQvyBr6ikw
         QOQLXNKluEnPzfORmt2PGmh8UOWX+I/2SBgufnzV1wQ0AkA97vg+fCr2/PilF3BcC5
         /zT/IbQ3PKhCtbzS7PNBSLfoshNU6zS/CW8yPZ/g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.30.84.97] ([89.1.213.224]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McpNy-1iwQWR0lFa-00Zy2M; Wed, 06
 May 2020 14:54:41 +0200
Date:   Wed, 6 May 2020 14:54:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n?= <carenas@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Danh Doan <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v5 10/12] tests: when run in Bash, annotate test failures
 with file name/line number
In-Reply-To: <20200506073045.GA52959@Carlos-MBP>
Message-ID: <nycvar.QRO.7.76.6.2005061447010.56@tvgsbejvaqbjf.bet>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586538752.git.congdanhqx@gmail.com> <ce0038598704e03becc65731a71abf596bdfbe98.1586538752.git.congdanhqx@gmail.com> <20200504174636.GG86805@Carlos-MBP> <20200504232511.GB29599@danh.dev>
 <xmqqlfm7cj7s.fsf@gitster.c.googlers.com> <20200506073045.GA52959@Carlos-MBP>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-645252486-1588769681=:56"
X-Provags-ID: V03:K1:sds14wmH5im3qjCRqztz1wN7NJ1ToiXj1dXr/y9/svTPrRDS+FO
 EvrVvintKjq2sh+M7w0DMQmg+gf/BZsbs/FPBq/ShJUQKXB732C49gLYyel+hMNc1nqLwQW
 2Y391GnKFJyJVEBHMkVlRIdVfRnqufNvPr7yyx012gF4lvq4EirNX1/o28vPZ6m2bPhFRlZ
 4uHwLqtiEPETFwjtSmwWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Uvr5UFtlxR0=:xi+SXeMHT0qcAGI/c7rkqq
 P/hYcvbtIGFOZZ9JwYwA64DapPZ2FI1fFpKaWlUi52Zj07HXdrjRPdcsmXAQTRt3HhG/9JvdN
 waHH+AUGbXBLrV10RWxsN8ywJKfARPq9zWhYtcsKS4tmrhoswtH6Gu8ka2jkRTcXz6YLUtn9s
 JManRVLsHU4tmQf9NpRNoqwhksUVWtl5NWFqRhM/gY+4FhFKN8YO8AkksvRBRKg3V37iLgRXe
 jxrK1bzs66ZmgcshubnnhwyUO/uznmFAZkeYH5zmHJAVWocurvMZ6wJ/Sxq3Ih4fiAPpxnBcO
 vzOnviBGQE06EFYtZA1fmEcdkOos68z/Kpgmg7pfmFD6+2BXWTY+7EOhAPCpRtAynQxaLJeyU
 UCsWqYXkZUcxWVjnjMhys3uLhq8h9v5tXokPr/bLNuu9eUq6G2i46YbkRjIOhSZ7v/12ydw8a
 D843WnlJpxYgVprQzS6U10uN3ON1AGpuSMyGrWrommNdMVEjVih9ayrgLT1tPUIwynfJXjvJ3
 N1Li6/mTMQcVmdNG607fNVZbtJ/y19unsfo6pLJTdTsC9+lQ3mvzwE0q+Cc40D6m11GDq4/OM
 Il1657DKLtF9CxdPb7iBwhXc5rLgJ+/8/f1v1Jyyp6tibMZ07p21/xK8gSKmHh5eeBOmHZtHN
 pNAA5Aw/L/TsY7f0vpDdOFQ9Y6oN21IaUfQ3qDES1SgYAnDwoj4zPjZ7NyaL/t14qMbELGcYp
 kKZai+HaSbmNtQREshwtoYAj7zYorY6tvxR04GAN5iwhBeEll65+6ziBTxbRRO+fCfbFy7Mk4
 lXSnbjf/WDfOEJkIFrN/0QCX2nxbp2hJv7Inxk6M2p9RbK5EF/JIa20sAP4naW6bKGyH7BJ4B
 25XYFfbRmkOaCrdLlmcIv6PJPy8ga6KgvYJmDDtzIgO1jObMksrOrsNZD2h9pqo0u/Kh7sNXs
 4nRyN8IpOaGCNNhhBC+DaiItdv/oCh4cATmpg3GLBSbldJx7Uw7qGw3iyfKed3+sm71y8Ws5A
 UutnA/NCQcI4Clf1rDPM9QXuvss/dkA/gloOAABL3iyvR7pke+RTWR744mWmwf3PGvBfTC7W5
 yvGg2EVMWF88xWS6WljNK1K7O/mc6s8us4m5wMhVDfa8DMNT2ie3mN4aX2DHSZcuRv0irwRz+
 MO8r9q7x8mmspAWBKi6esidIctf5iCXHRkRn21lev7mfy0lWi/rsH0RojXx1c53FpZlMyTQua
 QLCm6KOz7eUxI2NIZ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-645252486-1588769681=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Carlo,

On Wed, 6 May 2020, Carlo Marcelo Arenas Bel=C3=B3n wrote:

> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 1b221951a8..a8f8e4106b 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -676,15 +676,9 @@ die () {
>  }
>
>  file_lineno () {
> -	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" && test -n "$BASH" || return 0
> -	local i
> -	for i in ${!BASH_SOURCE[*]}
> -	do
> -		case $i,"${BASH_SOURCE[$i]##*/}" in
> -		0,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:$LINENO: ${1+$1: }"; return;=
;
> -		*,t[0-9]*.sh) echo "t/${BASH_SOURCE[$i]}:${BASH_LINENO[$(($i-1))]}: $=
{1+$1: }"; return;;
> -		esac
> -	done
> +	test -z "$GIT_TEST_FRAMEWORK_SELFTEST" || return 0
> +
> +	echo "$0:$LINENO: ${1+$1: }"

That suppresses the error all right.

Unfortunately, it completely breaks the feature. At that point, `$LINENO`
is either unset (e.g. in `dash`) or it contains the number of the line
_containing the `echo`. That is totally useless information at this point,
we want the line number of the caller.

Try this, for example:

```
#!/bin/sh

file_lineno () {
	echo "$0:$LINENO: hello"
}

file_lineno
```

When you run this, it will print `4`. What we want is `7`.

Even worse, as `$0` does _not_ contain `test-lib.sh` at this point, the
printed information is totally bogus.

So we will have to use that `eval` unless we find a better solution.

Ciao,
Dscho

--8323328-645252486-1588769681=:56--
