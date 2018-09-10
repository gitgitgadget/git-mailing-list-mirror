Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D788B1F404
	for <e@80x24.org>; Mon, 10 Sep 2018 15:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbeIJUx3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Sep 2018 16:53:29 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46805 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728268AbeIJUx3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Sep 2018 16:53:29 -0400
Received: by mail-qt0-f195.google.com with SMTP id d4-v6so24683676qtn.13
        for <git@vger.kernel.org>; Mon, 10 Sep 2018 08:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O6ctuyRzvNIO7dCdrTPvArhBO6reOMZDFBqVfMg2EsU=;
        b=n8onIXNWaQrWY9Y479RA21EoqEZo2UMePQvSe8/8sAn7VkLdNjnMTcoC0Pnbtlv/ra
         oR0XTHKgDGoDy9Qj8o9qSwC9zO4sUUMrEhZG/EjQI08JRFWtWFJ4Swe2P0XtOOTFVIiD
         FO8EtjDHiX/lWSsqiGRkRvcAjnFOsIdQMtwr99MknXRD6pWopEW7eN1HiLLocxP5eO3/
         lXj0OPhRQPFVLOhh3joCQJX05Ent5NYVSgNbapc5pOizv/fo3qDdBw7/fxcnRPOOX9hd
         tFagUYHYkQs7p4yEe5zKhCV8D22KxMVg3zwZE0h/w+NpFkEM5vqa+xtkGv2ajwA0Dp6s
         /HTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O6ctuyRzvNIO7dCdrTPvArhBO6reOMZDFBqVfMg2EsU=;
        b=F5sDagn19tmexnmWTL+tjcQVAeKcoL+CwPVsNE0NEXzimn7w3yBjK0fwWUUnp/Bjbl
         /ER0sJFnlL62THH40Wtwx7AlJfY1Oyam4oAl3kFxX94MhUwGw/haxQPAJ2h5YTI6uNJN
         d/4Q6T4ev3SszFsV2l9ipXafAAwfAiUQN7BqaSHak06OKt3brnYTtbpbKlt2TKpaTWqW
         RpxzK3pdl7BfwimEl5AUN7vrxPare94zJ2gF10nZhKnkMHBLBNEjSTYTRDB3lS1m+1a6
         7oCmPuduo8QcOhqIrNcCxxzqTMg/DqAlHBtb/rfh1cZQHBIRgEeCY4pnF5AHYT5Y5Jr5
         p+iw==
X-Gm-Message-State: APzg51AOyWre0zXhtjcjgumcWwoWWJDearfIstmg8aANE9V3+1s6+DlA
        zAQv8gbvq3+hWuS55sJScJo=
X-Google-Smtp-Source: ANB0VdZyQBkgR1JZh/c06mMz0Ht6SOSbO5uHl5HyFqvT9F5TELsI+LQDnkVfTBZhVH2RspGAXOGksQ==
X-Received: by 2002:a0c:fc49:: with SMTP id w9-v6mr15134190qvp.166.1536595124115;
        Mon, 10 Sep 2018 08:58:44 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id k9-v6sm12966595qtk.2.2018.09.10.08.58.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Sep 2018 08:58:43 -0700 (PDT)
Subject: Re: [PATCH] git-mv: allow submodules and fsmonitor to work together
To:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org
Cc:     Ben.Peart@microsoft.com, avarab@gmail.com, gitster@pobox.com
References: <CAGZ79kY_+jNAu4jwVOhd+gVMELDSjk_MACKBRf51tksrzZMx-A@mail.gmail.com>
 <20180906203444.162213-1-sbeller@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <85d96d65-2e74-7877-80ab-f74fdb81d500@gmail.com>
Date:   Mon, 10 Sep 2018 11:58:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180906203444.162213-1-sbeller@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 9/6/2018 4:34 PM, Stefan Beller wrote:
> It was reported that
> 
>    GIT_FSMONITOR_TEST=$PWD/t7519/fsmonitor-all ./t7411-submodule-config.sh
> 
> breaks as the .gitmodules file is modified and staged after the fsmonitor
> considers it clean. Mark the .gitmodules file to be not clean before
> staging.
> 
> Reported-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> Inspired-by: Ben Peart <benpeart@microsoft.com>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> 
> I am not quite sure if this is the correct approach and handling of the
> fsmonitor API, but it unbreaks the test.
> 
>> Just naively adding mark_fsmonitor_invalid doesn't work, as then ...
> 
> Adding it before the staging, works.
> 
> Please double check!

I took a look at this bug/patch and wondered why add_file_to_index() 
wasn't properly handling the .gitmodules file.  On investigation, I 
chased it down to what looks like a faulty test in 
is_staging_gitmodules_ok().

I believe the following is a better patch for this bug:

diff --git a/submodule.c b/submodule.c
index 50cbf5f13e..1e7194af28 100644
--- a/submodule.c
+++ b/submodule.c
@@ -65,8 +65,7 @@ int is_staging_gitmodules_ok(struct index_state *istate)
         if ((pos >= 0) && (pos < istate->cache_nr)) {
                 struct stat st;
                 if (lstat(GITMODULES_FILE, &st) == 0 &&
-                   ie_match_stat(istate, istate->cache[pos], &st,
-                                 CE_MATCH_IGNORE_FSMONITOR) & DATA_CHANGED)
+                   ie_match_stat(istate, istate->cache[pos], &st, 0) & 
DATA_CHANGED)
                         return 0;
         }

Please double check but I just don't understand why the .gitmodules file 
should force the fsmonitor data to be ignored.  This flag was added to 
enable proper behavior in the preload_thread() logic and I don't believe 
it is appropriate here.

Ben

> 
> Thanks,
> Stefan
> 
>   submodule.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/submodule.c b/submodule.c
> index 50cbf5f13ed..56b0d5fe24e 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -22,6 +22,7 @@
>   #include "worktree.h"
>   #include "parse-options.h"
>   #include "object-store.h"
> +#include "fsmonitor.h"
>   
>   static int config_update_recurse_submodules = RECURSE_SUBMODULES_OFF;
>   static struct string_list changed_submodule_names = STRING_LIST_INIT_DUP;
> @@ -149,6 +150,15 @@ int remove_path_from_gitmodules(const char *path)
>   
>   void stage_updated_gitmodules(struct index_state *istate)
>   {
> +	struct cache_entry *ce;
> +	int pos;
> +
> +	pos = index_name_pos(istate, GITMODULES_FILE, strlen(GITMODULES_FILE));
> +	ce = (0 <= pos) ? istate->cache[pos] : NULL;
> +
> +	if (ce)
> +		mark_fsmonitor_invalid(istate, ce);
> +
>   	if (add_file_to_index(istate, GITMODULES_FILE, 0))
>   		die(_("staging updated .gitmodules failed"));
>   }
> 
