Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A4AE1F404
	for <e@80x24.org>; Fri, 24 Aug 2018 16:04:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbeHXTjr (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Aug 2018 15:39:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:60993 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726504AbeHXTjq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Aug 2018 15:39:46 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0M4Wwq-1fjXqt31Se-00yems; Fri, 24
 Aug 2018 18:04:23 +0200
Date:   Fri, 24 Aug 2018 18:04:22 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Pratik Karki <predatoramigo@gmail.com>
cc:     git@vger.kernel.org, christian.couder@gmail.com,
        sbeller@google.com, alban.gruin@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 07/18] builtin rebase: support `keep-empty` option
In-Reply-To: <20180808152140.14585-8-predatoramigo@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808241803100.73@tvgsbejvaqbjf.bet>
References: <20180808152140.14585-1-predatoramigo@gmail.com> <20180808152140.14585-8-predatoramigo@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tWvvFMDmd8FRnBGr+J2aUQ+hHSNaAZ4X8Tb5KH5ZebJ8OZTCRB1
 AYKgG6q/HUHG2Uey+4j1KJ2NOHW5WW4iVinrLDCqEQuLPSkbXFa02MP3Xnc2LJpfli4AwtX
 T8TO//FFNMK2Yc0CSxVQy4IkZFzNCa/yhWJ9Cb93PQyX5d+DFgBjXNdpS6Z4Z/ASM5a+q0Q
 n82ulIu3XU/1hNRwsby2Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:SR77i7KOmG0=:QNCSDfW6GQ3I+8CTVfrYlr
 Q7A9IV6igpVdJGwfY5YqRfyriJLqxW2YeDWIisMi5XUgHcz+Q2S3xseF00VYO8PVS4Fq4P1Bs
 h9qp9TGmGVw+cX6+ElQY1Xd+4v+td8BmY1yMv9gDv0qbYD438JY/1gg7ARg8ba7hJlnNIc28M
 Yj71Y5a0fcIOBpDRksfN6YqZ7jNAeStD7XpCZs8cwNSXB8fH92z0LV/fj3/7iVE7fDcWFARPj
 bRUqeCRgROQ0yY2bBkbCYId0LCzsWMu2z5QPpS1GEWB2npZx+yu3zX5AmD6YpuQeXGHdSvKV1
 91g9zb1Kr1Kby55cqls3SVd+2PIRqONVodSIugH5h11/5QIkZY08KTxeu3zf0jTTN62Cmqbvu
 N/iwhPTUl4giY2RZ+Q4Z5LMtEs12dQ8zPA3iX+P27TJTeJ2MdrWgGDj9uTkiS98GJ3chx0b2R
 NKMO2A7F+xMEt/MawYBI2tE5FDkLtgqJH6FZ38PccDb4hL5O9L0gwgEpEexYiUYARxY3uG/mc
 Q16z6nmgMCh7hREEn1LXyA+q89vmcJvhAg7rOQxpt66zUzgXKg6wj+PZemg8plls/zjFLpAEp
 I5TkCYXQ8mLCJHJylbMCcSb+5clxQRRE98SpDmWR/6aU5mY0uM9Cl7emJrRzyLM+0Ntl751Pq
 9x9TdnyLzjVjSCyYZTfcXBJZAL1H0vOwxb1sh1bHD4gM/OVglEzxzHJAm2KJqM5w/iVzwNw7k
 hjnAvCzmSy+xH1UgKFPjYUnNA3ZekmpQPFAGtpbWYi7Kf2m7lq2Ft97Q2eeLThN1j3LtTMLq4
 tXvR0/W
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Wed, 8 Aug 2018, Pratik Karki wrote:

> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 42ee040da3..fd9ad8efae 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -588,6 +607,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			 &options.allow_rerere_autoupdate,
>  			 N_("allow rerere to update index  with resolved "
>  			    "conflict")),
> +		OPT_BOOL(0, "keep-empty", &options.keep_empty,
> +			 N_("preserve empty commits during rebase")),
>  		OPT_END(),

This forgets the short option `-k`, I just noticed. I then looked at the
rest of the options, and they seem not to forget the short option
anywhere.

I will fix this before sending v2.

Ciao,
Dscho
