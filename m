Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CCB951F42D
	for <e@80x24.org>; Thu, 31 May 2018 23:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750777AbeEaX6G (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 May 2018 19:58:06 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:51614 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750738AbeEaX6F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 May 2018 19:58:05 -0400
Received: by mail-wm0-f49.google.com with SMTP id r15-v6so29261644wmc.1
        for <git@vger.kernel.org>; Thu, 31 May 2018 16:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=+3mvf53ZDjbj/TSjfBb8o23z1vOxsgumLpMPdYIeg28=;
        b=qqd8aGs/Y7W7gnnmnGlc/e7U5zdvmZnJYGvT6Lc7jMsSR2ae/ixxpFoHHAZ1Trj5Z5
         QtnnFF53DLnPDc031M6wRotg5/3CDS2C0LCUWudY60egdOZtC/qsRv3J4NkupW7etFbB
         VeHuDgD4ft/cnXFxlyDWyk+UwrBvhU5C5noGBPVWnFzk6+lWUeH6XbvdGUTEqWLMoOGt
         zyLK4c6u+JdXHrKKiLuD1sF+F4bl0mODWt91wTDTbNYxG7JxvpIfGJt3sJauVuEFfUJ3
         Yy7BHBtxkX4DgEY0qNHEyhP13ABof9D9f24e1P/8rbiy6lBm+zI1LE93gZY/hm90MOi7
         JlCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=+3mvf53ZDjbj/TSjfBb8o23z1vOxsgumLpMPdYIeg28=;
        b=EKzwSQMgFW2VpYapcevJpUeblhy7JiScfhkp6xetb20dIwVJdt87HKP+wIsbujGuZ4
         z5UkNYcJ2/q94y/q/r1ifdjjyfjb4TwELqjhGnDd1Yb0x1YLC8wnneXfOJ0bscKDgBgX
         cos7Z+SlGwIl/b8NC0v4bsTWjBXixtQTTULfwWNbhAhPH/By1YKDqsyTWLs7DPo4esYu
         xBORscA6MaPdJJNw7qFW23Frr5bdHCIYJJ6zZd1AafrXJeSaj2IvvETDF8ZtMCI24wfQ
         4xF0tbBDR2SYVhSA5NQgbTqHpUHSlD52pRLFkc2XTraRF7w8CmbmIx8Hdhog243T50hs
         jmMQ==
X-Gm-Message-State: ALKqPweeQ90YU5qf4VsrDpBlm59PooQP0NezWx1pE8+J0C58Ac/a+fhv
        T9qxjWnG/84s1UGDHUsi8u8=
X-Google-Smtp-Source: ADUXVKJM3Fbf9EHRvPtxLqWS4f7X+/vDCvxCsr+VCoRkYcNZD8q0jHH8bZSfiENK7tWiyMgawMo08A==
X-Received: by 2002:a1c:6952:: with SMTP id e79-v6mr1210356wmc.76.1527811084415;
        Thu, 31 May 2018 16:58:04 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b66-v6sm638728wma.48.2018.05.31.16.58.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 May 2018 16:58:02 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2018, #04; Wed, 30)
References: <xmqqy3g1d4xa.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DW8e4rFWzzc4WxLRtK-WTAcG_BwFSxAya_fLfXOk9p8A@mail.gmail.com>
Date:   Fri, 01 Jun 2018 08:58:01 +0900
In-Reply-To: <CACsJy8DW8e4rFWzzc4WxLRtK-WTAcG_BwFSxAya_fLfXOk9p8A@mail.gmail.com>
        (Duy Nguyen's message of "Wed, 30 May 2018 18:27:27 +0200")
Message-ID: <xmqqa7sfcr92.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, May 30, 2018 at 8:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> * sb/object-store-alloc (2018-05-16) 13 commits
>>  - alloc: allow arbitrary repositories for alloc functions
>>  - object: allow create_object to handle arbitrary repositories
>>  - object: allow grow_object_hash to handle arbitrary repositories
>>  - alloc: add repository argument to alloc_commit_index
>>  - alloc: add repository argument to alloc_report
>>  - alloc: add repository argument to alloc_object_node
>>  - alloc: add repository argument to alloc_tag_node
>>  - alloc: add repository argument to alloc_commit_node
>>  - alloc: add repository argument to alloc_tree_node
>>  - alloc: add repository argument to alloc_blob_node
>>  - object: add repository argument to grow_object_hash
>>  - object: add repository argument to create_object
>>  - repository: introduce parsed objects field
>>  (this branch is used by sb/object-store-grafts.)
>>
>>  The conversion to pass "the_repository" and then "a_repository"
>>  throughout the object access API continues.
>>
>>  Is this ready for 'next'?
>
> I think so. Stefan could remove the comment "/* TODO: what about
> commit->util? */" if he wants since nd/commit-util-to-slab is already
> in next. But this is really minor and does not need fixing to land on
> 'next'.

Thanks.
