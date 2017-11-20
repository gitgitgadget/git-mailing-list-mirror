Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 095F2202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751159AbdKTWex (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:34:53 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36586 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751149AbdKTWex (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 17:34:53 -0500
Received: by mail-qk0-f174.google.com with SMTP id o6so9528161qkh.3
        for <git@vger.kernel.org>; Mon, 20 Nov 2017 14:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=6nc/Kn/ROHV4rKkzc77lpC6ll9vhz6n9qdkzk7XoG2Y=;
        b=bEUqKTqYTpxqGQsNDJIcYK3kx9jkCGA5cCQ+5dWvGJnMa+qoUDowrHP+UEuqJqinAF
         XLYkJLsh/9h8CTYo8zi4ggIub5cKCUqIwPkKH0bJxsgEMTk2V2QJH9t685Z3LFpnOmhQ
         hOKm2PW6ejhqAed7aH17+zoZBszf6isekSFjRlbIJBcqryHmrk/k/X35oYeHespYJu+q
         ewh0tMVK4UPOC5FiTuOUU4dJDpJz3BEhJzhg9dWE1+4dfSfbdUKv6D9GIwXJoIcq9bzp
         Ozup9UkQ46pmzeJfrqeoTeLOQrc5+08JO0VvArO13aPMla0E/XT24SvGu2kJtSSFGa5z
         DYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=6nc/Kn/ROHV4rKkzc77lpC6ll9vhz6n9qdkzk7XoG2Y=;
        b=EHkjhGa9SrYy6LQDHxQzBelEWMWKeY+8X31r8vCNL0yI+Tl71LH0iaQPbScxPLs2qE
         wHU8lh0yIV3G6D0nu6SJTzv3sAvVKYbKaL4PXpdTb59/2u9CMLfdvCFusW4UsqFxvbqe
         pwp3a9ZloW/pHOmSmRGz3pH4ZnjoALb7amvFTa/kGqRexS/KWdveSdzKFc3mNWv4dC81
         WdOv7W14r8Z+XUC6LWSDrN7mOC8D5cBiHEN5Uy5jrRo1eHaAKhtQp8UQCSgBxeU2hw7E
         07ZShf7AO9px67sYxTty28zhU15khOOlFVOGTGRvIRPTp3f6IHhfP6do0MB+lGFHsFGG
         oyTQ==
X-Gm-Message-State: AJaThX6xl9HmcD4kA5R5eEIKbgaUCHOG6dUUgf1Lo780Hjk2Ls1+vXJC
        xDad4xe0HBmFKazE/bLeAzrJxfT2bP+d1wOl1yU=
X-Google-Smtp-Source: AGs4zMZ+NHWvzCdyutoShm3Hn7CEcYnb/04PlIXnAv0tYaY/ijoLQPM2tuBAbsqxIi1lKhI+Y6ZUktZA9Bhl45QE2Dw=
X-Received: by 10.55.58.14 with SMTP id h14mr21708971qka.132.1511217290583;
 Mon, 20 Nov 2017 14:34:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.155.209 with HTTP; Mon, 20 Nov 2017 14:34:50 -0800 (PST)
In-Reply-To: <87a7zhxm9s.fsf@linaro.org>
References: <20171116154814.23785-1-alex.bennee@linaro.org>
 <CAPig+cSh0tVVkh0xF9FwCfM4gngAWMSN_FXd2zhzHcy2trYXfw@mail.gmail.com> <87a7zhxm9s.fsf@linaro.org>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 20 Nov 2017 17:34:50 -0500
X-Google-Sender-Auth: zwKMacieTTt0ZLk631FHjok9lEc
Message-ID: <CAPig+cQQHMt9757aoBAQfyMtnxmDmrVJ_g8AmzvmmqTMAYaUXw@mail.gmail.com>
Subject: Re: [PATCH] git-send-email: fix get_maintainer.pl regression
To:     =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 5:44 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>> It is not at all clear, based upon this text, what this is fixing.
>> When you re-roll, please provide a description of the regression in
>> sufficient detail for readers to easily understand the problem and the
>> solution.
>
> How about:
>
> Since the removal of Mail::Address from git-send-email certain addresses
> common in MAINTAINERS now fail to get correctly parsed by
> Git::parse_mailboxes. Specifically the patterns with embedded
> parenthesis fail, for example for MAINTAINERS:
> [...snip...]

Thanks, that explanation makes the problem quite clear. It also
allowed me to examine the fix with a more critical eye, which led to
several additional comments and observations (sent in my previous
email).

>> Use write_script() to create the script:
>
> Thanks for the pointers, I'll fix it up.
>
> I missed the existence of write_script.sh while I scanned through
> t/README, perhaps a stanza in in "Test harness library":
>
>  - write_script <name> <<-\EOF && <rest of test>
>    echo '...'
>    ...
>    EOF
>
>    The write_script helper takes care of ensuring the created helper
>    script has the right shebang and is executable.
> ?

Mentioning write_script() in the "Test harness library" section might
indeed be a good idea.

> Ahh that makes sense. Again perhaps in the t/README "Keep in mind:"
>
>  - All the tests in a given test file run sequentially and share
>    repository state. This means you should take care not to break
>    assumptions of later tests as to which commits exist in the test
>    repository.
> ?

Maybe, maybe not. Ideally, tests should be as self-contained as
possible. In practice, of course, this isn't always practical or even
possible (and there is a lot of old test code which is heavily
dependent upon state left over from earlier tests). Perfectly
self-contained tests (or self-contained _sets_ of tests) could
theoretically be run in parallel, so, in general, we'd like to
encourage people to tend toward self-contained, thus the above snippet
may be going in the wrong direction.
