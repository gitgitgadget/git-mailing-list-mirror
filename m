Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D4B21F51C
	for <e@80x24.org>; Fri, 25 May 2018 09:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965077AbeEYJOU (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 05:14:20 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41814 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964909AbeEYJOT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 05:14:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id u12-v6so7923999wrn.8
        for <git@vger.kernel.org>; Fri, 25 May 2018 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZiCp8OhibFOhuNuZiJnR93WyNAaBWTgERYawztSHgfQ=;
        b=L9rh5IE4ltT3bOt5k1zsaFcK3A8UOufb8PiplwlwjclT5gUV5XPy3Bi0CG4qvk8DmW
         fppZbB4k9KVguxlQBeKr9d+fWtQFiA9HnyotFPDXAg4pQ0KmQv/VtLTXluz9l1yMk3wW
         wf3GwWQgeOX+A0GY62klF3eSBsIn5ot4ekT/ohR4p0xGwI0uxRzZRgnucNuNhlyly/uv
         agrAziaxjjJXgclpidhLYg78/y828KxwNU30Nv9/CsUQmuFD0GIn3oJD3j9pJauJraxQ
         5lJo67tDfxYOtwW53HrjDMTAk0NqgqqCFCrj2jHRh2DVPqbyioxGSet5Ab+h51HzD5bK
         fsnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZiCp8OhibFOhuNuZiJnR93WyNAaBWTgERYawztSHgfQ=;
        b=PJB2+d98YgBHcRTAHo1O22SA46YgS/luFTZMdyArc9SYuOHjkwSjBFje7fyoXtXf7l
         Qjq7N9SLbCkxyah1wkh0TDQXfOd4OA3qytY7XFza+rTBnBdYgebiBFbGCgyQci2IqI7D
         5tsHmk6TjN4Igp8AKugaqsFz5vltOyXd5xiqxSGto9XP+1iHhnKH3RxNCoJjkqBOTBFm
         vT1pEnpuHnUkPYBzQ/Jn04ZWi5SrIKTF03reJtDpDiE37q+jRgw2SOj27vPL2RiU8t1a
         9InZJbzy+GvEBjk7DF/hTK2CUuCkNmS+bF0fZtt8Am4HfJLy2JrqinmZFYZpPQogM7uZ
         0wbA==
X-Gm-Message-State: ALKqPwc7XauwLvreQ1dO2h9Jv6I/ns45RismZc8wA/wnfahf6Ky8jh80
        59GVODXWcBQl/jbU3fDzJuk=
X-Google-Smtp-Source: AB8JxZqYdzfNF+plVXhDNPyjadj0EAs7Jlaqsk6fVB2LscmCydKrKahbb8nxlaFNrWr1Ivr4hnJUZQ==
X-Received: by 2002:adf:8567:: with SMTP id 94-v6mr1289139wrh.24.1527239657509;
        Fri, 25 May 2018 02:14:17 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id b185-v6sm5771804wmb.25.2018.05.25.02.14.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 May 2018 02:14:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJu?= =?utf-8?B?ZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch: issue "-l" deprecation warning after pager starts
References: <xmqqvabm6csb.fsf@gitster-ct.c.googlers.com>
        <e440f6e0-6d7d-0e72-b875-de290cea6b94@gmail.com>
        <87fu2qbojy.fsf@evledraar.gmail.com>
        <20180517133601.GC17548@sigill.intra.peff.net>
        <1527174618.10589.4.camel@gmail.com>
        <20180524192214.GA21535@sigill.intra.peff.net>
        <20180524193105.GB21535@sigill.intra.peff.net>
        <xmqqh8mwpkgu.fsf@gitster-ct.c.googlers.com>
        <20180525024002.GA1998@sigill.intra.peff.net>
        <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com>
Date:   Fri, 25 May 2018 18:14:16 +0900
In-Reply-To: <xmqqd0xknmf1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Fri, 25 May 2018 17:56:34 +0900")
Message-ID: <xmqq8t88nllj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> -		warning("the '-l' alias for '--create-reflog' is deprecated;");
>> -		warning("it will be removed in a future version of Git");
>> +		if (list) {
>> +			warning("the '-l' option is an alias for '--create-reflog' and");
>> +			warning("has no effect in list mode. This option will soon be");
>> +			warning("removed and you should omit it (or use '--list' instead).");
>> +		} else {
>> +			warning("the '-l' alias for '--create-reflog' is deprecated;");
>> +			warning("it will be removed in a future version of Git");
>> +		}

By the way, this is one of these times when I feel that we should
have a better multi-line message support in die/error/warning/info
functions.  Ideally, I should be able to write

	warning(_("the '-l' option is an alias for '--create-reflog' and\n"
		  "has no effect in list mode, This option will soon be\n"
		  "removed and you should omit it (or use '--list' instead)."));

and warning() would:

 - do the sprintf formatting thing as necessary to prepare a long multi-line
   message;

 - chomp that into lines at '\n' boundary; and

 - give each of these lines with _("warning: ") prefixed.

That way, translators can choose to make the resulting message to
different number of lines from the original easily.


