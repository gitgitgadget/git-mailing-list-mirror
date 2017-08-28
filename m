Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C9F4D208DB
	for <e@80x24.org>; Mon, 28 Aug 2017 23:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbdH1XGK (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Aug 2017 19:06:10 -0400
Received: from mail-qk0-f194.google.com ([209.85.220.194]:33556 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751190AbdH1XGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Aug 2017 19:06:09 -0400
Received: by mail-qk0-f194.google.com with SMTP id i69so1699047qkh.0
        for <git@vger.kernel.org>; Mon, 28 Aug 2017 16:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=K9zM0X15ToyQPCmJ5zbAXHKOy71uf0wW0Juny1yC5/E=;
        b=cFEq2/oyNHFJW+mtcLgt6521E7HDDmUPJlrr1PpvNRBpG1XPhfQOVo7S9X86Hqk3DF
         Yz7eNXNcts6t04yuJSBkq26j8BlUWuXehcYx+4o3nzTfD9CIL2bpZ897I0kDlcNwGi5Q
         b2hAO+N865bk7zzB5shA6hDgZfXpnDspEKU4Y/FnbVuI8kX5yE5w/cUuSviuXk5/7vli
         XkUfd2F2+7xpOnuGqp070NgzyK1kwci4N6lZT/tqFHD8+r24js0nCkrX2VKohsPFg5I+
         OydjgwleTD8E/ZnENoQBMbdvKiW7G+Xx8k/U05+b9mHZxW+2DqDN9FEta3DjVx4VGE5F
         EBLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=K9zM0X15ToyQPCmJ5zbAXHKOy71uf0wW0Juny1yC5/E=;
        b=OgiUugILsm09k0LukDt7rDpRFdZuhTTnSC6IlegLvlxbe7Pr0PqKnU/brmVJGeG50e
         Mwn4VJ/5z9KwqVsG7Qz6q7+6VUL81036jsjf5egSg2u3ZMg7znBqdG37c9nM6bQsTm2T
         GNuDS1v3JtJCWByIBvjgr9YiDDc0EGlzOAVYitE9uL0od5etqpoY3Buo6KFxhAe1jtN0
         tNoXgpHI32CMjp5A5dhCtw79CM/jvp4sfgLOyi7EnnVhQO6KqzMhhticH0bOfUCVtGDe
         aTx18tiCLwlxjXGPbHqKBSSnD50jkvaJmK+FMrbCBKmh1kg0Q41Q5USFnzo2syjN9d3L
         Ygdg==
X-Gm-Message-State: AHYfb5jX73c4zEDgn0IdR8X0+SeVANNE5OXKgzWVHpHuqdsZw3RAupPd
        Z0+KbAyZb4SB9w==
X-Received: by 10.55.73.213 with SMTP id w204mr2910177qka.231.1503961568818;
        Mon, 28 Aug 2017 16:06:08 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id n125sm997709qke.66.2017.08.28.16.06.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Aug 2017 16:06:07 -0700 (PDT)
Subject: Re: [PATCH 3/3] merge-recursive: change current file dir string_lists
 to hashmap
To:     Kevin Willford <kewillf@microsoft.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net
References: <20170828202829.3056-1-kewillf@microsoft.com>
 <20170828202829.3056-4-kewillf@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <a9140320-05df-d45b-19bc-e67a7a5b6eb9@gmail.com>
Date:   Mon, 28 Aug 2017 19:06:08 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20170828202829.3056-4-kewillf@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/28/2017 4:28 PM, Kevin Willford wrote:
> The code was using two string_lists, one for the directories and
> one for the files.  The code never checks the lists independently
> so we should be able to only use one list.  The string_list also
> is a O(log n) for lookup and insertion.  Switching this to use a
> hashmap will give O(1) which will save some time when there are
> millions of paths that will be checked.
> 

Good observation that the two string lists were never used 
independently.  Perhaps the intent was to help the O(log n) issue by 
splitting them up?  A single hashmap is much faster.  Looks good.


> Signed-off-by: Kevin Willford <kewillf@microsoft.com>
> ---
>   merge-recursive.c | 48 +++++++++++++++++++++++++++++++++++++-----------
>   merge-recursive.h |  3 +--
>   2 files changed, 38 insertions(+), 13 deletions(-)
> 
> diff --git a/merge-recursive.c b/merge-recursive.c
> index d47f40ea81..ef4fe5f09f 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -24,6 +24,26 @@
>   #include "dir.h"
>   #include "submodule.h"
>   
> +struct path_hashmap_entry {
> +	struct hashmap_entry;
> +	char path[FLEX_ARRAY];
> +};
> +
> +static unsigned int (*pathhash)(const char *path);
> +static int (*pathcmp)(const char *a, const char *b);
> +
> +static int path_hashmap_cmp(const void *cmp_data,
> +			    const void *entry,
> +			    const void *entry_or_key,
> +			    const void *keydata)
> +{
> +	const struct path_hashmap_entry *a = entry;
> +	const struct path_hashmap_entry *b = entry_or_key;
> +	const char *key = keydata;
> +
> +	return pathcmp(a->path, key ? key : b->path);
> +}
> +
>   static void flush_output(struct merge_options *o)
>   {
>   	if (o->buffer_output < 2 && o->obuf.len) {
> @@ -314,15 +334,15 @@ static int save_files_dirs(const unsigned char *sha1,
>   		struct strbuf *base, const char *path,
>   		unsigned int mode, int stage, void *context)
>   {
> +	struct path_hashmap_entry *entry;
>   	int baselen = base->len;
>   	struct merge_options *o = context;
>   
>   	strbuf_addstr(base, path);
>   
> -	if (S_ISDIR(mode))
> -		string_list_insert(&o->current_directory_set, base->buf);
> -	else
> -		string_list_insert(&o->current_file_set, base->buf);
> +	FLEX_ALLOC_MEM(entry, path, base->buf, base->len);
> +	hashmap_entry_init(entry, pathhash(entry->path));
> +	hashmap_add(&o->current_file_dir_set, entry);
>   
>   	strbuf_setlen(base, baselen);
>   	return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> @@ -642,6 +662,8 @@ static void add_flattened_path(struct strbuf *out, const char *s)
>   
>   static char *unique_path(struct merge_options *o, const char *path, const char *branch)
>   {
> +	struct path_hashmap_entry dummy;
> +	struct path_hashmap_entry *entry;
>   	struct strbuf newpath = STRBUF_INIT;
>   	int suffix = 0;
>   	size_t base_len;
> @@ -650,14 +672,17 @@ static char *unique_path(struct merge_options *o, const char *path, const char *
>   	add_flattened_path(&newpath, branch);
>   
>   	base_len = newpath.len;
> -	while (string_list_has_string(&o->current_file_set, newpath.buf) ||
> -	       string_list_has_string(&o->current_directory_set, newpath.buf) ||
> +	hashmap_entry_init(&dummy, pathhash(newpath.buf));
> +	while (hashmap_get(&o->current_file_dir_set, &dummy, newpath.buf) ||
>   	       (!o->call_depth && file_exists(newpath.buf))) {
>   		strbuf_setlen(&newpath, base_len);
>   		strbuf_addf(&newpath, "_%d", suffix++);
> +		hashmap_entry_init(&dummy, pathhash(newpath.buf));
>   	}
>   
> -	string_list_insert(&o->current_file_set, newpath.buf);
> +	FLEX_ALLOC_MEM(entry, path, newpath.buf, newpath.len);
> +	hashmap_entry_init(entry, pathhash(entry->path));
> +	hashmap_add(&o->current_file_dir_set, entry);
>   	return strbuf_detach(&newpath, NULL);
>   }
>   
> @@ -1941,8 +1966,7 @@ int merge_trees(struct merge_options *o,
>   	if (unmerged_cache()) {
>   		struct string_list *entries, *re_head, *re_merge;
>   		int i;
> -		string_list_clear(&o->current_file_set, 1);
> -		string_list_clear(&o->current_directory_set, 1);
> +		hashmap_init(&o->current_file_dir_set, path_hashmap_cmp, NULL, 512);
>   		get_files_dirs(o, head);
>   		get_files_dirs(o, merge);
>   
> @@ -1978,6 +2002,8 @@ int merge_trees(struct merge_options *o,
>   		string_list_clear(re_head, 0);
>   		string_list_clear(entries, 1);
>   
> +		hashmap_free(&o->current_file_dir_set, 1);
> +
>   		free(re_merge);
>   		free(re_head);
>   		free(entries);
> @@ -2179,8 +2205,8 @@ void init_merge_options(struct merge_options *o)
>   	if (o->verbosity >= 5)
>   		o->buffer_output = 0;
>   	strbuf_init(&o->obuf, 0);
> -	string_list_init(&o->current_file_set, 1);
> -	string_list_init(&o->current_directory_set, 1);
> +	pathhash = ignore_case ? strihash : strhash;
> +	pathcmp = ignore_case ? strcasecmp : strcmp;
>   	string_list_init(&o->df_conflict_file_set, 1);
>   }
>   
> diff --git a/merge-recursive.h b/merge-recursive.h
> index 735343b413..80d69d1401 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -25,8 +25,7 @@ struct merge_options {
>   	int show_rename_progress;
>   	int call_depth;
>   	struct strbuf obuf;
> -	struct string_list current_file_set;
> -	struct string_list current_directory_set;
> +	struct hashmap current_file_dir_set;
>   	struct string_list df_conflict_file_set;
>   };
>   
> 
