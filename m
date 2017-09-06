Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50FDD1F4DD
	for <e@80x24.org>; Wed,  6 Sep 2017 22:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753116AbdIFWLZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Sep 2017 18:11:25 -0400
Received: from mail-yw0-f181.google.com ([209.85.161.181]:33105 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbdIFWLY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Sep 2017 18:11:24 -0400
Received: by mail-yw0-f181.google.com with SMTP id s62so10334380ywg.0
        for <git@vger.kernel.org>; Wed, 06 Sep 2017 15:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ixz+0qQSKAIfirLraECnUh/4nJsKiGrwRVy6YwV0aeE=;
        b=mgxjFV22ZEJG57qIfTbbM6KQGrW2HQaf/tq4tZgoBD45oyV6QxuVTibZcZz7VYhjnX
         kSN1NHZzXM3TN2KN9NLMzOJRcOWNjb7Xc1Qubgpoj+Zc3fx/O158juGxlp5m0lW0/a5W
         8Y6CvlxnHbKpFLdqLegKX7Nnbf5vWhK1YjL26lT4f/BD359lvs1VaZO+U/R6zjkFfTHs
         rM+OB+gLNYhjkSc+EpW3KjCAIKMYo5ex/7MVZDNp05GyOO11QNOMnD0alROS19kCSHoj
         7PWLkft3bn7nfhE6Ra1x3e6VIYf8m9Jn4LcZJRRQOdUcwRmcskS6r4w443UR7EsjqC8E
         q0/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ixz+0qQSKAIfirLraECnUh/4nJsKiGrwRVy6YwV0aeE=;
        b=cRybGgCM11JTyvca+1YZbTBzJuskdy+FB+CWtjzvKPcFFZduTJ+enqtCV2f/hwGKu8
         asl7ROOEbx94UubIm8hw4jw8N8ZIhuZ/H+EP3fH9XsVxZ4W369ksztkNKmyXJk2/OQWx
         apUnjtm5FKBLlITPGx+wv5B5axVafQid9hNH/vWKpBEzEAougvI8ql0dPCAhUszPgzk5
         nkzzZnkBY16vzvsigOl2s5xtEYCmJsfGuG1lS1UuR7BJD93URZTDxgJyWhBQ92fNe3WJ
         he5Jj/kYO3Pa+1vvdEFWGqQUKlO7p4jaTmNJ/fUkqB05oaiSlVkGvT/Pn4GFT7Cbd80b
         lzsQ==
X-Gm-Message-State: AHPjjUjI93yDpr4wC8QFd7D4N+oRQmQ+dS1WHrlS32O8wN8B6Rm4vQXe
        FrLigZmdPTEGW7YlPpHee3XR+bGslf8PjB6Djg==
X-Google-Smtp-Source: ADKCNb67mezoqs3/yVd8dUSl8euhAmhBd1yAcASpYoHkEmuOdwa4fDP74v7CcLS1Qd3FYI0wUV82fIXYtUgjbLklDsQ=
X-Received: by 10.129.146.66 with SMTP id j63mr495752ywg.137.1504735883588;
 Wed, 06 Sep 2017 15:11:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.116.7 with HTTP; Wed, 6 Sep 2017 15:11:23 -0700 (PDT)
In-Reply-To: <xmqq4lsga8s7.fsf@gitster.mtv.corp.google.com>
References: <xmqqd174bzco.fsf@gitster.mtv.corp.google.com> <20170905232953.22330-1-sbeller@google.com>
 <xmqq4lsga8s7.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 6 Sep 2017 15:11:23 -0700
Message-ID: <CAGZ79kauB+AznEOwmNBQLbuz-szD3kYBHAJDmy0OWWEbxny9xQ@mail.gmail.com>
Subject: Re: [PATCHv2] builtin/merge: honor commit-msg hook for merges
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 5, 2017 at 6:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> Junio writes:
>>> I didn't check how "merge --continue" is implemented, but we need to
>>> behave exactly the same way over there, too.  Making sure that it is
>>> a case in t7504 may be a good idea, in addition to the test you
>>> added.
>>
>> After inspection of the code I do not think it is a good idea, because
>> (a) it clutters the test suite with something "obvious" for now,
>>     the call to cmd_commit will be the same as git-commit on the
>>     command line and
>> (b) piping through --[no-]verify would either introduce irregularities
>>     ("Why do we pipe through --no-verify, when --sign-off is more important?")
>>     or miss important options to pipe through:
>>
>>       static int continue_current_merge;
>> ...
>>       OPT_BOOL(0, "continue", &continue_current_merge,
>>               N_("continue the current in-progress merge")),
>> ...
>>       if (continue_current_merge) {
>>               int nargc = 1;
>>               const char *nargv[] = {"commit", NULL};
>>
>>               if (orig_argc != 2)
>>                       usage_msg_opt(_("--continue expects no arguments"),
>>                             builtin_merge_usage, builtin_merge_options);
>>
>>               /* Invoke 'git commit' */
>>               ret = cmd_commit(nargc, nargv, prefix);
>>               goto done;
>>       }
>
> That line of thought is backwards.  'something "obvious" for now'
> talks about the present.  tests are all about future-proofing.

I agree, but I did not think a call to cmd_commit would need to
be future-proofed as we already test git-commit, and these
are equal....

>
> I also thought that we were hunting calls of cmd_foo() from outside
> the git.c command dispatcher as grave errors and want to clean up
> the codebase to get rid of them.

... but I did not account for this fact. (I was not aware of these being
called grave errors, but assumed this is a good state. And why change
a good state?)

> So the above is the worst example
> to use when you are trying to convince why it needs no test---the
> above is a good example of the code that would need to change soon
> when we have enough volunteers willing to keep the codebase clean
> and healthy, and we would benefit from future-proofing tests.

Given that new fact, I agree with the reasoning to add a new test
for future proofing. In the current form

    git merge --continue --no-verify

would trigger to usage_msg_opt(..), so all I'd offer is a test_must_fail
for now?
