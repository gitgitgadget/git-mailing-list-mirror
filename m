Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE712C6FA8E
	for <git@archiver.kernel.org>; Fri, 24 Feb 2023 22:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjBXWbW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Feb 2023 17:31:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjBXWbV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2023 17:31:21 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8266A79D
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:31:20 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536c02ed619so12794067b3.8
        for <git@vger.kernel.org>; Fri, 24 Feb 2023 14:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zU0iqu2i8Moo+sjcbNzW79vKzU5/Yehqn73rog7zQjM=;
        b=JuW9lyrznyUbWznaR1cuTD0ikXcVI8b/d/Cvt5PpyvpvT40xan0SPKLWgQm7ZoqCi4
         KMm/cbDe72FmsllMS7TU9bCr+UdLAgEryVqsMhNTZepFz/cQOjwKyP7LHVM9UbnCovxB
         15KKe3aGLYFjC78smnKctPM73YrqlxBa2riGMz3Qa2ZsipPPdRVmyEnzcarpoFQPfdfw
         1ezNJbD55pct14LqIngbjG/NsaYbEd67Z4B2Rji/fyfr6AN+1WVoeTIY+0qMi7hvdTW3
         JCcPnvFfvw/UT1RHNffLnOazcRIoCD7GpJHSLVODvS4W0+LmwnqxoNQlLv39eL1ovm26
         5VwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zU0iqu2i8Moo+sjcbNzW79vKzU5/Yehqn73rog7zQjM=;
        b=cEPYt2DFCyp/CO/iotgsnfNwITDTDFQXgtiiVR+cNAWH1hl4ETalA7T3JWW2sp72r0
         9S2NB/aC5+qs6z7EJEUvLmtVh69tEag8t9DPcKVZOCXduXXqY+3xmQk7uDuRmQkeMWv+
         22jMo+EgDiU7vPItkW5A6Z1iP1hiVax6r18r7IwRPNOaTHbWGO+7d+knwPEUCo30O144
         +qMYKBqFBDOY0EHMms7PDkIpAQ43Iko2ThyL3V327PvxSpCiGFmMVJxEZfBvZHnLNxpo
         O86HucTiU+LtsMlK+FnoWoThMbZLPoR+ZZWxfX1O8mo74pq3lTI4eU4PaiLx2zj5+4Jz
         ZsVQ==
X-Gm-Message-State: AO0yUKW8frjs6OqjMr0AhjQFpco2Nc8PeEKPsGVjDoV/tO8P9/Sfh/VH
        4X4VxNPgBL+wRhQQ5n8bmTOyTu0nH/57m/mNrkbb
X-Google-Smtp-Source: AK7set8xL9yhaz9AadTbNzvESeBW2fW08wY037UUuUw3Lf/E9X7U1j3YsQHLnIRi6AmI+ntRwAtwOXZ0W7B9wwaEza0K
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:6b04:35a6:9357:29a1])
 (user=jonathantanmy job=sendgmr) by 2002:a81:ad5c:0:b0:538:112b:67a0 with
 SMTP id l28-20020a81ad5c000000b00538112b67a0mr4878416ywk.5.1677277879563;
 Fri, 24 Feb 2023 14:31:19 -0800 (PST)
Date:   Fri, 24 Feb 2023 14:31:16 -0800
In-Reply-To: <239b10e11812d99be587265c0a5e283da45ca315.1677143700.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.637.g21b0678d19-goog
Message-ID: <20230224223116.1508846-1-jonathantanmy@google.com>
Subject: Re: [PATCH 02/11] dir: add a usage note to exclude_per_dir
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
> diff --git a/dir.h b/dir.h
> index 33fd848fc8d..2196e12630c 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -295,8 +295,12 @@ struct dir_struct {
>  	struct untracked_cache *untracked;
>  
>  	/**
> -	 * The name of the file to be read in each directory for excluded files
> -	 * (typically `.gitignore`).
> +	 * Deprecated: ls-files is the only allowed caller; all other callers
> +	 * should leave this as NULL; it pre-dated the
> +	 * setup_standard_excludes() mechanism that replaces this.
> +	 *
> +	 * This field tracks the name of the file to be read in each directory
> +	 * for excluded files (typically `.gitignore`).
>  	 */
>  	const char *exclude_per_dir;

I'm not sure what is meant by "allowed caller", but I wouldn't have
expected this to also mean that unpack-trees would need to know to
propagate this from o->internal.dir to d in verify_clean_subdirectory.

I would be OK with excluding this from the patch set - I think the other
changes can stand independent of this.
