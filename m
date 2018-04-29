Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A0B1F428
	for <e@80x24.org>; Sun, 29 Apr 2018 23:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754520AbeD2X4S (ORCPT <rfc822;e@80x24.org>);
        Sun, 29 Apr 2018 19:56:18 -0400
Received: from mail-wm0-f44.google.com ([74.125.82.44]:35594 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754382AbeD2X4R (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Apr 2018 19:56:17 -0400
Received: by mail-wm0-f44.google.com with SMTP id o78so11595599wmg.0
        for <git@vger.kernel.org>; Sun, 29 Apr 2018 16:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=q6YnA6f/C831cWMPj6qxzoTVTWYn8pvqvn3j6+/GccQ=;
        b=J+cLpGHNCKpDvRnc6qC26LAnRdcr8Ngj8zvy6UigCxU9tCaqY9GPIBdDSp8OtZztwB
         RYvzIZImgxgfUJh4fmc66MOvs5BIAf6xpEUvBJneMsZpL64WA5OnK5Y98nykTFBJ3lgO
         yjgc7B9Ky3L6JYBFyL4EXp8KMP/FVt/ThOXxiJYmoBvZViaDmcVvn/UfXRjNRpky8QXF
         VW6UKhV+X/2dScj99Z54OBOYAM463oHrRw/C+3yZcAF2umTgVXXljN/aMER1J0Uy+gfn
         5QZPJswlfXZTB1jwn5r0ytzIc7VeuF4ML2uH3mhTmqWnUpetg9KoWK4MvI9uabd1Hq0T
         3uXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=q6YnA6f/C831cWMPj6qxzoTVTWYn8pvqvn3j6+/GccQ=;
        b=CGpG8uTNtSN9KSFfDWRtlY/UzRQ0mPMUKAqXoe79ml732lhbTP4NmrjbwGqYqAyJzW
         N+shThJb+DAw1f6w4MKD/JTlF6Zw7n3qBAxufwfWVWY2pmFA1V2HV9P9Hp/AFSqT+UAg
         84n0ooeMGHLuNd7pU1mCUjz7JrpMoKna2Xrb8F1j8QUoh1H9NlLqvKqT9mymXsL/gV/6
         Yr47wGBK4ZbCZ/B6DTfTvOCWtgqHQWGUwf8SsStS/U/F7Cj46ZTHq5gIxmWa3Z+yzdMP
         yj73lKWQdUNU794rVEo05TPQycWAm6ndZujrLTWfziWikVAntfSKYuMi80B6N9DV6bLK
         O5Ig==
X-Gm-Message-State: ALQs6tA6DKQtBbtNaiWVOeAX7xZ+faYI3M0iPg+vzQS73Y2U6gU/d9B3
        4nrxL/Kmm4LoTRwiGq9YLl8=
X-Google-Smtp-Source: AB8JxZpIkRoQr+oXOvHlXtSbp6hMIAu09X03nFFMqOipsbeSFe8TV1I4nPVFg22rRMoi3DnOwe3MKg==
X-Received: by 10.28.178.69 with SMTP id b66mr5773149wmf.31.1525046176408;
        Sun, 29 Apr 2018 16:56:16 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id a69sm6041909wma.7.2018.04.29.16.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 29 Apr 2018 16:56:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        Marc Branchaud <marcnarc@xiplink.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
References: <20180413170129.15310-1-mgorny@gentoo.org>
        <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
        <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
        <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
        <xmqqin8f4qoq.fsf@gitster-ct.c.googlers.com>
        <ad4d0d66-58f4-5cab-d314-a30a50e8ad32@xiplink.com>
        <CACsJy8ATwEPiCDpOr7e=wJxhZAr1R4OpSdOvb6EgpnyYonQYWg@mail.gmail.com>
        <robbat2-20180426T165501-471483273Z@orbis-terrarum.net>
        <20180426184411.GA6844@duynguyen.home>
Date:   Mon, 30 Apr 2018 08:56:15 +0900
In-Reply-To: <20180426184411.GA6844@duynguyen.home> (Duy Nguyen's message of
        "Thu, 26 Apr 2018 20:44:11 +0200")
Message-ID: <xmqqpo2hzhwg.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Target revision should be available in the index. But this gives me an
> idea to another thing that bugs me: sending the list to the hook means
> I have to deal with separator (\n or NUL?) or escaping. This mentions
> of index makes me take a different direction. I could produce a small
> index that contains just what is modified, then you can retrieve
> whatever info you want with `git ls-files` or even `git show` after
> pointing $GIT_INDEX_FILE to it.

That's somewhere in between a tail wagging the dog and a hammer
looking like a solution even when you have a screw.  By passing a
temporary index, you may be able to claim that you are feeding the
necessary information without corruption and in a readable and
native format of Git, and make it up to the reader to grab the paths
out of it, but

 (1) the contents, and probably the cached stat information, in that
     temporary index is duplicated and wasted; you know from the
     time you design this thing that all you want to convey is a
     list of paths.

 (2) it is totally unclear who is responsible for cleaning the
     temporary file up.

 (3) the recipient must walk and carefully grab the path, certainly
     has to "deal with separator (\n or NUL?) or escaping" anyway,
     especially if the reason you use a temporary index is because
     "they can use ls-files on it".  They need to read from ls-files
     anyway, so that is no better than feeding ls-files compatible
     input from the standard input of the hook script.

no?
