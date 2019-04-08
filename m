Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D792D20248
	for <e@80x24.org>; Mon,  8 Apr 2019 04:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbfDHES5 (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 00:18:57 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:52985 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbfDHES5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Apr 2019 00:18:57 -0400
Received: by mail-wm1-f52.google.com with SMTP id a184so12588935wma.2
        for <git@vger.kernel.org>; Sun, 07 Apr 2019 21:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AaK8bamBjTrcL2rM/lpJr0X70VbId91JVA2ilkSIN6M=;
        b=IJRviTscEUosdMY25fjR5YhJjLk+8YOpoe8phEN+PLpoPOqJDWOziGopunSkAvQm0/
         ZBsmmtcXYXB/U2pY4ee4ryr8LoOtY2jDeePwwndGumhtdQBDJyYStxwnPPnXORrwA2UR
         yT5d+Lgh84jA7XNUiV7hj14aPy3ovHJ+zmjLc/FdgV/25uyxhP09udsL022Zc4csdJd9
         aXThqndGLjsSwh2OBTwQV9nyCqzsVy66AbPzop+kG7TjXw1OhWO2gxd3QqPWsaexzZmh
         XHOc50L2sQ8XjI9PPADO+EX189SFJqMCFzOfCgf6vEhK0+27YyPEHjiFT1qRvyPC32wv
         lE3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AaK8bamBjTrcL2rM/lpJr0X70VbId91JVA2ilkSIN6M=;
        b=l7msFUejENvGT1AvyzKJEOpb949OL1hPH4QKs9F4JVSoesDkIhvuON5Uc8jqD/G51P
         d9g+B56CLGNncfF0NdOgeLDFnZ06Ou9v5tutkVccJtsuvf8DkiMifnzUtIPtGZ2IJSil
         71/SNzEJRjemnbx7abln/2qkS9M71T5YZfJPsXG8CWpOtO2GN4cr79lIW2LnbLeCgdQq
         197uOXixT8HX6pRlhshOSzBgRQcPts6ePUEfZYLxCrX3SpGwMoRYhW/+67KoUy89yju1
         MSKNwl87vp7pqUkW+vzlkNs5ELC+jKCVZ6gktozS67CUXrV7rW+9rEsIKMCDi80dZpqL
         T6aA==
X-Gm-Message-State: APjAAAWrrlWgRKA0vW2BBqEYM3aFvU/D6lMJpAmLHcvr0ccjSGnhQKMB
        vW/FmvN5iahfnsOJW8w6H8M6Ktyfi98=
X-Google-Smtp-Source: APXvYqyG1h0eqz/lC3zmO6eYnNNRzNZy8V9OjJgZROxyHM8RsYFX1GGZPjL3cxWMNAaE2zWLMuRcdw==
X-Received: by 2002:a7b:c301:: with SMTP id k1mr16556779wmj.37.1554697135298;
        Sun, 07 Apr 2019 21:18:55 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id x5sm9288447wmi.37.2019.04.07.21.18.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Apr 2019 21:18:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Apr 2019, #01; Thu, 4)
References: <xmqqr2aidpxw.fsf@gitster-ct.c.googlers.com>
        <87h8bb9bmx.fsf@evledraar.gmail.com>
Date:   Mon, 08 Apr 2019 13:18:54 +0900
In-Reply-To: <87h8bb9bmx.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 06 Apr 2019 21:28:22 +0200")
Message-ID: <xmqqef6db041.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Thu, Apr 04 2019, Junio C Hamano wrote:
>
> Just comments on ab/* stuff:
>
>> * ab/gc-reflog (2019-04-01) 7 commits
>>  - gc: handle & check gc.reflogExpire config
>>  - reflog tests: assert lack of early exit with expiry="never"
>>  - reflog tests: test for the "points nowhere" warning
>>  - reflog tests: make use of "test_config" idiom
>>  - gc: refactor a "call me once" pattern
>>  - gc: convert to using the_hash_algo
>>  - gc: remove redundant check for gc_auto_threshold
>>
>>  Fix various glitches in "git gc" around reflog handling.
>>
>>  cf. <20190328161434.19200-1-avarab@gmail.com> (v4)
>
> Missing a "will..." note for this one, the "cf" is just the cover letter
> for v4. AFAICT it should be ready to merge down from "pu".

The former is because I haven't decided and more importantly I
haven't seen enough input on the list to make a decision.

The latter is quite normal.  cf. is literally "here is one of the
things I can look at as a starting point to remind me what this
topic was about and what its current state is", a note left for me.
It often is "don't forget that somebody raised an issue and I should
not merge to to 'next' yet" but it is not limited to objections.

As I haven't seen enough input on the topic, and I have quite a
backlog after being offline for a wee, pointing at a cover to make
sure I can quickly find out which iteration I happen to have was/is
a logical thing to do.

>> * ab/gc-docs (2019-04-01) 12 commits
>>  - SQAUSH??? fixup! gc docs: include the "gc.*" section from "config" in "gc"
>>  - gc docs: remove incorrect reference to gc.auto=0
>>  - gc docs: clarify that "gc" doesn't throw away referenced objects
>>  - gc docs: note "gc --aggressive" in "fast-import"
>>  - gc docs: downplay the usefulness of --aggressive
>>  - gc docs: note how --aggressive impacts --window & --depth
>>  - gc docs: fix formatting for "gc.writeCommitGraph"
>>  - gc docs: re-flow the "gc.*" section in "config"
>>  - gc docs: include the "gc.*" section from "config" in "gc"
>>  - gc docs: clean grammar for "gc.bigPackThreshold"
>>  - gc docs: stop noting "repack" flags
>>  - gc docs: modernize the advice for manually running "gc"
>
> That squash makes sense. Will submit another version with it integrated.

OK, then I won't squash it myself, but instead queue the updated
patches.

Thanks.
