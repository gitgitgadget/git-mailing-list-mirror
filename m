Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4855020248
	for <e@80x24.org>; Tue,  9 Apr 2019 12:19:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbfDIMTa (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 08:19:30 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:45924 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbfDIMTa (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 9 Apr 2019 08:19:30 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hDpio-0005Fo-GT; Tue, 09 Apr 2019 14:19:26 +0200
Received: by mail-lj1-f178.google.com with SMTP id l7so14240520ljg.6
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 05:19:26 -0700 (PDT)
X-Gm-Message-State: APjAAAX2tr1BU+02zeXpocb2NsML99S7xnoEJHa/mQrjoVTlR4W/vYiF
        15ZxkSKYB+Ac7gSJI/O6GLO7FdEyELwdrnX4B9c=
X-Google-Smtp-Source: APXvYqw/dUG+wA35LzkqdbaNBAwGvMwyhkzM5ZznfAgL3C4cdw8xYcQ8bxkYPyQkkxFSz7HlwB1IYc4prHHTZm4ea0I=
X-Received: by 2002:a2e:9a46:: with SMTP id k6mr19138466ljj.119.1554812366013;
 Tue, 09 Apr 2019 05:19:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190405200045.10063-1-admin@in-ici.net> <xmqqftqt7x49.fsf@gitster-ct.c.googlers.com>
 <CAKrvxcVgMLNEEY6U+ybm6n4WtUCdOaYRjBrDKFvRwzYbZyB2UQ@mail.gmail.com> <xmqqy34j7jci.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqy34j7jci.fsf@gitster-ct.c.googlers.com>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Date:   Tue, 9 Apr 2019 14:19:14 +0200
X-Gmail-Original-Message-ID: <CAKrvxcW1hKUjMsCGUz7GothxbEKiQek2J5CkjhuiSKoGrArjbQ@mail.gmail.com>
Message-ID: <CAKrvxcW1hKUjMsCGUz7GothxbEKiQek2J5CkjhuiSKoGrArjbQ@mail.gmail.com>
Subject: Re: [PATCH/docs] make slash-rules more readable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1554812368;93970b47;
X-HE-SMSGID: 1hDpio-0005Fo-GT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>> I agree with you. How about we make up the word "intermediate slash" and
>> explain it in an extra paragraph?

> I am not sure if that is any better than "in the following, pretend
> that a slash at the end of a pattern does not exist", which is how
> the current description avoids repetition and aims for clarity.
> It probably is worse than than the current one if we need to introduce
> a new term that is otherwise not useful elsewhere---a new term adds
> to the cognitive load of readers.

The description "in the following, pretend that a slash at the end of
a pattern does not exist"
is much better understandable then "it is removed for the purpose of
the following description"
to me. However, I still think its better not to use it:

  1. The following paragraphs may not be valid if you do not keep this
rule in mind.
      This could happen, because one may not read the paragraphs in order,
      or its unclear if "in the following" is meant for all following
paragraphs or just this
      paragraph, or one simply forgets it if one happens to check up a
specific paragraph
      after some months or when returning from a break.
  2. Forcing the user to be aware that "in the following pretend that
a slash at the end does not exist"
      is at least for me a harder cognitive load then introducing a new term.
      Because for every new paragraph that I read, I have to check if
this rule applies.
  3. If you jump between paragraphs, you always need to locate the rule
      and then check if the current paragraph is below or after that rule.
  4. There are 7 paragraphs following this "specific rule" but only
the next paragraph
      is using it. I think its also not needed for the paragraph where
it appears.
      For the other 6 paragraphs one needs to unnecessary check
      if the rule is implicitly used anywhere.
  5. For every paragraph that one may add in the future below that
rule, one needs to double check
      if its compatible with this rule. So in terms of maintenance I
think its rather a downside.

If something is cumbersome to explain and appears often, I think its
best to explain it once in detail
and refer to that instead of a bloated description. However, since
this scenario only appears in two paragraphs,
a new term is maybe not justifiable. Thus, a cumbersome but complete
description might be preferable.

> > Its mentioned at the start of the page that the pattern is always
> > relative to the location of the `.gitignore` file. However, I see that
> > since its said "in all directories" its necessary to restrict it again.
> > How about
> >
> >          If the pattern contains no intermediate slash "`/`",
> >          the pattern will match in all directories at or below
> >          the `.gitignore` file, with infinite depth.
>
> It is unclear what "with infinite depth" means in this sentence.
> There is no depth-limit in the exclude mechanism, and I'd prefer
> not to confuse readers by making a casual mention of "depth" to
> imply as if there is some depth-based logic.

The description "infinite depth" is used in the current documentation
in the paragraph
for `/**`. I thought its good to reuse something that has already been
approved by the community.
I think it points out very well that we are not only looking at
folders at the level of the `.gitignore`
file but all the folders below.

> Also, as you defined "intermediate" as a slash that is neither
> leading nor trailing, the above paragraph says "/foo" matches any
> filesystem entity whose final path component is 'foo', e.g. a file
> 'foo' at the current level, a directory 'foo' in subdirectory 'dir'
> (i.e. 'dir/foo'), etc.  I do not think you meant to say that (and

We could fix it by defining an intermediate slash as any slash that is
not a trailing one.
But then one may just call it a "non-trailing" slash which is maybe
self-explanatory enough.

> this is why I do not like to introduce a new term---even its
> inventor cannot get it right).

Especially if someone invents a new thing, I would not expect that its
perfect right from scratch.

However, I have to admit, the introduced term "intermediate" has its
flaws. Maybe using "non-trailing" or a description is better.

> > I agree, this is much better. Although I would leave out
> >
> >>  "as the asterisk in the patter does not match "bar/hello.c"
> >>   which has a slash in it."
>
> I happen to think that the part is the more important half of that
> whole "example".

Alright.



To summarize: I would suggest to drop "it is removed for the purpose
of the following description" because of the points
I made at the top and instead mention the necessary exceptions in the
two relevant paragraphs. Here my new updated proposals:

          If the pattern contains no slash "`/`"
          (except an optional trailing slash),
          the pattern will match in all directories relative to
          the `.gitignore` file, with infinite depth.
          For example, `frotz/` matches `frotz` and `a/frotz` that
          is a directory, but does not match if these are files.
          A pattern `frotz` on the other hand matches these paths
          whether they are files or directories.

I think this is better then my first proposal:

>> + - If the pattern contains no slash "`/`" other then a trailing slash,

>While pretending to be a fresh reader and reading only this line
>made me wonder if the rule described in this bullet point applies
>only to a pattern that has a single slash at the end.  I wonder if
>it is just me, or we can improve the phrasing so that it is clear
>that a pattern without any slash also is covered by this rule, not
>just a pattern that has all non-slash chars followed by a single
>slash.

The phrase "except an optional" and the example both point out that
this rule works with and without trailing slash.
I kept "infinite depth" for the reasons explained above.

For the next paragraph I would suggest this:

        If the pattern contains a non-trailing slash "`/`",
        it matches the beginning of the pathname.
        For example, the pattern `doc/frotz/` matches
        `doc/frotz` that is a directory
        but does not match `a/doc/frotz`.

Where I have taken `it matches the beginning of the pathname` from the
paragraph of a leading slash.
The example uses a trailing slash, to emphasize that this rule works
also with trailing slash, for the case
that the reader confuses the line with "If the pattern contains no
trailing slash". Alternatively I would suggest:

        If the pattern contains a slash "`/`"
        that is not a trailing slash,
        it matches the beginning of the pathname.
        For example, the pattern `doc/frotz/` matches
        `doc/frotz` that is a directory
        but does not match `a/doc/frotz`.

This might be addressing the problem of my first proposal:

>> + - If the pattern contains a slash "`/`" other then a trailing slash, then

>The same comment applies to this first line about the ambiguity of a
>pattern without any slash anywhere.



All the best,
Adam
