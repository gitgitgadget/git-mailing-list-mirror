Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_HK_NAME_DR shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A171920248
	for <e@80x24.org>; Mon,  8 Apr 2019 10:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfDHK2I (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Apr 2019 06:28:08 -0400
Received: from vwp8955.webpack.hosteurope.de ([176.28.35.119]:58412 "EHLO
        vwp8955.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbfDHK2H (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 8 Apr 2019 06:28:07 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]); authenticated
        by vwp8955.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1hDRVT-0007Op-Ca; Mon, 08 Apr 2019 12:28:03 +0200
Received: by mail-lj1-f176.google.com with SMTP id y6so10696366ljd.12
        for <git@vger.kernel.org>; Mon, 08 Apr 2019 03:28:03 -0700 (PDT)
X-Gm-Message-State: APjAAAWhFja3+ESCybjco0v9H7x9VszKcpSOLf+nSSx0czte2hosUInA
        NeP+p7xyZjSCndNG64+AGAIx1rd2euFeLzySou0=
X-Google-Smtp-Source: APXvYqwVtJQ7U8HaWtKncjv8WroZWJ7uUJNCroLbWfN52OrZwewHFQyPgZXhrdTUqQXX51a+sG6UECjCqP05EWPvaPg=
X-Received: by 2002:a2e:9e4d:: with SMTP id g13mr12872549ljk.12.1554719282834;
 Mon, 08 Apr 2019 03:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190405200045.10063-1-admin@in-ici.net> <xmqqftqt7x49.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqftqt7x49.fsf@gitster-ct.c.googlers.com>
From:   "Dr. Adam Nielsen" <admin@in-ici.net>
Date:   Mon, 8 Apr 2019 12:27:51 +0200
X-Gmail-Original-Message-ID: <CAKrvxcVgMLNEEY6U+ybm6n4WtUCdOaYRjBrDKFvRwzYbZyB2UQ@mail.gmail.com>
Message-ID: <CAKrvxcVgMLNEEY6U+ybm6n4WtUCdOaYRjBrDKFvRwzYbZyB2UQ@mail.gmail.com>
Subject: Re: [PATCH/docs] make slash-rules more readable
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-bounce-key: webpack.hosteurope.de;admin@in-ici.net;1554719285;d4b91b14;
X-HE-SMSGID: 1hDRVT-0007Op-Ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am Mo., 8. Apr. 2019 um 09:51 Uhr schrieb Junio C Hamano <gitster@pobox.com>:
>
> "Adam Nielsen" <admin@in-ici.net> writes:
>
> A few notes on the form.
>
> > From: Adam Nielsen <admin@in-ici.net>
>
> This "author" identity and the name-email on the Signed-off-by: line
> should match, at least for this project.  I cannot tell which one is
> your preference, and I do not have any preference over your name
> either ;-), but please pick one and use it consistently.
>

Haha yes sorry. I had my struggles with this patch procedure and I
will do better next time.


> >
> > gitignore.txt: make slash-rules more readable
> >
> > Remove the addition `it is removed for the purpose of the following description` and
> > make clear in which situations a trailing slash is used or not. Increase readability
> > and make all paragraphs valid, even if they are not read in strict order.
> > Replace `otherwise` with the the concrete pattern that is considered in the paragraph to avoid
> > confusion.
> > Add simple examples to point out the significant difference between using or not using a trailing slash.
>
> These are overly long lines; we tend to fold long lines at around
> 70 char or so.

Okay.

>
> > Signed-off-by: Adam J. N. Nielsen <info@drnielsen.de>
> >
> > ---
> >  Documentation/gitignore.txt | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> > index 1c94f08ff4..c6720b0ac4 100644
> > --- a/Documentation/gitignore.txt
> > +++ b/Documentation/gitignore.txt
> > @@ -89,22 +89,25 @@ PATTERN FORMAT
> >     Put a backslash ("`\`") in front of the first "`!`" for patterns
> >     that begin with a literal "`!`", for example, "`\!important!.txt`".
> >
> > - - If the pattern ends with a slash, it is removed for the
> > -   purpose of the following description, but it would only find
> > + - If the pattern ends with a slash "`/`", it would only find
> >     a match with a directory.  In other words, `foo/` will match a
> >     directory `foo` and paths underneath it, but will not match a
> >     regular file or a symbolic link `foo` (this is consistent
> >     with the way how pathspec works in general in Git).
>
> I do like this change, even though I cannot bring myself backing it
> 100% immediately.

