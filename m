Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B40301F453
	for <e@80x24.org>; Wed, 24 Oct 2018 02:56:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeJXLWQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Oct 2018 07:22:16 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53989 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbeJXLWP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Oct 2018 07:22:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id f8-v6so1310146wmc.3
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 19:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=lmjK43rdNB8zCgG4DuJG6nEvBthkKSBT+v6gvapW/G0=;
        b=sTjGLd4pnQTlm9IJXWtb5btZBBC1oN+GMdXSaGPdlsN/hRHVAnTvXR4lQ7h/zSu7pq
         kIVxrphLdwbNTz6hCHZ3f2hoLEunc8mF2FlpMMkcWyNSYVvu/XM1XORvgPRAcxGIsbhj
         tmiME8rW4xR40o6rJCIofErT7pBGtzuEWst+tqfwTFuNTVTkdaQI5cSNVW+mVSb3QkHe
         m+mMGY5B6Aq92uNrLZTHcvyzwOLf4wtNUvwSvIRIEIbQ0Poj3YcG8WSE3mARBj8H1AVC
         PU0C5Kxy2YJhg4m81h5AJg3RM7fPFM6ynLiFa54RsZv/KotEIoWQ6U80QjM885afo+JT
         kkwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=lmjK43rdNB8zCgG4DuJG6nEvBthkKSBT+v6gvapW/G0=;
        b=tfViITlDXJ9YtUUAXmqg7s8xnAx6qkU67dxTjEE1uQNiPcReN3f8bb3DYOr6b9Vrcd
         7Gf4aodNLVrXXPIgEQk5+aL1lC87GVxKSzsEZ2o/dDRsuDCbw2j5VVzUCztk281A9u8J
         CihwOI5aCNKZa071JAd6shKZ4yYzXnfHHKT9J6Un2oWlATz92i9zm21833jmMk0lJRu+
         5aKG4Ce4hrCM3NOjfelIksIGxA3SxYMOvNdFYl9yXdwST3Eksz2E6LNiulJDRGhdUaoN
         O+QvqRwBZ6tZAYuDQJA0N1Hy7dUsejkexS/byMqJLXzBcFDulZhaPtPfJVIFI/gag51P
         2vRA==
X-Gm-Message-State: AGRZ1gKKnXxmFehTPds93RC4O6Hi60I2tiDU348/eW9+oYArN/AZKNgb
        +H9R3fWIhvoxkSSvVSpbQVqmZvSrhpI=
X-Google-Smtp-Source: AJdET5dXwsx3Mt9axTZcBhzjVdg7O/IwtkiZbdQPZgiIZ0kUcv0ELSke/7yyBiGNMEuU5GfcFzXY/A==
X-Received: by 2002:a1c:ab54:: with SMTP id u81-v6mr586390wme.45.1540349771575;
        Tue, 23 Oct 2018 19:56:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id o130-v6sm4164096wmd.11.2018.10.23.19.56.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 23 Oct 2018 19:56:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <benpeart@microsoft.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 2/3] reset: add new reset.quiet config setting
References: <20181017164021.15204-1-peartben@gmail.com>
        <20181022131828.21348-1-peartben@gmail.com>
        <20181022131828.21348-3-peartben@gmail.com>
        <CACsJy8Dcf8OknyMaSZxOaib54jLSSt71XXjTZD3UjgnH6J7QFA@mail.gmail.com>
        <e1f50b07-b3bf-0805-fcc9-692331dd170a@gmail.com>
Date:   Wed, 24 Oct 2018 11:56:09 +0900
In-Reply-To: <e1f50b07-b3bf-0805-fcc9-692331dd170a@gmail.com> (Ben Peart's
        message of "Tue, 23 Oct 2018 14:47:43 -0400")
Message-ID: <xmqq8t2oqchi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>>> index f6f4c21a54..a2d1b8b116 100644
>>> --- a/Documentation/config.txt
>>> +++ b/Documentation/config.txt
>>> @@ -2728,6 +2728,9 @@ rerere.enabled::
>>>          `$GIT_DIR`, e.g. if "rerere" was previously used in the
>>>          repository.
>>>
>>> +reset.quiet::
>>> +       When set to true, 'git reset' will default to the '--quiet' option.
>>> +
>>
>> With 'nd/config-split' topic moving pretty much all config keys out of
>> config.txt, you probably want to do the same for this series: add this
>> in a new file called Documentation/reset-config.txt then include the
>> file here like the sendemail one below.
>>
>
> Seems a bit overkill to pull a line of documentation into a separate
> file and replace it with a line of 'import' logic.  Perhaps if/when
> there is more documentation to pull out that would make more sense.

This change (ehh, rather, perhaps nd/config-split topic) came at an
unfortunate moment.  Until I actually did one integration cycle to
rebuild 'pu' and merge this patch and the other topic, I had exactly
the same reaction as yours above to Duy's comment.  But seeing the
tree at the tip of 'pu' today, I do think the end result with a
single liner file that has configuration for the "reset" command
that is included in config.txt would make sense, and I also think
you would agree with it if you see the same tree.

How we should get there is a different story.  I think Duy's series
needs at least another update to move the split pieces into its own
subdirectory of Documentation/, and it is not all that urgent, while
this three-patch series (with the advice.* bit added) for "reset" is
pretty much ready to go 'next', so my gut feeling is that it is best
to keep the description here, and to ask Duy to base the updated
version of config-split topic on top.


