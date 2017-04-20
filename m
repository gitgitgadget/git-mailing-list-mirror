Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C2191FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 17:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938918AbdDTRYy (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 13:24:54 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36068 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938879AbdDTRYx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 13:24:53 -0400
Received: by mail-qt0-f196.google.com with SMTP id t52so8466401qtb.3
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 10:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=3MmQQhnxs/n/wmCLL1YoH6g5+ot4Sgq3n4Pc2zxJBOA=;
        b=Auc9NPiSsuSGx5+wcLJ0+k1ZWaFMiognubKNpq+1Yg+bYdBsmr9Uvj11/xLviCsSkT
         F5lsSKTRtGzoQ8vbKJR7qTRDoIFUVAde8bLOORc4TMx4upS5PAMalxlQlGDAOIJ/00Cg
         ukaDAcdKAakUZImxjXQG8DemsIP/pK7qxW+iEfsPOvO85LVvWvL2jX6aw4k7VufnEtFJ
         oLSkO7K9f0HhXVYqiZDq/mCbnLxTHjTHp+6zN6AfjvP6qPwf5MaYmqnwrZ0gxSYqTUEU
         tdwfKc4qBKSaoCgZzNFEkLXYT+xMpDo+zD9J/nb8dD3er1LMyGT+cx+Y3urVUsYlMpqO
         ioeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=3MmQQhnxs/n/wmCLL1YoH6g5+ot4Sgq3n4Pc2zxJBOA=;
        b=T8r082UidC+N6s9SsLe7c9NMwS7hpSPgq7CaoDjIVVEUQ+T3+kGX+XZqYxdTF5waVZ
         jNiMFhJQGtq2uK/Q1xngxZ2uPkY//p7xFk4d5zgRWlgebfNNASlZ5z5VYYKhrjY8fGIm
         uVXXe0aXC3cD8fsehRgUw3LPnHAHU7lFzIf8L1S+c4Ml9wiE6knUVJKXZAQJoZ0jozat
         ZYfO/1RHVdOKEgAukNkpjnm31tWi73aSEc+VBc0AEMvhN1AHdClBwdvNFwe/e4KzCtmF
         6eutg9LTPneh+VqNvrX/yP2BjVNOoJ/qymIw5Bf6LhvnQdSoNYcn1P+SVb1Cgji1cGGT
         opjg==
X-Gm-Message-State: AN3rC/4yyHaiimxY8GR766OdjQc/2G8Vhi0okF62lLSF0G+NxiNMbmvT
        w2/aaPzwjWJ45Q==
X-Received: by 10.200.46.150 with SMTP id h22mr10072514qta.157.1492709092133;
        Thu, 20 Apr 2017 10:24:52 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id m57sm4571907qtb.23.2017.04.20.10.24.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 10:24:50 -0700 (PDT)
Subject: Re: [PATCH v5 4/8] convert: Separate generic structures and variables
 from the filter specific ones
To:     Junio C Hamano <gitster@pobox.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
 <20170407120354.17736-5-benpeart@microsoft.com>
 <48FA4601-0819-4DE2-943A-7A791BA7C583@gmail.com>
 <xmqqmvbfk8va.fsf@gitster.mtv.corp.google.com>
 <48448c2c-378d-0d87-2f99-32095326f323@gmail.com>
 <xmqqa87ddwbe.fsf@gitster.mtv.corp.google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        benpeart@microsoft.com, christian.couder@gmail.com
From:   Ben Peart <peartben@gmail.com>
Message-ID: <afcdc386-0122-a33e-fa90-4ddbba32ab66@gmail.com>
Date:   Thu, 20 Apr 2017 13:24:45 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa87ddwbe.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/18/2017 9:23 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
>
>> On 4/16/2017 11:31 PM, Junio C Hamano wrote:
>>> Lars Schneider <larsxschneider@gmail.com> writes:
>>>
>>>> However, I think it eases code maintainability in the long run if a function is "as pure as
>>>> possible" (IOW does rely on global state as less as possible).
>>> If the original relied on a global hashmap and this update kept the
>>> code like so, I wouldn't mind the end result of this series
>>> (i.e. rely on it being global).  But that is not the case.  It is
>>> making the code worse by stopping passing the hashmap through the
>>> callchain.
>> ...  Since it was already a global, I didn't feel
>> like this made it any worse.
> The code before your series can easily lose the globals with the
> attached patch, _exactly_ because it is prepared to be reusable by a
> new caller that supplies its own hashmap by passing it through the
> callchain.  The child-process machinery Lars made for his conversion
> thing, which you are trying to split out to make it reusable, can be
> used by somebody other than apply_multi_file_filter() if you do not
> lose the hashmap; what the new caller needs to do is to supply its
> own hashmap so that they do not interact with the set of processes
> used by Lars's conversion machinery.
>
> If we want to lose the global _after_ applying this patch 4/8, don't
> we have to essentially _undo_ 4/8?  How can it not be seen as making
> it worse?

That's fine.  I'll flip it back in the next spin and enable multiple 
pools of sub-processes.  We'll still need 4/8 but it will be a smaller 
change.

>
>   convert.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/convert.c b/convert.c
> index 8d652bf27c..ff831e85b8 100644
> --- a/convert.c
> +++ b/convert.c
> @@ -503,9 +503,6 @@ struct cmd2process {
>   	struct child_process process;
>   };
>   
> -static int cmd_process_map_initialized;
> -static struct hashmap cmd_process_map;
> -
>   static int cmd2process_cmp(const struct cmd2process *e1,
>   			   const struct cmd2process *e2,
>   			   const void *unused)
> @@ -682,6 +679,9 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
>   	struct strbuf filter_status = STRBUF_INIT;
>   	const char *filter_type;
>   
> +static int cmd_process_map_initialized;
> +static struct hashmap cmd_process_map;
> +
>   	if (!cmd_process_map_initialized) {
>   		cmd_process_map_initialized = 1;
>   		hashmap_init(&cmd_process_map, (hashmap_cmp_fn) cmd2process_cmp, 0);
>

