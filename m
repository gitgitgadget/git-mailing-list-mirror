Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0701C1F404
	for <e@80x24.org>; Mon,  5 Feb 2018 19:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750990AbeBETjq (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 14:39:46 -0500
Received: from mail-yw0-f182.google.com ([209.85.161.182]:36269 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750818AbeBETjo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 14:39:44 -0500
Received: by mail-yw0-f182.google.com with SMTP id q6so19230965ywg.3
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 11:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4DftwnZm48Wzc6SAU45YCQuOkxUbf7s0L4X3yrRNnsU=;
        b=iEtNmnxdXhUaTyjypVktoj65/Vixt1tqfncMZqwQO8Ly1ZI9kvOWxv6inC3EKGr4f5
         aOIJfB1dzr+67/DB+sKx3A7/9juGwu9mDkENlZHIyebLwlBtkYSyEpK6IiPskvoD/sdj
         NMrKz3+JWMc9Jxmaiv+YYmOTb2VUldpGYS55/FhaV9L9vyyK9OXUlfJ1Y/6qAxpekSub
         ybeIWmaelcB3O0AD7rO7np8KgC0V+eTeQKHwWBlr8fW0T24iSUuuqhA+lUx1LNeGAjCn
         XkFH2aWOUHi1zERINBxhmVeXvmcHDzWj/akdKWwW17HHdnFMkAwRj4kXM9PeWFHlRInd
         QsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4DftwnZm48Wzc6SAU45YCQuOkxUbf7s0L4X3yrRNnsU=;
        b=dsZ8JkDcQbWJecM5osXRwdBqUze5f14V06jMYTrPjyhOMmsvTfllPbydvaJT4UIr1Z
         L6mDkxX9upCB3MH/q341jvFHsw1ytT+KsX55yRO3nOhFDzeHN/12A8sahZwju0VCT3ot
         dRoC5CNq//g++Sx+V92z3thc7sNZXgJG1BlEnonIn/eF2s8ArV8qc3wC5HV/iNi0zTPd
         rejf0tu/Lfc/uhPQ+dmtF7aiFinshV1SYP1bkWmlEVhVRxs1KrVlZM6r3G7QTZzh5A7Y
         hUexrevCzPNjqLN+UOeywUN9Jv0plWGwUaiO2IPVyDXTVe3E3n6m9rcTCmsttLwZaxk1
         w4Bg==
X-Gm-Message-State: AKwxyte9Hnz+QmBOXzY07D1thkYgNnOAOQF54IefR5sHXTtseSuWxw5O
        sY76TRYJixvG9u9M5qoCZZn0HPpXKUDzH3h0fMEIrA==
X-Google-Smtp-Source: AH8x227zOLGfdyQaQQcpMpJwvGQFVeLUYsHnYEcw79WSNCCuqiKIqZRMiJjQnNERdXwGdgeUK2pUPEM2PiBgGMOyOzw=
X-Received: by 10.129.156.134 with SMTP id t128mr31969166ywg.108.1517859583556;
 Mon, 05 Feb 2018 11:39:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Mon, 5 Feb 2018 11:39:43 -0800 (PST)
In-Reply-To: <CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQsB6fHXT+9hLQ@mail.gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-20-newren@gmail.com>
 <CAGZ79kb2+tpr0K0x2VVfFR-u3W2htvbxokxfKBpG60mNjXGPEw@mail.gmail.com> <CABPp-BGh7QTTfu3kgH4KO5DrrXiQjtrNhx_uaQsB6fHXT+9hLQ@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 5 Feb 2018 11:39:43 -0800
Message-ID: <CAGZ79kboJkX-Z8PtZir2DFLCbktwjJ5Mi7odR0SfdwxYDEXYhw@mail.gmail.com>
Subject: Re: [PATCH v7 19/31] merge-recursive: add get_directory_renames()
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

>     /*
>      * For
>      *    "a/b/c/d/e/foo.c" -> "a/b/some/thing/else/e/foo.c"
>      * the "e/foo.c" part is the same, we just want to know that
>      *    "a/b/c/d" was renamed to "a/b/some/thing/else"
>      * so, for this example, this function returns "a/b/c/d" in
>      * *old_dir and "a/b/some/thing/else" in *new_dir.
>      *
>      * Also, if the basename of the file changed, we don't care.  We
>      * want to know which portion of the directory, if any, changed.
>      */
>
> Is that better?

yes, that helps me understanding pretty much.

>
>>> +        *
>>> +        * Also, if the basename of the file changed, we don't care.  We
>>> +        * want to know which portion of the directory, if any, changed.
>>> +        */
>>> +       end_of_old = strrchr(old_path, '/');
>>> +       end_of_new = strrchr(new_path, '/');
>>> +
>>> +       if (end_of_old == NULL || end_of_new == NULL)
>>> +               return;
>>
>> return early as the files are in the top level, and apparently we do
>> not support top level renaming?
>>
>> What about a commit like 81b50f3ce4 (Move 'builtin-*' into
>> a 'builtin/' subdirectory, 2010-02-22) ?
>>
>> Well that specific commit left many files outside the new builtin dir,
>> but conceptually we could see a directory rename of
>>
>>     /* => /src/*
>
> We had some internal usecases for want to support a "rename" of the
> toplevel directory into a subdirectory of itself.  However, attempting
> to support that opened much too big a can of worms for me.  We'd open
> up some big surprises somewhere.


ok, I was just trying to understand the code.
(As said before, I was not asking for having this implemented.)

> In particular, note that not supporting a "rename" of the toplevel
> directory is a special case of not supporting a "rename" of any
> directory to a subdirectory below itself, which in turn is a very
> special case of excluding partial directory renames.  I addressed this
> in the cover letter of my original submission, as follows:
>
> """
> Further, there's a basic question about when directory rename detection
> should be applied at all.  I have a simple rule:
>
>   3) If a given directory still exists on both sides of a merge, we do
>      not consider it to have been renamed.
>
> Rule 3 may sound obvious at first, but it will probably arise as a
> question for some users -- what if someone "mostly" moved a directory but
> still left some files around, or, equivalently (from the perspective of the
> three-way merge that merge-recursive performs), fully renamed a directory
> in one commmit and then recreated that directory in a later commit adding
> some new files and then tried to merge?  See the big comment in section 4
> of the new t6043 for further discussion of this rule.
> """
>
> Patch 04/31 is the one that adds that big comment with further discussion.
>
> Maybe there's a way to support toplevel renames, but I think it'd make
> this series longer and more complicated...and may cause more edge
> cases that confuse users.

Thanks for reminding!

>
>>> +       while (*--end_of_new == *--end_of_old &&
>>> +              end_of_old != old_path &&
>>> +              end_of_new != new_path)
>>> +               ; /* Do nothing; all in the while loop */
>>
>> We have to compare manually as we'd want to find
>> the first non-equal and there doesn't seem to be a good
>> library function for that.
>>
>> Assuming many repos are UTF8 (including in their paths),
>> how does this work with display characters longer than one char?
>> It should be fine as we cut at the slash?
>
> Oh, UTF-8.  Ugh.
> Can UTF-8 characters, other than '/', have a byte whose value matches
> (unsigned char)('/')?  If so, then I'll need to figure out how to do
> utf-8 character parsing.  Anyone have pointers?

Oh right we are always cutting at '/', which hex 2F, so we cannot split
a codepoint in half accidentally (finding the slash inside a codepoint).

And renaming a directory from one utf8 codepoint to another, which
have the same prefix is not an issue at this layer, too.
(Think of abc -> abd just all of abc/d in one code point, but there
but even for multi code points/ASCII we repeat the prefix when
printing the rename)

>> So the first loop is about counting the number of files in each directory
>> that are renamed and the later while loop is about mapping them?
>
> Close; would adding the following comment at the top of the function help?
>
>     /*
>      * Typically, we think of a directory rename as all files from a
>      * certain directory being moved to a target directory.  However,
>      * what if someone first moved two files from the original
>      * directory in one commit, and then renamed the directory
>      * somewhere else in a later commit?  At merge time, we just know
>      * that files from the original directory went to two different
>      * places, and that the bulk of them ended up in the same place.
>      * We want each directory rename to follow the bulk of the files
>      * from that directory.  This function exists to find where the
>      * bulk of the files went.
>      *
>      * The first loop below simply iterates through the list of
>      * renames, adding up all the rename source->target locations with
>      * a count.
>      *
>      * The second loop compares the count for each renamed directory
>      * and declares the "winning" target location.
>      */
>
> Is there any part that remains unclear with that comment?  (Also, is
> that comment too long?)

Sounds good to me. Thanks!


>
>>> +               /* Strings were xstrndup'ed before inserting into string-list,
>>> +                * so ask string_list to remove the entries for us.
>>> +                */
>>
>> comment style.
>
> Thanks.
>
>>> +               entry->possible_new_dirs.strdup_strings = 1;
>>
>> Why do we need to set strdup_strings here (so late in the
>> game, we are about to clear it?) Could we set it earlier?
>>
>> Or rather have the string list duplicate the strings instead of
>> get_renamed_dir_portion ?
>
> We didn't strdup the original string (a file path) as-is, we
> strndup'ed a subset of the original string (just the relevant portion
> of the directory).  Since we already had to allocate a special string
> for that, making the string list duplicate the strings would have
> caused an extra unnecessary allocation and required us to free the
> memory allocated by get_renamed_dir_portion manually.  So, we do need
> this here.
>
> Does this comment make it clearer?:
>
>         /*
>          * The relevant directory sub-portion of the original full
>          * filepaths were xstrndup'ed before inserting into
>          * possible_new_dirs, and instead of manually iterating the
>          * list and free'ing each, just lie and tell
>          * possible_new_dirs that it did the strdup'ing so that it
>          * will free them for us.
>          */
>         entry->possible_new_dirs.strdup_strings = 1;
>         string_list_clear(&entry->possible_new_dirs, 1);

Phrased this way, it makes sense.

Thanks,
Stefan