> The reason why I wrote it the way in the original
> was because I did not want to repeat "... but a slash at end, if
> exists, is exempt from this rule"

Yes, I can see why this makes sense. However, I find that this exception
makes this paragraph hard to read. Also I think its ambiguous if "it" refers
to the pattern or the slash. The first few times I read it,
I just didn't get it and was very intimidated by the paragraph.

> over and over in the later bullet
> points, as it would be a maintenance burden when we have more bullet
> points and when we find a better phrasing to say "... but a slash at
> end if exists, is exempt from this rule".

Yes, I agree. One should not repeat such a bloated exception rule over and over
again.

>
> The patch I am responding to bites the bullet and repeats the "the
> one at the end does not count", which may be slightly harder to
> maintain, but certainly makes it easier to read.
>
> > - - If the pattern does not contain a slash '/', Git treats it as
> > -   a shell glob pattern and checks for a match against the
> > -   pathname relative to the location of the `.gitignore` file
> > -   (relative to the toplevel of the work tree if not from a
> > -   `.gitignore` file).
> > + - If the pattern contains no slash "`/`" other then a trailing slash,
>
> While pretending to be a fresh reader and reading only this line
> made me wonder if the rule described in this bullet point applies
> only to a pattern that has a single slash at the end.  I wonder if
> it is just me, or we can improve the phrasing so that it is clear
> that a pattern without any slash also is covered by this rule, not
> just a pattern that has all non-slash chars followed by a single
> slash.

I agree with you. How about we make up the word "intermediate slash" and
explain it in an extra paragraph? This would make it less repetitive.
Also it makes clear that the case without any slash is also covered.
Perhaps

         In the following we use the term **intermediate slash** to
         denote a slash "`/`" in a pattern that is not a trailing slash
         nor a leading slash.
         For example the pattern `/foo/bar`, `foo/bar` and `/foo/bar/`
all contain
         only one intermediate slash. The pattern `foo/` does not contain an
         intermediate slash.

Then, instead of:

         If the pattern contains no slash "`/`" other then a trailing slash,"

one could say:

         If the pattern contains no intermediate slash "`/`",


>
> > +   then the pattern will match in all directories. In other words,
> > +   `foo/` will match `/bar/foo/` and `foo` will match `/bar/bar/foo`.
>
> The half-technical "treats it as a shell glob pattern" from the
> original is gone, which I think is a good change.  The examples may
> need to be improved, as it may not be clear to naive readers that
> with /bar/foo/, you meant that it is limited to a directory but not
> a file, and with /bar/bar/foo you meant both a directory and a file
> is fine.  Perhaps
>
>         For example, 'frotz/' matches 'frotz', 'a/frotz', etc. that
>         is a directory, but does not match if these are files.
>         A pattern 'frotz' on the other hand matches these paths
>         whether they are files or directories.
>

Yes. This is so much better.

> I also wonder if "in all directories" is clear enough that your
> "all" is limited to below the level the ignore pattern is defined
> for (i.e. "*.1" that appears in "Documentation/.gitignore" does not
> ignore "foo.1" at the top-level of the tree).

Its mentioned at the start of the page that the pattern is always
relative to the location of the `.gitignore` file. However, I see that
since its said "in all directories" its necessary to restrict it again.
How about

         If the pattern contains no intermediate slash "`/`",
         the pattern will match in all directories at or below
         the `.gitignore` file, with infinite depth.

