Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05721F51C
	for <e@80x24.org>; Thu, 17 May 2018 22:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751965AbeEQWgR (ORCPT <rfc822;e@80x24.org>);
        Thu, 17 May 2018 18:36:17 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:36794 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751892AbeEQWgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 May 2018 18:36:16 -0400
Received: by mail-wr0-f195.google.com with SMTP id p4-v6so7227416wrh.3
        for <git@vger.kernel.org>; Thu, 17 May 2018 15:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=A03qzwtJjIHA4Lzw5de7bFRhTakGjIpOI4JwOqfKAXU=;
        b=b+XovgUyzDOV5udTphdAS3jtbWuRFHdkntlG2DE+B+OTgMmkoyatLtVs9k/vSCPBTa
         lJlgTu2mGZKyO6ppWoGnW0Rhr82nHeb7ieTUQKyQf8jB/CPbGkhXkSZv5Pt9fGLHAxdE
         J9ZncRhOMoTZbGe9ddwqtLJ4FQu7We/2aqsVlY+y2wcYz2QUISOkrKSbrMYW7MdpOS0X
         W/YcsXODhfKQrv33uF/ZT8sJNOkQ3VzxuCRkAkCvISoia/Ng9J1/Nhc2IGuVr8ohSF7N
         63aQVEbfW8kZ1efDSf/JmBkYDb8vr/koAxa3MDyRy2+G+dOZZvlaaNNt5XlvJp/Ie2pm
         0qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=A03qzwtJjIHA4Lzw5de7bFRhTakGjIpOI4JwOqfKAXU=;
        b=OdtUWpYj1ptETW/fydABsi8/g9w9xNE3p+iHiNHc000fmMOBazQ0aGvm/9tmBk6cud
         aMNsECnZKBYBrGwRWPhpinmGxwlBLUGiCIoQopFNwwmLwHBlNghpRHWRaCoh8GFcQYy1
         bg6afnwrlY1vV+wsdf31AeRcghu/13FaLtSE90xbkn91JaZvSeMKDv8GOM5GY9MOF6kc
         av8kNpMOpcShMZLIt0lk43grjEjTWqynKHG4xgPSOxL+8sjmssVgEx4VkgP4gpox0Iy1
         jlELRhSONxn37iQk2IN8oEYXQTDDYylnBB8N+Z+HHtcWYH8e5KzAjQk47tx+6AAAZ5Bn
         8aYQ==
X-Gm-Message-State: ALKqPwcFzxI3mE7ZgOoSGwx2XDPqkXTqtLv7zff5mpLHlnRdTHMp2MfP
        vsLRIwby1wR4tubMOkG4sgMjMTfN
X-Google-Smtp-Source: AB8JxZqrOdEo7BeQFsahTgN/JMToimG8MQryjqGakNLy0OQ7hPaSPXN3nv1RKbQQyT93qkucI5bfIQ==
X-Received: by 2002:adf:a0b9:: with SMTP id m54-v6mr5446498wrm.76.1526596575424;
        Thu, 17 May 2018 15:36:15 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 194-v6sm9220650wml.20.2018.05.17.15.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 15:36:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (May 2018, #02; Thu, 17)
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
        <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
Date:   Fri, 18 May 2018 07:36:14 +0900
In-Reply-To: <CAGZ79kY1DOgrbkgUWHb+5KSBjrupHod0n8SU6M+xMnBGjMTmZQ@mail.gmail.com>
        (Stefan Beller's message of "Thu, 17 May 2018 11:20:57 -0700")
Message-ID: <xmqqbmdd6hb5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> * sb/object-store-replace (2018-05-10) 2 commits
>>   (merged to 'next' on 2018-05-16 at 41bbedcc81)
>>  + replace-object.c: remove the_repository from prepare_replace_object
>>  + object.c: free replace map in raw_object_store_clear
>>
>>  Hotfix.
>>
>>  Will merge to 'master'.
>
> Please do not.
> (Or do, but then be prepared for another hotfix.)
>
> The commit sb/object-store-replace^ needs more free'ing and shall be
> replaced with

Please do not replace what already hit 'next'.

> https://public-inbox.org/git/20180510195849.28023-4-sbeller@google.com/
> I'll resend shortly.
>
>>
>> * sb/submodule-merge-in-merge-recursive (2018-05-16) 3 commits
>>  - merge-recursive: give notice when submodule commit gets fast-forwarded
>>  - merge-recursive: i18n submodule merge output and respect verbosity
>>  - submodule.c: move submodule merging to merge-recursive.c
>>
>>  By code restructuring of submodule merge in merge-recursive,
>>  informational messages from the codepath are now given using the
>>  same mechanism as other output, and honor the merge.verbosity
>>  configuration.  The code also learned to give a few new messages
>>  when a submodule three-way merge resolves cleanly when one side
>>  records a descendant of the commit chosen by the other side.
>>
>>  Will merge to 'next'.
>
> Merging would be ok, but I would rather not.
> A resend will be only for cosmetic effect, as I messed up the last commit
>
> So, please hold in pu.
>
>> * sb/diff-color-move-more (2018-04-25) 7 commits
>>  - diff.c: add --color-moved-ignore-space-delta option
>>  - diff.c: decouple white space treatment from move detection algorithm
>>  - diff.c: add a blocks mode for moved code detection
>>  - diff.c: adjust hash function signature to match hashmap expectation
>>  - diff.c: do not pass diff options as keydata to hashmap
>>  - xdiff/xdiffi.c: remove unneeded function declarations
>>  - xdiff/xdiff.h: remove unused flags
>>
>>  "git diff --color-moved" feature has further been tweaked.
>>
>>  Will merge to 'next'.
>
> I did not get around to fix it up, there are still review
> comments outstanding. (The test is broken in the last commit.)
>
> Please hold in pu;
>
> Thanks,
> Stefan
