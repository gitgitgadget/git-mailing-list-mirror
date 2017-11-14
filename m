Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 04A721F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 18:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbdKNSiM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 13:38:12 -0500
Received: from mail-ua0-f171.google.com ([209.85.217.171]:47801 "EHLO
        mail-ua0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754795AbdKNSiL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 13:38:11 -0500
Received: by mail-ua0-f171.google.com with SMTP id s28so8493329uag.4
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 10:38:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=96AFY9Irxvl5rWZgKuuKIlMgnsyG608cjl+RqTVMHbA=;
        b=OiQMUCYN6q8l2zPJ/ChAe4jOvK91zDRBkDmTrSm+r1RjSRpuwwZDggIiWXhzrBgx6b
         0RoTvnGw4IUhsaK2CA6o1uKo0qIXL4zNOtlXm09clkFQ6KwpPScBDqYmAadNXUx68B7p
         lEcU15QRj4+R0IHckNBIJfJK2LStmq6pviX4jEhwwIYpeQLuTz1lVyWbXdolPGMSJJL/
         NfkqUg323uuTW2Sgg/uJiHf3xEKr9NWsW5Vho7MdMCbXy3m/3ryKAFmLqvktDsF/qyUA
         WgTX/yGDDjcq7rwsGf3UOhTzpqT3/HFNQEHx7SGgIWep1v41Lb0kCfyLcUb4CmmDjbt1
         Ypeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=96AFY9Irxvl5rWZgKuuKIlMgnsyG608cjl+RqTVMHbA=;
        b=GD90YkZF8Q+gGeksOrshD1Yw9ResvMpM+m9Uc8xAH9n2UHW5HMV88NINSYfAeN6zlJ
         hiyg0ASbWENXIlI0VtRztommVV+eaxsPvnXQr1TGLVQK210i05eVRfoq3eShFsLK+dHa
         RwNOe9mxYSuzdIJWqsj39uGMmzI+3GmuvcgW+HdWmrszk7YBU5rXOmyCGMVhDekr8gVx
         Y8KQffS/mz3JaYvfwQjuB7EIauAFmX173iD36cy9ugenPLS/CbrPPjkwL8Duu7GbIdBa
         z/rcCJ59pTHdU/1y66rOgavGbWr8sNSKXX9Q4wXpjkLrrp9JzeEGtvhTpjFWX44sHNwC
         bgNw==
X-Gm-Message-State: AJaThX7c40d9yV6dj/JnPKkUGAPmN2LUpQ3WuaW8iRi1QoJ/WppTc/6v
        2Pmm8DOAOEfComj5YCAq0XaAZ/jJfhNC0aJ6UaA=
X-Google-Smtp-Source: AGs4zMYVfwDRCnwk2M7L6aJSGmbcY0Z4Vn/AH6d/k1y9fUqoVObreCMTASTwgNtzEIrtk27LYqSo3n09XNzcIKky+0s=
X-Received: by 10.176.85.215 with SMTP id w23mr1697713uaa.87.1510684690329;
 Tue, 14 Nov 2017 10:38:10 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.67.33 with HTTP; Tue, 14 Nov 2017 10:38:09 -0800 (PST)
In-Reply-To: <xmqqmv3p4ebo.fsf@gitster.mtv.corp.google.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-22-newren@gmail.com>
 <xmqqmv3p4ebo.fsf@gitster.mtv.corp.google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 14 Nov 2017 10:38:09 -0800
Message-ID: <CABPp-BEsEwqAZWtHVe9zhn_KtnLo9yv55666FAiDsMEw62yZoA@mail.gmail.com>
Subject: Re: [PATCH 21/30] merge-recursive: Add get_directory_renames()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 13, 2017 at 9:30 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> +             entry = dir_rename_find_entry(dir_renames, old_dir);
>> +             if (!entry) {
>> +                     entry = xcalloc(1, sizeof(struct dir_rename_entry));
>> +                     hashmap_entry_init(entry, strhash(old_dir));
>
> Please make these two lines into its own dir_rename_entry_init()
> helper.
<snip>
> we'd want to see its string_list member to be
> initialised explicitly

Will do.
