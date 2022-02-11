Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DB0C433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 13:40:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350615AbiBKNkL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 08:40:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238948AbiBKNkL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 08:40:11 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBCA95
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 05:40:08 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id q8so9553606oiw.7
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 05:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=WK+Us/EY2udE98NZy83UXlXk8p7movXdBxpU4d17E8E=;
        b=i9zxyPEjI+O769+yIKi1eZGSe6oWgpIk/l6YZEm8GSmUHdgs+fuaQ8CXYVDO+2Rteh
         +vQpUVc2uSkxyocLl9HMV+gxAB3rmwPHhxRWk/6MWGFEUfLfbNBA1Pry+k72HgqbdHup
         xEEStCaBYqYPw3cXcOYDbudmS7QzLwmbfsNwELSTTjkwZUrPXKNSMrm/2KYlA9U8j+6q
         kzXoH7wt4nNs5fdMMsXhE7nPabk5gpbBKLpEvQ7sOtLjvv6VjNvNAzXn40nJ9jIeHXZe
         5oTwh+rVfR6Jb0/Sux+sz3WrLXTZQzF8IO7n31VOIgJKPfrqi9YMby2Km8btAUdxYoKv
         Pypg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WK+Us/EY2udE98NZy83UXlXk8p7movXdBxpU4d17E8E=;
        b=OJqSiMFLVOCAC1+jOEDU21moWkEy6At8TLUCF1+pceDHzwrXeru4klkHk+PS4PF1Li
         TZz6s60TexjWt1L25MNYz0oCmbp1qkImNbr8so408Tt6vVOfwmVppsQleZbBQG2m1Yz4
         mdMKacwSnANhpaaBvjbPcK4w55/ZEdXeagsMKocoGAfFRzqnrG/RpWfeZviMY7qvUcgp
         CFrcvWM4SQLWx0bhXstn5RmfGuUZxAg+RqaMPW446LvYdpTL4sqf900sDA9z/SrCSwyv
         GvQ7a7hYJaIsS0S9HGPqZJ3RYB4v+QdsCLJDeCuid1+bCxkFDgv8sJO6tEt88fUTe2Er
         ZcNA==
X-Gm-Message-State: AOAM530nDnrrkbdAK/gMksS42tn4BMlTEKfIuG0R6PxDvSJHB7i8Uh0x
        OBcc5jNjehSh3IU4FZY31Pg=
X-Google-Smtp-Source: ABdhPJz/tlrlZ3RWBAWhDVhKNaX1FCxFtEZVT/FspVYXneS9kMTLBaH8ZLlsbXAdXU+x29KA+2POyQ==
X-Received: by 2002:a05:6808:159c:: with SMTP id t28mr175771oiw.230.1644586807844;
        Fri, 11 Feb 2022 05:40:07 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:407:1519:6db3:88c? ([2600:1700:e72:80a0:407:1519:6db3:88c])
        by smtp.gmail.com with ESMTPSA id p7sm2681078otf.8.2022.02.11.05.40.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Feb 2022 05:40:07 -0800 (PST)
Message-ID: <f36712f5-28bd-42d7-3ea1-f4afa328be07@gmail.com>
Date:   Fri, 11 Feb 2022 08:40:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: ds/sparse-checkout-requires-per-worktree-config (was Re: What's
 cooking in git.git (Feb 2022, #02; Wed, 9))
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_AVILA?= <jn.avila@free.fr>
References: <xmqqa6ez60l8.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqa6ez60l8.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/9/2022 7:12 PM, Junio C Hamano wrote:

> * ds/sparse-checkout-requires-per-worktree-config (2022-02-08) 6 commits
>  - config: make git_configset_get_string_tmp() private
>  - worktree: copy sparse-checkout patterns and config on add
>  - sparse-checkout: set worktree-config correctly
>  - config: add repo_config_set_worktree_gently()
>  - worktree: create init_worktree_config()
>  - Documentation: add extensions.worktreeConfig details
> 
>  "git sparse-checkout" wants to work with per-worktree configration,
>  but did not work well in a worktree attached to a bare repository.
> 
>  Will merge to 'next'?
>  cf. <20220204081336.3194538-1-newren@gmail.com>
>  cf. <CAPig+cRrRxuTeByhKkLs_KDaWY8-r4+jrwT83A-r+sBQsmebMw@mail.gmail.com>
>  source: <pull.1101.v6.git.1644269583.gitgitgadget@gmail.com>

You and I have had a good discussion about the latest version. I
think we've mostly landed on finding ways to improve documentation
in other ways (including the patch you submitted), but here are
the things that I see as still outstanding:

0. Eric mentioned earlier that he was interested in looking again,
   but has not signaled that his review is complete.

1. You and Eric disagree about the use of "worktree" and "working
   tree" in the documentation. I could revert the change to these
   docs from v5 to v6.

2. You mention that the changes in config.c could be split into
   two (first, create repo_config_set_multivar_gently() and then
   create repo_config_set_worktree_gently()).

3. Jean-Noël noticed an improvement to reduce work on translators.
   The diff below could be squashed into patch 5 OR I could submit
   it as a forward fix.

diff --git a/builtin/worktree.c b/builtin/worktree.c
index c6eb636329a..7c272078dc9 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -384,11 +384,13 @@ static int add_worktree(const char *path, const char *refname,
 			    bare &&
 			    git_config_set_multivar_in_file_gently(
 					to_file, "core.bare", NULL, "true", 0))
-				error(_("failed to unset 'core.bare' in '%s'"), to_file);
+				error(_("failed to unset '%s' in '%s'"),
+				      "core.bare", to_file);
 			if (!git_configset_get_value(&cs, "core.worktree", &core_worktree) &&
 			    git_config_set_in_file_gently(to_file,
 							  "core.worktree", NULL))
-				error(_("failed to unset 'core.worktree' in '%s'"), to_file);
+				error(_("failed to unset '%s' in '%s'"),
+				      "core.worktree", to_file);
 
 			git_configset_clear(&cs);
 		}

Thanks,
-Stolee
