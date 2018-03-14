Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 389911F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751394AbeCNSWs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:22:48 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46301 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCNSWq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:22:46 -0400
Received: by mail-qt0-f195.google.com with SMTP id m13so4450070qtg.13
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=mv6YwBfIt5rTw+1yKu720DbOr8PsSooKsHwXL7nTgjY=;
        b=tlu9ltdk7ubOIWDHq9/QbOnym+zO4torXkiKlU/mY7KVWn1rv6nAWVHdk11oe8SV/H
         kh/U1yYREV4Te3YS52CrBDZ/tnJ8a9DoT1Lg3v5vQZIpjqbtTmIUOxYj75yzn7as1G7S
         diwdKzu5nJEgmtZuv7+/2ZN+SIVK4smdv3I4WMMianwSQtNW4/4izONd7t7dCmKhMjoU
         L58hDsXvMZi7ftBmhxIqmT4SJb1cF2C3HrAvd2DzgrvnUvyI09nSnC5cheFNRCFUZm0v
         IV8V/DqQHYVgdMTCpxwKPUjxTSAeekhQfkNVtV9EfR+a6um29gfhimGsdS5qh4Us5jCi
         7iQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=mv6YwBfIt5rTw+1yKu720DbOr8PsSooKsHwXL7nTgjY=;
        b=MhrS5IovXjxR4UnFCySjufxcXmj7ze6k1jdCYfKO3xCQ4Z50QbgaxaPG9krF004CvE
         Lkl+zyhD0ytSn8PH6v98THOok17+mK4Uutetjrr2cSYe7COhFyyMN1IraDRnG6dqYld9
         qBaB0ElT7ZolWtiz1Fk3LVPhJUkZIkSiAqEZGizXuijNCtW+h4i9M8JcoKq1uXy1xU0T
         ZcoAe+7BCO65whr3+ea2GnxGVb2R3uxxmDNVcAVkwoI527khTIwuZkGAErnn0Avfrykm
         tgRwmUf6q22C9RqxgcYCrg5UsI0rZn2k+Vd8DStnWY9PhDTV9cuLTgnU41OQWYEnuNAC
         ndkA==
X-Gm-Message-State: AElRT7FpWDDFJrB1Qr+iLr7vra76Ng/LgYLote2nOUXTE03Gafe43k1A
        oEuJdoxL2+bGnpf1GawyKF3735vqujcyb293AAY=
X-Google-Smtp-Source: AG47ELu2AbhQKZvxlIAxvsJawIiAty0tpaualzCBiY5qxBmIDWhIQQhIEXwP/CZv81WFETQOSSbkzrojpOfiyox0NU8=
X-Received: by 10.200.50.174 with SMTP id z43mr8254040qta.250.1521051765997;
 Wed, 14 Mar 2018 11:22:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.190.196 with HTTP; Wed, 14 Mar 2018 11:22:45 -0700 (PDT)
In-Reply-To: <87zi3bdlo2.fsf@evledraar.gmail.com>
References: <20180313201945.8409-1-predatoramigo@gmail.com>
 <CAPig+cRPzyw525ODC4=-E7w=zbpbhVN2eqxSYDSLij5wfW8S_A@mail.gmail.com> <87zi3bdlo2.fsf@evledraar.gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 14 Mar 2018 14:22:45 -0400
X-Google-Sender-Auth: V9QuW3q8IiNjev0Kab6QaFPOZnY
Message-ID: <CAPig+cTLCswg_=q5ybnyN3As4Au05q5eAcA7Prr643KCgZ0OAw@mail.gmail.com>
Subject: Re: [GSoC] [PATCH] test: avoid pipes in git related commands for test suite
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Pratik Karki <predatoramigo@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 14, 2018 at 5:57 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
> On Wed, Mar 14 2018, Eric Sunshine jotted:
>> On Tue, Mar 13, 2018 at 4:19 PM, Pratik Karki <predatoramigo@gmail.com> =
wrote:
>>> -    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
>>> -     grep "^R100..*path0/COPYING..*path2/COPYING" &&
>>> -     git diff-tree -r -M --name-status  HEAD^ HEAD | \
>>> -     grep "^R100..*path0/README..*path2/README"'
>>> +    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
>>> +     grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
>>> +     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
>>> +     grep "^R100..*path0/README..*path2/README" actual'
>>
>> Although this "mechanical" transformation is technically correct, it
>> is nevertheless wasteful. The exact same "git diff-tree ..." command
>> is run twice, and both times output is captured to file 'actual',
>> which makes the second invocation superfluous. Instead, a better
>> transformation would be:
>>
>>     git diff-tree ... >actual &&
>>     grep ... actual &&
>>     grep ... actual
>>
> I think we have to be careful to not be overly picky with rejecting
> mechanical transformations that fix bugs on the basis that while we're
> at it the test could also be rewritten.
>
> I.e. this bug was there before, maybe we should purely focus on just
> replacing the harmful pipe pattern that hides errors in this series and
> leave rewriting the actual test logic for a later patch.

Thanks for presenting an opposing opinion. While I understand your
position, the reason for my suggested transformation is that if the
patch already transformed the code in the way suggested, it would
increase my confidence, as a reviewer, that the patch author had
_studied_ and _understood_ the code. Increased confidence is
especially important for mechanical transformations since -- as seen
in the unsnipped review comment below -- blindly-applied mechanical
transformations can be suboptimal or outright incorrect.

It's also the sort of review comment I would make even to very
seasoned project participants[1].

[1]: https://public-inbox.org/git/CAPig+cQLmYQeRhPxvZHmY7gApnbE25H_KoSWs-Zj=
uBo4BruimQ@mail.gmail.com/

>>> -       test $(git cat-file commit refs/remotes/glob | \
>>> -              grep "^parent " | wc -l) -eq 2
>>> +       test $(git cat-file commit refs/remotes/glob >actual &&
>>> +              grep "^parent " actual | wc -l) -eq 2
>>
>> This is not a great transformation. If "git cat-file" fails, then
>> neither 'grep' nor 'wc' will run, and the result will be as if 'test'
>> was called without an argument before "-eq". For example:
>>
>>     % test $(false >actual && grep "^parent " actual | wc -l) -eq 2
>>     test: -eq: unary operator expected
>>
>> It would be better to run "git cat-file" outside of "test $(...)". For i=
nstance:
>>
>>     git cat-file ... >actual &&
>>     test $(grep ... actual | wc -l) -eq 2
>>
>> Alternately, you could take advantage of the test_line_count() helper fu=
nction:
>>
>>     git cat-file ... >actual &&
>>     grep ... actual >actual2 &&
>>     test_line_count =3D 2 actual2
>
> In this case though as you rightly point out the rewrite is introducing
> a regression, which should definitely be fixed.
