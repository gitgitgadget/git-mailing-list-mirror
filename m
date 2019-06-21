Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2ACB1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 22:58:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfFUW6p (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 18:58:45 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:38204 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfFUW6p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 18:58:45 -0400
Received: by mail-pg1-f202.google.com with SMTP id 21so4914134pgl.5
        for <git@vger.kernel.org>; Fri, 21 Jun 2019 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=yzy/o8wyT5rORBnyg/XCTe8NtqgM9zwVIy04hmaE4Wc=;
        b=LPeqixq0zo1qdN+mZNP+PUGyaH80h8LN3Xxx6TUk3cwBU4KCDVdjS2RoQMORR2QRjR
         37h/X3LZzYS+crQdNHhqx1tK9azG/jU+UaODAhTK/mO5g2yTsAuPSASeK8KoVKnWbGfE
         a17D/6WAPrGdZLtowQ9kZbQDM76H8yasTO99HMjJG/8lRB7u85b4bctUSv/PiXKTJ+x8
         YYkkJCFYRPN7J+LgWlgBRTimAUy5Zj+MtvIcclqS/smhSDHd6QWp2+pL/PB0SUM/YlLo
         QhcVnpIJrVJLgKtaFRI0qDba/uOYCD+lWQzy/rbEC8/Al8VUCXEIMsJAm5TrS2tG7Sp4
         DCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=yzy/o8wyT5rORBnyg/XCTe8NtqgM9zwVIy04hmaE4Wc=;
        b=U/a8VlIjkzxLobth/w/mTsZPb39ToPj+an/UYc7aljQFn1odgW0esa9DQikX2z9hAj
         pwwNcfa5uDVWmG6hrOQab7fSTFs6Wp2QWn0UaILdNwzhTQIXTLR/HRsMLSh0LEG7l4iL
         lksnwjdOTUgERoKIlM5qQv7SSBoHfPk7Unh+eflunPDFC2vyp9Nsp54if2lcMvdWQeyK
         i/UYoYvjjDFaKDaYMjEZANLahyrPRwvfl4SISMYW4kv5/JGM1PgTWm7OHB2mvUpNH0Yd
         QgL3H7/wYGPxSKYb0OhS7fdN9giIgtS/qxnvvtyjUPxf7APAuICmquIfI+sEUWbM4zKF
         zHgA==
X-Gm-Message-State: APjAAAXcsJNmfjCGnt9L1MA29s+6KFhe7GfllvEyOom47YVgVw2O9nkT
        7UDEC0YbHtlPkAYoxbY9sNnlk7bnMhlT/ISx+ndk
X-Google-Smtp-Source: APXvYqx62NOZpSgxxQguSYsys4Xx9HSJEwsEbzR6tcAs7RbBA7jutMsS9u4zBRQzBxWsaBB/WrN5spwStlaCGiW5Wpmm
X-Received: by 2002:a63:1d2:: with SMTP id 201mr15294156pgb.232.1561157924285;
 Fri, 21 Jun 2019 15:58:44 -0700 (PDT)
Date:   Fri, 21 Jun 2019 15:58:38 -0700
In-Reply-To: <70568c42ae6d59dacbb36ffb8e4a8828b6595158.1560558910.git.matvore@google.com>
Message-Id: <20190621225838.226321-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <70568c42ae6d59dacbb36ffb8e4a8828b6595158.1560558910.git.matvore@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: Re: [PATCH v4 01/10] list-objects-filter: make API easier to use
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Make the list-objects-filter.h API more opaque and easier to use. This
> prepares for combined filter support, where filters will be created and
> used in a new context.
> 
> Helped-by: Jeff Hostetler <git@jeffhostetler.com>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Matthew DeVore <matvore@google.com>

So what happens is that filter_fn, filter_free_fn, and filter_data are
encapsulated into one opaque object, and users will now use filter_fn
and filter_free_fn through other functions that we expose, allowing us
to add some conveniences that currently have to be repeated at each call
site.

I would prefer the following commit message:

  list-objects-filter: encapsulate filter components

  Encapsulate filter_fn, filter_free_fn, and filter_data into its own
  opaque struct.

  Due to opaqueness, filter_fn and filter_free_fn can no longer be
  accessed directly by users. Currently, all usages of filter_fn are
  guarded by a necessary check:

    (obj->flags & NOT_USER_GIVEN) && filter_fn

  Take the opportunity to include this check into the new function
  list_objects_filter__filter_object(), so that we no longer need to
  write this check at every caller of the filter function.

  Also, the init functions in list-objects-filter.c no longer need to
  confusingly return the filter constituents in various places
  (filter_fn and filter_free_fn as out parameters, and filter_data as
  the function's return value); they can just initialize the "struct
  filter" passed in.

> +enum list_objects_filter_result list_objects_filter__filter_object(
> +	struct repository *r,
> +	enum list_objects_filter_situation filter_situation,
> +	struct object *obj,
> +	const char *pathname,
> +	const char *filename,
> +	struct filter *filter)
> +{
> +	if (filter && (obj->flags & NOT_USER_GIVEN))
> +		return filter->filter_object_fn(r, filter_situation, obj,
> +						pathname, filename,
> +						filter->filter_data);
> +	/*
> +	 * No filter is active or user gave object explicitly. Choose default
> +	 * behavior based on filter situation.
> +	 */

This part is when we do not need to apply the filter (or none exists). I
think the comment will be better if stated more explicitly:

  No filter is active or user gave object explicitly. In this case,
  always show the object (except when LOFS_END_TREE, since this tree had
  already been shown when LOFS_BEGIN_TREE).

> +	if (filter_situation == LOFS_END_TREE)
> +		return 0;
> +	return LOFR_MARK_SEEN | LOFR_DO_SHOW;
> +}
