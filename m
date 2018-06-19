Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 236221F403
	for <e@80x24.org>; Tue, 19 Jun 2018 11:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937583AbeFSLfL (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 07:35:11 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:39229 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937499AbeFSLfK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 07:35:10 -0400
Received: by mail-qt0-f194.google.com with SMTP id p23-v6so17972489qtn.6
        for <git@vger.kernel.org>; Tue, 19 Jun 2018 04:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=2WUaKjkRcxAH2SHd7zMTCkGrFpR/Ir4ZpyjmGWI5aJk=;
        b=P/hsG100LVsRJKttzQOB/6z3cjlmYAo1S/zpxznnfbKA3JYbz4jMNUBMJlHVt6Rovk
         PUN0oowuA8k46Pa+dbqIHkdEGEc334caJJW+KsJ0sL7UBJOIxNzRB4FvNe2YjyaUUB4z
         O6Nr8k3FAZ7Yz6wyhRtCALlV3qdNEb/7bw7EdVIsXFOkTD5uSzgc8NlVpVcrJicYhdhL
         /z2x2Uqp+cWUJf7aYgZTwkvxqVtbKCqETvdqND3ionzztMSYsHLclURYauC/jVjxx1d6
         7O0kxaVPenS/oUp5hl6BrA98M2ZWHPOCxkWGrjXNw2/p/oQpaKhjrLfXbqCUgLX6iIf7
         EdHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=2WUaKjkRcxAH2SHd7zMTCkGrFpR/Ir4ZpyjmGWI5aJk=;
        b=LIvXBhhdblJXu6vZGIYHnVyiVrJeonaBVpNUZkPf8UBArq0MD9FycgX+gJmx2ggHps
         OaZJPnwGQBkUJWP719a0wrvXrQhi36yeQJPIqFQ74I8rft+wsNBQ8KaEw5LcKhHgrKOD
         7nI6uu7Rfv0AAeJxWoGVLZzP8mvl9IkfYe+OyJ5MGx+OoMweblKI9gQXuzTnVyRXtSNT
         uHKUCPiMJEcNHO48NlotKd6TgDaaki1t8vF2Zu2xLIP3+5bfvzSJAlJoDbfIuFF9XJXF
         Xu2us9rIFMVrz/I6vN2VtZZbaPxosFpON5P4x5Wd/XEfrCrQpTNyEJ2jEtAzK9sbW6mc
         lYBw==
X-Gm-Message-State: APt69E39IPlCsk5ZcP7ieQL6n4pIsp3pVud7quBes0yRdZCJzbrMqBd2
        BHf5prtuU7hD23/h3Xmzic4V/yvE
X-Google-Smtp-Source: ADUXVKIkiXPsVRoyFbjisCAztG2qnjc79cKue7ad7nzLC7B6mnlvqo4r1inRsUDe48Q5J4GoaNF1kg==
X-Received: by 2002:ac8:30b1:: with SMTP id v46-v6mr14896770qta.353.1529408108786;
        Tue, 19 Jun 2018 04:35:08 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:d807:51c7:6f48:91e4? ([2001:4898:8010:0:c13d:51c7:6f48:91e4])
        by smtp.gmail.com with ESMTPSA id v189-v6sm11065187qkb.29.2018.06.19.04.35.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jun 2018 04:35:08 -0700 (PDT)
Subject: Re: [PATCH 01/15] contrib: add cocci script to replace index compat
 macros
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20180616054157.32433-1-pclouds@gmail.com>
 <20180616054157.32433-2-pclouds@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a7e0bcd5-5bef-097e-f032-d152d51515aa@gmail.com>
Date:   Tue, 19 Jun 2018 07:35:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180616054157.32433-2-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/16/2018 1:41 AM, Nguyễn Thái Ngọc Duy wrote:
> Index compat macros are going to be removed to expose the_index and
> then reorganized to use the right index instead of simply the_index
> because sometimes we want to use a different index.
>
> This cocci script can help with the first step. It can be used later
> on on even builtin/ when we start to reorganize code in there, but for
> now this is the script that performs all the conversion outside
> builtin/

I pulled your code and ran `make coccicheck` and got quite a large patch 
as a result.

Perhaps reorder the commits in your large patch with this one at the 
end? It's helpful to see what your mechanical changes are going to be, 
but let's save it for when `make coccicheck` is stable.

>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   contrib/coccinelle/index-compat.cocci | 184 ++++++++++++++++++++++++++
>   1 file changed, 184 insertions(+)
>   create mode 100644 contrib/coccinelle/index-compat.cocci
>
> diff --git a/contrib/coccinelle/index-compat.cocci b/contrib/coccinelle/index-compat.cocci
> new file mode 100644
> index 0000000000..ca46711eb6
> --- /dev/null
> +++ b/contrib/coccinelle/index-compat.cocci
> @@ -0,0 +1,184 @@
> +@@
> +@@
> +-active_cache
> ++the_index.cache
> +
> +@@
> +@@
> +-active_nr
> ++the_index.cache_nr
> +
> +@@
> +@@
> +-active_alloc
> ++the_index.cache_alloc
> +
> +@@
> +@@
> +-active_cache_changed
> ++the_index.cache_changed
> +
> +@@
> +@@
> +-active_cache_tree
> ++the_index.cache_tree
> +
> +@@
> +@@
> +- read_cache()
> ++ read_index(&the_index)
> +
> +@@
> +expression path;
> +@@
> +- read_cache_from(path)
> ++ read_index_from(&the_index, path, get_git_dir())
> +
> +@@
> +expression pathspec;
> +@@
> +- read_cache_preload(pathspec)
> ++ read_index_preload(&the_index, pathspec)
> +
> +@@
> +@@
> +- is_cache_unborn()
> ++ is_index_unborn(&the_index)
> +
> +@@
> +@@
> +- read_cache_unmerged()
> ++ read_index_unmerged(&the_index)
> +
> +@@
> +@@
> +- discard_cache()
> ++ discard_index(&the_index)
> +
> +@@
> +@@
> +- unmerged_cache()
> ++ unmerged_index(&the_index)
> +
> +@@
> +expression name;
> +expression namelen;
> +@@
> +- cache_name_pos(name, namelen)
> ++ index_name_pos(&the_index, name, namelen)
> +
> +@@
> +expression ce;
> +expression option;
> +@@
> +- add_cache_entry(ce, option)
> ++ add_index_entry(&the_index, ce, option)
> +
> +@@
> +expression pos;
> +expression new_name;
> +@@
> +- rename_cache_entry_at(pos, new_name)
> ++ rename_index_entry_at(&the_index, pos, new_name)
> +
> +@@
> +expression pos;
> +@@
> +- remove_cache_entry_at(pos)
> ++ remove_index_entry_at(&the_index, pos)
> +
> +@@
> +expression path;
> +@@
> +- remove_file_from_cache(path)
> ++ remove_file_from_index(&the_index, path)
> +
> +@@
> +expression path;
> +expression st;
> +expression flags;
> +@@
> +- add_to_cache(path, st, flags)
> ++ add_to_index(&the_index, path, st, flags)
> +
> +@@
> +expression path;
> +expression flags;
> +@@
> +- add_file_to_cache(path, flags)
> ++ add_file_to_index(&the_index, path, flags)
> +
> +@@
> +expression ce;
> +expression flip;
> +@@
> +-chmod_cache_entry(ce, flip)
> ++chmod_index_entry(&the_index, ce, flip)
> +
> +@@
> +expression flags;
> +@@
> +-refresh_cache(flags)
> ++refresh_index(&the_index, flags, NULL, NULL, NULL)
> +
> +@@
> +expression ce;
> +expression st;
> +expression options;
> +@@
> +-ce_match_stat(ce, st, options)
> ++ie_match_stat(&the_index, ce, st, options)
> +
> +@@
> +expression ce;
> +expression st;
> +expression options;
> +@@
> +-ce_modified(ce, st, options)
> ++ie_modified(&the_index, ce, st, options)
> +
> +@@
> +expression name;
> +expression namelen;
> +@@
> +-cache_dir_exists(name, namelen)
> ++index_dir_exists(&the_index, name, namelen)
> +
> +@@
> +expression name;
> +expression namelen;
> +expression igncase;
> +@@
> +-cache_file_exists(name, namelen, igncase)
> ++index_file_exists(&the_index, name, namelen, igncase)
> +
> +@@
> +expression name;
> +expression namelen;
> +@@
> +-cache_name_is_other(name, namelen)
> ++index_name_is_other(&the_index, name, namelen)
> +
> +@@
> +@@
> +-resolve_undo_clear()
> ++resolve_undo_clear_index(&the_index)
> +
> +@@
> +expression at;
> +@@
> +-unmerge_cache_entry_at(at)
> ++unmerge_index_entry_at(&the_index, at)
> +
> +@@
> +expression pathspec;
> +@@
> +-unmerge_cache(pathspec)
> ++unmerge_index(&the_index, pathspec)
> +
> +@@
> +expression path;
> +expression sz;
> +@@
> +-read_blob_data_from_cache(path, sz)
> ++read_blob_data_from_index(&the_index, path, sz)

