Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 427F51F991
	for <e@80x24.org>; Wed,  9 Aug 2017 18:35:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752928AbdHISff (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 14:35:35 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36413 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752623AbdHISfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 14:35:32 -0400
Received: by mail-pf0-f180.google.com with SMTP id c28so31153674pfe.3
        for <git@vger.kernel.org>; Wed, 09 Aug 2017 11:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iIkMtv9WIjWSpVzjaA85Usxc5284QtXyIljIBREl3ZM=;
        b=EzB9dp121N4o4Scmnstxxk9+il9YP9n1oiOEVxr9n5Ycs1urpQdAKLRrpATXsGkS8+
         PVXbdwvx4bhOQwvgZUe4Rl0k5jdPJidZSem9nSO50lbOkNKuFYwYzbF3+CVGtw8yOyKQ
         gcvItYZvTAzcTAMiRUHNClLsFI6PVPDi3M88vPfCMzQ3j/2FOc+G+pPosAwsqJrZzYgH
         FZlV+DB5pT4SezNB2dqbui5CJ76ANo5E/MazorvzaD4UR9r0Jqh6XXIqG5Unw2zs8gXg
         EKRPkfHeRlmkfszvM1+1ftDevMojC7q3+nIT3mYmWsxgW1urBX6wXIqd+etrOIAvT07p
         AvJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iIkMtv9WIjWSpVzjaA85Usxc5284QtXyIljIBREl3ZM=;
        b=OjfjkC0heu3XmpxqgZxZa3bHpAEs1faW0Z/CcBA1T+5H6ggygGMahPn9lu4vz2a8YA
         pzUGlqsC1rRxqU5FBKXlYul0sDfqTKRXWTnRWjXJ6vxa9Ev3PGCKS6JTnnbXydbsbi3P
         VgINWMt/RBmjrzeIt920eX56Yd8A3HQli61LZnwJqVq1TxkEx+xAqQH8kgjIXWumVGBm
         QpjC4eZwStzxDLhLHj9foqssSiPhyReh6KJjUrFQVurI91DSBx0jDFmKuO0qDaIWM4dO
         4f+3iQNJxxCbwMFzbO8Cd/d7umuLTcQbsLqFCs13xs9syfy6QuPsRSNO4loUqzBPKHDq
         lFpQ==
X-Gm-Message-State: AHYfb5j6Ov62HgxvMq74gOB1C8o/dC3CNR4ife/a9S9HaMVgLgiEU1XT
        GSACgO2xiL0/RdTafXOkOg==
X-Received: by 10.99.96.150 with SMTP id u144mr8653429pgb.338.1502303732210;
        Wed, 09 Aug 2017 11:35:32 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:2958:5ad1:cb09:f54c])
        by smtp.gmail.com with ESMTPSA id k4sm9830973pfk.26.2017.08.09.11.35.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 09 Aug 2017 11:35:32 -0700 (PDT)
Date:   Wed, 9 Aug 2017 11:35:27 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/5] interpret-trailers: add an option to show only the
 trailers
Message-ID: <20170809113527.292c1776@twelve2.svl.corp.google.com>
In-Reply-To: <20170809122402.7y4g5g5y2kkrky5e@sigill.intra.peff.net>
References: <20170809122147.g44nwaitzctbadzm@sigill.intra.peff.net>
        <20170809122402.7y4g5g5y2kkrky5e@sigill.intra.peff.net>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 9 Aug 2017 08:24:03 -0400
Jeff King <peff@peff.net> wrote:

> diff --git a/trailer.c b/trailer.c
> index 0a0c2c264d..a4ff99f98a 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -164,13 +164,15 @@ static void print_tok_val(FILE *outfile, const char *tok, const char *val)
>  		fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
>  }
>  
> -static void print_all(FILE *outfile, struct list_head *head, int trim_empty)
> +static void print_all(FILE *outfile, struct list_head *head,
> +		      struct process_trailer_options *opts)

This can be const, I think. (Same thing for patch 1.)

>  {
>  	struct list_head *pos;
>  	struct trailer_item *item;
>  	list_for_each(pos, head) {
>  		item = list_entry(pos, struct trailer_item, list);
> -		if (!trim_empty || strlen(item->value) > 0)
> +		if ((!opts->trim_empty || strlen(item->value) > 0) &&
> +		    (!opts->only_trailers || item->token))
>  			print_tok_val(outfile, item->token, item->value);
>  	}
>  }
> @@ -897,9 +899,10 @@ static int process_input_file(FILE *outfile,
>  	trailer_info_get(&info, str);
>  
>  	/* Print lines before the trailers as is */
> -	fwrite(str, 1, info.trailer_start - str, outfile);
> +	if (outfile)

Any reason why you expect outfile to possibly be NULL?

> +		fwrite(str, 1, info.trailer_start - str, outfile);
>  
> -	if (!info.blank_line_before_trailer)
> +	if (outfile && !info.blank_line_before_trailer)

Same comment here.

>  		fprintf(outfile, "\n");
>  
>  	for (i = 0; i < info.trailer_nr; i++) {
