Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A0001F462
	for <e@80x24.org>; Wed, 19 Jun 2019 13:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbfFSNDa (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 09:03:30 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40278 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727076AbfFSNDa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 09:03:30 -0400
Received: by mail-qt1-f193.google.com with SMTP id a15so19708690qtn.7
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 06:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=xfqIJ4h0pun//KolUgec2yklsW7skqkNJkEQ7eBcNCw=;
        b=AgJ2Eo2UZFjEvWWLu/439Um6vgVyU494yug768ZoNvJBkYA0JtQz+uEXJhLHSMjp/i
         emjwZOQsQaxq87pK6Je0wSkIrOEnZrHCBO+T5W/2urmS+1kZf15J1XgXcHQDTsSAKXAI
         LD4GVdPAgtgo9xv6ru05+QZ4zO0XC/rWj2VY0OlVDruERgxZi1xutalEAeMdQdGdVx7P
         gQjv1JFHKU3m4ovtDBSmQT0poynYSXlWlSReae3pwoFComgkql33JrYPs5CuMWCk7O+e
         GeeY7LHnlJCPZ4Va1tr0fjQf+m+eK+02lFSfAdMLurAxEPlQ4QV54eQc8aN/LUnIadaS
         4quA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xfqIJ4h0pun//KolUgec2yklsW7skqkNJkEQ7eBcNCw=;
        b=lrt8lmep9KujV3LMvvPbhoh3uQWxgFz5izigAmYg2kM3CWUKHHDFAI4ZkZ5lfCIrxs
         CJeGsRIkTfyrjt9gfHWWpBNH+hnwQp+HrznBZadsaqIa16pfXwUCNetR0T+s7dscb3V0
         DLEu+KZcTpLdU8TZWO1N54DsXYZD5oIHMw4kxmFWc4YeaxU0+usFhHYyzzG8sZ1zOnVN
         BcjSNYX4HVAo2lO86M1GegHO/oPIWM3qToBkJ/LRxCf5AII0goxl9IxI8jUeAKPgta4k
         b5mRjuzp9wzXhvsuAmQXEUFyb3hLNXGYqP+nF88JiLBOhrWJXtLmjzIZGy6smd6zJs3X
         Ngkg==
X-Gm-Message-State: APjAAAU+KN1qmEOBPkQuZ9qSgHkVpedzVBLhlZ4DiyQW1QV1Rgbq+45h
        X46/KLYVy9AN1LDkI6no6LEyC8R8
X-Google-Smtp-Source: APXvYqwkS8fU9lBHFWZEAufKLD1TI4lqpfBw+ip7nLLSOnWP+R+M2lMjDNhWEtDgSIVt0Xb2O4NNiw==
X-Received: by 2002:a05:6214:1306:: with SMTP id a6mr20189523qvv.38.1560949408460;
        Wed, 19 Jun 2019 06:03:28 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id c18sm10274625qkk.73.2019.06.19.06.03.27
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 06:03:27 -0700 (PDT)
Subject: Re: [PATCH 1/8] ls-files: add --json to dump the index
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20190619095858.30124-1-pclouds@gmail.com>
 <20190619095858.30124-2-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e3b8d7bf-486d-d52f-9a33-6a7ff837552e@gmail.com>
Date:   Wed, 19 Jun 2019 09:03:27 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <20190619095858.30124-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2019 5:58 AM, Nguyễn Thái Ngọc Duy wrote:
> So far we don't have a command to basically dump the index file out,
> with all its glory details. Checking some info, for example, stat
> time, usually involves either writing new code or firing up "xxd" and
> decoding values by yourself.
> 
> This --json is supposed to help that. It dumps the index in a human
> readable format but also easy to be processed with tools. And it will
> print almost enough info to reconstruct the index later.

In an earlier message, I stated that I like the idea of this feature.
I know that you wanted to get that feedback before working too hard on
the patch series, so now that interest is declared, please add some tests
that verify this output looks as you expect.

> In this patch we only dump the main part, not extensions. But at the
> end of the series, the entire index is dumped. The end result could be
> very verbose even on a small repository such as git.git.

I would expect this commit to include a complete "output matches expected"
test, and the later patches can update the index to include these
extensions then verify that their sections appear in the output using
a grep.

> +--json::
> +	Dump the entire index content in JSON format. This is for
> +	debugging purposes and the JSON structure may change from time
> +	to time.
> +

"...purposes and the JSON structure may change from time to time" may be better
as "...purposes. The JSON structure is subject to change."

> +		OPT_BOOL(0, "json", &show_json,
> +			N_("dump index content in json format")),

We should probably use "JSON" here in the help text.

> -	show_files(the_repository, &dir);
> -
> -	if (show_resolve_undo)
> -		show_ru_info(the_repository->index);
> +	if (!show_json) {
> +		show_files(the_repository, &dir);
> +
> +		if (show_resolve_undo)
> +			show_ru_info(the_repository->index);
> +	} else {
> +		struct json_writer jw = JSON_WRITER_INIT;
> +
> +		discard_index(the_repository->index);
> +		the_repository->index->jw = &jw;
> +		if (repo_read_index(the_repository) < 0)
> +			die("index file corrupt");
> +		puts(jw.json.buf);
> +		the_repository->index->jw = NULL;
> +		jw_release(&jw);
> +	}
>  
>  	if (ps_matched) {
>  		int bad;

I see this 'ps_matched' condition at the end, which is related to
the '--error-unmatch' option. I added "--error-unmatch foo" to my
command and got the appropriate error message:

  error: pathspec 'foo' did not match any file(s) known to git
  Did you forget to 'git add'?

This was sent to stderr while the JSON was in stdout, so this should
be appropriate to allow both options. Just pointing it out to make
sure this is intended.

> +void jw_object_stat_data(struct json_writer *jw, const char *name,
> +			 const struct stat_data *sd)
> +{
> +	jw_object_inline_begin_object(jw, name);
> +	jw_object_intmax(jw, "st_ctime.sec", sd->sd_ctime.sec);
> +	jw_object_intmax(jw, "st_ctime.nsec", sd->sd_ctime.nsec);
> +	jw_object_intmax(jw, "st_mtime.sec", sd->sd_mtime.sec);
> +	jw_object_intmax(jw, "st_mtime.nsec", sd->sd_mtime.nsec);
> +	jw_object_intmax(jw, "st_dev", sd->sd_dev);
> +	jw_object_intmax(jw, "st_ino", sd->sd_ino);
> +	jw_object_intmax(jw, "st_uid", sd->sd_uid);
> +	jw_object_intmax(jw, "st_gid", sd->sd_gid);
> +	jw_object_intmax(jw, "st_size", sd->sd_size);
> +	jw_end(jw);
> +}

If these are all part of the same object, are the "st_" prefixes
necessary for every member?

> +	/*
> +	 * again redundant info, just so you don't have to decode
> +	 * flags values manually
> +	 */
> +	if (ce->ce_flags & CE_VALID)
> +		jw_object_true(jw, "assume-unchanged");
> +	if (ce->ce_flags & CE_INTENT_TO_ADD)
> +		jw_object_true(jw, "intent-to-add");
> +	if (ce->ce_flags & CE_SKIP_WORKTREE)
> +		jw_object_true(jw, "skip-worktree");
> +	if (ce_stage(ce))
> +		jw_object_intmax(jw, "stage", ce_stage(ce));

I'm really glad these flags are getting expanded! Much easier to
understand what's going on this way.

> +	if (istate->jw) {
> +		jw_object_begin(istate->jw, jw_pretty);
> +		jw_object_intmax(istate->jw, "version", istate->version);
> +		jw_object_string(istate->jw, "oid", oid_to_hex(&istate->oid));
> +		jw_object_intmax(istate->jw, "st_mtime.sec", istate->timestamp.sec);
> +		jw_object_intmax(istate->jw, "st_mtime.nsec", istate->timestamp.nsec);

Here, the "st_" prefixes are not on every member, but would it
be confusing if they were not there? Also, including a "." in
a member name may be troublesome for JSON, as that typically
means we are accessing a member of an object. Perhaps use _sec
and _nsec here and in the earlier stat_data block.

Thanks,
-Stolee
