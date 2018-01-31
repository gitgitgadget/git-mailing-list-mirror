Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B051F404
	for <e@80x24.org>; Wed, 31 Jan 2018 14:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753632AbeAaOpq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jan 2018 09:45:46 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35095 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752492AbeAaOpp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jan 2018 09:45:45 -0500
Received: by mail-qk0-f174.google.com with SMTP id 69so1837766qkz.2
        for <git@vger.kernel.org>; Wed, 31 Jan 2018 06:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qt5QUbX6l9UH0x+0zwjy9TZC1mOLhj4df69QK2lQDtg=;
        b=vJO4B5CMOsud5boQbvd17MvSujNwmdXIoD2iBpx7ArlucjIcTIQBxKqWwZ0UdU4qBo
         upLuvq6PtVLRZB22TDOk5W4DztJOwvLzu5TjlyhrPMG2q8Fb542za10Ir422uosePLk3
         ie3qSIG0VfeMcAtaTspFTHa8/z5A8cNnL0qDJ8uzxno66KulMEHU2uZJ32BW65VNyUS+
         nyjpGydDsoeEDJMPzrYE6260KxHmf8niJyriMJFNOGKMPgvJnvCyYaqbYSqqX4ugo8Mp
         757gpQ90yeXkn0AzhXFdNulVvFs4QpUih0D/VYc6GMwneAS2BuGz1M92BlvQhrtrcTlB
         ywEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qt5QUbX6l9UH0x+0zwjy9TZC1mOLhj4df69QK2lQDtg=;
        b=PVLIoqmQUT7w5SYPkPqVHeSRwlOfMkC2ieYrjhHeAtks1akexNhmVQlSUIA7JuUJB1
         FZevfwYSaAd6ghfzHCYJpWda6pr0aIlLVH6VCqinru5fUru9m0RfJQJgpPOSzZrAcmce
         0zBtkCdFy4v8klz4iyKkYo0jZgXiBbV2mTVE0G7nMl7Dt4v1GUExZGCtCH+I/jB+S7u6
         PheCXSL787hSvPeKBAyRb8M6q+swuQNXGV/m/IEMo1jA2+POQdXG5fgh0EoG4AqYZ71v
         sihK9OIedOPaNeisBy0ElOmcAhxekU2d6Kw2hBY2d/VaIDSD7ycaG99AbOYOvjTN8vHA
         Gldw==
X-Gm-Message-State: AKwxytdgPOHO0OOw5e0KvNHkaEoB9ugIXAkiDNFSX/vOZp+f1wagNvyG
        F0FOT3kyZOg+cru4jItXVNI=
X-Google-Smtp-Source: AH8x224DFHGI5rNtz4TRDQnK0f8yzfBIG6v2myT1wkuMbgJROwIdB3czKJ3Pg4QHgUbOaNjjdX7zlA==
X-Received: by 10.55.95.198 with SMTP id t189mr45991053qkb.273.1517409945133;
        Wed, 31 Jan 2018 06:45:45 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id m1sm10752837qkf.8.2018.01.31.06.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jan 2018 06:45:44 -0800 (PST)
Subject: Re: [PATCH v2 09/27] transport: store protocol version
To:     Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, jrnieder@gmail.com
References: <20180103001828.205012-1-bmwill@google.com>
 <20180125235838.138135-1-bmwill@google.com>
 <20180125235838.138135-10-bmwill@google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ae3bd6ae-7335-9aca-0818-a90e202ff37a@gmail.com>
Date:   Wed, 31 Jan 2018 09:45:43 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180125235838.138135-10-bmwill@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 6:58 PM, Brandon Williams wrote:
> +	switch (data->version) {
> +	case protocol_v1:
> +	case protocol_v0:
> +		refs = fetch_pack(&args, data->fd, data->conn,
> +				  refs_tmp ? refs_tmp : transport->remote_refs,
> +				  dest, to_fetch, nr_heads, &data->shallow,
> +				  &transport->pack_lockfile);
> +		break;
> +	case protocol_unknown_version:
> +		BUG("unknown protocol version");
> +	}

After seeing this pattern a few times, I think it would be good to 
convert it to a macro that calls a statement for protocol_v1/v0 (and 
later calls a different one for protocol_v2). It would at minimum reduce 
the code clones surrounding this handling of unknown_version, and we 
could have one place that is clear this BUG() is due to an unexpected 
response from discover_version().

