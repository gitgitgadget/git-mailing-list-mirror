Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE74C433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 22:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232062AbiBLW3w (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 17:29:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiBLW3w (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 17:29:52 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1B760A84
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 14:29:47 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id a8so29854137ejc.8
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 14:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0KguwmJFITsrZGAsETaoBdELzLKO8n+zFQse7t82c6E=;
        b=fJaRirbz74kSI0qju6lHbPmtfwu2v8XPtrV00aQ91LSkKSaQ1vu3RN6e1rZBlPgkpG
         kyZDRtIsiBVFOCB4DB7ojd5gbzX66Tt835lS05Sy6tkTWxCLYNiDm9EAkzSMp0mW9Hd4
         2/FO28Q9uOfep9asuhmTE9JCptTk11LGCRhzARWjlDABjvSt9AnGBt5fmKQl+BUybWyA
         SPvfRuYi9pFfDtqRH5m5uA2dLzG46nvtCfQNrYKVjoSf92Kbb9KYMvXDZmrf4MSV5yHO
         JXoQIGnW1GW/UPkoE0HXKoLzPPhQzVWklMWJJPUYlM6edovRpKlmtm3CCJn0beabLABr
         7BRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KguwmJFITsrZGAsETaoBdELzLKO8n+zFQse7t82c6E=;
        b=D7zxG+h/RGnyeUY0nGo4KMhEeFKqSqXU4CMiBrWcMiwEPMOBfUa0KWeVS6dXtjpu+b
         2FhXzz27ANPVjCHrkNAJ1+gemUQVqncW0pxv5p55vVywQ/KKgTUHml0wRi95/D83Eo+b
         lYfhMG5hlSZpnP3XNY0uGme33SYPNgIf28hrxQL85HBiuGq2iPUobGOQaydj0YZ7vGCM
         iU29LcVcbqDNVRtWw73huW1LoMp3lECIQlLnO4nh7PmO0iL9F5jvQW+PhbrgjQImuoMV
         QZTLF576ZiYZbJJS7K7liUUWpFbemes8A7Vu+Bk7EAZAjsu/yakqiZPtTonNKOlOO53s
         cymg==
X-Gm-Message-State: AOAM533eUxFYNlbdflGSkT2dOLcZL4qBNd/vsTU7bAGurgMlBQUARsj7
        wTFqGB90ENYyuj8zQHv/Wkhgt252LDPez37WUFqc1mVMLBs=
X-Google-Smtp-Source: ABdhPJwxTstTu/xFVr6Ki/pchiGde2+hCn9Y3CKgtpWBhpq+4QS6EVi8ehZEyT+nASTQ6I/tCDAU0EHlFnyBg+llkvI=
X-Received: by 2002:a17:906:2b06:: with SMTP id a6mr6250884ejg.476.1644704986478;
 Sat, 12 Feb 2022 14:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20220210024138.157327-1-bagasdotme@gmail.com>
In-Reply-To: <20220210024138.157327-1-bagasdotme@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 12 Feb 2022 14:29:35 -0800
Message-ID: <CABPp-BEguZQMTjDxEpMqKwKpDdPj9yWbL5T_wRJhD3KDJK5=UQ@mail.gmail.com>
Subject: Re: [PATCH] clean: Use past tense for msg_remove, msg_skip_git_dir,
 and msg_skip_cwd
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, zoltan.klinger@gmail.com,
        Patrick Marlier <patrick.marlier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 9, 2022 at 6:42 PM Bagas Sanjaya <bagasdotme@gmail.com> wrote:
>
> Use past tense form of "to remove" and "to skip". This is especially
> true when we had already removed an entry.

This strikes me as an unnecessary or at least insufficiently motivated
patch.  The difference between "Removing <path>" and "Removed <path>"
is lost in the noise when there is no user-input or other behavior
slowing these down, and they are removed at the speed the machine can
remove.  The only time the user will be able to tell the difference is
if they are using strace or a debugger, and I really don't like the
idea of changing the UI and making translators do more work just for
those users.  Besides, we could just print the messages earlier.

A bigger question to me, is what tense do other commands in git use?
If one command prints:

   Removed <path>

but another prints

   Patching <path>

then that's a minor inconsistency that users may actually notice.  I
have no idea what tense git tends to use for all its different
commands, but before changing some strings and incurring more work for
translators, I'd think we'd want to make sure we are at least
increasing consistency in this area rather than decreasing it.

Anyway, it may not be a big deal, but that's just my random thoughts
on the patch.