>
> So I can tell that this patch is trying to address a problem in the
> original that is worth fixing, but I cannot say the result is good.
> At least not yet.
>
> > - - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
> > -   anything except "`/`", "`?`" matches any one character except "`/`"
> > -   and "`[]`" matches one character in a selected range. See
> > + - If the pattern contains a slash "`/`" other then a trailing slash, then
>
> The same comment applies to this first line about the ambiguity of a
> pattern without any slash anywhere.

This would now change with the above remarks to:

         If the pattern contains an intermediate slash "`/`",

>
> > +   the pattern is always considered from the `.gitignore` file location.
> > +   In other words, `foo/bar` will match `/foo/bar` but not `/bar/foo/bar`.
>
> Again, loss of the mention of "shell glob" is a good thing, as we
> still have a clue for those "in the know" at the end by mentioning
> fnmatch(3).
>
> The example lacks one crucial description to be useful.  The reader
> must be told where foo/bar came from.  Was it in the .gitignore file
> at the top-level?  A per-directory exclude file bar/.gitignore?
> Without making that clear, none of the "In other words" example
> makes much sense.
>
> Also another issue common to previous example is that you are using
> absolute path notation "/bar/foo/", "/bar/foo/bar", etc. without
> explaining what you want it mean.  I can guess that it does not
> refer to the root of the filesystem but you meant to refer to the
> top level of the working tree, but you are not writing documentation
> to help _me_ understand Git, so we should not rely on that "I can
> guess".  I do not think an average first-time reader can.

Maybe its shorter and clearer to write it like this:

         If the pattern contains an intermediate slash "`/`",
         its equivalent to the same pattern starting with a leading slash.
         For example the pattern `doc/read.txt` is equivalent to
         `/doc/read.txt`.

