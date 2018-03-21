Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 39FC21FAE2
	for <e@80x24.org>; Wed, 21 Mar 2018 22:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754031AbeCUWfU (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 18:35:20 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38218 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754048AbeCUWem (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 18:34:42 -0400
Received: by mail-pg0-f66.google.com with SMTP id a15so2509543pgn.5
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 15:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=+yosZm8LahYhltFMx1yslI8RKhiCfg1t4JOkkjqV0og=;
        b=Npgwn/FDDL+aMHkFu94vDbcvkfGapBHgvcDJ8sfW1mHXP7kQIPYyOq3ZfQ8ljOThxR
         Mw6m1Q9xGz0lGje/1ZAfHDxuAo8OWVW75B2EuFHbjWMTMJ95iF0nXP5bwWNR2vXVtnFj
         wjBdfiM9LGyvRzFG3jjOiKa7SvtHanEYjQgTm/tKLDP578uop6ZjHizlGUf0LsTyl+Q0
         XXdCO+Gu1pY74LCzPEu9DZB7jpN08nHJ/3OSOE9nPaPysVDlg5tl0N9gt5NA2fCOue5R
         nHg1hALlMhaB9FzSoc5llni8YVtCNp7Z5oAglarebgvXvIyhBt2IPbS3E6FZgxT+mUEi
         Dqxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=+yosZm8LahYhltFMx1yslI8RKhiCfg1t4JOkkjqV0og=;
        b=unQMQHi3oac2p/6kaLIl90jKUESGwG12vTF6E27AbkUXhhpaUAG5Equ8IrA9YNdOv/
         oxXNjocpJdT3a7TG3jDgaATH0pH3EeNzKf8A/Sy1TAuZsbLfQBX+taEFW9e9vLcJAXsx
         OXJB/nxcwFabfehbfgpitCwJ7nK9G710wwuOJ75Cui+4shki8P2kZ4QWTNQ5QJOB8c6i
         /RsMdjI5naA7HPAHGHotiATgRhxzUqDa+rNbnGr118zWWYoUeeefwXnNfnXOZjpZpRLL
         5CE2m5zs9QT76OYCk/seJ3T2NZLiufrlUppDZO5urSxlmelQnBAWjYQD/7PSTGI5fvxz
         /5kQ==
X-Gm-Message-State: AElRT7GaT3gRPjg1+741WK1NJ43nDPPa8hYcZ2pjdO1wEO4jBZd0KOcX
        9FtpTbodCXO9IRUG8hur0g4Rbg==
X-Google-Smtp-Source: AG47ELt2c/gu+LVHDZiLmPh3x9GXJaSE2ZNIjeBSEQwGiaDJn9ojqdN/p27j7ZfPAPjcMAS1Ug3b6A==
X-Received: by 10.99.182.73 with SMTP id v9mr15880247pgt.158.1521671681729;
        Wed, 21 Mar 2018 15:34:41 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id b73sm8866433pga.62.2018.03.21.15.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 15:34:40 -0700 (PDT)
Date:   Wed, 21 Mar 2018 15:34:40 -0700
From:   Brandon Williams <bmwill@google.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 32/44] sha1_file: allow sha1_loose_object_info to handle
 arbitrary repositories
Message-ID: <20180321223440.GA202156@google.com>
References: <CACsJy8DWrNzZM1K2vkx2XiETdAR5WhwXEdPijsxd0ZD4Lj=tZw@mail.gmail.com>
 <20180303113637.26518-1-pclouds@gmail.com>
 <20180303113637.26518-33-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180303113637.26518-33-pclouds@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 03/03, Nguyễn Thái Ngọc Duy wrote:
> From: Jonathan Nieder <jrnieder@gmail.com>
> 
> Signed-off-by: Stefan Beller <sbeller@google.com>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Patches up to here look sane.

> ---
>  sha1_file.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/sha1_file.c b/sha1_file.c
> index c5a8b00aed..7066d4c9ce 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1149,10 +1149,9 @@ int parse_sha1_header(const char *hdr, unsigned long *sizep)
>  	return parse_sha1_header_extended(hdr, &oi, 0);
>  }
>  
> -#define sha1_loose_object_info(r, s, o, f) sha1_loose_object_info_##r(s, o, f)
> -static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
> -						 struct object_info *oi,
> -						 int flags)
> +static int sha1_loose_object_info(struct repository *r,
> +				  const unsigned char *sha1,
> +				  struct object_info *oi, int flags)
>  {
>  	int status = 0;
>  	unsigned long mapsize;
> @@ -1176,14 +1175,14 @@ static int sha1_loose_object_info_the_repository(const unsigned char *sha1,
>  	if (!oi->typep && !oi->typename && !oi->sizep && !oi->contentp) {
>  		const char *path;
>  		struct stat st;
> -		if (stat_sha1_file(the_repository, sha1, &st, &path) < 0)
> +		if (stat_sha1_file(r, sha1, &st, &path) < 0)
>  			return -1;
>  		if (oi->disk_sizep)
>  			*oi->disk_sizep = st.st_size;
>  		return 0;
>  	}
>  
> -	map = map_sha1_file(the_repository, sha1, &mapsize);
> +	map = map_sha1_file(r, sha1, &mapsize);
>  	if (!map)
>  		return -1;
>  
> -- 
> 2.16.1.435.g8f24da2e1a
> 

-- 
Brandon Williams
