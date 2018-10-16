Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C44D1F453
	for <e@80x24.org>; Tue, 16 Oct 2018 06:18:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbeJPOH2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 10:07:28 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50928 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbeJPOH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 10:07:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id i8-v6so20984500wmg.0
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 23:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=QAVVWilPvVxDX2jTQxoK0+LmrVbK0zY9ufsmrO0rSUk=;
        b=JH41wNI7CP5zrYGjVtnuviG1wewBaYtm9pAbaTR4jk6I9x/UOfOnKorYiYwufe11Lx
         CxokP6m/ODquZgPsnaaTQlpg3p6inu+2VG3OfyByI82veU/YEUJL80J0Qv93/O/HmwuR
         8iW9aEANJM+s5VtObdRGII0kAxUKDgG1WemOHqmU1SPoP4dThLv0GEw8F6xhORhBgynl
         qOHDzKfirGz3iz3rCehp/4Sc11X1rqOsKUdIVK8lL3fWB60sIeCx4ovW1cobOK0CTOdF
         SC6u4M3Ou2+fMwaETE1e2XeYQjXwQhAmkAAqdRgFfmmiebYmjK5/frrCrxINaJ3F3u7i
         W0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=QAVVWilPvVxDX2jTQxoK0+LmrVbK0zY9ufsmrO0rSUk=;
        b=VKzjEQ3YLg59ZxEdGd+FT7lf4zazkrqOmcUt14F1uGhzHSFhq24+EjsrMfu+qa5Y6U
         09SKwPYLf2YCC06MIDuPP/zKosjyw+PfNZKBtdo4Su14V5JdyicH+StfOMQO1YsKIGyo
         FfhPYctaup9Q8jWyioRrL5giKa1i0VObJb1eN/QAfpIDdXSiyYw6tWO8vASM1lF5cdun
         8rfMwZLTqVjjsZa8nGqHqqQtWeLYLknEnpqvblH8LclEw9LAAM8yljzHfacGu+OnY7SU
         KCtdpWb6L8oDgmToiJ9NmnLlAlIZmaKnYN4uay04lV5+P60JIxVvi3fHzYrHbB/YRnP8
         qeNw==
X-Gm-Message-State: ABuFfoh/2NGBYD/HbB+ZLWLkBk9TY1srmMy/OSPGfbQkhmCt0fbEeTb5
        w2uTvDgkpKnyPq7UD7OA8vQ=
X-Google-Smtp-Source: ACcGV62V+Z/i23KoX/boH66bQ22NHW0YTkIXMMB56bKd0VCCYItd8Vf4NTI9F0jzlU/gl5gDIcffww==
X-Received: by 2002:a1c:9355:: with SMTP id v82-v6mr15180023wmd.128.1539670715488;
        Mon, 15 Oct 2018 23:18:35 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id v1-v6sm9950497wrd.24.2018.10.15.23.18.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Oct 2018 23:18:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     steadmon@google.com
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/2] add fuzzing targets for use with OSS-Fuzz
References: <cover.1538693039.git.steadmon@google.com>
        <cover.1539391439.git.steadmon@google.com>
Date:   Tue, 16 Oct 2018 15:18:32 +0900
In-Reply-To: <cover.1539391439.git.steadmon@google.com> (steadmon's message of
        "Fri, 12 Oct 2018 17:58:39 -0700")
Message-ID: <xmqqbm7uza6f.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

steadmon@google.com writes:

> From: Josh Steadmon <steadmon@google.com>
>
> V2 of this series pulls the compiler flags out of the Makefile, to be
> provided by the user depending on the combination of compiler and
> fuzzing engine in use. This also makes it more compatible with
> OSS-Fuzz's build process.

Thanks, will replace.  I think we can merge this to 'next' and down
and build incrementally on top.
