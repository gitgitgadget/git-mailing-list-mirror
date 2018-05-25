Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 922F51F51C
	for <e@80x24.org>; Fri, 25 May 2018 09:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965287AbeEYJGA (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 05:06:00 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:52234 "EHLO
        alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965197AbeEYJF6 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 May 2018 05:05:58 -0400
X-AuditID: 12074413-b83ff70000006608-41-5b07d1f41ebc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
        (using TLS with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 81.B9.26120.4F1D70B5; Fri, 25 May 2018 05:05:56 -0400 (EDT)
Received: from mail-wr0-f172.google.com (mail-wr0-f172.google.com [209.85.128.172])
        (authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
        by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id w4P95tiI021551
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT)
        for <git@vger.kernel.org>; Fri, 25 May 2018 05:05:56 -0400
Received: by mail-wr0-f172.google.com with SMTP id l41-v6so7914122wre.7
        for <git@vger.kernel.org>; Fri, 25 May 2018 02:05:56 -0700 (PDT)
X-Gm-Message-State: ALKqPwe9sHdG3YABb/77eA/boD7NHVZspBwt0uL/LxLCTWBbK0o5vTK1
        7na6o1jHCsfYtksFXDxxp1JZqsoy0NhdaqdZ00U=
X-Google-Smtp-Source: ADUXVKJlpq1RanJD45kBPKOWEuG+2mKBCwlKesBidr6G7d7hlEzaJwjHqQbW1TIb6bbEwlL3AMlA7/9QMjFMYAU1TLk=
X-Received: by 2002:a19:964b:: with SMTP id y72-v6mr933727lfd.96.1527239155201;
 Fri, 25 May 2018 02:05:55 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mhagger@alum.mit.edu
Received: by 2002:a2e:3a1a:0:0:0:0:0 with HTTP; Fri, 25 May 2018 02:05:54
 -0700 (PDT)
In-Reply-To: <20180525085906.GA2948@sigill.intra.peff.net>
References: <20180523052517.4443-1-chriscool@tuxfamily.org>
 <615f57ad-7591-128a-0c42-660312d34ca2@alum.mit.edu> <20180525085906.GA2948@sigill.intra.peff.net>
From:   Michael Haggerty <mhagger@alum.mit.edu>
Date:   Fri, 25 May 2018 11:05:54 +0200
X-Gmail-Original-Message-ID: <CAMy9T_E_wO-XKn-BoVpnoUn8cGsmE4z11AzbqW+7Ppo=P9zcDg@mail.gmail.com>
Message-ID: <CAMy9T_E_wO-XKn-BoVpnoUn8cGsmE4z11AzbqW+7Ppo=P9zcDg@mail.gmail.com>
Subject: Re: [PATCH v2] t: make many tests depend less on the refs being files
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Carlos_Mart=C3=ADn_Nieto?= <cmn@dwim.me>,
        David Turner <novalis@novalis.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        David Turner <dturner@twopensource.com>
Content-Type: text/plain; charset="UTF-8"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAKsWRmVeSWpSXmKPExsUixO6iqPv1Inu0wa4lPBZdV7qZHBg9Pm+S
        C2CM4rJJSc3JLEst0rdL4Mp4vGwrU8EyzoplE26wNjBuYO9i5OSQEDCReLbvCmsXIxeHkMAO
        JolbT/oZIZynTBIL1t9gg3AmMkqs+XOTDaKlXOLe/idMEHaRxI7Lv1lg4ndvgYzi5OAVEJQ4
        OfMJWFxIQE7i1YYbjBB2uMSRBRvBejkFrCRubL0HtWA+o8SUNz1gCTYBXYlFPc1gNouAqsTP
        S1ugliVK9DTdBhrKAbQgQOL/rQSQsLCAn8S+U0eZQWwRAVmJ74c3gn3ALNDEJnFhTxtYgllA
        U6J1+2/2CYwis5DcNwtJagEj0ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXXO93MwSvdSU0k2M
        kAAX3sG466TcIUYBDkYlHl6Ow2zRQqyJZcWVuYcYJTmYlER5Ty5ljxbiS8pPqcxILM6ILyrN
        SS0+xCjBwawkwjs5GCjHm5JYWZValA+TkuZgURLnZTbZGyUkkJ5YkpqdmlqQWgSTleHgUJLg
        DQNGspBgUWp6akVaZk4JQpqJgxNkOA/QcC2QGt7igsTc4sx0iPwpRkuOJU+7e5g57rT1AMkF
        Wyb1MAux5OXnpUqJ87qBNAiANGSU5sHNhCWsV4ziQC8K8xaCVPEAkx3c1FdAC5mAFq5bDbaw
        JBEhJdXAKHW5X+dXNuer9Qall05f/PT24nLrL/9M/j/0luXJDLcOnHxi/1Wvh8ZfDsTqb7S4
        9sI1YEILS+iuN0q1Lq2cRZfuddl1ee9xfNJxYffvsO7Ym9NjK34rHNq6WX99zKdN27yU67NM
        sl7u+5p095RI+YZcR6ubJ/lE9Hry+tewJISe0WZYkGm/TImlOCPRUIu5qDgRABN2UpEzAwAA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 25, 2018 at 10:59 AM, Jeff King <peff@peff.net> wrote:
> On Fri, May 25, 2018 at 10:48:04AM +0200, Michael Haggerty wrote:
>
>> >  test_expect_success "multi-fetch works off a 'clean' repository" '
>> > -   rm -r "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" "$GIT_DIR/logs" &&
>> > +   rm -rf "$GIT_DIR/svn" "$GIT_DIR/refs/remotes" &&
>> > +   git reflog expire --all --expire=all &&
>> >     mkdir "$GIT_DIR/svn" &&
>> >     git svn multi-fetch
>> >     '
>> >
>>
>> `rm -rf "$GIT_DIR/refs/remotes"` is not kosher. I think it can be written
>>
>>     printf 'option no-deref\ndelete %s\n' $(git for-each-ref
>> --format='%(refname)' refs/remotes) | git update-ref --stdin
>>
>> as long as the number of references doesn't exceed command-line limits.
>> This will also take care of the reflogs. Another alternative would be to
>> write it as a loop.
>
> Perhaps:
>
>   git for-each-ref --format="option no-deref%0adelete %(refname)" refs/remotes |
>   git update-ref --stdin

Ah yes, that's nicer. I tried with `\n`, but that's not supported
(wouldn't it be nice if it were?). I didn't think to try `%0a` (let
alone look in the documentation!)

Michael
