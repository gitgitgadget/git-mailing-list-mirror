Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0319CC433F5
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 23:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbiCDXmj (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 18:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiCDXmh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 18:42:37 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A7D224501
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 15:41:48 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id z12-20020a17090ad78c00b001bf022b69d6so8158768pju.2
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 15:41:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3DCcJiCHsFah34bkUjLMSYDpVXVyitGR6ZvBYBPDiy8=;
        b=feWc5MQPoRfN2WQgDFfug2gbZrfA7oZRjsfbD6bVopo/yTH1/wx9htmB84WlYoxoja
         VG1rSv0iOyxntPhHVuE/VNFSxQwsjnCgEgNCMd5lt2HLojIYClX3SMy5FXD/69Kkdorp
         2rbHgoWUMh6e1QZXREHYW9TQvYr+hQdmi1ruxTkooJK06TgPbuCaxO75DV/4Ln0YwOLq
         wLx1aOjOvFF4EE9oVOQTnekEerOhxsY9CEgpKHnvuRUZYqKMCi4OmjyNDkL7OexQUu2s
         85fGJUh4IMu2Kjn+wgdVuZv8h7bjOhzYlPEDzAK8t/ckkfh/1uxRECQv0ZEnLV+djvtS
         L39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3DCcJiCHsFah34bkUjLMSYDpVXVyitGR6ZvBYBPDiy8=;
        b=qVomoaAU/c/WquHWqGEVrix8CRDerG8caIDYWYhhwL7AKOq2kt725HGS35xabYZCtq
         cOFOp9pZyovxCMkVQdsIm0hWfYcBWMa8li7fq9tLzR5njMSUMwBGKrgp8iKYV5elBAos
         WBgD03SxQIyxYp+IYOQqnKF/4uQldg3fHQ0+IO6w2auRh1frrQJVmZLtVRCpWx4zQmt9
         HYxbdHmqZYrRkaAqXNxa2FVUXe8LsIMur1NzR7kwwVM5YxHvI2qb24VSSgttvjWxd2QL
         S1z9DFyy3AzQ+qGVYMNokHkeKg8K9M39ZA+oOXZJOFoMOtjDN778jfdGBIUXHKiw/7o1
         5ZyQ==
X-Gm-Message-State: AOAM5324QM1EGhds5EWWqgwXIPQn/129dW3SBzjHG1nePbEhlLeU5iiq
        6n7N5rfJYNozJ23q1KQqrrX8cnR++RNc/A==
X-Google-Smtp-Source: ABdhPJwOyJfaqFkKuORPn5peapSKRytj6Snk9h91lJ4nSC2sn1pfcKT4Xmn1vXlTS1ueomX3jOB9BQ==
X-Received: by 2002:a17:90a:ab08:b0:1bc:3ece:bdc with SMTP id m8-20020a17090aab0800b001bc3ece0bdcmr1092555pjq.32.1646437307307;
        Fri, 04 Mar 2022 15:41:47 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:e381:a3f4:ceac:8c28])
        by smtp.gmail.com with ESMTPSA id lw12-20020a17090b180c00b001b8a61a0ea5sm5664111pjb.38.2022.03.04.15.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 15:41:46 -0800 (PST)
Date:   Fri, 4 Mar 2022 15:41:41 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] SubmittingPatches: write problem statement in the
 log in the present tense
Message-ID: <YiKjtcHSBXWky7Ze@google.com>
References: <20220126234205.2923388-1-gitster@pobox.com>
 <20220127190259.2470753-2-gitster@pobox.com>
 <YiFWZal+k6ixnYPU@google.com>
 <xmqqzgm65zvy.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqzgm65zvy.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 03, 2022 at 04:23:45PM -0800, Junio C Hamano wrote:
> 
> Emily Shaffer <emilyshaffer@google.com> writes:
> 
> > As for the norm itself, I think it is a good one, and I've seen it
> > pointed out in code reviews frequently. Thanks.
> >
> > Reviewed-by: Emily Shaffer <emilyshaffer@google.com>
> 
> Thanks.
> 
> Was this meant to be sent long after the topic was merged to
> 'master' at 83760938 (Merge branch 'jc/doc-log-messages',
> 2022-02-11)?

As mentioned in
https://lore.kernel.org/git/YiFZicz69mDyFzXB%40google.com - no, it
wasn't. In fact, in conversation at $dayjob someone said "whatever
happened to Junio planning to write updates to SubmittingPatches?" and
someone else said "it didn't really get any review" - so I said "okay, I
will do review" instead of checking whether you merged anyway. So mostly
useless noise :)

 - Emily
