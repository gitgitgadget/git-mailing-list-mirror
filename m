Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MALFORMED_FREEMAIL,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36B071F71B
	for <e@80x24.org>; Mon,  1 Aug 2016 09:51:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340AbcHAJvB (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 05:51:01 -0400
Received: from mout.gmx.net ([212.227.15.15]:59311 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751906AbcHAJu6 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 05:50:58 -0400
Received: from virtualbox ([37.24.142.100]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MarNa-1bj46j3lJC-00KM0S; Mon, 01 Aug 2016 11:49:40
 +0200
Date:	Mon, 1 Aug 2016 11:49:37 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v5 16/16] merge-recursive: flush output buffer even when
 erroring out
In-Reply-To: <xmqq4m7avi32.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1608011141380.149069@virtualbox>
References: <cover.1469187652.git.johannes.schindelin@gmx.de> <cover.1469547160.git.johannes.schindelin@gmx.de> <af195979d2c0cf9958b7811b4d2294deeea30b75.1469547160.git.johannes.schindelin@gmx.de> <xmqq4m7avi32.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GKmqsz0PgRFXAF5gM2XdqQ5YB4mwF/aQwp2/ObkivQt5bFRUzCF
 /mol+91BuY6bknQlR2Ck5S2Wv2LAwfUxh9j1NBoE/2sadmJqblj+/zoz1BHz25N5ChY54Ej
 fGaBW1pcehEjgXpH0rNahcj+LX69UdFgd+bdbCv0ieUtZhiJdxiwSwtk1YQMXtfMhktKfw9
 D6RfJYnp5SpV5TrWgF/nA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YofNUNNV/aU=:eR5UK3URic8SW5CMiDRWTT
 KDM+oSjXqeli1LeDn6e/jyNMuG2fUN8Ca/+LkGFpsg0GYj7Nmph9JVqvAF9zj/DbD6QcJpszt
 6fuu7JuYTtcefOzgeQ9Mg/0ZoKzllc42vgRNTo9jxHdk2IMTQETLhhj539Dn0AZcXzkiLtEtB
 iJTKW5L5sD/DzcigTpbNxHoPouM43tqEGenlhNQbKNSqsl/0lHg8czEbqCSb+K+tuFzAlHRRq
 qC39fbXC+VaRVyErtIXbfzuzfQzLe98DOrfl2yWBcT17UZTzrHV4l1nArvalVz9lEjncyKiZF
 VLDDv0gUtmS3VPDzDwcD1X8jySkqrTO5nu1RbxsGNTJzg4+1jbdLa+ZWZ4L07F/LKi4zQF7Hy
 /KP0eMAFWsKUWbqzcff5/rnKSd5RT+P2oasUp66B0aiED3Ki27BrOd2Z2/nbp99qwyI3k4sxv
 ecFT1nu8mW9/vzJ12lIBpuzOhunJRXW3EgEP6W3Mnwq6XHs3jtyKU/BaeF+eqf7U5yF69vnWb
 fVa0CdQrc724NBdErEi/iQPQjD7/TQxYSjbJMsIrD0rUAo8F8n4WWPf/+XIZ5enNxpma7CPYI
 rm1vR65yh5oHaED2oSG/9IN1W/RU6+y6yjHBPRodqqh2RgIxoTaWEF1I6+6FcWRrU6gSpDxtg
 rfhQ9v2BHXfcvPjbYeTG8/qH0EjRQJan7CnQaHPDhmvj9tHrYVfC6RwvKC47Sz231lG5+j5xi
 Q+3H4T5SIxWc5VRouo46g/MUcnTD/mIUGwO0zX3iEy4beUvHYacT7/JBmchMqXhWAcgh0d0qk
 E4Ln0BF
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Wed, 27 Jul 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/merge-recursive.c b/merge-recursive.c
> > index a16b150..66e93e0 100644
> > --- a/merge-recursive.c
> > +++ b/merge-recursive.c
> > @@ -2069,6 +2069,7 @@ int merge_recursive(struct merge_options *o,
> >  	o->ancestor = "merged common ancestors";
> >  	clean = merge_trees(o, h1->tree, h2->tree, merged_common_ancestors->tree,
> >  			    &mrtree);
> > +	flush_output(o);
> >  	if (clean < 0)
> >  		return clean;
> 
> This is of course a good change, but we need to assume that no
> further output is made from the remainder of the function for the
> change in the next hunk to remove the existing flush to be correct.

Please note that nothing prevents the code further down from adding more
output. All we do here is flushing the output *so far*, in case we return
an error. And of course nothing gets flushed if buffer_output == 2,
because that value states that the caller wants to take care of displaying
the output herself.

But you made me realize that I cannot simply *move* the flush_output()
call here, in case that code in between will eventually add output.

Thanks,
Dscho
