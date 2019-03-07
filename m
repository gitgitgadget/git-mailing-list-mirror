Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6337B20248
	for <e@80x24.org>; Thu,  7 Mar 2019 14:44:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726166AbfCGOos (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Mar 2019 09:44:48 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37313 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfCGOor (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Mar 2019 09:44:47 -0500
Received: by mail-wm1-f67.google.com with SMTP id x10so9437428wmg.2
        for <git@vger.kernel.org>; Thu, 07 Mar 2019 06:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/noByXlr5nMgvfcEAbBbcLMGWdFOoQNy9nnrOUXme7s=;
        b=tMDCH3BxFdC2/ZsX3C0cG35NyfUD51L83un3dZipuEAMEPtNzfhquWKuMpNoKmnYa8
         P7iReSmQzDD/gG9o7U1HJ+X6PumiZUvX16QCDmKJ3/tffuZlkG07wyS1ev8RzsybXi9k
         QGJCacfSgHpb7CES8G09KD3pXs3KTsFRjlaiOIShex0QEI8rb9nlV7FCz5PWT+Z8ZyKL
         QYB6Qt1tDQdA4JDjg0zXkaEeKHw2/A1KcBSa08Ka38t12Y3e4/3/qRkFW6HG7I8Kzuaw
         UOGUXjQ6ocERv57OiFcY6csSG9WGuM3Cbb/CLLp/jxre53Ohw9fqObihhigtMTyxqGi5
         Ul/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=/noByXlr5nMgvfcEAbBbcLMGWdFOoQNy9nnrOUXme7s=;
        b=mdATWgNHfsEHPHNQx3tmb19ecoTe197A6OePIU4e01hHVDv8PiQPbo0SfAKhsBGSPC
         4cezc0783zEUNqbcbKmHJ98XfPdP80SBhQiDEdE3bbtnjz4biDO87NWg6e+xBTXa2ReK
         0C9ZKRxjAzIFzW8Q9eeLVtiq/+C9wBntMyPfZ/en+JzEw5GgmHsIW5DU8iBGmWHkRnZi
         HieqQ7cuq18ikSGTQTIkeuR4wdMho60PReWqpEOQql891c12FQUfC+Y3DfGe2Qg+rLtp
         cRXtSlM/OM1TsOmAp/4iMLv3oLa9i8086Dx7FAAK6cHE1AtfJAw5i9PuYz7nZvgyEcbI
         Rilw==
X-Gm-Message-State: APjAAAXpKWWyf2xW8YlM1I+8JEEjFD8Wa3koWBs6RR/wRr80bXmdPwM3
        PhZXG2wKN+Y4bwtJ8AtnFRo=
X-Google-Smtp-Source: APXvYqxRsjew9GI+klIA14A0sbp4TFw+iMu6eGERysoXp6GA6mrG3fQnpKBEZR1eSaITJz0xkWHynw==
X-Received: by 2002:a1c:c5:: with SMTP id 188mr5911166wma.112.1551969886275;
        Thu, 07 Mar 2019 06:44:46 -0800 (PST)
Received: from [192.168.2.240] (host-92-22-20-26.as13285.net. [92.22.20.26])
        by smtp.gmail.com with ESMTPSA id p1sm8847092wrx.50.2019.03.07.06.44.45
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Mar 2019 06:44:45 -0800 (PST)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/3] files-backend.c: reduce duplication in
 add_per_worktree_entries_to_dir()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <ec707cbb-96e8-f26f-3d69-b69d29b31737@gmail.com>
 <20190307122917.12811-1-pclouds@gmail.com>
 <20190307122917.12811-3-pclouds@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <3c50aa4f-127a-1be8-2d3e-1941f01d2fa0@gmail.com>
Date:   Thu, 7 Mar 2019 14:44:44 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190307122917.12811-3-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Duy

On 07/03/2019 12:29, Nguyễn Thái Ngọc Duy wrote:
> This function is duplicated to handle refs/bisect/ and refs/worktree/
> and a third prefix is coming. Time to clean up.
> 
> This also fixes incorrect "refs/worktrees/" length in this code. The
> correct length is 14 not 11. The test in the next patch will also cover
> this.

I ran strace this morning and saw

openat(AT_FDCWD, "/tmp/x/repo/.git/refs/worktr", 
O_RDONLY|O_NONBLOCK|O_CLOEXEC|O_DIRECTORY) = -1 ENOENT (No such file or 
directory)

I was just about to email you about it but you've already fixed it!

Best Wishes

Phillip

> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   refs/files-backend.c | 22 +++++++++++-----------
>   1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 26417893c8..3d0e06edcd 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -221,22 +221,22 @@ static void files_ref_path(struct files_ref_store *refs,
>    */
>   static void add_per_worktree_entries_to_dir(struct ref_dir *dir, const char *dirname)
>   {
> -	int pos;
> +	const char *prefixes[] = { "refs/bisect/", "refs/worktree/" };
> +	int ip;
>   
>   	if (strcmp(dirname, "refs/"))
>   		return;
>   
> -	pos = search_ref_dir(dir, "refs/bisect/", 12);
> -	if (pos < 0) {
> -		struct ref_entry *child_entry =
> -			create_dir_entry(dir->cache, "refs/bisect/", 12, 1);
> -		add_entry_to_dir(dir, child_entry);
> -	}
> +	for (ip = 0; ip < ARRAY_SIZE(prefixes); ip++) {
> +		const char *prefix = prefixes[ip];
> +		int prefix_len = strlen(prefix);
> +		struct ref_entry *child_entry;
> +		int pos;
>   
> -	pos = search_ref_dir(dir, "refs/worktree/", 11);
> -	if (pos < 0) {
> -		struct ref_entry *child_entry =
> -			create_dir_entry(dir->cache, "refs/worktree/", 11, 1);
> +		pos = search_ref_dir(dir, prefix, prefix_len);
> +		if (pos >= 0)
> +			continue;
> +		child_entry = create_dir_entry(dir->cache, prefix, prefix_len, 1);
>   		add_entry_to_dir(dir, child_entry);
>   	}
>   }
> 