If we do this, one would need to lift the "leading slash" paragraph up
(The one starting with "A leading slash matches the beginning of the
pathname. For example,...").

Note that since an intermediate slash is explicitly not a leading
slash, it is not said that
`/bar/` and `//bar/` are equivalent.



>
> > + - The character "`*`" matches anything except a non trailing slash "`/`".
> > +   For example, "foo/*" matches "foo/test.json" and "foo/bar/"
> > +   but not "foo/bar/test.json".
>
> I think your writing out the trailing slash on the filesystem-entity
> side (i.e. things that are matched by patterns) is making the
> resulting description more distracting than necessary.  Being able
> to mark a pattern with a trailing slash to "match only to directory"
> is one thing, but when the example talks about paths foo/test.json
> (presumably a regular file and not a directory) and foo/bar
> (presumably a directory), it shouldn't force users to mistakenly
> think that the matching engine first appends a slash after a
> directory we read from the filesystem before applying the pattern
> matching logic, which has a compensating hack to ignore trailing
> slash from the path when matching.
>
> Once you write consistently that a path for a directory foo/bar is
> foo/bar, not foo/bar/, then this example would become much easier to
> write and read, I suspect.
>
>         An asterisk "`*`" matches anything except a slash.  A
>         pattern "foo/*", for example, matches "foo/test.json" (a
>         regular file), "foo/bar" (a diretory), but it does not match
>         "foo/bar/hello.c" (a regular file), as the asterisk in the
>         patter does not match "bar/hello.c" which has a slash in it.
>
> perhaps.

I agree, this is much better. Although I would leave out

>  "as the asterisk in the patter does not match "bar/hello.c"
>   which has a slash in it."

>
> > +   The character "`?`" matches any one character except "`/`".
> > +   The character "`[]`" matches one character in a selected range. See
>
> Calling `[]` construct "the character" is blatantly wrong.

Yes, my bad.

>
>         The range notation, e.g. `[a-zA-Z]`, can be used to match
>         one of the characters in a range.
>
> perhaps.

That is much better too.

> It still omits negation [!0-9] but it probably is OK to
> leave that for fnmatch(3), and you've done so by leaving these two
> lines from the original intact, which is good.
>
> >     fnmatch(3) and the FNM_PATHNAME flag for a more detailed
> >     description.
>
>
> Thanks.

Thank you for all your input. If you agree with my proposed changes, I would
create a new patch merging all this together.


Am Mo., 8. Apr. 2019 um 09:51 Uhr schrieb Junio C Hamano <gitster@pobox.com>:
>
> "Dr. Adam Nielsen" <admin@in-ici.net> writes:
>
> A few notes on the form.
>
> > From: Adam Nielsen <admin@in-ici.net>
>
> This "author" identity and the name-email on the Signed-off-by: line
> should match, at least for this project.  I cannot tell which one is
> your preference, and I do not have any preference over your name
> either ;-), but please pick one and use it consistently.
>
> >
> > gitignore.txt: make slash-rules more readable
> >
> > Remove the addition `it is removed for the purpose of the following description` and
> > make clear in which situations a trailing slash is used or not. Increase readability
> > and make all paragraphs valid, even if they are not read in strict order.
> > Replace `otherwise` with the the concrete pattern that is considered in the paragraph to avoid
> > confusion.
> > Add simple examples to point out the significant difference between using or not using a trailing slash.
>
> These are overly long lines; we tend to fold long lines at around
> 70 char or so.
>
> > Signed-off-by: Adam J. N. Nielsen <info@drnielsen.de>
> >
> > ---
> >  Documentation/gitignore.txt | 23 +++++++++++++----------
> >  1 file changed, 13 insertions(+), 10 deletions(-)
> >
> > diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
> > index 1c94f08ff4..c6720b0ac4 100644
> > --- a/Documentation/gitignore.txt
> > +++ b/Documentation/gitignore.txt
> > @@ -89,22 +89,25 @@ PATTERN FORMAT
> >     Put a backslash ("`\`") in front of the first "`!`" for patterns
> >     that begin with a literal "`!`", for example, "`\!important!.txt`".
> >
> > - - If the pattern ends with a slash, it is removed for the
> > -   purpose of the following description, but it would only find
> > + - If the pattern ends with a slash "`/`", it would only find
> >     a match with a directory.  In other words, `foo/` will match a
> >     directory `foo` and paths underneath it, but will not match a
> >     regular file or a symbolic link `foo` (this is consistent
> >     with the way how pathspec works in general in Git).
>
> I do like this change, even though I cannot bring myself backing it
> 100% immediately.  The reason why I wrote it the way in the original
> was because I did not want to repeat "... but a slash at end, if
> exists, is exempt from this rule" over and over in the later bullet
> points, as it would be a maintenance burden when we have more bullet
> points and when we find a better phrasing to say "... but a slash at
> end if exists, is exempt from this rule".
>
> The patch I am responding to bites the bullet and repeats the "the
> one at the end does not count", which may be slightly harder to
> maintain, but certainly makes it easier to read.
>
> > - - If the pattern does not contain a slash '/', Git treats it as
> > -   a shell glob pattern and checks for a match against the
> > -   pathname relative to the location of the `.gitignore` file
> > -   (relative to the toplevel of the work tree if not from a
> > -   `.gitignore` file).
> > + - If the pattern contains no slash "`/`" other then a trailing slash,
>
> While pretending to be a fresh reader and reading only this line
> made me wonder if the rule described in this bullet point applies
> only to a pattern that has a single slash at the end.  I wonder if
> it is just me, or we can improve the phrasing so that it is clear
> that a pattern without any slash also is covered by this rule, not
> just a pattern that has all non-slash chars followed by a single
> slash.
>
> > +   then the pattern will match in all directories. In other words,
> > +   `foo/` will match `/bar/foo/` and `foo` will match `/bar/bar/foo`.
>
> The half-technical "treats it as a shell glob pattern" from the
> original is gone, which I think is a good change.  The examples may
> need to be improved, as it may not be clear to naive readers that
> with /bar/foo/, you meant that it is limited to a directory but not
> a file, and with /bar/bar/foo you meant both a directory and a file
> is fine.  Perhaps
>
>         For example, 'frotz/' matches 'frotz', 'a/frotz', etc. that
>         is a directory, but does not match if these are files.
>         A pattern 'frotz' on the other hand matches these paths
>         whether they are files or directories.
>
> I also wonder if "in all directories" is clear enough that your
> "all" is limited to below the level the ignore pattern is defined
> for (i.e. "*.1" that appears in "Documentation/.gitignore" does not
> ignore "foo.1" at the top-level of the tree).
>
> So I can tell that this patch is trying to address a problem in the
> original that is worth fixing, but I cannot say the result is good.
> At least not yet.
>
> > - - Otherwise, Git treats the pattern as a shell glob: "`*`" matches
> > -   anything except "`/`", "`?`" matches any one character except "`/`"
> > -   and "`[]`" matches one character in a selected range. See
> > + - If the pattern contains a slash "`/`" other then a trailing slash, then
>
> The same comment applies to this first line about the ambiguity of a
> pattern without any slash anywhere.
>
> > +   the pattern is always considered from the `.gitignore` file location.
> > +   In other words, `foo/bar` will match `/foo/bar` but not `/bar/foo/bar`.
>
> Again, loss of the mention of "shell glob" is a good thing, as we
> still have a clue for those "in the know" at the end by mentioning
> fnmatch(3).
>
> The example lacks one crucial description to be useful.  The reader
> must be told where foo/bar came from.  Was it in the .gitignore file
> at the top-level?  A per-directory exclude file bar/.gitignore?
> Without making that clear, none of the "In other words" example
> makes much sense.
>
> Also another issue common to previous example is that you are using
> absolute path notation "/bar/foo/", "/bar/foo/bar", etc. without
> explaining what you want it mean.  I can guess that it does not
> refer to the root of the filesystem but you meant to refer to the
> top level of the working tree, but you are not writing documentation
> to help _me_ understand Git, so we should not rely on that "I can
> guess".  I do not think an average first-time reader can.
>
> > + - The character "`*`" matches anything except a non trailing slash "`/`".
> > +   For example, "foo/*" matches "foo/test.json" and "foo/bar/"
> > +   but not "foo/bar/test.json".
>
> I think your writing out the trailing slash on the filesystem-entity
> side (i.e. things that are matched by patterns) is making the
> resulting description more distracting than necessary.  Being able
> to mark a pattern with a trailing slash to "match only to directory"
> is one thing, but when the example talks about paths foo/test.json
> (presumably a regular file and not a directory) and foo/bar
> (presumably a directory), it shouldn't force users to mistakenly
> think that the matching engine first appends a slash after a
> directory we read from the filesystem before applying the pattern
> matching logic, which has a compensating hack to ignore trailing
> slash from the path when matching.
>
> Once you write consistently that a path for a directory foo/bar is
> foo/bar, not foo/bar/, then this example would become much easier to
> write and read, I suspect.
>
>         An asterisk "`*`" matches anything except a slash.  A
>         pattern "foo/*", for example, matches "foo/test.json" (a
>         regular file), "foo/bar" (a diretory), but it does not match
>         "foo/bar/hello.c" (a regular file), as the asterisk in the
>         patter does not match "bar/hello.c" which has a slash in it.
>
> perhaps.
>
> > +   The character "`?`" matches any one character except "`/`".
> > +   The character "`[]`" matches one character in a selected range. See
>
> Calling `[]` construct "the character" is blatantly wrong.
>
>         The range notation, e.g. `[a-zA-Z]`, can be used to match
>         one of the characters in a range.
>
> perhaps.  It still omits negation [!0-9] but it probably is OK to
> leave that for fnmatch(3), and you've done so by leaving these two
> lines from the original intact, which is good.
>
> >     fnmatch(3) and the FNM_PATHNAME flag for a more detailed
> >     description.
>
>
> Thanks.



-- 


Dr. Adam Nielsen


Administrator for IN/ICI/WHO


IN:

www.nlp-institutes.net


ICI:

www.coaching-institutes.net


WHO:

www.world-hypnosis.org
