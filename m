Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 75D381F453
	for <e@80x24.org>; Thu, 18 Oct 2018 21:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbeJSFEO (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 01:04:14 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:50709 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbeJSFEO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Oct 2018 01:04:14 -0400
Received: by mail-qt1-f202.google.com with SMTP id f62-v6so3707007qtb.17
        for <git@vger.kernel.org>; Thu, 18 Oct 2018 14:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l1jpV1M1BtTAqM1k1kRyNVGmDswo0Hcsdo0WLwYbfHI=;
        b=G02zcN3ACX74/uMfnQ+OYM73Ifig46AHO/M1u7lzfjj7mRh0I6A6coM/t9QPc5wys3
         1ZpNitniYqHFo/dav+LtMjJnCQQPXaz+5RsalxY7pbNQysdqx3C+uvs1qRU4WcRNLv8u
         KYkJXvm1U0hp2JsoTjxM8cMZbVndILGF+YePptbBPf+vzpGP+AraZ8cFXL6upLD2s71H
         CnPHsKRrfZtO3vEXU9E2N4vpKyVcQQ1HXXg/HwEpUVdFP1MO1QdBJUNxHy2Vi5HQUSuK
         fJOFvZi2FD3/10kbVe+0An+013uut17SCMNFARR0ijRv8lAprrD7AHgXhrcAhD/P7F2o
         lboA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l1jpV1M1BtTAqM1k1kRyNVGmDswo0Hcsdo0WLwYbfHI=;
        b=lKavhHcibZ8UFGQ82ydRos33c5jd8alMkHAbVypwsgQSl0glMF1eaAe7wLwZX5utzc
         kCekmi49wEBNQiSCLrY8ow+xmtXIdMGFpueKxmewRMPSlVpmfW+DpGn+20OdYdkvgDuC
         cJuqMpTfL8tOOHpZO7qq6Acz5g8Z2wNozuncMbG/IuCL45w82N5IOjaVpEuz4V7KzIK3
         Z4HI9RLwUJOELdQfYfYEdEZ4kn4x7MjCEHy0lPs7LTeRDOAVJ/pri5z/AwyiIkxF6GJi
         BhlJ5C7ZXI00c0bi2hlfXcaTctU6q+l3jayFcL5oc3UrdNzUux3Cvggrl45nS6iB37Da
         1iXg==
X-Gm-Message-State: ABuFfohkR4dLS3VzZZthc2IYk8b9SA9RNaKP05SwqieOdzSTeKz/iVRJ
        6IODFmeeXjeCjrUTdfqlekNZbEwrUFHd6N/5ufW5
X-Google-Smtp-Source: ACcGV60joQ/IasX4pm3UlaM9H9YRKOXPk5pwi5jf7SbEQXEPP97I3G40IaSWxgb0S9Jkl/nK+57L8OmWA9nMW83n9bkH
X-Received: by 2002:a0c:d022:: with SMTP id u31mr9074947qvg.35.1539896483021;
 Thu, 18 Oct 2018 14:01:23 -0700 (PDT)
Date:   Thu, 18 Oct 2018 14:01:19 -0700
In-Reply-To: <20181018183758.81186-1-sbeller@google.com>
Message-Id: <20181018210119.149727-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20181018183758.81186-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [RFC PATCH 0/2] Bring the_repository into cmd_foo
From:   Jonathan Tan <jonathantanmy@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jonathantanmy@google.com, stolee@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > Or instead we could accelerate the long term plan of removing a
> > hard coded the_repository and have each cmd builtin take an additional
> > repository pointer from the init code, such that we'd bring all of Git to
> > work on arbitrary repositories. Then the standard test suite should be
> > okay, as there is no special case for the_repository any more.
> 
> Demo'd in this RFC series for git-merge-base.
> 
> The core idea is found in patch 1,
> and the proof of concept is found in patch 2.

I don't think working around the_repository is sufficient, as there are
other ways to access the same repository state (the_index, directly
accessing files through file I/O). Instead I would prefer a test like in
t/test-repository.c - each patch set would probably only need one test
for the last function converted, since typically the last function uses
every other function converted.

Also, even if we decided that working around the_repository is
sufficient, I don't think this get_the_repository() is a good approach.
If (or when) we decide to convert all builtins to not use
the_repository, we would have to clean up all such calls.

Better would be to pass the_repository from the invoker of the cmd
builtin, and reuse NO_THE_REPOSITORY_COMPATIBILITY_MACROS in the
builtin. (I haven't thought much about how to transition to this, but
one way might be to extend "struct cmd_struct" in git.c to also have a
new-style function pointer, and #define GIT_CMD(c, f, o) {c, NULL, o, f}
or something like that.)

This doesn't directly address the fact that the builtin might call lib
code that indirectly references the_repository, but I think that this
won't be an issue because by the time we're ready to convert builtins to
not use the_repository, most if not all of the lib code would have
NO_THE_REPOSITORY_COMPATIBILITY_MACROS defined anyway.
