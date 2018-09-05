Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74AD41F404
	for <e@80x24.org>; Wed,  5 Sep 2018 12:06:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeIEQgT (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 12:36:19 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43211 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726361AbeIEQgT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 12:36:19 -0400
Received: by mail-qk1-f196.google.com with SMTP id 130-v6so4633663qkd.10
        for <git@vger.kernel.org>; Wed, 05 Sep 2018 05:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0n84Q538PghyT30NMNhg+4N+dddSr/m56/ypLmQSNws=;
        b=D17ZgfdRiuM/R4qvU21FGhkk5eFojrXl10ggVZ1NgekU8cdKTRVN0lMQp5bW8tjJF9
         orcAINdluJzus8Ey3UpleYTNo9r92WqPypAgI2xNUSvmYTl5F4BjYC0PwsDpzqKwcy5i
         4nkW0PHeowNw9jJmJgIXPYvq/8IngrpjFTMhHEGTUpi9Qt1beu+7+rRbzJ7wfHNdwYYq
         o4jZn1M16gmlSY1SD6ybuAaM6eFPZbE4vYaj/vgD/M0qA4IUvHKy383MkP7SKoJmWKyW
         oN8hrZRwvZLCE37cNhvBsr/RRldJKYl910qeDmeIhMJveodFTiLxuynNrtfSp5ERPLEW
         XRrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0n84Q538PghyT30NMNhg+4N+dddSr/m56/ypLmQSNws=;
        b=qFiDVPTcVtV/fHPpWu+fRyie1CsTwv9caC+IvyeXzIJU/Pch+BWzXUBgDXN5pBJbsC
         j/s0OyUcPL6/3ulyJzwwp1Rbdkv5db1t8q5sHXfE6QKRm8uyyZ1459n8pBYSpumICrOk
         IV0M2QS8tBC+7dsxjqgGm08fcLUSKzuFSKnk4z7MPybrNsACIxQtFPZi+qRIhZBSZwNr
         cs+5vC31CXNmQUWux+qXOrlKCwO0nV2JhdUymVWElTP8cztWXOEAzTH1rfWYGTDZEzOj
         BzlEgqBrPM7Zlbb5yYVxVkz6iB8lXsfeU311A8l4Ecs/LgG8wTCCu29HcpJvaRAOX6Ww
         CPAQ==
X-Gm-Message-State: APzg51CqTQT5kVPnBwztWFl7BOlvL2Ao+OtLD5x7cNLuRhooZLDnQCGA
        09mPlz4jJX4JgxI7C0F8f+4=
X-Google-Smtp-Source: ANB0VdYn5QygbGC1Ig5dzvUE+jSwJ6sqRn/c8BkAHgdvPB6fPa5dxJXSsNCbV9XA+53nDDHj+2f1JQ==
X-Received: by 2002:a37:b286:: with SMTP id b128-v6mr32452711qkf.158.1536149181493;
        Wed, 05 Sep 2018 05:06:21 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:846:acea:77a8:94b8? ([2001:4898:8010:0:f17b:acea:77a8:94b8])
        by smtp.gmail.com with ESMTPSA id p30-v6sm1117020qta.4.2018.09.05.05.06.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 05:06:20 -0700 (PDT)
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20180904202729.13900-1-avarab@gmail.com>
 <20180904202729.13900-2-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <bd12692c-e169-31aa-03c8-4d229e85c925@gmail.com>
Date:   Wed, 5 Sep 2018 08:06:21 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180904202729.13900-2-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/4/2018 4:27 PM, Ævar Arnfjörð Bjarmason wrote:
> @@ -591,8 +597,13 @@ static void close_reachable(struct packed_oid_list *oids)
>   {
>   	int i;
>   	struct commit *commit;
> +	struct progress *progress = NULL;
> +	int j = 0;

The change below over-counts the number of commits we are processing (by 
at least double, possibly triple).


> +	progress = start_delayed_progress(
> +		_("Annotating commits in commit graph"), 0);
>   	for (i = 0; i < oids->nr; i++) {
> +		display_progress(progress, ++j);
>   		commit = lookup_commit(the_repository, &oids->list[i]);
>   		if (commit)
>   			commit->object.flags |= UNINTERESTING;
This count is the number of oids given to the method. For 'git 
commit-graph write --reachable', this will be the number of refs.
> @@ -604,6 +615,7 @@ static void close_reachable(struct packed_oid_list *oids)
>   	 * closure.
>   	 */
>   	for (i = 0; i < oids->nr; i++) {
> +		display_progress(progress, ++j);
>   		commit = lookup_commit(the_repository, &oids->list[i]);
>   
>   		if (commit && !parse_commit(commit))

This is the important count, since we will be parsing commits and adding 
their parents to the list. The bulk of the work happens here.

> @@ -611,19 +623,25 @@ static void close_reachable(struct packed_oid_list *oids)
>   	}
>   
>   	for (i = 0; i < oids->nr; i++) {
> +		display_progress(progress, ++j);
>   		commit = lookup_commit(the_repository, &oids->list[i]);
This iterates through the commits a second time and removes the 
UNINTERESTING flag.
>   
>   		if (commit)
>   			commit->object.flags &= ~UNINTERESTING;
>   	}
> +	stop_progress(&progress);
>   }

I think it is good to have the progress start before the first loop and 
end after the third loop, but the middle loop has the important count.

I tried deleting the first and third display_progress() methods and 
re-ran the process on the Linux repo and did not notice a delay at the 
0% and 100% progress spots. The count matches the number of commits.

Thanks,

-Stolee

