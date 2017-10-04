Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6559620365
	for <e@80x24.org>; Wed,  4 Oct 2017 13:40:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752314AbdJDNkS (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 09:40:18 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37333 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752288AbdJDNkR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 09:40:17 -0400
Received: by mail-qk0-f194.google.com with SMTP id a12so5342292qka.4
        for <git@vger.kernel.org>; Wed, 04 Oct 2017 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=AF8neOkWpNHxeg9pDgxUKnIoItYSGA3DHCcxnB7U4ME=;
        b=ZOBBTDHs3tgcC9l/O87jfYL+r4I69r8TdZSzmlqQSNqQV2WEfWLDildFK7UhLhoVgx
         TIBsgvlISMfKlI5dgZXkVXYAUZ3utah5sCUXWV4kNFZbVh9luF7A7lmGlc3GxYmCWytX
         7N995hfXKArTzHiIcq+td7mf8ZpeCanE/8qdf7HyL9j/3OZ+sKKnxsr39oysD1JUkMt0
         IYW0zRS8RKr2fKzndDI4RnNO2wy1miC8/eYaSqsmzJ6BzssJRn2KjbbqUaAbSnClHWe3
         5MtZZH/hor59TYyqzoujsaLxRCzmExiD9pDUC4NbeZTuu4Wq4y5Cy76vNobkQsu6z/lO
         XO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=AF8neOkWpNHxeg9pDgxUKnIoItYSGA3DHCcxnB7U4ME=;
        b=jZSqcqncDukb10OJMDKokdAv5JgKJnnMJTx0qUnP4+9oPWnTi0ve0TvrcY55QypHgt
         mTvF3aTi8Aq7uK1i1v3zBLcTXgbllLKOMUPTBpQ8VOBtUBEicIwWBYkpnDKJZwQ++JnN
         X7Iu22RVn4HVtdECymZwvIfxm9mBIlnmOuLVEJR6JPVw1xuAq+A2NqA4PfZA2lJ0qtyA
         kC17Qni8RjJHobJIvL+lgmwUWQxyxL76AfGmVlf0VkyKdlKnMX/oIBU9ZTTllhkTA7NB
         GWkwq10mdOCL3a2M7eYW93hHHMgj34btyAKsE+WxEnmdEimfhKlayHm0D3PhiG9iQmbS
         NZBQ==
X-Gm-Message-State: AMCzsaXUJXJB1vhP/4kQKCeqwu4fmPRapxBcxi+yOBlUQrW6nhW78fDm
        SPDAtOKfxQY3+sgpuW2VQZOP0f3Z
X-Google-Smtp-Source: AOwi7QDHDt0nuGx6OHLdX1AZXISLwaB9Ua8Dc6bIs3HU2hX7cE1IcqJT9NfmrvObeiqzsY8QkqyC3Q==
X-Received: by 10.55.31.163 with SMTP id n35mr25622542qkh.279.1507124416466;
        Wed, 04 Oct 2017 06:40:16 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010::7cc])
        by smtp.gmail.com with ESMTPSA id t9sm3168047qti.47.2017.10.04.06.40.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 06:40:15 -0700 (PDT)
Subject: Re: [PATCH] test-list-objects: mark file-local symbols as static
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>, dstolee@microsoft.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>
References: <5b3d8899-d4c5-c145-7128-21c8aaa4f38f@ramsayjones.plus.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <de2c43ca-2b5c-62e5-80a7-a8513a946558@gmail.com>
Date:   Wed, 4 Oct 2017 09:40:15 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <5b3d8899-d4c5-c145-7128-21c8aaa4f38f@ramsayjones.plus.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/3/2017 5:51 PM, Ramsay Jones wrote:
> Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
> ---
>
> Hi Derrick,
>
> If you need to re-roll your 'ds/find-unique-abbrev-optim' branch,
> could you please squash this into the relevant patch (commit 3792c78ba0,
> "test-list-objects: list a subset of object ids", 01-10-2017).
>
> Thanks!
>
> ATB,
> Ramsay Jones
>
>   t/helper/test-list-objects.c | 32 ++++++++++++++++----------------
>   1 file changed, 16 insertions(+), 16 deletions(-)
>
> diff --git a/t/helper/test-list-objects.c b/t/helper/test-list-objects.c
> index 22bc9b4e6..5c5d3c03f 100644
> --- a/t/helper/test-list-objects.c
> +++ b/t/helper/test-list-objects.c
> @@ -6,43 +6,43 @@ struct count {
>   	int select_mod;
>   };
>   
> -int count_loose(const struct object_id *oid,
> -		const char *path,
> -		void *data)
> +static int count_loose(const struct object_id *oid,
> +		       const char *path,
> +		       void *data)
>   {
>   	((struct count*)data)->total++;
>   	return 0;
>   }
>   
> -int count_packed(const struct object_id *oid,
> -		 struct packed_git *pack,
> -		 uint32_t pos,
> -		 void* data)
> +static int count_packed(const struct object_id *oid,
> +			struct packed_git *pack,
> +			uint32_t pos,
> +			void* data)
>   {
>   	((struct count*)data)->total++;
>   	return 0;
>   }
>   
> -void output(const struct object_id *oid,
> -	    struct count *c)
> +static void output(const struct object_id *oid,
> +		   struct count *c)
>   {
>   	if (!(c->total % c->select_mod))
>   		printf("%s\n", oid_to_hex(oid));
>   	c->total--;
>   }
>   
> -int output_loose(const struct object_id *oid,
> -		 const char *path,
> -		 void *data)
> +static int output_loose(const struct object_id *oid,
> +			const char *path,
> +			void *data)
>   {
>   	output(oid, (struct count*)data);
>   	return 0;
>   }
>   
> -int output_packed(const struct object_id *oid,
> -		  struct packed_git *pack,
> -		  uint32_t pos,
> -		  void* data)
> +static int output_packed(const struct object_id *oid,
> +			 struct packed_git *pack,
> +			 uint32_t pos,
> +			 void* data)
>   {
>   	output(oid, (struct count*)data);
>   	return 0;
Thanks, Ramsay. I applied these changes locally. I'll remember "static" 
in the future.

Thanks,
-Stolee
