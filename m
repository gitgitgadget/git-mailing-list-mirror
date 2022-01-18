Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA0DC433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 18:20:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347611AbiARSUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 13:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347657AbiARSUa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 13:20:30 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66710C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 10:20:30 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id 67-20020a630746000000b003443fe43bbaso10035597pgh.12
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 10:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bO+aEvtiVNGPp+SAPr9u0csi9HDx9ZlZ7+fNkbFPUHI=;
        b=FPsKEzhAK1x420rTKH8jmEX2QEKovibxg1HFDouXpklClSlO+myv5izXLqavAD22iH
         4Nr468UTGE5aXlm5DSVnesQV6Nn8/u6NHpWRrtsrVK3mCcAcs5BLoeWceHMeAq5TLpSW
         7XS82Q0oz4DLQ99SUQMdrBGxitVUnZo8S61Vgdhdx8zlqpZ5mCQhbd9Hf63scEh1hQVZ
         zqOLk4zkeKhxRlmYZs71teS4LnAIi7ovGYB+kTlErhXEsr24MaEebGLjPFTvV9tOundX
         T7nxRDYZVcekO34QitAY1MnQsByWiPUD/fzmvnAzwnyaeBQaf7/N66VH0Ht0ca1Z3yjC
         sxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bO+aEvtiVNGPp+SAPr9u0csi9HDx9ZlZ7+fNkbFPUHI=;
        b=hvj455FRJZ0u3C9XnR9MKdpjXnajSFSPCAfXk7O3H7bm2Uc9EkY8pZOvtqJ0xsr0Wy
         nu8rk8QrP8HJL61GAFTlsYFktpaYzSn3Uh/0Y24VeOI0j+iUD2PobleAR81EmzYy91Bt
         Q1CeFdayQZ4U8EVNkOKVu3MLQRU1swU4dYcbcy08AO1IZTy7kzdWp+UDorW9azz+dnd9
         TptMTyhJtP4TkniwcGw0UD6gBUXuu/VZKMbp+Uz0ISiE2Too3uhRnPJL0JbpiTKEyxdX
         z8pecy0VHKF0kSFiKNlMy0a3V/zkYZaYEYvVpKKCZHacvcRlhOjfkjNEAZxyitgNUql6
         dmKg==
X-Gm-Message-State: AOAM530MBir10TZhGllAtqsCRtT7mXCqak6AS6kzAR5Tvtrqj4KLIlz4
        cmsAyEMgot8uuKS3lLWZ+UIIoDLcjH/c/g==
X-Google-Smtp-Source: ABdhPJyH8At1bYd5WfTjPWi0IyAe6wyOB7d7pOe5wPSTjCR3zXYdev0mA8xMGj48QSE30fJHiPx//WOQXgAwAw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:410a:: with SMTP id
 u10mr105921pjf.1.1642530029566; Tue, 18 Jan 2022 10:20:29 -0800 (PST)
Date:   Tue, 18 Jan 2022 10:20:27 -0800
In-Reply-To: <xmqq1r1lhobf.fsf@gitster.g>
Message-Id: <kl6l5yqgzz10.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1111.git.1641410782015.gitgitgadget@gmail.com> <xmqq1r1lhobf.fsf@gitster.g>
Subject: Re: [PATCH] submodule.h: use a named enum for RECURSE_SUBMODULES_*
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Philippe Blain <levraiphilippeblain@gmail.com>
>>
>> Using a named enum allows casting an integer to the enum type in both
>> GDB and LLDB:
>>
>>     (gdb) p (enum diff_submodule_format) options->submodule_format
>>     $1 = DIFF_SUBMODULE_LOG
>
> Hmph, this was somewhat unexpected and quite disappointing.
>
> Because that's not what those "Let's move away from #define'd
> constants and use more enums" said when they sold their "enum" to
> us.  In the diff_options struct, the .submodule_format member is of
> type enum already, so, if we trust what they told us when they sold
> their enums, "p options->submodule_format" should be enough to give
> us "DIFF_SUBMODULE_LOG", not "1", as its output.  Do you really need
> the cast in the above example?
>
>> Name the enum listing the different RECURSE_SUBMODULES_* modes, to make
>> debugging easier.
>
> Even though this patch may be a good single step in the right
> direction, until it is _used_ to declare a variable or a member of a
> struct of that enum type, it probably is not useful as much as it
> could be.  The user needs to know which enum is stored in that "int"
> variable or member the user is interested in to cast it to.
>
> That is, many changes like this one.
>
> diff --git i/builtin/pull.c w/builtin/pull.c
> index c8457619d8..f2fd4784df 100644
> --- i/builtin/pull.c
> +++ w/builtin/pull.c
> @@ -71,7 +71,7 @@ static const char * const pull_usage[] = {
>  /* Shared options */
>  static int opt_verbosity;
>  static char *opt_progress;
> -static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static enum submodule_recurse_mode recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
>  
>  /* Options passed to git-merge or git-rebase */
>  static enum rebase_type opt_rebase = -1;

Your comment on the use of RECURSE_SUBMODULES_DEFAULT elsewhere [1]
reminded me of how odd this enum actually is.

* submodule_recurse_mode is used almost exclusively by fetch and push 
  because they are the only commands that accept anything other than
  true/false.
* however, it is also used by
  submodule.c:config_update_recurse_submodules to store true/false (it
  don't even use RECURSE_SUBMODULES_DEFAULT!)

i.e. I suspect that the enum is only relevant for fetch/push, but its
values for _ON and _OFF have been co-opted for other things.

This patch and the suggestion of s/int/enum submodule_recurse_mode makes
sense, though I think we can take this a bit further in some follow-up
work:

If I am correct in my suspicion earlier, then submodule_recurse_mode can
be made even more specific, like "submodule_transport_mode", and all
non-transport related uses can be replaced with int.

If I am wrong and there are some legitimate uses for
submodule_recurse_mode that I have missed, it might still be worthwhile
to separate the different uses of the enum so that it doesn't end up
overloaded.

[1] https://lore.kernel.org/git/xmqqr19cjuzw.fsf@gitster.g
