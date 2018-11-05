Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 368931F453
	for <e@80x24.org>; Mon,  5 Nov 2018 00:02:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729897AbeKEJTG (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 04:19:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55185 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729871AbeKEJTG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 04:19:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so6568919wma.4
        for <git@vger.kernel.org>; Sun, 04 Nov 2018 16:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=aLe1cY5lXq0Ztnajl0T+JitqiSekGkpFsqlrfIgbhWE=;
        b=NDt4p9rT4jTOhRw9e53ueSPU8CvPLFQu4IYH+DAWrqdLryMMeit6ByOFtiFjBtwJkv
         Efvp5vzR24YfnWKaSLUn0HF392ugZYyqFoGkXlEnkkzhWrac42o1qfQM1Hlvm/u9+Ms/
         d8qZKPWUZBJ+ZxICZSv/CJm0MytQ7buxO7DpCRnbitAvo1oS9VSAb0/sdWtRIcVgsQCw
         dUTKInbNHE96FiVo9z25FuerkEGnJmifg/XbYXKNOgIYyE+poL9W+SPo40O8b9CIyS3r
         0XXQmvEwIO28V1AmLMxSNm885Br8w0eoYIIJXDJvk4W3Mno+WOAr6iYdmFAtdqd3iCSo
         BS7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=aLe1cY5lXq0Ztnajl0T+JitqiSekGkpFsqlrfIgbhWE=;
        b=BTSG2a2U+24/DSK/b5Kgu8eAEcfhvPGy8iP9QVl/uHeCKD1LZAOp62jGVz+zZBUOWK
         aaW9VtKXseqe+2nQRP+MjV2r43WMGQyDkE2TQjEpYxa21QiOICAXlquS4oTigLV2cECZ
         sEFT1YfUzxRxm98z9cI/UOLxzWRwOW/8xHt/rQh/mnmw8hKxDGfwZ2gYFYsC++Q5Aq5V
         xkGUrv3vAiUdud8S3S/H7p38r0I43jtoy6uFdnf8Np8oAJTlaL7fE1IfvVJB5tBPMlUr
         7ejN7a6GqEr4wVVp3/9wrxFrk3F+hbvPEhgOU3aFo19EENn96485t+XHm2mZDmgJhpS2
         Oc6A==
X-Gm-Message-State: AGRZ1gJHdCIxkBfYGXFu9/Taub9UqD4eBfYqOUNNUW2KrbTt8G3EdF8r
        KeERGIx3NEY5GlRw1Q9Fc+M=
X-Google-Smtp-Source: AJdET5fCR1gRl1kUDua6/MtmOWtKfqO/5XSi9X695x1xNYWU0QZI9WWrMdsp+/iEgJ26zHiAC3w7hQ==
X-Received: by 2002:a1c:91cd:: with SMTP id t196-v6mr4197724wmd.63.1541376135363;
        Sun, 04 Nov 2018 16:02:15 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id p17-v6sm7200373wmc.16.2018.11.04.16.02.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 04 Nov 2018 16:02:14 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     git@vger.kernel.org, Ben Peart <benpeart@microsoft.com>
Subject: Re: [RFC v1] Add virtual file system settings and hook proc
References: <20181030191608.18716-1-peartben@gmail.com>
        <xmqqsh0nyqx9.fsf@gitster-ct.c.googlers.com>
        <dbc2eb4f-842e-f49a-256f-3a140d801bb0@gmail.com>
Date:   Mon, 05 Nov 2018 09:02:13 +0900
In-Reply-To: <dbc2eb4f-842e-f49a-256f-3a140d801bb0@gmail.com> (Ben Peart's
        message of "Wed, 31 Oct 2018 16:12:53 -0400")
Message-ID: <xmqqa7momlx6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>>> +	if (*dtype == DT_UNKNOWN)
>>> +		*dtype = get_dtype(NULL, istate, pathname, pathlen);
>>
>> We try to defer paying cost to determine unknown *dtype as late as
>> possible by having this call in last_exclude_matching_from_list(),
>> and not here.  If we are doing this, we probably should update the
>> callpaths that call last_exclude_matching_from_list() to make the
>> caller responsible for doing get_dtype() and drop the lazy finding
>> of dtype from the callee.  Alternatively, the new "is excluded from
>> vfs" helper can learn to do the lazy get_dtype() just like the
>> existing last_exclude_matching_from_list() does.  I suspect the
>> latter may be simpler.
>
> In is_excluded_from_virtualfilesystem() dtype can't be lazy because it
> is always needed (which is why I test and die if it isn't known).  

You make a call to that function even when virtual-file-system hook
is not in use, i.e. instead of the caller saying

	if (is_vfs_in_use()) {
		*dtype = get_dtype(...);
                if (is_excluded_from_vfs(...) > 0)
			return 1;
	}

your caller makes an unconditional call to is_excluded_from_vfs().
Isn't that the only reason why you break the laziness of determining
dtype?

You can keep the caller simple by making an unconditional call, but
maintain the laziness by updating the callig convention to pass
dtype (not *dtype) to the function, e.g..

	if (is_excluded_from_vfs(pathname, pathlen, dtype) > 0)
		return 1;

and then at the beginning of the helper

	if (is_vfs_in_use())
		return -1; /* undetermined */
	*dtype = get_dtype(...);
	... whatever logic it has now ...

no?

> Your comments are all feedback on the code - how it was implemented,
> style, etc.  Any thoughts on whether this is something we could/should
> merge into master (after any necessary cleanup)?  Would anyone else
> find this interesting/helpful?

I am pretty much neutral.  Not strongly opposed to it, but not all
that interested until seeing its integration with the "userland" to
see how the whole thing works ;-)
