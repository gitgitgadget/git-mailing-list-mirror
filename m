Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DC321F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 20:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbfJKUCU (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 16:02:20 -0400
Received: from mail-ua1-f65.google.com ([209.85.222.65]:34573 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbfJKUCU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 16:02:20 -0400
Received: by mail-ua1-f65.google.com with SMTP id q11so3437185uao.1
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 13:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yq/EceOxApcPTperT4nNTdYH0iyJSETeog5/Y5ctC+w=;
        b=jqgRdKwxG7nVuK0I0rofBMCRP61iOeUm70IXC/VvrSQsT16ZR0NJATcSUv7Fo770ef
         5eYufYGRe485wnBihHsxxJ6CrWvXP9/WxmINPeJ8Vg3tR6IPqRaBcMq3VEKiHgTAkJ6C
         gV0VOPQwd2SOR9rMUfAGrUekwV9JFroGuPq2H40oaeRVBaxV3rP4nbIeJkdrUa58VjEp
         ByMj8GNQEu1f0+NNjOxu6gtvrZzTwWmYGfcxE1IBpaztDraE6QWsPz1Pqid8/rO0YGN6
         Z4jklK8BAW8a3AEk2r2sglAaFKA3U4VfjOVNsEsFdoYrcTyrIfi3fbXPbRyWDuUW7zy2
         XzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yq/EceOxApcPTperT4nNTdYH0iyJSETeog5/Y5ctC+w=;
        b=AeHYRSMYhfXI7cz7lgxs/KdUfV0DLmeDVEXWvQ3eeXRVEHjmv3ULp00o9ucn/1HqV/
         cja+Zn1HqxD+kEgj6vb2BuRXubvVzCaA0DntytEbAsxCSjnP/of5m1X2lLB3svIBxHSa
         FcxN4sNXrVpQwx8YiLKTFXZTdX1slIUDGU1xhEIlUSmhtiwP5a5eFMtGYagf8GuW7ib/
         xGrt7LK/9mp6QbRfdvqEvSaj6Tw+f0az8Rq1zhFlL6lZLX383FUYBAvx7R3stmsPanIN
         1knIE2eNUybzHWiCpFcOgUqIYY/bD3nHprbnfQD4TMO4tgWgKBlDwBsT/FmBrdDw4cFG
         l3tQ==
X-Gm-Message-State: APjAAAUBBjcDtI9kfgxi7zqWo5ujdscdKBFHY/MlzUYPRv0NbjRt2pue
        ObpMgjmoueMT4bMxt4pjaDwaLU3bM5xlnX6q5ifYTg==
X-Google-Smtp-Source: APXvYqwbuAWydcggdht3YTI7ILI9shvWlp2dTmrCRLNz5a5oiMTuCMNnM9NWXIEoXOGgo7DJu3RFPQ2Vo53j3J4XFCg=
X-Received: by 2002:ab0:6791:: with SMTP id v17mr9191413uar.81.1570824137361;
 Fri, 11 Oct 2019 13:02:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180419175823.7946-1-newren@gmail.com> <20180419175823.7946-19-newren@gmail.com>
 <nycvar.QRO.7.76.6.1910092044590.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1910092044590.46@tvgsbejvaqbjf.bet>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Oct 2019 13:02:03 -0700
Message-ID: <CABPp-BFrFrm1-MdttBDRHMmun++HxwV1tySoDb75f58ObwMwfg@mail.gmail.com>
Subject: Re: [PATCH v10 18/36] merge-recursive: add get_directory_renames()
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

// Dropping a few folks from the cc list as the thread is so old that
I think it should just be the normal git mailing list.

Hi Dscho,

On Wed, Oct 9, 2019 at 1:39 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Elijah,
>
> sorry about the blast from the past, but I just stumbled over something
> I could not even find any discussion about:

I'm curious what brought you to this part of the codebase, but either
way, thanks for sending an email with your findings.

More comments below...

[...]
> > @@ -1357,6 +1395,169 @@ static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
> >       return ret;
> >  }
> >
> > +static void get_renamed_dir_portion(const char *old_path, const char *new_path,
> > +                                 char **old_dir, char **new_dir)
> > +{
> > +     char *end_of_old, *end_of_new;
> > +     int old_len, new_len;
> > +
> > +     *old_dir = NULL;
> > +     *new_dir = NULL;
> > +
> > +     /*
> > +      * For
> > +      *    "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
> > +      * the "e/foo.c" part is the same, we just want to know that
> > +      *    "a/b/c/d" was renamed to "a/b/some/thing/else"
> > +      * so, for this example, this function returns "a/b/c/d" in
> > +      * *old_dir and "a/b/some/thing/else" in *new_dir.
> > +      *
> > +      * Also, if the basename of the file changed, we don't care.  We
> > +      * want to know which portion of the directory, if any, changed.
> > +      */
> > +     end_of_old = strrchr(old_path, '/');
> > +     end_of_new = strrchr(new_path, '/');
> > +
> > +     if (end_of_old == NULL || end_of_new == NULL)
> > +             return;
> > +     while (*--end_of_new == *--end_of_old &&
> > +            end_of_old != old_path &&
> > +            end_of_new != new_path)
> > +             ; /* Do nothing; all in the while loop */
> > +     /*
> > +      * We've found the first non-matching character in the directory
> > +      * paths.  That means the current directory we were comparing
> > +      * represents the rename.  Move end_of_old and end_of_new back
> > +      * to the full directory name.
> > +      */
> > +     if (*end_of_old == '/')
> > +             end_of_old++;
> > +     if (*end_of_old != '/')
> > +             end_of_new++;
>
> Is this intentional? Even after thinking about it for fifteen minutes, I
> think it was probable meant to test for `*end_of_new == '/'` instead of
> `*end_of_old != '/'`. And...

Yeah, looks like a mess-up, and yes your suspicion is correct about
what was intended.

Hilariously, though, no bug results from this.  Since these are paths,
as canonicalized by git (i.e. not as specified by the user where they
might accidentally type multiple consecutive slashes), there will
never be two slashes in a row (because we can't have directories with
an empty name).  Thus, it is guaranteed at this point that *end_of_old
!= '/', and end_of_new is thus unconditionally advanced.  Further,
since we wanted to find the _next_ '/' character after end_of_new,
then there were two cases: (1) end_of_new already pointed at a slash
character in which case we needed it to be advanced, or (2) end_of_new
didn't point to a slash character so it wouldn't hurt at all to
advance it.

> > +     end_of_old = strchr(end_of_old, '/');
> > +     end_of_new = strchr(end_of_new, '/');
>
> ... while I satisfied myself that these calls cannot return `NULL` at
> this point, it took quite a few minutes of reasoning.
>
> So I think we might want to rewrite these past 6 lines, to make
> everything quite a bit more obvious, like this:
>
>         if (end_of_old != old_path)
>                 while (*(++end_of_old) != '/')
>                         ; /* keep looking */
>         if (end_of_new != new_path)
>                 while (*(++end_of_new) != '/')
>                         ; /* keep looking */

I think your if-checks here are not correct.  Let's say that old_path
was "tar/foo.c" and new_path was "star/foo.c".  The initial strrchr
will bring both end_of_* variables back to the slash.  The moving left
while equal will move end_of_old back to old_path (i.e. pointing to
the "t") and end_of_new back to pointing at "t" as well.  Here's where
your six alternate lines would kick in, and would leave end_of_old at
old_path, while moving end_of_new to the '/', making it look like we
had a rename of "" (the empty string or root directory) to "star"
instead of a rename of "tar" to "star".  If you dropped your if-checks
(just having the while loops), then I think it does the right thing.

> There is _still_ one thing that makes this harder than trivial to reason
> about: the case where one of `*end_of_old` and `*end_of_new` is a slash.
> At this point, we assume that `*end_of_old != *end_of_new` (more about
> that assumption in the next paragraph), therefore only one of them can
> be a slash, and we want to advance beyond it. But even if the pointer
> does not point at a slash, we want to look for one, so we want to
> advance beyond it.

I should probably add a comment that we want to advance BOTH to the
next slash.  I would have just used strchr() but it wouldn't advance
the string if it already points to what I'm looking for.  Actually, I
guess I could simplify the code by unconditionally advancing by one
character, then calling strchr().  In other words, simplifying these
six lines to just

       end_of_old = strchr(++end_of_old, '/');
       end_of_new = strchr(++end_of_new, '/');

> I also think that we need an extra guard: we do not handle the case
> `a/b/c` -> `a/b/d` well. As stated a few lines above, "if the basename
> of the file changed, we don't care". So we start looking at the last
> slash, then go backwards, and since everything matches, end up with
> `end_of_old == old_path` and `end_of_new == new_path`. The current code
> will advance `end_of_new` (which I think is wrong) and then looks for
> the next slash in both `end_of_new` and `end_of_old` (which is also
> wrong).

The current code is slightly convoluted, but I would say it's not
wrong for this case.  If we renamed a/b/c -> a/b/d, then there isn't a
directory rename; the leading directory (a/b/) is the same for both.
You are right that the advancing of end_of_old and end_of_new to the
next slash would result in what looks like a rename of "a" to "a", but
the checks at the end checked for this case and only returned
something for *old_dir and *new_dir if these didn't match; in fact,
it's the part of the code at the end of your email that you didn't
comment on, here:

> > +
> > +     /*
> > +      * It may have been the case that old_path and new_path were the same
> > +      * directory all along.  Don't claim a rename if they're the same.
> > +      */
> > +     old_len = end_of_old - old_path;
> > +     new_len = end_of_new - new_path;
> > +
> > +     if (old_len != new_len || strncmp(old_path, new_path, old_len)) {
> > +             *old_dir = xstrndup(old_path, old_len);
> > +             *new_dir = xstrndup(new_path, new_len);
> > +     }
> > +}
> > [...]

However, we could drop this late check by just doing a simpler earlier
check to see if end_of_old == old_path and end_of_new == new_path
after the "find first non-equal character" step and before advancing
to the next '/', and if that condition is found, then return early
with no match.


However, since you highlighted this code, there are two other special
cases that might be interesting:

1) What if we are renaming e.g. foo/bar/baz.c ->
leading/dir/foo/bar/baz.c?  Then after trying to find the first
non-matching char we'll have end_of_old == old_path and *end_of_new ==
'f', and the advancing makes it look like "foo" being renamed to
"leading/dir/foo".  Since the root directory cannot be renamed (it
always exists on both sides of history), this probably makes sense as
the right thing to return.
2) What if the renaming went the other way, from
leading/dir/foo/bar/baz.c -> foo/bar/baz.c?  The whole advancing thing
makes this look like "leading/dir/foo" being renamed to "foo", instead
of "leading/dir" being renamed to "" (the root directory).  If we
don't detect it as "leading/dir" being renamed (merged into) the root
directory, then new files added directly within leading/dir/ on the
other side of history won't be moved by directory rename detection
into the root directory.

> Is my reading correct?

I'm not sure if I've answered your questions; let me know if not.  I
have generated a couple patches to (1) make the code easier to follow,
and (2) support the rename/merge of a subdirectory into the root
directory.  They're waiting for the gitgitgadget CI checks right now,
then I'll send them to the list.
