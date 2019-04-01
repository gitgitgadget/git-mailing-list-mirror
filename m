Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43ECE20248
	for <e@80x24.org>; Mon,  1 Apr 2019 09:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDAJH1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Apr 2019 05:07:27 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35272 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfDAJH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Apr 2019 05:07:26 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so10404881wmd.0
        for <git@vger.kernel.org>; Mon, 01 Apr 2019 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=08iEzdtKvc3/gS238+s1q74ShMKj/fywFXoKraegK0c=;
        b=OO/tcwyyv+rORgAJ9C3VcftqD5A9TDbBtO7Zz6j7ZXDY7kGsQsvUSlPLVTvGquqgXP
         8k9+79WfN78lopwdjKEQduuc64PVcRiPC1UjBkXlDtDO6X0nLIiW60A/s03S19fU+104
         3BRcPb16DiN0+8u2qWx86FPB75DAlWFsLf0mEx7e2nXCX8LNIEAaMFCR0VhUG8CqhkkZ
         BvCy2RqprKuOcxZh+U4krkhRWXA559I+/GaKLkytlYP8UfqHH9mlj3KIdXXcZp2Fx083
         pcLJI2NlHU3j6sSTP+EF7Sta/svMFH3sSmEA/9h0gGeoQWjKwP6wIuSce8Cd6wfLMj/V
         ENjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=08iEzdtKvc3/gS238+s1q74ShMKj/fywFXoKraegK0c=;
        b=P247v0jHTvFvsTGDpN+sp8pL34Ymjip+WPwprhxtYprLknGFFF2GtPr4oxJzjTvRbB
         b297duaIyGSB/fh/iAeF8a7RehDYuvFh8vQlfmWUe0JNyPph3d96DI2I1qcGYvKe2G8J
         H5U88f2hY93ANygu8ngixg6HLiV7pVFhon2lQ5YGV9KewEm9FBn1JJMX36HGaMDOX5Xj
         7GTSI42sV0OHAKIQCRWmQpih07cCADt8u1xBVEpASL1/h4ztQh9Rse5Tfr64qFYcJnuU
         O2kH2yKiHyJuf1uSAIChGKs39RANzMyxkQsUJUnEtba+tLdy8l9nu+oHryig3Z8jZg03
         cWYQ==
X-Gm-Message-State: APjAAAUyerM1BYY9GftXtbBIvDD7DlhFOEtEvbFN6oPvUrLnVcnI6Zx0
        4x3V9WRH+U8odedPuUDtb9Sxc9EGj4o=
X-Google-Smtp-Source: APXvYqy41S8ExxOFQOnZk5ad4cdQWXyVosUvwZxL57CW6C7sbziDBpXYKlAxzoi0YCKrSU/fCczKog==
X-Received: by 2002:a05:600c:220b:: with SMTP id z11mr11718844wml.73.1554109644023;
        Mon, 01 Apr 2019 02:07:24 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id t24sm10826651wmi.10.2019.04.01.02.07.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 01 Apr 2019 02:07:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] mailinfo: support Unicode scissors
References: <20190331220104.31628-1-rybak.a.v@gmail.com>
        <20190331230947.GI32732@szeder.dev>
Date:   Mon, 01 Apr 2019 18:07:22 +0900
In-Reply-To: <20190331230947.GI32732@szeder.dev> ("SZEDER =?utf-8?Q?G?=
 =?utf-8?Q?=C3=A1bor=22's?= message of
        "Mon, 1 Apr 2019 01:09:47 +0200")
Message-ID: <xmqqimvyxfed.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER Gábor <szeder.dev@gmail.com> writes:

> On Mon, Apr 01, 2019 at 12:01:04AM +0200, Andrei Rybak wrote:
>> diff --git a/mailinfo.c b/mailinfo.c
>> index b395adbdf2..4ef6cdee85 100644
>> --- a/mailinfo.c
>> +++ b/mailinfo.c
>> @@ -701,6 +701,13 @@ static int is_scissors_line(const char *line)
>>  			c++;
>>  			continue;
>>  		}
>> +		if (!memcmp(c, "✂", 3)) {
>
> This character is tiny.  Please add a comment that it's supposed to be
> a Unicode scissors character.
>
> Should we worry about this memcmp() potentially reading past the end
> of the string when 'c' points to the last character?

Quite honestly, I'd rather document what "scissors" line looks like
exactly and make sure no readers would mistake that we'd accept any
Unicode character whose name has substring "scissors" in it.

Ah, wait, we already do.  It is very clear that scissors are either
">8" (for right handers) or "8<" (for lefties) and nothing else.

Unless you are sure that you are (and more importantly, can stay to
be) exhaustive, adding allowed representations for a thing will
force users to learn more non-essential things ("we allow only 8<
and >8" vs "we allow only these 7, even though we are aware that
there are at least 14 more that we do not allow"---the end-user
needs to remember which 7 are allowed) and does not help users.

Taking only "black scissors" U+2702 but not all of U+2700 - U+2704
will be a cause for unnecessary end-user complaints "why do you take
this but not that one?"  Then the next noise would be "why is '-'
the only perforation and not U+2014 Em Dash or U+2013 En Dash?"

Let's try not to be cute in non-essential things like how a pair of
scissors ought to be spelled.  If "8<" had worked well for us for
the past 10 years, we should just stick to it.




