Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B21101F453
	for <e@80x24.org>; Tue, 22 Jan 2019 19:51:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726015AbfAVTv3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 22 Jan 2019 14:51:29 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:46480 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfAVTv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jan 2019 14:51:29 -0500
Received: by mail-ed1-f66.google.com with SMTP id o10so20297516edt.13
        for <git@vger.kernel.org>; Tue, 22 Jan 2019 11:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M5xdm+LcRJBqo4kSg8R86tfcr+Gg+r9qVt7VU1yKuyc=;
        b=CPM8HZmlb2DlJZMn1XWyxVo1vFbVIgGCu7jgGUCXm9lEL9p/BksgFHP0YiZkdkzmRV
         2TZoQfS3+RlrQIy6LyKZNuEnKNXOWX59+3qzABis9k6MSkp/Y8DXcA28TzCT5T2V8L+s
         /uXBgGad6k+iB7GnEPB39jFDWVA/SBFh+OLHpQLPO6hT5tJjNOwy25PsYxKjkqoH+g/6
         yt5eMZubpjN4jT0E3B4WoFILDIB6ui5bmKBs0ijwkzHUwubI36dr8HQkXnDc7i84BIU+
         3Cs/g/JuSKDaJ6IMUks6SbhEsSNPDkJIjtegV2D3MN8Id+ONTjDe5AuTVMMEnB7Met4L
         ohMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M5xdm+LcRJBqo4kSg8R86tfcr+Gg+r9qVt7VU1yKuyc=;
        b=QKz8P+JQRNjzsuT2Ba84LjfB1cH0BCKIvy48sY34v14j+DGPR7auGTSSAciCKakdY7
         6FfvLK4fyTOYmPPherBlvRa0ufXC0pn45mBbnw6OW9mPVeVgpo3JejN7PhDwtNk4IjUg
         3u6xm2wr/Z2f8oKRVBN1bdv5gfNORBBuI4ybKuhgj35Bqc5DFG8r0E/6tdgv7e2Fdkgb
         EkL5BSVKuQj/fKEVwde1acZVGKzzTH9CryeQDmIHPZggYpa9z5KzHRWBS8N/cy1SD86f
         8Ic8RA0Cp7MEBZr7+gvl1vlH4U5zjUz2vbEfyMVrzyW3JkU5+JbZyEUocRkXvagaXHnY
         NAMQ==
X-Gm-Message-State: AJcUukc09OivR2Rj1wQhrMvrBaVQIDFy1pitHqxxLrfPubLaiHTHRSTB
        zA4gwlpKU4aIC2khG9PsZx5HMDFmE3SGWIawSVp93A==
X-Google-Smtp-Source: ALg8bN6sJ3NAOsUw/OOUEAQbv36Nj2XwQps9DfPGVPAvC89dYInDu9GxnEtBJKY63zhH2cAO+0bIfU15CXUWnZuYXzY=
X-Received: by 2002:a50:acc3:: with SMTP id x61mr31667024edc.76.1548186687092;
 Tue, 22 Jan 2019 11:51:27 -0800 (PST)
MIME-Version: 1.0
References: <20190121223216.66659-1-sxenos@google.com> <20190121223216.66659-2-sxenos@google.com>
In-Reply-To: <20190121223216.66659-2-sxenos@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 22 Jan 2019 11:51:16 -0800
Message-ID: <CAGZ79kYiE+VhQw4GMs_VM6kK5yXAQ8An0o4fCVSZ3gr2+rHwiA@mail.gmail.com>
Subject: Re: [PATCH 2/8] evolve: Implement oid_array_contains_nondestructive
To:     Stefan Xenos <sxenos@google.com>
Cc:     git <git@vger.kernel.org>, Stefan Xenos <sxenos@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 21, 2019 at 2:32 PM <sxenos@google.com> wrote:
>

> evolve: Implement oid_array_contains_nondestructive

I'd think I would word this

    sha1-array: implement oid_array_contains_nondestructive

as for this patch it is not relevant what we we'll be using it for
later, but rather that it touches the oidset class?

> From: Stefan Xenos <sxenos@gmail.com>
>
> Implement a "contains_nondestructive" function for oid_array that won't
> sort the array if it is unsorted. This can be used to test containment in
> the rare situations where the array order matters.
>
> The function has intentionally been given a name that is more cumbersome
> than the "lookup" function, which is what most callers will will want
> in most situations.

What about naming it oid_array_linear_lookup instead?
That would still have the common "lookup" in the name and
the "linear" should be enough to scare away the casual
user. The non-destructive sounds scary.

Missing sign off
