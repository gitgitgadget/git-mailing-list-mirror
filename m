Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 183312018A
	for <e@80x24.org>; Mon, 27 Jun 2016 18:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbcF0S5T (ORCPT <rfc822;e@80x24.org>);
	Mon, 27 Jun 2016 14:57:19 -0400
Received: from cloud.peff.net ([50.56.180.127]:33579 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751644AbcF0S5S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jun 2016 14:57:18 -0400
Received: (qmail 2614 invoked by uid 102); 27 Jun 2016 18:57:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 14:57:18 -0400
Received: (qmail 12367 invoked by uid 107); 27 Jun 2016 18:57:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 27 Jun 2016 14:57:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 27 Jun 2016 14:57:15 -0400
Date:	Mon, 27 Jun 2016 14:57:15 -0400
From:	Jeff King <peff@peff.net>
To:	Matthieu Moy <Matthieu.Moy@imag.fr>
Cc:	gitster@pobox.com, git@vger.kernel.org,
	Jordan DE GEA <jordan.de-gea@ensimag.grenoble-inp.fr>,
	Samuel GROOT <samuel.groot@ensimag.grenoble-inp.fr>,
	Erwan MATHONIERE <erwan.mathoniere@ensimag.grenoble-inp.fr>,
	Tom RUSSELLO <tom.russello@ensimag.grenoble-inp.fr>
Subject: Re: [PATCH 1/6] doc: typeset short command-line options as literal
Message-ID: <20160627185715.GB9594@sigill.intra.peff.net>
References: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160627174623.11084-1-Matthieu.Moy@imag.fr>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 07:46:18PM +0200, Matthieu Moy wrote:

> It was common in our documentation to surround short option names with
> forward quotes, which renders as italic in HTML. Instead, use backquotes
> which renders as monospace. This is one more step toward conformance to
> Documentation/CodingGuidelines.
> 
> This was obtained with:
> 
>   perl -pi -e "s/'(-[a-z])'/\`\$1\`/g" *.txt

I think this is an improvement, assuming everyone is happy with the new
MAN_BOLD_LITERAL default.

I skimmed the diff and it looks there were no mis-conversions (I
recommend diff-highlight for this, as it makes it much easier to spot,
though perhaps --color-words would help, too).

> diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
> index e453132..cbae886 100644
> --- a/Documentation/git-mv.txt
> +++ b/Documentation/git-mv.txt
> @@ -35,7 +35,7 @@ OPTIONS
>          Skip move or rename actions which would lead to an error
>  	condition. An error happens when a source is neither existing nor
>  	controlled by Git, or when it would overwrite an existing
> -        file unless '-f' is given.
> +        file unless `-f` is given.

git-am complains about the space indentation in the post-image. I know
it was there before your patch, but the indentation for that paragraph
is off. I wonder if it makes sense to fix it as a preliminary patch.

-Peff
