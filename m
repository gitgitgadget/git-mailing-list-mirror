Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 257A51F404
	for <e@80x24.org>; Fri, 16 Mar 2018 21:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751618AbeCPVwO (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Mar 2018 17:52:14 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33483 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751233AbeCPVwN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Mar 2018 17:52:13 -0400
Received: by mail-wr0-f196.google.com with SMTP id z73so8717369wrb.0
        for <git@vger.kernel.org>; Fri, 16 Mar 2018 14:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=30FAc5e3ERXd9AdHLLr9AhC6SH2xIKRn1lb2spKfKVg=;
        b=NvYI/X4bx7dIVlRssyYsMEb/gPHa12xTlzHckitBFGjCq5P9QIdovXHjx2UlQDgGKP
         465x+CBw4kQx8kaAewFpedfsaWkyavhIilXXnAirbwI2wNk8CO/0Dl4zbTRmhyVbOIFD
         iKraP0HXZWHL8pIuwdbA/zwVzgSmMcQUY066xlF5WfN1HRnnOtHiovlAiWjYKsNAz9RJ
         yiIDdfKNWz4ANnxCBK0ME4KPGLAd9hY3QNmQ0VsUZO50tzyAK2r9z4JdtpqanQgpdXqe
         8uoIZuVGraiM10VGOZr5X2IfqJtK6wt2GsssgBJT2Ab68wcG62TEOdp/b28Bakv4yLqs
         Dp6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=30FAc5e3ERXd9AdHLLr9AhC6SH2xIKRn1lb2spKfKVg=;
        b=sdQE6o9AWqU9ivgOxPP4TqOFAfGrAVv6a8jRgcHpwqgUajUS1ERU50zlOgLQz/YZzx
         bxj+0j0hRB+YipTezjo8m6paPdhgQhvC2dvz+mNbQz2YDMIjFhpKqwCuUUQMm8oMA/1a
         Y2QB6o0x6M+QbLyEYChuMMEMWQIRlJMD7VyQRVvcmiwjDYiDwKknIqMSzFRpR+I+7bEz
         irl75Qgp5c6ApboX0pwccICt6yIFguV+a2kpvmyn2SMyjHVgw3YoUVw4PXZhXti9PDYi
         HiMTkWVjfna5dHrCkhVmjQSD1WZJht/DKDekzOmry1moUveNk3k9hkqMof3GWQF2lGMW
         SMvA==
X-Gm-Message-State: AElRT7FH4DqSHjLennXQ7Ijnw9Sxvzh2UfHlR1ofuKHh6Qf9zf2JD8+r
        9a1uKLwsszhDvLcZgv1mj2U=
X-Google-Smtp-Source: AG47ELvfHIFkdW8mbBmTIIKkZey2y8lOPDchkJxajXnu4ngARRMQQLfk7/bd9b5cO/uAzRtCiwJ5RQ==
X-Received: by 10.223.132.167 with SMTP id 36mr3080023wrg.227.1521237131501;
        Fri, 16 Mar 2018 14:52:11 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id y111sm8932024wrc.0.2018.03.16.14.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 16 Mar 2018 14:52:10 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Mar 2018, #03; Wed, 14)
References: <xmqqefkm6s06.fsf@gitster-ct.c.googlers.com>
        <20180316143124.5b22d70861344cbcbbad46dd@google.com>
Date:   Fri, 16 Mar 2018 14:52:10 -0700
In-Reply-To: <20180316143124.5b22d70861344cbcbbad46dd@google.com> (Jonathan
        Tan's message of "Fri, 16 Mar 2018 14:31:24 -0700")
Message-ID: <xmqqh8pfzo1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> On Wed, 14 Mar 2018 18:34:49 -0700
> Junio C Hamano <gitster@pobox.com> wrote:
>
>> * sb/object-store (2018-03-05) 27 commits
>
> [snip list of commits]
>
>>  (this branch is used by sb/packfiles-in-repository; uses nd/remove-ignore-env-field.)
>> 
>>  Refactoring the internal global data structure to make it possible
>>  to open multiple repositories, work with and then close them.
>> 
>>  Rerolled by Duy on top of a separate preliminary clean-up topic.
>>  The resulting structure of the topics looked very sensible.
>> 
>>  Waiting for a follow-up discussion.
>
> Would it be possible for this set to go in independently of
> nd/remove-ignore-env-field? I understand that some patches might be
> cleaner if ignore_env is first removed, but this patch set has already
> undergone several rounds of review and (I think) is an improvement to
> the codebase on its own.

I thought the "remove-ignore-env-field" thing is a quite small and
more-or-less straightforward improvements that would serve as a good
preparatory change to give a solid foundation to the object-store
topic.

I was hoping to hear quick Acks for remove-ignore-env (and also
Duy's reroll of their topics on it) from people involved in all the
related topics, so that we can advance them more-or-less at the same
time.


