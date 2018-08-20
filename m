Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B85C11F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:31:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeHTWso (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 18:48:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:48061 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726077AbeHTWsn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 18:48:43 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LkSOt-1gO9W623Ip-00cU46; Mon, 20
 Aug 2018 21:31:45 +0200
Date:   Mon, 20 Aug 2018 21:31:43 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/3] diff.c: add --output-indicator-{new, old, context}
In-Reply-To: <20180817204354.108625-2-sbeller@google.com>
Message-ID: <nycvar.QRO.7.76.6.1808202129420.73@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1808161022180.71@tvgsbejvaqbjf.bet> <20180817204354.108625-1-sbeller@google.com> <20180817204354.108625-2-sbeller@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:aL1VZnny6tPCGvJC7P/jipnbRMco6TbCzOqmTga8KrWfborAjT9
 iZCLYgReHS775WF8V2L/UkW2p31RQP0wm+LZwnFDgBc9FSi1uVX5n5FwRWRBSoAWdqYJ/Nk
 2q0E3K7QjdN7t40qrEZwxqiAKmZ4Lx56JfQqTTuNyptMQ9+/Kl3pEo2PKMY2Wvp/+aCy0tZ
 yjKz17p8qK1HexJ9g2ruQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YM+WSzT3OFk=:IvXu3AZJBQJtpbIuK92JWv
 w9hvALigFZZ9XwDxTG4dcwLMHsY+AVvTpqtFi87tvMkb8YMjrBivEqJzay4QJBkun4aa1vx70
 igfd/pSiNAGxElpqWocJv/uwg2HtQz5iZEe/4/+WTPrM8uoVe80os/rRT+WL1zUZ//03gfX1X
 H443OTY4IjEFEHxlUMj1/1VWj5dkbVm4Q39WYosUnvAozS8IrZwLFtHeT91ZXLSjk7X7XNXPn
 fQ2FBW9a2yPA5cD3AV3tIr3qKJ29Jfp5up/6D18jl6FXhESRpf8ToxtX2NwWyZoQnw4BGOPtE
 WqK5CeBF7wfdStStB/21vgcnVU0wMnPQE0goZH+SKt5wP82AD9LTZ69lYlLl9qmvfao3CM6TB
 fwoFljfMaTJ/Wc5l4cHfo96d3/eJ7TQJcNK9aIjZQngo+hqh90SWq0LghbDfeAjrz6919NSRK
 +AAVnAY2O5az1enmeGn2vapN9eZcxAFJflFTc6PbND6Mc9XNoQ3z+cQc2VpSg6lyjBTLR+PU/
 Nm2Ndy/3Qx1NgKYfl20yCILnJgOBOhs4cfo3fdP14VH4szifoDYckBegX87wRCrGj2KRY4EAk
 nB1J0se3Z3W3t7+o187pYudM+SlvFYskm2RLnPoMXLxq8Y9RbW4hud2qzgclnH5gTc4d5fbYl
 ELSJ4NQGlAzIA4mBP1uqyQ14supqgsSf0yxT741axQKvUphgWYosNT56zCu6nzQg5Sjsmr7Nq
 St8cNB6ZffVV0QumBmcofooHKBQ+dKOYrfDyFCioH/fEz40j8gJ3LUBhmndSeBZlCIEX216sT
 XDXvarn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Fri, 17 Aug 2018, Stefan Beller wrote:

> This will prove useful in range-diff in a later patch as we will be able
> to differentiate between adding a new file (that line is starting with
> +++ and then the file name) and regular new lines.
> 
> It could also be useful for experimentation in new patch formats, i.e.
> we could teach git to emit moved lines with lines other than +/-.

Thanks.

> diff --git a/diff.c b/diff.c
> index c5c7739ce34..03486c35b75 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -1281,7 +1281,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			else if (c == '-')
>  				set = diff_get_color_opt(o, DIFF_FILE_OLD);
>  		}
> -		emit_line_ws_markup(o, set_sign, set, reset, ' ', line, len,
                                    ^
Here we already pass `o`... so...

> +		emit_line_ws_markup(o, set_sign, set, reset,
> +				    o->output_indicators[OUTPUT_INDICATOR_CONTEXT],
                                    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
... here, we could simply pass `OUTPUT_INDICATOR_CONTEXT` and let the
callee look it up in`o->output_indicators[]`...

I read all three patches and did not see a reason why we could not
simplify the code that way.

Other than that: great!

Thank you,
Dscho

> +				    line, len,
>  				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
>  		break;
>  	case DIFF_SYMBOL_PLUS:
> @@ -1324,7 +1326,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  				set = diff_get_color_opt(o, DIFF_CONTEXT_BOLD);
>  			flags &= ~DIFF_SYMBOL_CONTENT_WS_MASK;
>  		}
> -		emit_line_ws_markup(o, set_sign, set, reset, '+', line, len,
> +		emit_line_ws_markup(o, set_sign, set, reset,
> +				    o->output_indicators[OUTPUT_INDICATOR_NEW],
> +				    line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK,
>  				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
>  		break;
> @@ -1367,7 +1371,9 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
>  			else
>  				set = diff_get_color_opt(o, DIFF_CONTEXT_DIM);
>  		}
> -		emit_line_ws_markup(o, set_sign, set, reset, '-', line, len,
> +		emit_line_ws_markup(o, set_sign, set, reset,
> +				    o->output_indicators[OUTPUT_INDICATOR_OLD],
> +				    line, len,
>  				    flags & DIFF_SYMBOL_CONTENT_WS_MASK, 0);
>  		break;
>  	case DIFF_SYMBOL_WORDS_PORCELAIN:
> @@ -4382,6 +4388,9 @@ void diff_setup(struct diff_options *options)
>  
>  	options->file = stdout;
>  
> +	options->output_indicators[OUTPUT_INDICATOR_NEW] = '+';
> +	options->output_indicators[OUTPUT_INDICATOR_OLD] = '-';
> +	options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = ' ';
>  	options->abbrev = DEFAULT_ABBREV;
>  	options->line_termination = '\n';
>  	options->break_opt = -1;
> @@ -4869,6 +4878,12 @@ int diff_opt_parse(struct diff_options *options,
>  		 options->output_format |= DIFF_FORMAT_DIFFSTAT;
>  	} else if (!strcmp(arg, "--no-compact-summary"))
>  		 options->flags.stat_with_summary = 0;
> +	else if (skip_prefix(arg, "--output-indicator-new=", &arg))
> +		options->output_indicators[OUTPUT_INDICATOR_NEW] = arg[0];
> +	else if (skip_prefix(arg, "--output-indicator-old=", &arg))
> +		options->output_indicators[OUTPUT_INDICATOR_OLD] = arg[0];
> +	else if (skip_prefix(arg, "--output-indicator-context=", &arg))
> +		options->output_indicators[OUTPUT_INDICATOR_CONTEXT] = arg[0];
>  
>  	/* renames options */
>  	else if (starts_with(arg, "-B") ||
> diff --git a/diff.h b/diff.h
> index e1e54256c18..d7edc64454a 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -194,6 +194,11 @@ struct diff_options {
>  	FILE *file;
>  	int close_file;
>  
> +#define OUTPUT_INDICATOR_NEW 0
> +#define OUTPUT_INDICATOR_OLD 1
> +#define OUTPUT_INDICATOR_CONTEXT 2
> +	char output_indicators[3];
> +
>  	struct pathspec pathspec;
>  	pathchange_fn_t pathchange;
>  	change_fn_t change;
> -- 
> 2.18.0.265.g16de1b435c9.dirty
> 
> 
