Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06AC91F803
	for <e@80x24.org>; Thu, 10 Jan 2019 22:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728512AbfAJWLh (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Jan 2019 17:11:37 -0500
Received: from mail-io1-f73.google.com ([209.85.166.73]:51428 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbfAJWLh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jan 2019 17:11:37 -0500
Received: by mail-io1-f73.google.com with SMTP id q207so10994639iod.18
        for <git@vger.kernel.org>; Thu, 10 Jan 2019 14:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZdnHlBoppDVOGbbMYyu+X1ZSH+r8B8H7WjeLR7IJg3s=;
        b=LbjujJXFikWYMsJibOrAmhuGCGEAk8LdNNSXQpBkWGsHRrd2oWEZ/jkSo1qTwVfk4G
         0Kt5gDtWk2BS3mr6jaw+IoXwfY/FDifoi4ZKS6u6iq/vFHNn+LOlLZVq6dSBhPmffeBf
         ognK9nEZ0phj7hyBPQubfRo+d9Rm9kEXpDVQOUFwtjMRPknshOtHV/geo8EMBpWDC8jH
         5U0C5qBAvAnbMFsHhHODF+YMtEA7XhkXeqFLSflg+zg84Cl+XmeAk18GNaI+RTjcs5Ja
         a+n6dUynctTH7RiJFY06Bc5/neQNjKS4QSaMlXq5SrPgvxqLzT1nCqZMsomNvV9AplYb
         y97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZdnHlBoppDVOGbbMYyu+X1ZSH+r8B8H7WjeLR7IJg3s=;
        b=ubRlfLOht0LJvj9lAkN9KfDDfK2e5VH5CvE7gAwLji7Sk9YkJp+tW01Psp/mSAobAT
         0pSA/jS0BIxspO5PMFr2cMRKK/wSDa8YU0Jd9HuCrkmwi8Zvmn+evMHfeWmHjmaqD9JD
         tb4dk9VjisLSO52oom2UL0HKMqvFzc0W7tchMorLNJow9dwmN/ONuvWr+6vLl1i5iR5O
         TLB0LkXLCUIlz/iyITNHrRxG4ZM6xAerUGX4fbQS2QJ1AT0YQmyE7yw5H9u3RVdMesvb
         cRVF84kdDDM9Gwfux/VYoJcxoBgQzQhBPYSpryplRNFHGanX15KZ4a0S93+JABoU712n
         KwUA==
X-Gm-Message-State: AJcUukcKEd9Rm1rJQCkDNxt9nLRKmrjdH7TndGVUc4pOMN6xFgDH5sV4
        MsC8hcnw+ldTP+t1HiehcaifgcyLsHLphGwrfvK1
X-Google-Smtp-Source: ALg8bN6bfHouLxY4s6M0tqO8vekUW9xJR9WK7sRTEYABbV90uK7HXsMzbSSc7GUBsxMQMYktza3aJfS7foraWW4OdwIF
X-Received: by 2002:a24:1c87:: with SMTP id c129mr569249itc.11.1547158296815;
 Thu, 10 Jan 2019 14:11:36 -0800 (PST)
Date:   Thu, 10 Jan 2019 14:11:32 -0800
In-Reply-To: <20190110212857.58772-1-jonathantanmy@google.com>
Message-Id: <20190110221132.52443-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190110212857.58772-1-jonathantanmy@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH] upload-pack: teach deepen-relative in protocol v2
From:   Jonathan Tan <jonathantanmy@google.com>
To:     jonathantanmy@google.com
Cc:     gitster@pobox.com, steadmon@google.com, git@vger.kernel.org,
        avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > This, when applied on top of ecbdaf08991, seems to break t5702.30,
> > at least for me.
> > 
> > Tip of 'pu' in today's push-out will be broken as it has this patch
> > merged.
> > 
> > Can somebody take a look?
> 
> I can reproduce this. I'll investigate this further. In the meantime,
> feel free to remove this from pu.

The test failure is caused by a bug I fixed in [1]. I've verified that
if I apply [1] first, then this, all tests pass. If you do include this
patch in some branch, it should be dependent on [1], but I understand if
you'd like reviewers to look at both this and [1] first.

I thought I tested this without something that fixes the issue fixed by
[1] and it passed, but apparently that's not true.

[1] https://public-inbox.org/git/20190110193645.34080-1-jonathantanmy@google.com/
