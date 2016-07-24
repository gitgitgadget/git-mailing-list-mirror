Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 395B9203E2
	for <e@80x24.org>; Sun, 24 Jul 2016 07:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbcGXHiN (ORCPT <rfc822;e@80x24.org>);
	Sun, 24 Jul 2016 03:38:13 -0400
Received: from mout.gmx.net ([212.227.15.15]:57119 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751870AbcGXHiM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Jul 2016 03:38:12 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Ljqgb-1aueJt0Fsv-00bqBS; Sun, 24 Jul 2016 09:38:00
 +0200
Date:	Sun, 24 Jul 2016 09:37:57 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Eric Wong <e@80x24.org>
cc:	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] format-patch: escape "From " lines recognized by
 mailsplit
In-Reply-To: <20160724031543.GC32480@starla>
Message-ID: <alpine.DEB.2.20.1607240926500.14111@virtualbox>
References: <20160722224739.GA22961@whir> <alpine.DEB.2.20.1607231056150.14111@virtualbox> <20160724031409.GA32480@starla> <20160724031543.GC32480@starla>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Kb2Bi/WiXpXRcfCYPvVIXSqPUTU0EJGDJO9DI5epD27ukzfCFcx
 o/N4l1b32ZrJWbeS3H17isznCbWYCJ0ZGEDUKm88+0lY9gKXzpnox+ymCd1aElXpDD+pCPo
 QosnOV5AlBTrbIFSs3jihn42OdUiWGH/e8KlYZIRDiZYbSolZ+BmPOfDd1hU+vLXcotKgt5
 KB24FTFH5Xh38dzgr4kjg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:0suaQb3CsZM=:zUZITzh1IAY8DcgcTxjh3P
 a+XqDF/ygl4z5Lmmj3i98YlFHYWIj7sdT8P67Q4R1mB7QI6Qx9t6W6E9p/P9VnENdmbZb2YkT
 /MQGaqyYR1JYDSpxjO7rWlIT2u1zF6Z3Y5l/m00RxKM9FUQK/8MKWDrYPcFH8YTQyZqvQuzAk
 ARqlzk2KXdeyUHEmDU3vUmObyCXb590wQE4U6KrqIBZDOf6CgNAy/vGFVqW4wXk63qMe4RY2T
 mrf7SSISMNnMYsmQrMWtq9MM7OXw/PUmIW0W4NGO9quZg3MAD7bHeXhwsKJVIOu0+WRnmNvgn
 bc7FItDWXZzcyMpz1Q94x9FxdUUQAGQPSvssjtJesYkaXiYTUCheOeWq+mB7Wuxd2ZxItwlZF
 in5mEybNRD6DIQ4bVrFDOxS0KgDg4GaICt2uVeo8P8nsm7GQj9Gyl2St1jw6nWexblywmbjEk
 TU4FUAKWrlOXG+ZOUCJ6TfTYNPSF0lBqZnl3YtZkX+olsakbxW0ndcqM6twf4GnRHKwRJ+WzD
 Zs1F3Qdl7bE8plRdOseSLaVBQtAIhHXK0sabZyiQpU4zcLPnBqtQdEVt16PwQFoEHmFFM+HzE
 6z80b7zFabp0HwaK7JG4SErr8DhtImtumWpOO3V+CIxE/48AHf+kBNHKFVagOg0iBmjc2//iW
 KC1IlHVR6wZZ7Ek/RwXLf1knnmBUDmsq76wpOb6zaa2neX1+MxyV04GvE7nsZwJl7tjcTf88e
 3SyN4DDmnRANl/jqa3pQFamEJd+NgcEEJG5IvGbnhejhzeI9CXVq5WdUNnFO7JUI/wtDds1Ye
 JNOz8Or
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Eric,

On Sun, 24 Jul 2016, Eric Wong wrote:

> @@ -1745,9 +1746,18 @@ void pp_remainder(struct pretty_print_context *pp,
>  			strbuf_add_tabexpand(sb, pp->expand_tabs_in_log,
>  					     line, linelen);
>  		else {
> -			if (pp->fmt == CMIT_FMT_MBOXRD &&
> -					is_mboxrd_from(line, linelen))
> -				strbuf_addch(sb, '>');
> +			switch (pp->fmt) {
> +			case CMIT_FMT_EMAIL:
> +				if (is_from_line(line, linelen))
> +					strbuf_addch(sb, '>');
> +				break;
> +			case CMIT_FMT_MBOXRD:
> +				if (is_mboxrd_from(line, linelen))
> +					strbuf_addch(sb, '>');
> +				break;
> +			default:
> +				break;
> +			}

Sorry to be nitpicking once again; I think this would be conciser (and
easier to read at least for me) as:

-			if (pp->fmt == CMIT_FMT_MBOXRD &&
-					is_mboxrd_from(line, linelen))
+			if ((pp->fmt == CMIT_FMT_MBOXRD &&
+			     is_mboxrd_from(line, linelen)) ||
+			    (pp->fmt == CMIT_FMT_EMAIL &&
+			     is_from_line(line, linelen)))
 				strbuf_addch(sb, '>');

> diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
> index 1206c48..8fa3982 100755
> --- a/t/t4014-format-patch.sh
> +++ b/t/t4014-format-patch.sh
> @@ -1606,4 +1606,18 @@ test_expect_success 'format-patch --pretty=mboxrd' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'format-patch From escaping' '
> +	cat >msg <<-INPUT_END &&
> +	somebody pasted format-patch output into a body
> +
> +	From 0000000000000000000000000000000000000000 Mon Sep 17 00:00:00 2001
> +	INPUT_END
> +
> +	C=$(git commit-tree HEAD^^{tree} -p HEAD <msg) &&

The double caret makes this a bit hard to read. Maybe this instead?

+	C=$(git commit-tree HEAD: -p HEAD^ <msg) &&

> +	git format-patch --stdout -1 $C~1..$C >patch &&

Either "-1 $C" or "$C~1..$C", not both...

> +	git grep -h --no-index \
> +		">From 0000000000000000000000000000000000000000 " \
> +		patch
> +'
> +
>  test_done
> -- 
> EW

Heh, that's a nice Git version ;-)

Ciao,
Dscho
