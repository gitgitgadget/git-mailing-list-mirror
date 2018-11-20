Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2E741F87F
	for <e@80x24.org>; Tue, 20 Nov 2018 13:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbeKTXfY (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Nov 2018 18:35:24 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45639 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725902AbeKTXfY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Nov 2018 18:35:24 -0500
Received: by mail-qk1-f194.google.com with SMTP id d135so2604277qkc.12
        for <git@vger.kernel.org>; Tue, 20 Nov 2018 05:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7xUt/iZxi4GHzfNRvvopUPMp8UB5n7hUw3y9zpm+nIY=;
        b=USggBRdjmvkPYX//Y1FYjMv6p7MRdURGgqNT6gOZ9OlflpsWm60bbDp/pbr55BThlo
         Yfnezjyw5of3Uhb6XKBjVN5z/vtb1EH08frb9y4XruMdsJ8FkIZ5c9v/RGnwbc9ckllD
         Tda4rFBxOqyRAboZ5evfwUvVAXwtM054MayRVqDdNBPriP8BYr41dRjPcpXkVk6jeON8
         ezjDYzubAMGplmsHsOjQUQwB3d6BE0iOKXGn92UYye+XJqiAtInOXtsFp6H4a9F0QegV
         xGSTFCOBZKW/C6Wgo+PbxT3+EhQ2KQ7TiC6pRupVoFSmb+j+aBPBxhBU+q55tkqem7Hu
         oc4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7xUt/iZxi4GHzfNRvvopUPMp8UB5n7hUw3y9zpm+nIY=;
        b=ktr8Y5yET/m6yRYThiXXmIuso78SRkzVFt3LCeXhNU66LsI7VvsJF6mi0UMMyAtJeA
         bmDK49QXaLoeczFvYzo8OtxH97iECTfFepIjlg0Pi0aAUl+Z4N+D0fECPdibCnzV/WrV
         pnGV+tyr8sfJkRjk3Rj7WAVuCxRgk8SyuGr4yLMKx0ahZeqLtkTBa1SGUxXeF6hfl612
         Qn9nBZSGh46ulH0sL7HyskYKD/hxVcjzY9vERqIMVSr4jpt2MxGOiWPl/XmIzx30/xfC
         cqg6gfRIRQvwuDLaGxsi/1LKfrx/L9JmIhjZMLAXDchQyY+tOTLxWhHZHRT8pdqQAnap
         xcPA==
X-Gm-Message-State: AA+aEWbHCN5PpM9t5u+7tPTP2bBySRx4o9GVHbGSTZfWQ0JKohKxpW8o
        MVhmxfw6fpSjY/3ADxtEYLE=
X-Google-Smtp-Source: AJdET5dWkolGoE4sveF8nkCYqzBouSr50qG6a7K/ceR2Wbez1PCt/YOTEqoXIgJ+xQb2YpaLLUddNw==
X-Received: by 2002:ac8:60cb:: with SMTP id i11mr1830957qtm.360.1542719180587;
        Tue, 20 Nov 2018 05:06:20 -0800 (PST)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id x127sm21264570qkx.43.2018.11.20.05.06.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 05:06:19 -0800 (PST)
Subject: Re: [PATCH 1/5] eoie: default to not writing EOIE section
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>, jonathantanmy@google.com
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181010155938.20996-1-peartben@gmail.com>
 <20181113003817.GA170017@google.com> <20181113003938.GC170017@google.com>
 <f2f8cec8-d770-a1e9-b5a1-83653575122e@gmail.com>
 <xmqqo9asqrxu.fsf@gitster-ct.c.googlers.com>
 <20181120060920.GA144753@google.com> <20181120061147.GB144753@google.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <efa1d7fb-1da3-c093-1cb1-873a2e1c445c@gmail.com>
Date:   Tue, 20 Nov 2018 08:06:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181120061147.GB144753@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 11/20/2018 1:11 AM, Jonathan Nieder wrote:
> Since 3b1d9e04 (eoie: add End of Index Entry (EOIE) extension,
> 2018-10-10) Git defaults to writing the new EOIE section when writing
> out an index file.  Usually that is a good thing because it improves
> threaded performance, but when a Git repository is shared with older
> versions of Git, it produces a confusing warning:
> 
>    $ git status
>    ignoring EOIE extension
>    HEAD detached at 371ed0defa
>    nothing to commit, working tree clean
> 
> Let's introduce the new index extension more gently.  First we'll roll
> out the new version of Git that understands it, and then once
> sufficiently many users are using such a version, we can flip the
> default to writing it by default.
> 
> Introduce a '[index] recordEndOfIndexEntries' configuration variable
> to allow interested users to benefit from this index extension early.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Rebased.  No other change from v1.
> 
> As Jonathan pointed out, it would be nice to have tests here.  Ben,
> any advice for how I could write some in a followup change?  E.g. does
> Derrick Stolee's tracing based testing trick apply here?
> 
>   Documentation/config/index.txt |  7 +++++++
>   read-cache.c                   | 11 ++++++++++-
>   t/t1700-split-index.sh         | 11 +++++++----
>   3 files changed, 24 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
> index 4b94b6bedc..8e138aba7a 100644
> --- a/Documentation/config/index.txt
> +++ b/Documentation/config/index.txt
> @@ -1,3 +1,10 @@
> +index.recordEndOfIndexEntries::
> +	Specifies whether the index file should include an "End Of Index
> +	Entry" section. This reduces index load time on multiprocessor
> +	machines but produces a message "ignoring EOIE extension" when
> +	reading the index using Git versions before 2.20. Defaults to
> +	'false'.
> +
>   index.threads::
>   	Specifies the number of threads to spawn when loading the index.
>   	This is meant to reduce index load time on multiprocessor machines.
> diff --git a/read-cache.c b/read-cache.c
> index 4ca81286c0..1e9c772603 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -2689,6 +2689,15 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
>   		rollback_lock_file(lockfile);
>   }
>   
> +static int record_eoie(void)
> +{
> +	int val;

I believe you are going to want to initialize val to 0 here as it is on 
the stack so is not guaranteed to be zero.

> +
> +	if (!git_config_get_bool("index.recordendofindexentries", &val))
> +		return val;
> +	return 0;
> +}
> +
>   /*
>    * On success, `tempfile` is closed. If it is the temporary file
>    * of a `struct lock_file`, we will therefore effectively perform
> @@ -2936,7 +2945,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
>   	 * read.  Write it out regardless of the strip_extensions parameter as we need it
>   	 * when loading the shared index.
>   	 */
> -	if (offset) {
> +	if (offset && record_eoie()) {
>   		struct strbuf sb = STRBUF_INIT;
>   
>   		write_eoie_extension(&sb, &eoie_c, offset);
> diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> index 2ac47aa0e4..0cbac64e28 100755
> --- a/t/t1700-split-index.sh
> +++ b/t/t1700-split-index.sh
> @@ -25,14 +25,17 @@ test_expect_success 'enable split index' '
>   	git update-index --split-index &&
>   	test-tool dump-split-index .git/index >actual &&
>   	indexversion=$(test-tool index-version <.git/index) &&
> +
> +	# NEEDSWORK: Stop hard-coding checksums.
>   	if test "$indexversion" = "4"
>   	then
> -		own=3527df833c6c100d3d1d921a9a782d62a8be4b58
> -		base=746f7ab2ed44fb839efdfbffcf399d0b113fb4cb
> +		own=432ef4b63f32193984f339431fd50ca796493569
> +		base=508851a7f0dfa8691e9f69c7f055865389012491
>   	else
> -		own=5e9b60117ece18da410ddecc8b8d43766a0e4204
> -		base=4370042739b31cd17a5c5cd6043a77c9a00df113
> +		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> +		base=39d890139ee5356c7ef572216cebcd27aa41f9df
>   	fi &&
> +
>   	cat >expect <<-EOF &&
>   	own $own
>   	base $base
> 
