Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD920201A7
	for <e@80x24.org>; Mon, 15 May 2017 18:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964793AbdEOS0h (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 14:26:37 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:35267 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934127AbdEOS0g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 14:26:36 -0400
Received: by mail-pf0-f181.google.com with SMTP id n23so62192482pfb.2
        for <git@vger.kernel.org>; Mon, 15 May 2017 11:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=GLtSllHIY0DpJl2v6Musb0XKlC+1oHPmWQM16WExNRg=;
        b=iMesLYOx+OxHavO3HY7khbokseARXT2GDOw7RxjsgyVTN12sR87rVDFvxrN0fp53YR
         cF8lWjxGjST2pH9N3SLYn4HPjQwF76JcbN+yqNaltCm+brgTS+2BVpqG/9FjGEi/T+sa
         uTrFVlfeCJItBYpi1Gq+DaFdIBYSK4MILE9BFFir+C2Sdkbl9H2d+YRN4uLokRWtipj6
         8/4DhlrzdkElMvrDuLsBAjLuEn0ql01FswxG1eju9RD7INm3MBfBfxtSZe292+zZPGcv
         MckTBGmL3sqMiRtDNX42qAawYgYifUr/VCl+g+/hqc1HgbkASje2+myEBQmE3qmyI+I8
         WE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=GLtSllHIY0DpJl2v6Musb0XKlC+1oHPmWQM16WExNRg=;
        b=EWPSWti4sJnwddq986KTbgVDfmxx41DQx1EeJVbVlWkqLBd/Xele9sPt2n6Y7VXud2
         YLR++jkbLAAfwesplqUBiaJ8/oEMJIGG2KH0v+AJt3NTibpptoRpO6FsPRDZsYF69P0j
         PGot0T18gGRT9Y5I/C89KQ+OKe9fQ7FZkL/X+DYmIyXjlPJKORSaNjgCpRJrPs6c9eEU
         CmIbeeQoESsxujbPj+tOtEDBmFhuhmDhTpDMvp0ip49cnhHnQmD/unocZ7qd2cuQET5q
         kC+NuZLbSK6ta1tFrcL1959YSSii49huhlic9G572K2Bet9EGQuv6qRkCV9OO+LsV7fk
         na7Q==
X-Gm-Message-State: AODbwcDt7mPtW/nKYbhbc/m3lG71ggd/FyFPQZiUAEwPnv9AQ1HArMiq
        hHfnrMC5YlYlxWXz
X-Received: by 10.84.178.101 with SMTP id y92mr10243952plb.116.1494872795342;
        Mon, 15 May 2017 11:26:35 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:f484:2515:b6cf:fcc0])
        by smtp.gmail.com with ESMTPSA id c196sm24941897pga.23.2017.05.15.11.26.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 May 2017 11:26:34 -0700 (PDT)
Subject: Re: [PATCH 03/19] diff.c: drop 'nofirst' from emit_line_0
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
References: <20170514040117.25865-1-sbeller@google.com>
 <20170514040117.25865-4-sbeller@google.com>
Cc:     peff@peff.net, gitster@pobox.com, mhagger@alum.mit.edu,
        jrnieder@gmail.com, bmwill@google.com
From:   Jonathan Tan <jonathantanmy@google.com>
Message-ID: <115f4d30-5c97-9ee9-e56b-3cf955a5454e@google.com>
Date:   Mon, 15 May 2017 11:26:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170514040117.25865-4-sbeller@google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/13/2017 09:01 PM, Stefan Beller wrote:
> In 250f79930d (diff.c: split emit_line() from the first char and the rest
> of the line, 2009-09-14) we introduced the local variable 'nofirst' that
> indicates if we have no first sign character. With the given implementation
> we had to use an extra variable unlike reusing 'first' because the lines
> first character could be '\0'.
>
> Change the meaning of the 'first' argument to not mean the first character
> of the line, but rather just containing the sign that is prepended to the
> line. Refactor emit_line to not include the lines first character, but pass
> the complete line as well as a '\0' sign, which now serves as an indication
> not to print a sign.
>
> With this patch other callers hard code the sign (which are '+', '-',
> ' ' and '\\') such that we do not run into unexpectedly emitting an
> error-nous '\0'.

