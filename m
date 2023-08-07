Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5955C001DF
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 21:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjHGVRE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 17:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHGVRC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 17:17:02 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6FBB6
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 14:17:01 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-583f048985bso64884897b3.2
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 14:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691443020; x=1692047820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=u6fyXSKPI3nyk68Qn/LsETed15dltSEFoy+RjVQo36I=;
        b=DqnLQUFUUZSfcvfPNs/tfbeeMCe6hXmiKL50OmJaAWt5u814z001ZaYgED/rSQysOM
         c0b7vpIfGvJdWLiCKLYF/CZC7ZT98R+B4a46iFRWCbqUiBp7zPpM4JK7/Plu44a67pAW
         pwJAcgA5bVZMF0gIMG4Dv0mjjyRSWnHZ9/Nb9KZuszrRNw0FBgZQvEkazvd80mgfNB6i
         KOcz954ROLghdrhof26JhbNFLLklCI64ZtG468/LmU4q4EExgCx/F2aTheYz9KVAHEeT
         xHKlD/b3PncUHOj8+wDn5+xCB+G/6bbJT4M1KlTZfWdOBLrofIg5fPUnnwAr52DMW9sS
         03TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691443020; x=1692047820;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6fyXSKPI3nyk68Qn/LsETed15dltSEFoy+RjVQo36I=;
        b=JNpmKIk7oyhS72w1FIkjukT9opWagFhiMMYsU+LYco2Fcc21s9snjjx4CIiQ2Vtm4g
         Rq7cJRHpfDeLWkj9PDs1qS0DvwpSCleFmdw7nTEw3nw+Ltj7E0ozUZg6R01ThV3PHxjV
         lC5uRgRJJPKiamtvBzsAZEleAqGCgN/BqORR80i4fj0EuFgpjzpYZeJn5uWzaf6UiQph
         uP/wgA2GjH6CFf0FIEoXVglm1zfrFqjKMeUyOILjc3GclLtU0XthBBHVk4KJgZbixt8g
         z2Pd0z2McIT/KhVnhPYtaZL1jAlKKehx8nb2MIfrlT8YoSABmj7Y5FB+f+ngWBwPyc2S
         zZTw==
X-Gm-Message-State: AOJu0YyXpoFA5QM0vQAZS3EsURAUIDx5bCaNNxsn8IHYu6ZEPW/RhPdK
        /Fb8kt31TcOeMc+zvQ4r/qgpBdHDGBVYtg==
X-Google-Smtp-Source: AGHT+IFfYNMz+rACk7/U14AUDEtzwGInX9yBY7ot+Kqz+GiVosgtJI0pYrzl/696/B/ZzW9Vt7n2uAhvyjdRYA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a81:b144:0:b0:586:4e84:26d2 with SMTP id
 p65-20020a81b144000000b005864e8426d2mr88592ywh.3.1691443020340; Mon, 07 Aug
 2023 14:17:00 -0700 (PDT)
Date:   Mon, 07 Aug 2023 14:16:52 -0700
In-Reply-To: <0bce4d4b0d5650edf477cbbcc9f4e467b7981426.1691211879.git.gitgitgadget@gmail.com>
Mime-Version: 1.0
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com> <0bce4d4b0d5650edf477cbbcc9f4e467b7981426.1691211879.git.gitgitgadget@gmail.com>
Message-ID: <kl6l8rama6yj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 1/5] trailer: separate public from internal portion of trailer_iterator
From:   Glen Choo <chooglen@google.com>
To:     Linus Arver via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As someone who isn't that familiar with trailer code, and will have less
time for the ML soon, this is more of a quick drive-by..

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +#define private __private_to_trailer_c__do_not_use
> +
>  void trailer_iterator_init(struct trailer_iterator *iter, const char *msg)
>  {
>  	struct process_trailer_options opts = PROCESS_TRAILER_OPTIONS_INIT;
>  	strbuf_init(&iter->key, 0);
>  	strbuf_init(&iter->val, 0);
>  	opts.no_divider = 1;
> -	trailer_info_get(&iter->info, msg, &opts);
> -	iter->cur = 0;
> +	trailer_info_get(&iter->private.info, msg, &opts);
> +	iter->private.cur = 0;
>  }
> --- a/trailer.h
> +++ b/trailer.h
> @@ -119,8 +119,10 @@ struct trailer_iterator {
>  	struct strbuf val;
>...
>  	/* private */
> -	struct trailer_info info;
> -	size_t cur;
> +	struct {
> +		struct trailer_info info;
> +		size_t cur;
> +	} __private_to_trailer_c__do_not_use;
>  };

Interesting approach to "private members". I like that it's fairly
lightweight and clear. On the other hand, I think this will fail to
autocomplete on most people's development setups, and I don't think this
is worth the tradeoff.

This is the first instance of this I could find in the codebase. I'm not
really opposed to having a new way of doing things, but it would be nice
for us to be consistent with how we handle private members. Other
approaches I've seen are:

- Using a "larger" struct to hold private members and "downcasting" for
  public users (struct dir_iterator and struct dir_iterator_int). I
  dislike this because I think this enables 'wrong' memory access too
  easily.

  (As an aside, if we really wanted to 'strictly' enforce privateness in
  this patch, shouldn't we move the "#define private" into the .c file,
  the way dir_iterator_int is in the .c file?)

- Prefixing private members with "__" (khash.h and other header-only
  libraries use this at least, not sure if we have this in the 'main
  tree'). I think this works pretty well most of the time.
- Just marking private members with a comment. IMO this is good enough
  the vast majority of the time - if something is private for a good
  reason, it's unlikely to get used accidentally anyway. But properly
  enforcing "privateness" is worthy goal anyway.

Personally, I think a decent tradeoff between enforcement and ergonomics
would be to use an inner struct like you do here, but name it something
autocomplete-friendly and obviously private, like "private" or
"_private". I suspect self-regulation and code review should be enough
to catch nearly all accidental uses of private members.
