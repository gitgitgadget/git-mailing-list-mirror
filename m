Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7115C1F42D
	for <e@80x24.org>; Sat, 26 May 2018 00:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030816AbeEZAo0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 May 2018 20:44:26 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:46550 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030802AbeEZAoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 May 2018 20:44:25 -0400
Received: by mail-vk0-f66.google.com with SMTP id i190-v6so4121967vkd.13
        for <git@vger.kernel.org>; Fri, 25 May 2018 17:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=qwg5DJ9NK5CKPfAHJQNANkJKw7wJqf/Svhq4CDoTMJs=;
        b=jKET7qxsSlMmLUJtOLLVpwSu1YjguAS/VjlpV2CXvOod14KsEFpBv0kvrlRjx22E3h
         vlVZFAXEejeGko5FYS2Tp3Jrl2Kfk4PY2fPN/WKttbXHNHPPpcIRAyXq279Tql+kCeFN
         FlOgk8uZxIlpO/dSaES7ag9HX5rHJ3GfaTJy9iGRiCf92Mg0BoH4+PRwpPawOs5IZny5
         DWFei971V7ARp9NWcfUQCoijSq6vsIjauEFDR4coaiP77xHr+DStqgFzdaWCSkAdM0hn
         rylvW/IikaCj3E6PxBMf4SvQdPCtGI2rrkZJR4PgAu2nfUHqvJGs99jpPNMK7f/XOwKR
         0Xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=qwg5DJ9NK5CKPfAHJQNANkJKw7wJqf/Svhq4CDoTMJs=;
        b=YZcovrpQUkjatzwonluGVJopjAEbxH4eFZQeNNbjE7+JrZsQhVWD0VBHlpFJKZdp/Y
         LdGNTEyknHU3Wf4wTMJzj+V8th21DZcTYKESr8CUvwQ2OxxcN0UaTNyNgu6LgZmcqoKo
         81I1jvO6YAhOafovyZ7Tz2YVhtarchTDrFLr7/1gVZdLMBKNjwKVRRXmADBeXiShO0Yv
         rlRc0q7c1U53QVO4kphN4wP7epS3t76GFJjKLPmXp0ggZCRt35iQY6NIOihYEiw+/qm7
         t4QkhwdNSlCctocFZrN/0aD1EyYoWKoZqAnIM+HcvGGKh9SGPmikczpx+NcsQQtkzChX
         fsng==
X-Gm-Message-State: ALKqPwdooPMQATv7x/q1W3UFL6JTYvCCwfL7pGeCc7OuO1iXS7Ouwmdm
        ffZw3xV0T87c+UrLKErtvBZT8fZUso6Vul7ugRc=
X-Google-Smtp-Source: ADUXVKLNWfmI9ukjYxKjgwjJ2eqmkry3b0lwiqAGlJQs37+Wemng/nlL5vsJRXX7iM88ezVaeYODKBSlmYsat6H9wGI=
X-Received: by 2002:a1f:a54:: with SMTP id 81-v6mr2608386vkk.184.1527295464991;
 Fri, 25 May 2018 17:44:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:5f04:0:0:0:0:0 with HTTP; Fri, 25 May 2018 17:44:24
 -0700 (PDT)
In-Reply-To: <xmqqy3g8pm8g.fsf@gitster-ct.c.googlers.com>
References: <20180524070439.6367-1-newren@gmail.com> <20180524070439.6367-3-newren@gmail.com>
 <20180524100507.32305-1-szeder.dev@gmail.com> <xmqqy3g8pm8g.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 25 May 2018 17:44:24 -0700
Message-ID: <CABPp-BEcTKaPPUOVqTRUAW+LBBySCK0dgx1J66hYB30yMasK_Q@mail.gmail.com>
Subject: Re: [PATCH 2/5] t6036, t6042: use test_line_count instead of wc -l
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 24, 2018 at 6:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
>>> -            test 2 =3D $(git ls-files -s | wc -l) &&
>>> -            test 2 =3D $(git ls-files -u | wc -l) &&
>>> -            test 2 =3D $(git ls-files -o | wc -l) &&
>>
>> Here 'git ls-files -o' should have listed two untracked files ...
>>
>>> +            git ls-files -s >out &&
>>> +            test_line_count =3D 2 out &&
>>> +            git ls-files -u >out &&
>>> +            test_line_count =3D 2 out &&
>>> +            git ls-files -o >out &&
>>> +            test_line_count =3D 3 out &&
>>
>> ... but now you expect it to list three.  I was about to point out the
>> typo, but then noticed that you expect it to list one more untracked
>> file than before in all subsequent tests...  now that can't be just a
>> typo, can it?
>>
>> Please mention in the commit message that when using an intermediate
>> file to store the output, 'git ls-files -o' will list that file, too,
>> that's why the number of expected untracked files had to be adjusted;
>> so future readers won't have to figure this out themselves.
>
> I'd expect that a reader of the commit who cares enough to bother to
> wonder by looking at the patch and seeing that 2 became 3 would know
> why already.  And a reader of the resulting file would not know that
> the 3 used to be 2, and won't be helped by "we used to count to 2,
> now we have 'out' also counted" that much, especially in the commit
> log message.  What would help the latter would be to name which
> three paths we expect to see in the comment (or test against the
> exact list of paths, instead of using test_line_count).
>
>> An alternative to consider would be to add a .gitignore file in the
>> initial commit to ignore 'out', then the number of untracked files
>> don't have to be adjusted.
>
> I think that is a preferred solution that we've used in ls-files and
> status tests successfully.

...except that if we add a .gitignore to each initial commit (we use
test_create_repo for nearly every test to keep them separable meaning
we'd have to do this many times), then four lines above we have to
adjust the number of expected tracked files.  And, for it to work,
we'd have to add an --exclude-standard flag to ls-files -o.

I can make that change if you both want it, but it seems like it's
actually making it harder to follow the changes rather than easier.