"erroneous"?

I also don't understand the meaning of this paragraph - if you mean that 
this patch teaches other callers to hardcode the sign, I don't see any 
such changes in the diff below.

After reading the patch below, would this commit message be better:

[begin]
diff.c: teach emit_line_0 to accept sign parameter

Instead of a separate "first" parameter representing the first character 
of the line to be printed, make emit_line_0 take an optional "sign" 
parameter specifically intended to hold the sign of the line. Callers 
that store the sign and line separately can use the "sign" parameter 
like they used the "first" parameter previously, and callers that store 
the sign and line together (or do not have a sign) no longer need to 
manipulate their arguments to fit the requirements of emit_line_0.

(And then mention that you have checked all the callers and that none of 
them send '\n' or '\r' as the sign, as you have done in this version.)
[end]

>
> The audit of the caller revealed that the sign cannot be '\n' or '\r',
> so remove that condition for trailing newline or carriage return in the
> sign; the else part of the condition handles the len==0 perfectly,
> so we can drop the if/else construct.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  diff.c | 40 +++++++++++++++++-----------------------
>  1 file changed, 17 insertions(+), 23 deletions(-)
>
> diff --git a/diff.c b/diff.c
> index c2ed605cd0..4269b8dccf 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -517,33 +517,24 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
>  }
>
>  static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
> -			int first, const char *line, int len)
> +			int sign, const char *line, int len)
>  {
>  	int has_trailing_newline, has_trailing_carriage_return;
> -	int nofirst;
>  	FILE *file = o->file;
>
>  	fputs(diff_line_prefix(o), file);
>
> -	if (len == 0) {
> -		has_trailing_newline = (first == '\n');
> -		has_trailing_carriage_return = (!has_trailing_newline &&
> -						(first == '\r'));
> -		nofirst = has_trailing_newline || has_trailing_carriage_return;
> -	} else {
> -		has_trailing_newline = (len > 0 && line[len-1] == '\n');
> -		if (has_trailing_newline)
> -			len--;
> -		has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
> -		if (has_trailing_carriage_return)
> -			len--;
> -		nofirst = 0;
> -	}
> +	has_trailing_newline = (len > 0 && line[len-1] == '\n');
> +	if (has_trailing_newline)
> +		len--;
> +	has_trailing_carriage_return = (len > 0 && line[len-1] == '\r');
> +	if (has_trailing_carriage_return)
> +		len--;
>
> -	if (len || !nofirst) {
> +	if (len || sign) {
>  		fputs(set, file);
> -		if (!nofirst)
> -			fputc(first, file);
> +		if (sign)
> +			fputc(sign, file);
>  		fwrite(line, len, 1, file);
>  		fputs(reset, file);
>  	}
> @@ -556,7 +547,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
>  static void emit_line(struct diff_options *o, const char *set, const char *reset,
>  		      const char *line, int len)
>  {
> -	emit_line_0(o, set, reset, line[0], line+1, len-1);
> +	emit_line_0(o, set, reset, 0, line, len);
>  }

Maybe this function is unnecessary now that emit_line_0 can take the 
line directly.

>
>  static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
> @@ -4822,9 +4813,12 @@ void diff_flush(struct diff_options *options)
>
>  	if (output_format & DIFF_FORMAT_PATCH) {
>  		if (separator) {
> -			fprintf(options->file, "%s%c",
> -				diff_line_prefix(options),
> -				options->line_termination);
> +			char term[2];
> +			term[0] = options->line_termination;
> +			term[1] = '\0';
> +
> +			emit_line(options, NULL, NULL,
> +				  term, 1);

If options->line_termination is 0, this is actually a zero-length string 
(not 1).

>  			if (options->stat_sep) {
>  				/* attach patch instead of inline */
>  				fputs(options->stat_sep, options->file);
>
