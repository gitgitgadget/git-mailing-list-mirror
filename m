Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11CC61F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 17:53:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbdKJRxG (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 12:53:06 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:57005 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753231AbdKJRxF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 12:53:05 -0500
X-Originating-IP: 172.56.42.40
Received: from s (unknown [172.56.42.40])
        (Authenticated sender: josh@joshtriplett.org)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id E9045FB8B3;
        Fri, 10 Nov 2017 18:53:01 +0100 (CET)
Date:   Fri, 10 Nov 2017 09:52:58 -0800
From:   Josh Triplett <josh@joshtriplett.org>
To:     Adam Dinwoodie <adam@dinwoodie.org>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4] doc/SubmittingPatches: correct subject guidance
Message-ID: <20171110175257.elceafddaebm55uk@s>
References: <CAPig+cRADknKB7KxqcZVinwP9vmGh1tmUrySUND3hMTi7a+bag@mail.gmail.com>
 <20171110150250.8896-1-adam@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171110150250.8896-1-adam@dinwoodie.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 03:02:50PM +0000, Adam Dinwoodie wrote:
> The examples and common practice for adding markers such as "RFC" or
> "v2" to the subject of patch emails is to have them within the same
> brackets as the "PATCH" text, not after the closing bracket.  Further,
> the practice of `git format-patch` and the like, as well as what appears
> to be the more common pratice on the mailing list, is to use "[RFC
> PATCH]", not "[PATCH/RFC]".
> 
> Update the SubmittingPatches article to match and to reference the
> `format-patch` helper arguments, and also make some minor text
> clarifications in the area.
> 
> Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>

This looks great! Thank you for updating this documentation.

Reviewed-by: Josh Triplett <josh@joshtriplett.org>

> ---
> 
> Notes:
>     Changes since v3:
>     - Clarified meaning of "RFC" per Eric's suggestion
>     - Made the impact of --subject-prefix and friends clearer per Eric's
>       suggestion
>     
>     Thank you for your nitpicking, Eric, it's useful and very much
>     appreciated :)
> 
>  Documentation/SubmittingPatches | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
> index 558d465b6..89f239071 100644
> --- a/Documentation/SubmittingPatches
> +++ b/Documentation/SubmittingPatches
> @@ -184,21 +184,26 @@ lose tabs that way if you are not careful.
>  
>  It is a common convention to prefix your subject line with
>  [PATCH].  This lets people easily distinguish patches from other
> -e-mail discussions.  Use of additional markers after PATCH and
> -the closing bracket to mark the nature of the patch is also
> -encouraged.  E.g. [PATCH/RFC] is often used when the patch is
> -not ready to be applied but it is for discussion, [PATCH v2],
> -[PATCH v3] etc. are often seen when you are sending an update to
> -what you have previously sent.
> +e-mail discussions.  Use of markers in addition to PATCH within
> +the brackets to describe the nature of the patch is also
> +encouraged.  E.g. [RFC PATCH] (where RFC stands for "request for
> +comments") is often used to indicate a patch needs further
> +discussion before being accepted, [PATCH v2], [PATCH v3] etc.
> +are often seen when you are sending an update to what you have
> +previously sent.
>  
> -"git format-patch" command follows the best current practice to
> +The "git format-patch" command follows the best current practice to
>  format the body of an e-mail message.  At the beginning of the
>  patch should come your commit message, ending with the
>  Signed-off-by: lines, and a line that consists of three dashes,
>  followed by the diffstat information and the patch itself.  If
>  you are forwarding a patch from somebody else, optionally, at
>  the beginning of the e-mail message just before the commit
>  message starts, you can put a "From: " line to name that person.
> +To change the default "[PATCH]" in the subject to "[<text>]", use
> +`git format-patch --subject-prefix=<text>`.  As a shortcut, you
> +can use `--rfc` instead of `--subject-prefix="RFC PATCH"`, or
> +`-v <n>` instead of `--subject-prefix="PATCH v<n>"`.
>  
>  You often want to add additional explanation about the patch,
>  other than the commit message itself.  Place such "cover letter"
> -- 
> 2.14.3
> 
