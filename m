Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D98D1F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1760281AbeAISEO (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:04:14 -0500
Received: from mail-pg0-f47.google.com ([74.125.83.47]:36408 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1760276AbeAISEN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:04:13 -0500
Received: by mail-pg0-f47.google.com with SMTP id j2so7291109pgv.3
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 10:04:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xOmBTFvQrXLLOqDH9j6ow2/eCxeZSpZZ7+4Px+36fCI=;
        b=T/dZtXQImmqSq9+X+MEQMkaxlyMllEGrYkMERZHWTMM8NCLlQEFzqoaYLIBp4MPGfS
         mchsummmPsS41gsf6jfNmgXaSDhTVG4GNEaugBREGvI5nEDuOa5VOCfffbqCjwowe+3I
         tAIZ6M8d9oWwqCc9Qvi5eGeaAH28wgwTKNn3XulsRrJbnISmcslss4IHHpVFdECKEXuR
         lmXeQFBuQas0CWWgmbmB0enqDfI8NnJsed0olKeKDBlMHE6YFKnXtQ0Z027bWwrLgN6L
         akJfGVI5D4E1J0ouOFLpa46SNRRptLR5JLX/MVc4rnMoMj/iTfO6vOAlmm7A+f6o3ZRq
         FCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xOmBTFvQrXLLOqDH9j6ow2/eCxeZSpZZ7+4Px+36fCI=;
        b=LviuFnVajVE57bfD1b8aSrSATBinK2THDX48W47Pzw3KBZXg9P/XDDmZClMJC2ATlP
         B29jyhl0IrybiAoQm/6EXWVipTdXBsn3grh/6Ng2FrF7l/BZ7W/v8cgdqpHiOWnvWQfZ
         mFWBq0TJFQD2CP1TBOGG13hnpiqUwLW2X4emVceQPl24DSOusfgMHJcuwfyu6hE3qmzh
         acn490cOgjgIfaQP/NjRfNtSc/jWeEBAGxbkQhR0GipB4RWHKoX9azfeFKjbTlK0A62R
         /DjEV/rHoYTKvSEaL3aR18vkDArwA+EAiRGIPHDvYfoEHbucFbZj6YTuk7gX3sX05yzO
         vRjg==
X-Gm-Message-State: AKGB3mI9JUvo7v3EsD9JISl/iHSTv3WbT8g1r9LRZ8d6c9jC2f7pYlSx
        1aUVr37ab83P3/ktwSjb9/SlnQ==
X-Google-Smtp-Source: ACJfBotuBqyhF+dD94pJY8JOEmgXhEcQsoHvihzHMslqBMRQd91XJbxv+41P2tRwcUwiQKCBK7FGFg==
X-Received: by 10.84.128.72 with SMTP id 66mr16005453pla.284.1515521053262;
        Tue, 09 Jan 2018 10:04:13 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:592e:240e:24e2:56aa])
        by smtp.gmail.com with ESMTPSA id s25sm28492974pge.63.2018.01.09.10.04.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 10:04:12 -0800 (PST)
Date:   Tue, 9 Jan 2018 10:04:11 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, gitster@pobox.com,
        peff@peff.net, philipoakley@iee.org, stolee@gmail.com,
        jrnieder@gmail.com
Subject: Re: [PATCH 01/26] pkt-line: introduce packet_read_with_status
Message-Id: <20180109100411.b63dd903e2037372e4a28a91@google.com>
In-Reply-To: <20180103001828.205012-2-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com>
        <20180103001828.205012-2-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  2 Jan 2018 16:18:03 -0800
Brandon Williams <bmwill@google.com> wrote:

> -int packet_read(int fd, char **src_buf, size_t *src_len,
> -		char *buffer, unsigned size, int options)
> +enum packet_read_status packet_read_with_status(int fd, char **src_buffer, size_t *src_len,
> +						char *buffer, unsigned size, int *pktlen,
> +						int options)
>  {
> -	int len, ret;
> +	int len;
>  	char linelen[4];
>  
> -	ret = get_packet_data(fd, src_buf, src_len, linelen, 4, options);
> -	if (ret < 0)
> -		return ret;
> +	if (get_packet_data(fd, src_buffer, src_len, linelen, 4, options) < 0)
> +		return PACKET_READ_EOF;
> +
>  	len = packet_length(linelen);
>  	if (len < 0)
>  		die("protocol error: bad line length character: %.4s", linelen);
> -	if (!len) {
> +
> +	if (len == 0) {

This change (replacing "!len" with "len == 0") is unnecessary, I think.

>  		packet_trace("0000", 4, 0);
> -		return 0;
> +		return PACKET_READ_FLUSH;
> +	} else if (len >= 1 && len <= 3) {
> +		die("protocol error: bad line length character: %.4s", linelen);
>  	}

This seems to be more of a "bad line length" than a "bad line length
character".

Also, some of the checks are redundant. Above, it is probably better to
delete "len >= 1", and optionally write "len < 4" instead of "len <= 3"
(to emphasize that the subtraction of 4 below does not result in a
negative value).

> +
>  	len -= 4;
> -	if (len >= size)
> +	if ((len < 0) || ((unsigned)len >= size))
>  		die("protocol error: bad line length %d", len);

The "len < 0" check is redundant.

> -	ret = get_packet_data(fd, src_buf, src_len, buffer, len, options);
> -	if (ret < 0)
> -		return ret;
> +
> +	if (get_packet_data(fd, src_buffer, src_len, buffer, len, options) < 0)
> +		return PACKET_READ_EOF;
>  
>  	if ((options & PACKET_READ_CHOMP_NEWLINE) &&
>  	    len && buffer[len-1] == '\n')
