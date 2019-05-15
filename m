Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8171F4B6
	for <e@80x24.org>; Wed, 15 May 2019 10:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfEOKjI (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 06:39:08 -0400
Received: from mout.gmx.net ([212.227.15.18]:57037 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725939AbfEOKjI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 06:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557916737;
        bh=tfl+UzUc8V+4NUda1lVsVBykkMXAR5cKu41Y3KS27H8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Wwf9c+OZ0raBB4uF4ELMqzAsLceA5m2nzWAbvLMm5GycH0b/e6VSLrhKfBmiRtlDP
         w5mFjEyr3GBTJ6DuBWoZ44qX1ZvZi+fCVtzJJGIP0Ru6vtAgKiIc1pebamYRrX2xP4
         52/28k772gwopNm84WPzzjaYN4hJMG3ScCbQxMiI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.171] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N8GQs-1geEsb31Ga-014DR4; Wed, 15
 May 2019 12:38:57 +0200
Date:   Wed, 15 May 2019 12:39:04 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: dscho@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] pkt-line: fix declaration of `set_packet_header()`
In-Reply-To: <xmqqa7fo8pdg.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1905151234370.44@tvgsbejvaqbjf.bet>
References: <pull.192.git.gitgitgadget@gmail.com> <a6bfec76c85bbe9187b536ff78252b82e30e20d3.1557787395.git.gitgitgadget@gmail.com> <xmqqo9469buw.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905141454510.44@tvgsbejvaqbjf.bet> <20190514144305.GA28530@sigill.intra.peff.net>
 <xmqqa7fo8pdg.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:jGRbaGGMrZWXUagvMhhtBvl5/ZMB8SO7NSJ4YdSkQf5gMYX6rk+
 u3srIbev/GoxQ0W9VuOzom5/RdhU8emJ3YdVjwTWwjPtazcydBA68H1AxW5f6xDsZ1x5V8y
 8htm/X5vKQH7agM2K8G4lCJ6SgOy5Qf1gZ6vZ5kAvQO1k24nEUg8x4eck2aPP+KYmmBAmjl
 9ZEphpi/8wuy0Jh9db+DQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DNT5jqavBkg=:zDLUzO9wP6JAxctkCz2OzX
 jxsrnFf2sy2ZjVuKQRRUx3WjQQPzx3LUUokzZ+ynkGvo9STwBYpfhj5e7txpBzK0iQV7dH2EZ
 iLMiSPrk7vOkUscR5VJIdKlvfXbXx4LRjLoM5BpuCwPyozWR7ziGR/9+kvPngJ75+W/gGAKEb
 fMWq7/7IVNbv6bUTOMcIyhjMDDpRQQhBGU9mnb3gtvEDO6Y7aPUlfgt3PqWpEZNvoB2HmRgwo
 YS7gauLFX2i6JFXDkooRNnCQW+nG1B0eCPhTcgJXOFJLg4xjBl4del/L8lb3js5pOO9rMQSQ1
 LPIzW3//PJQpd2IdQM3ewrqtWrJlDZmmHatFM/6F64tkF2Wu6B0/Im+iQ31Z9Ek4TcDQMw6nH
 jE05nsAe7g9hdvAseutK9IL3KhbXPFLPzjk+hC7f2xPJFUOFEsHNDZCHD4296vtIyKKmTO3yJ
 tnw7iF0FdxYAk0w5GateoRSmU++m7qWxom8vj9NFtFDBWnvhH8aFRRF9ZJBW5d4XSS06OFYA8
 hqhAeGaX9q6rhdMqRa0JFB0EZOwYGuFfViti3uK6dRqSjb6i6gYCXv7Mg0aOAZT65QiEvdW63
 OtweKd/TlYfDY52O8LT9EOs6dNN7xIOCqTaiUmS7pIPKSZCB9nu05k0XDwHraTgZtu5V8QDeO
 c8eyIw4r49yFFuIgx7H+Wks8VsVYXQ4nCuRgZdZZM29/GZGTBW1jFREzmFAuUb9/tc1e3Uyt7
 UxQzCPiiwJ1EqJUAWuT1JYUwKvZZmRs52c0Zr3tVUjex0C7MPNZBtbHvoRnFsdVXE6GvMcN7I
 sIagMYXInY7jbTv5u0n5inhvgsHFuxAuZgBtewyuNoFisth35yeoip9pSV7jLL5HG8A/qGYyU
 lU7OgoUpuYWSgsmXmHYpcqPrgxCXC/7Wuy72DO1578zTv9RVe9qqQWc0FzCBBd+BPeZMu3q4n
 0tAEGLJ7VYw==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 15 May 2019, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
> > I do have a slight preference for going the _other_ way. There is no
> > need to mark the parameter as const in the definition. It is passed by
> > value, so nobody except the function body cares either way. And we hav=
e
> > many function bodies where value-passed parameters (or local variables=
!)
> > are not marked as const, even though they are only assigned to once.
>
> That would be more like this patch, then?

I can live very well with this patch.

Just two minor comments:

> -- >8 --
> Subject: pkt-line: drop 'const'-ness of a param to set_packet_header()
>
> The fact that the incoming parameter is used as read-only in the
> fuction is an implementation detail that the callers should not have
> to know, and the prototype defined for the function in pkt-line.h
> lacked the "const" for that reason, but apparently some compilers
> complain about the parameter type mismatch.

We could be more explicit, as we know exactly that it is MS Visual C 2017
that is complaining.

> Let's squelch it by removing the "const" that is pointless for a
> small function like this, which would not help optimizing compilers

It is not pointless because of the size of the function, but because `int`
is already a type that is always passed by value, never by reference.

If at all, it would make a difference if the function was inlined, so I
would argue that it would be pointless for large functions.

But both aspects are moot and more philosophical than anything else in
this context.

Thanks,
Dscho

> nor reading humans that much.
>
> Noticed-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  pkt-line.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/pkt-line.c b/pkt-line.c
> index c9ed780d0b..a0e87b1e81 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -119,7 +119,7 @@ void packet_buf_delim(struct strbuf *buf)
>  	strbuf_add(buf, "0001", 4);
>  }
>
> -void set_packet_header(char *buf, const int size)
> +void set_packet_header(char *buf, int size)
>  {
>  	static char hexchar[] =3D "0123456789abcdef";
>
>
