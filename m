Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C3BA1F404
	for <e@80x24.org>; Sat,  3 Feb 2018 22:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752465AbeBCWcK (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Feb 2018 17:32:10 -0500
Received: from mail-ua0-f196.google.com ([209.85.217.196]:34586 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752688AbeBCWcI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Feb 2018 17:32:08 -0500
Received: by mail-ua0-f196.google.com with SMTP id g5so4694447uac.1
        for <git@vger.kernel.org>; Sat, 03 Feb 2018 14:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=x2kJuWF1ljHcnH/4cgccrte4baS/pn09lv2jtHti8bo=;
        b=VREx0h2oCSHGaR/ylNvbrpM+/zdnFknSryjrfzWtnYaX5CHQ6PkwgCeKFwFCzkMR02
         bAsISzYrmh0U+8XfgMU2b7c850mx3v2cPcBriFFWngpeRNEOM3zr+140dMM92IDEes3x
         906aQIwHH/LHHShN6U8U0FcZbZZn7SHvcTriC02aPG9cNNkQ2kpdMNE9p3jXG06zVqAy
         /SG/hlnMT7vsYDMm2D5IDSD3cU1HuWSH1D4EDPtvQ3C+cGhidLF/Lzh/sSSQ7Fw6DF4U
         owbqVs2TEn3kJp7eogQ9mByrZbKsNhhADyKgEZUyecRVkweeN3/fewwWa2yYM8hjU9UV
         YBaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=x2kJuWF1ljHcnH/4cgccrte4baS/pn09lv2jtHti8bo=;
        b=tDFfIfHKBKS4A7JurheyWdr4xsKemE3kg/5592Ilx/QcHq1k3B4mm2JIQZluJxSv1u
         H6jCHY23NABwFZgsk+XWIZFbQKqNA9jQI3v4kMTtZhqQ++V+6hNck0R5RgfQJFr204Fp
         IZwNBGVMhv5pqgpMo8EsSaASpaCwQ65hbpIe+EQIn5Dw8AbLpzlnXgnjFLmepH9Y8UDF
         z+7MVr8MSt62HAPM7BIjL3SyEtwFqu9uW+IZrEo4IUnHK/shzYilnO5mxCUX5ya4xt7T
         ZkkmT61ixvGAOwSMTuuOo4D2CgQLVyETKa4X64ls0Pyr/FbvbPlsJ/f9RRIwxktgam7P
         xKYQ==
X-Gm-Message-State: AKwxytdUBIPuHyCfUQ1x0VOUtfhOvvXwx+YpQo7HjVzPWbBittevqt3S
        Cqv+KwCo/zvCfqy4oi7KhCPDPKD0pgs1NMi0MCg=
X-Google-Smtp-Source: AH8x225VyVXJmiEngmIRQbccD22Tva7AD5LVTH0ANgZvNNxquKkCxEQP5tdNbQOZIS0Ydh07w3sE/5x7eqNyFOxZuZs=
X-Received: by 10.159.40.35 with SMTP id c32mr36589055uac.40.1517697127521;
 Sat, 03 Feb 2018 14:32:07 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.1.33 with HTTP; Sat, 3 Feb 2018 14:32:07 -0800 (PST)
In-Reply-To: <CAGZ79kb2+tpr0K0x2VVfFR-u3W2htvbxokxfKBpG60mNjXGPEw@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-20-newren@gmail.com>
 <CAGZ79kb2+tpr0K0x2VVfFR-u3W2htvbxokxfKBpG60mNjXGPEw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 3 Feb 2018 14:32:07 -0800
Message-ID: <CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQsB6fHXT+9hLQ@mail.gmail.com>
Subject: Re: [PATCH v7 19/31] merge-recursive: add get_directory_renames()
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 2, 2018 at 5:02 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:

>> +       /* For
>
> comment style.

Fixed it and looked through the file for any other violations and
fixed the ones introduced in this series.  (The ones I added years ago
in other places of the file I just left.)

>> +        *    "a/b/c/d/foo.c" -> "a/b/something-else/d/foo.c"
>> +        * the "d/foo.c" part is the same, we just want to know that
>> +        *    "a/b/c" was renamed to "a/b/something-else"
>> +        * so, for this example, this function returns "a/b/c" in
>> +        * *old_dir and "a/b/something-else" in *new_dir.
>
> So we would not see multi-directory renames?
>
>     "a/b/c/d/foo.c" -> "a/b/something-else/e/foo.c"
>
> could be detected as
>
>     "a/b/{c/d/ => something-else/e}/foo.c"
>
> I assume this patch series is not bringing that to the table.
> (which is fine, I am just wondering)

I fully intended to support that, and believe the code does.  I
changed the comment as follows to try to make it clearer:

    /*
     * For
     *    "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
     * the "e/foo.c" part is the same, we just want to know that
     *    "a/b/c/d" was renamed to "a/b/some/thing/else"
     * so, for this example, this function returns "a/b/c/d" in
     * *old_dir and "a/b/some/thing/else" in *new_dir.
     *
     * Also, if the basename of the file changed, we don't care.  We
     * want to know which portion of the directory, if any, changed.
     */

Is that better?

>> +        *
>> +        * Also, if the basename of the file changed, we don't care.  We
>> +        * want to know which portion of the directory, if any, changed.
>> +        */
>> +       end_of_old = strrchr(old_path, '/');
>> +       end_of_new = strrchr(new_path, '/');
>> +
>> +       if (end_of_old == NULL || end_of_new == NULL)
>> +               return;
>
> return early as the files are in the top level, and apparently we do
> not support top level renaming?
>
> What about a commit like 81b50f3ce4 (Move 'builtin-*' into
> a 'builtin/' subdirectory, 2010-02-22) ?
>
> Well that specific commit left many files outside the new builtin dir,
> but conceptually we could see a directory rename of
>
>     /* => /src/*

We had some internal usecases for want to support a "rename" of the
toplevel directory into a subdirectory of itself.  However, attempting
to support that opened much too big a can of worms for me.  We'd open
up some big surprises somewhere.

In particular, note that not supporting a "rename" of the toplevel
directory is a special case of not supporting a "rename" of any
directory to a subdirectory below itself, which in turn is a very
special case of excluding partial directory renames.  I addressed this
in the cover letter of my original submission, as follows:

"""
Further, there's a basic question about when directory rename detection
should be applied at all.  I have a simple rule:

  3) If a given directory still exists on both sides of a merge, we do
     not consider it to have been renamed.

Rule 3 may sound obvious at first, but it will probably arise as a
question for some users -- what if someone "mostly" moved a directory but
still left some files around, or, equivalently (from the perspective of the
three-way merge that merge-recursive performs), fully renamed a directory
in one commmit and then recreated that directory in a later commit adding
some new files and then tried to merge?  See the big comment in section 4
of the new t6043 for further discussion of this rule.
"""

Patch 04/31 is the one that adds that big comment with further discussion.

Maybe there's a way to support toplevel renames, but I think it'd make
this series longer and more complicated...and may cause more edge
cases that confuse users.

>> +       while (*--end_of_new == *--end_of_old &&
>> +              end_of_old != old_path &&
>> +              end_of_new != new_path)
>> +               ; /* Do nothing; all in the while loop */
>
> We have to compare manually as we'd want to find
> the first non-equal and there doesn't seem to be a good
> library function for that.
>
> Assuming many repos are UTF8 (including in their paths),
> how does this work with display characters longer than one char?
> It should be fine as we cut at the slash?

Oh, UTF-8.  Ugh.
Can UTF-8 characters, other than '/', have a byte whose value matches
(unsigned char)('/')?  If so, then I'll need to figure out how to do
utf-8 character parsing.  Anyone have pointers?

>> +       /*
>> +        * We've found the first non-matching character in the directory
>> +        * paths.  That means the current directory we were comparing
>> +        * represents the rename.  Move end_of_old and end_of_new back
>> +        * to the full directory name.
>> +        */
>> +       if (*end_of_old == '/')
>> +               end_of_old++;
>> +       if (*end_of_old != '/')
>> +               end_of_new++;
>> +       end_of_old = strchr(end_of_old, '/');
>> +       end_of_new = strchr(end_of_new, '/');
>> +
>> +       /*
>> +        * It may have been the case that old_path and new_path were the same
>> +        * directory all along.  Don't claim a rename if they're the same.
>> +        */
>> +       old_len = end_of_old - old_path;
>> +       new_len = end_of_new - new_path;
>> +
>> +       if (old_len != new_len || strncmp(old_path, new_path, old_len)) {
>
> How often are we going to see this string-is-equal case?
> Would it make sense to do that first in the function?

We don't have old_len at that point, and old_len != strlen(old_path).
In particular, this is for comparing directories, and old_path and
new_path both stored file paths.
In particular, I think the most common case is someone renaming e.g.
   a/b/file.c -> a/b/newfile.c
The filenames are different, but the directory name is not.  Trying to
compare at the beginning of the function would thus give us the wrong
information.

So the check really needs to be done at this point of the function.

>> +       dir_renames = malloc(sizeof(struct hashmap));
>
> xmalloc

Thanks; I also looked for any other malloc uses I introduced, but it
looks like you caught both of them.  I'll fix them up.

>
>> +       dir_rename_init(dir_renames);
>> +       for (i = 0; i < pairs->nr; ++i) {
>> +               struct string_list_item *item;
>> +               int *count;
>> +               struct diff_filepair *pair = pairs->queue[i];
>> +               char *old_dir, *new_dir;
>> +
>> +               /* File not part of directory rename if it wasn't renamed */
>> +               if (pair->status != 'R')
>> +                       continue;
>> +
>> +               get_renamed_dir_portion(pair->one->path, pair->two->path,
>> +                                       &old_dir,        &new_dir);
>> +               if (!old_dir)
>> +                       /* Directory didn't change at all; ignore this one. */
>> +                       continue;
>
>
> So the first loop is about counting the number of files in each directory
> that are renamed and the later while loop is about mapping them?

Close; would adding the following comment at the top of the function help?

    /*
     * Typically, we think of a directory rename as all files from a
     * certain directory being moved to a target directory.  However,
     * what if someone first moved two files from the original
     * directory in one commit, and then renamed the directory
     * somewhere else in a later commit?  At merge time, we just know
     * that files from the original directory went to two different
     * places, and that the bulk of them ended up in the same place.
     * We want each directory rename to follow the bulk of the files
     * from that directory.  This function exists to find where the
     * bulk of the files went.
     *
     * The first loop below simply iterates through the list of
     * renames, adding up all the rename source->target locations with
     * a count.
     *
     * The second loop compares the count for each renamed directory
     * and declares the "winning" target location.
     */

Is there any part that remains unclear with that comment?  (Also, is
that comment too long?)

>> +               /* Strings were xstrndup'ed before inserting into string-list,
>> +                * so ask string_list to remove the entries for us.
>> +                */
>
> comment style.

Thanks.

>> +               entry->possible_new_dirs.strdup_strings = 1;
>
> Why do we need to set strdup_strings here (so late in the
> game, we are about to clear it?) Could we set it earlier?
>
> Or rather have the string list duplicate the strings instead of
> get_renamed_dir_portion ?

We didn't strdup the original string (a file path) as-is, we
strndup'ed a subset of the original string (just the relevant portion
of the directory).  Since we already had to allocate a special string
for that, making the string list duplicate the strings would have
caused an extra unnecessary allocation and required us to free the
memory allocated by get_renamed_dir_portion manually.  So, we do need
this here.

Does this comment make it clearer?:

        /*
         * The relevant directory sub-portion of the original full
         * filepaths were xstrndup'ed before inserting into
         * possible_new_dirs, and instead of manually iterating the
         * list and free'ing each, just lie and tell
         * possible_new_dirs that it did the strdup'ing so that it
         * will free them for us.
         */
        entry->possible_new_dirs.strdup_strings = 1;
        string_list_clear(&entry->possible_new_dirs, 1);
