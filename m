Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D3B71FAF4
	for <e@80x24.org>; Mon, 13 Feb 2017 08:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752421AbdBMIaq (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 03:30:46 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35259 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752407AbdBMIap (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 03:30:45 -0500
Received: by mail-pg0-f66.google.com with SMTP id 204so9282649pge.2
        for <git@vger.kernel.org>; Mon, 13 Feb 2017 00:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=WGe0H5/s+epUHrkgtm1X4ysn0CrDg+9BT+ZVA66uHAU=;
        b=BDJlUJqhfmwXr+N5fgpuR6VvoIFaBvfJ7e0pvYiSZoLYvtvlXfPsLKB/MZM8lXZhxz
         pBKhd5Zd0r2Kt0cQ2d72Z7JIBCBSicd7T8elspuL9ZPOuWxhDs+zuMaP9Xe7bPDBtxFg
         sC9FyCzOYxzh5umdV3b/8DLfhyY6YdSZ/DuypW1A9WQn7HgyLGr9KjB60TXcsW3N5CJO
         oO3KMG4rVYpAGJEQ2tov7e3wzQjuDr2iFTWxeWzh9pjMvneMcytNAEVB/pgQBivLJsPU
         7jFtG1yWRPLljSDeEBuErNKcjrKBWlXR+u7IkaauATIWpwSiXIikeAAbOY/5JAtg0XjH
         kfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=WGe0H5/s+epUHrkgtm1X4ysn0CrDg+9BT+ZVA66uHAU=;
        b=XvZoi4npyo+lcl875cb0UhjJfAb3grRjZy3uACocgALw0UAd8RP5VGwAM91fifHDrq
         SRQfeba7bK+iYJYY7nXCbUb7jfnqKQ6AfIhbrQba6Fnm7qvGyGPnmC5Iea6ou7FizPF2
         EEzw1SeIrnBfrYPJQOF17LblFkErlamhkMxx/oKYRZvCS1OLThzx79NQvFBT9wafMOlY
         xvnMbgOp9XTNr54K1YpnXaRAYSkyFW4cKgJwEvlDKhVVZod1j7SpcFki+Ia4WPbG+GLo
         nbUR4HdKKsKTqf1+ErQAclnffLc7D2MO2UVDY67cqsLnSUP0DTFVdJfTsA0mwh32k4DJ
         c3FA==
X-Gm-Message-State: AMke39l6fMvJ80hzM8H4zYPFzLR3/j65sgeuC3jn0VtU6jjrM9kX8k6xP6mczXQPowAB4A==
X-Received: by 10.98.196.1 with SMTP id y1mr24929309pff.105.1486974644297;
        Mon, 13 Feb 2017 00:30:44 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:644a:2999:a3b7:74ee])
        by smtp.gmail.com with ESMTPSA id l188sm19173382pfl.28.2017.02.13.00.30.41
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 13 Feb 2017 00:30:42 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [RFC PATCH] show decorations at the end of the line
References: <alpine.LFD.2.20.1702110943460.31350@i7.lan>
        <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
Date:   Mon, 13 Feb 2017 00:30:41 -0800
In-Reply-To: <CA+55aFw2S14a4_4YK0b6PNK4TH_AUo_+2JN+PTyBTufNeB5t6A@mail.gmail.com>
        (Linus Torvalds's message of "Sat, 11 Feb 2017 10:13:44 -0800")
Message-ID: <xmqq1sv2fq6m.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Feb 11, 2017 at 10:02 AM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> I've signed off on this, because I think it's an "obvious" improvement,
>> but I'm putting the "RFC" in the subject line because this is clearly a
>> subjective thing.
>
> Side note: the one downside of showing the decorations at the end of
> the line is that now they are obviously at the end of the line - and
> thus likely to be more hidden by things like line truncation.

Side note: I refrained from commenting on this patch because
everybody knows that the what I would say anyway ;-) and I didn't
want to speak first to discourage others from raising their opinion.

An obvious downside is that people (against all recommendations) are
likely to have written a loose script expecting the --oneline format
is cast in stone.  I personally think it is OK to break them as long
as "workaround" (aka kosher way to do what they have been doing) is
obvious and easily doable, and in this case their script can switch
to use --format to keep using the order of fields and format they
have been relying on.

It would be nice if we can have that --format string they can use
somewhere in the log message, so that I can cut & paste it into the
release notes that contains this change (i.e. "those who want to
keep using the traditional --oneline --decorate can use this string
as pretty.my1line configuration variable and use --pretty=my1line
instead").
