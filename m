Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 923F91FE4E
	for <e@80x24.org>; Sun, 26 Jun 2016 06:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752013AbcFZG4Q (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 02:56:16 -0400
Received: from mout.gmx.net ([212.227.15.19]:49265 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751675AbcFZG4Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 02:56:16 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Llm9w-1bqOjm3h7w-00ZPHm; Sun, 26 Jun 2016 08:56:06
 +0200
Date:	Sun, 26 Jun 2016 08:56:08 +0200 (CEST)
From:	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	Junio C Hamano <gitster@pobox.com>
cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 01/10] Prepare log/log-tree to reuse the diffopt.close_file
 attribute
In-Reply-To: <xmqq60syfgqf.fsf@gitster.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.20.1606260853030.12947@virtualbox>
References: <cover.1466505222.git.johannes.schindelin@gmx.de> <cover.1466607667.git.johannes.schindelin@gmx.de> <044f3c6359b63eaa18229cd73e6815e8e15c9778.1466607667.git.johannes.schindelin@gmx.de> <xmqq60syfgqf.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:/O4fm61ZNV7g8ArhPtT0OXN6FUBzOYJlPjZNDATk016oAuVPb6S
 KKMZyJBkU9eVN4+hJGUQiW526xAoquIQWZ7NOH5zcsqV4UCEk9gJZCaxVglvN3G/ttB5Jrs
 wxXrBUViJZneVV9wLCYEHAxcwwEq070+FgINlDB8eObkciOa8RUAj0bBhxXueEQ20kQo0wn
 Z25gY2Fel5W33jSeh8FnQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:TqGGPzUDgxM=:a/jsFRQBi2IpaCmoU5bD8m
 hcaXzECmdsFISbmWUb75V2gKYBIHCFX+3okEs4ynQR7jJhWFHJ755N5I1jMyGPUXcmh+p42hV
 HesPijnrFbd4+WKXTeoBLRis+sB3k8vkCJRCISpfbGMj/GIpg3Z3zjCwO6jWBbTdnGPUwhc2i
 14JtTcfbp+waVJlVj9+xacfVQL9Ca2Ao6rW9jYl5mEwp/FsJceqd8K/wB2EBON2QHw7cIDcZu
 dq32fzkUBztWPiUk91PcbQky8mljWgkjLzNonyppUK4NOXy99YA4XmCdtOqoc5XolxeUerggK
 QggaeaU85Y45NazWLohbO/K5V7ifNXnfMWDjXrgEOCYBgMY3jzGZZupcJa0iRRNtgx102lcDx
 eJT63QNf4qy03b5T48Dpz+2PStIvlXRRgvslOwApIbZGcrB7aM0w6jpO/ztNtb9Ru81VoEaIt
 PsGMmj2p/a5e7aog663wG2cSgwIIqenVpOb7ptRBsMTg2rdD31HYGbNRo6wrgcPv78Hx0stUi
 7PG+DzL36EZxJ3nKliTNIuQ1GntkePUamphXxQvpLg+gEEgPOHrFNYMExURR1ngM9SGKtf1Rb
 GrkBPLMbwJFS6gjjofVbQS/P/SusEW1TfcR+es0QrzRFPpUbwGeVYfQLftwObHi18UP/AIUQE
 aC024VY2kXocQldZPWrGGbk1oP1MoAP8+Q1mmNnR1v9+i7fNQKxiZ4HVy45WTYa+8eNb+eN2U
 4k6HaTo57uF54XEbCCARpdj7JWA/SLvjHt7N+P7zctPkO4MS1zctdgFzeKUO6bq+qGzV347aL
 2W+iklJ
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Junio,

On Fri, 24 Jun 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > diff --git a/builtin/log.c b/builtin/log.c
> > index 099f4f7..27bc88d 100644
> > --- a/builtin/log.c
> > +++ b/builtin/log.c
> > @@ -243,9 +243,10 @@ static struct itimerval early_output_timer;
> >  
> >  static void log_show_early(struct rev_info *revs, struct commit_list *list)
> >  {
> > -	int i = revs->early_output;
> > +	int i = revs->early_output, close_file = revs->diffopt.close_file;
> 
> Probably not worth a reroll, but I find this kind of thing easier to
> read as two separate definitions.
> 
> >  	int show_header = 1;
> 
> And this was separate from "int i = ...;" for the same reason.  It
> is OK to write "int i, j, k;" but "show_header" is something that
> keeps track of the more important state during the control flow and
> it is easier to read if we make it stand out.  close_file falls into
> the same category, I would think.

Makes sense. I changed it locally, in case this patch series needs a
re-roll.

> >  		case commit_error:
> > +			if (close_file)
> > +				fclose(revs->diffopt.file);
> 
> I wondered if we want to also clear, i.e. revs->diffopt.file = NULL, 
> but I do not think .close_file does that either, so this is good.

Indeed, the current code in diff_flush() just fclose()s the stream, but
does not reset the "file" field:

	https://github.com/git/git/blob/v2.9.0/diff.c#L4715-L4716

Ciao,
Dscho
