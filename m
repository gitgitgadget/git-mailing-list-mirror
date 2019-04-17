Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14D9620248
	for <e@80x24.org>; Wed, 17 Apr 2019 15:49:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732715AbfDQPt5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 Apr 2019 11:49:57 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:43396 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732305AbfDQPt5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Apr 2019 11:49:57 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hGmot-00088i-16; Wed, 17 Apr 2019 17:49:55 +0200
Received: by mail-lf1-f43.google.com with SMTP id t11so14762952lfl.12
        for <git@vger.kernel.org>; Wed, 17 Apr 2019 08:49:55 -0700 (PDT)
X-Gm-Message-State: APjAAAV4vJLCE+QhugdgA1QwRX3dQ36OSPizthgnslJxeTm0e6z5VEuS
        n8qRz7bfrWjTNJqVI6rGG7G3LHrWtbC1qngo1ac=
X-Google-Smtp-Source: APXvYqxvtPbpMc3q3z3w04HmwyFMVqZcHNAxEHUM/Ua2qClijjtXjlnQhJWPEykW7kiCW4lKr1TQ6q4ghPNeU1T/QGc=
X-Received: by 2002:a19:4f19:: with SMTP id d25mr6739174lfb.124.1555516194605;
 Wed, 17 Apr 2019 08:49:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190405200045.10063-1-admin@in-ici.net> <xmqqftqt7x49.fsf@gitster-ct.c.googlers.com>
 <CAKrvxcVgMLNEEY6U+ybm6n4WtUCdOaYRjBrDKFvRwzYbZyB2UQ@mail.gmail.com>
 <xmqqy34j7jci.fsf@gitster-ct.c.googlers.com> <CAKrvxcW1hKUjMsCGUz7GothxbEKiQek2J5CkjhuiSKoGrArjbQ@mail.gmail.com>
 <xmqqzhoz2lpr.fsf@gitster-ct.c.googlers.com> <CAKrvxcX+Fi1U4NcH5Mqf0cR8QQc9FWtVQ-uuj0Dhd3qEu5o6XA@mail.gmail.com>
In-Reply-To: <CAKrvxcX+Fi1U4NcH5Mqf0cR8QQc9FWtVQ-uuj0Dhd3qEu5o6XA@mail.gmail.com>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Date:   Wed, 17 Apr 2019 17:49:42 +0200
X-Gmail-Original-Message-ID: <CAKrvxcXrnEdVFHxrEhhcFB5knXF1V=Jtf0psVVaK-Q=KVEztTg@mail.gmail.com>
Message-ID: <CAKrvxcXrnEdVFHxrEhhcFB5knXF1V=Jtf0psVVaK-Q=KVEztTg@mail.gmail.com>
Subject: Re: [PATCH/docs] make slash-rules more readable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1555516196;e1c29d2c;
X-HE-SMSGID: 1hGmot-00088i-16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think its maybe hard to track all the changes that we have discussed
so far. Should I create a new PATCH request including all the changes
from the recent mails and then we continue the discussion from there?

Best regards,
Adam

Am Mi., 10. Apr. 2019 um 09:39 Uhr schrieb Dr. Adam Nielsen <admin@in-ici.net>:
>
> > the pattern is matched against paths in the directory where the
> > `.gitignore` file that has the pattern in it is in, and any of
> > its subdirectories (recursively).
>
> > the pattern will match in all directories relative to
> > the `.gitignore` file, with infinite depth.
>
> I could not catch the difference between the meaning of both.
> However, I think "paths in the directory" and "directories relative to"
> are maybe both ambiguous.
>
> Since a pattern without a non-trailing slash must always be a file name or a
> folder name, and does not have a leading slash, we could maybe just
> say it like this:
>
>         the pattern is matched against all files and folders (recursively)
>         from the location of the `.gitignore` file.
> ---------
>
>
> > Unlike a pattern without a slash, a pattern with a
> > non-trailing slash is matched against paths immediately in
> > the directory the `.gitignore` file the pattern appears in
> > is stored in, and does not get used in its subdirectories..
>
> I think one can always assume that we talking about the relevant
> `.gitignore` file (where the pattern appears in).
>
> Perhaps this covers it all?
>
>         A pattern with a non-trailing slash is always considered
>         to begin at the `.gitignore` file location.
>
> followed by your example
>
> > For example, the pattern `doc/frotz/` that appears in
> > `.gitignore` at the top-level of the project matches
> > `doc/frotz` directory (again, seen from the top-level), but
> > not `a/doc/frotz`.
>
> and maybe one more example
>
>         Note that the pattern `doc/frotz` and `/doc/frotz` are
>         equivalent.
>         However `/bar` and `bar` are different. They both match the
>         `bar` file or folder at the top level, but only the latter
> will also match `foo/bar`
>         (when `foo` is at the top level).
>
> This avoids the hustle with the ambiguous path, where it starts, and
> trailing or leading slashes. Together with the
> two examples it seems to be a good compromise between accuracy and
> understandable.
>
> The alternative would be to say
>
>         A pattern with a non-trailing slash is only matched against any
>         path that begins in the directory of the `.gitignore` file.
>
> While this is maybe clearer then saying "pattern [...] always
> considered to begin at` it is ambiguous about the slashes.
> So a very accuracy but maybe less understandable version would be
> something like this:
>
>         A pattern with a non-trailing slash is only matched against any
>         path that begins in the directory of the `.gitignore` file.
>         For example, if the `.gitignore` file is in folder `doc`
>         the path to file  `bar/doc/a/foo` that begins in `doc` is `a/foo`.
>         A pattern that matches a path except for a leading slash or
> trailing slash
>         is still considered a match. It is still valid however,
>         that when a pattern ends with a slash, it would only find a
> match with a directory.
>
> ---------
>
> > Also, a pattern "/doc" matches doc at the current level (i.e. the
> > directory in which .gitignore file that the pattern was taken from
> > is found) and not in any subdirectories.  Is that clear in the
> > proposed update?
>
> Yes.
>
> However, in the docs is already one paragraph solely dedicated for this case:
>
> > A leading slash matches the beginning of the pathname. For example, "/*.c" matches
> > "cat-file.c" but not "mozilla-sha1/sha1.c".
>
> However, we have already a better and more in detail explained example
> in the new
> proposal `*` paragraph and and the case with the leading slash is
> now a sub-case of `A pattern with a non-trailing slash`
> so we might just get rid of the above paragraph?
> ----------
>
>
> Thank you for explaining me how the algorithm works procedurally.
> It gave some inside of the origin of "If the pattern ends with a slash, it is
> removed for the purpose of the following description.."
> ---------
>
> All the best,
> Adam
