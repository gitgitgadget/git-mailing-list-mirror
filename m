Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F2332047F
	for <e@80x24.org>; Wed, 27 Sep 2017 16:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752436AbdI0Qqd (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Sep 2017 12:46:33 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:55520 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752425AbdI0Qqc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2017 12:46:32 -0400
Received: by mail-io0-f177.google.com with SMTP id z187so16153917ioz.12
        for <git@vger.kernel.org>; Wed, 27 Sep 2017 09:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=5Drp0H6hh/fwH2/RRE5JDI53lq95A4mrQ6C7YeSdmg8=;
        b=f8lazCElopxogWBovBf+8qryuSZrO2t51hygO2aRgCGdBIWfnJAJaad6wZyR2x9cvl
         0/cYjTl0g2e2QBkJBHyiFjaJqnKyC4f8zwH6yYjRk792mXXdhHr8Ho7lmRLm3XCQmb9Q
         o/jklTZN+Pgj7vS2rpwGTVnJ9HeoG9w8Iqw1laq/ltv9WbMQch0l9W5BUzW0EENqlQsw
         URg2NcrKqvRvp9BXy9CUu8bzqOem6WFqhaqE6hevtT9KWgWFSq+bujxOLqDXbnSbdjEc
         58Qj5h3yk3mbw2bW+V95Csi+aJ+03K6WMh2LMwjw3RGupeqH1OHrPfMOsG+fPvJJlKCD
         mRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=5Drp0H6hh/fwH2/RRE5JDI53lq95A4mrQ6C7YeSdmg8=;
        b=Oi9pZzJCZIZ5vmLKsVvFozAeb73jkxRXEq5KpO5Yl79k+8PMw1QBwKQkOpQgj1X884
         tpx9pPzKj8AJ8QoOTSvi7lC+YsKP7NbdGzAJdzGkDlu67iBjqO+d+rIr8Tgx6t641o95
         dVNFE/8gTW2yWxZxbU1UxLw+w6iAnx8qUbWg8CfcG5Rudd7PF+ux2C6A44Z6rd8M47MV
         ZpSLN7t+U8Jn1KqDI+Qy82B0m6XPT+0I9kwhRSlU5U5C996Lb9/LRjJrRIYzV+UeAmU3
         kf8oeNg1gtsk4lWsI2wMDiH6D4O85b8r2RXNZnug4pQz/7z14pvQMFFrvcAZvHMeLzu2
         zH9g==
X-Gm-Message-State: AMCzsaX6lhXSKeuUSWsZHk41hAf8F3bJaVDAIvwbZNZj+MRVe/Z0i/pL
        uxpui+zrV9z1mY2eybZ3BMajX4jNon9Ypj6wNnE=
X-Google-Smtp-Source: AOwi7QAgUq0JQk7d6vrdhhnCX305RX9j6Dg1g1tK4r5wU3J3xfvYfoPdd+w4L6hE6VIQvBL6eCCbtNcKp5Nl2TdiM88=
X-Received: by 10.107.30.77 with SMTP id e74mr992822ioe.277.1506530791233;
 Wed, 27 Sep 2017 09:46:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.125.142 with HTTP; Wed, 27 Sep 2017 09:46:30 -0700 (PDT)
In-Reply-To: <20170919104553.494d7d3b@twelve2.svl.corp.google.com>
References: <20170916080731.13925-1-chriscool@tuxfamily.org>
 <20170916080731.13925-10-chriscool@tuxfamily.org> <20170919104553.494d7d3b@twelve2.svl.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 27 Sep 2017 18:46:30 +0200
Message-ID: <CAP8UFD2D2NkKKy9oT-1Mwe0Gq6=UG+15t9GENKKbV-PbRf3Kkw@mail.gmail.com>
Subject: Re: [PATCH v6 09/40] Add initial external odb support
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 19, 2017 at 7:45 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> I wonder if it's better to get a change like this (PATCH v6 09/40 and
> any of the previous patches that this depends on) in and then build on
> it rather than to review the whole patch set at a time.  This would
> reduce ripple effects (of needing to change later patches in a patch set
> multiple times unnecessarily) and help collaboration (in that multiple
> people can write patches, since the foundation would already be laid).

I am ok to split the patch series, but I am not sure that 01/40 to
09/40 is the right range for the first patch series.
I would say that 01/40 to 07/40 is better as it can be seen as a
separate refactoring.

> The same concerns about fsck apply, but that shouldn't be a problem,
> since this patch provides the same internal API as mine ("get" function
> taking in a single hash, and "have" function taking in a single hash) so
> it shouldn't be too difficult to adapt my fsck and gc patches [1]. (I
> can do that if necessary.)
>
> [1] https://public-inbox.org/git/20170915134343.3814dc38@twelve2.svl.corp.google.com/

Great! I would be happy with such an outcome.

> One possible issue (with committing something early) is that later work
> (for example, a fast long-running process protocol) will make the
> earlier work (for example, here, a simple single-shot protocol)
> obsolete, while saddling us with the necessity of maintaining the
> earlier one. To that end, if we want to start with the support for a
> hook, a better approach might be to only code the fast long-running
> process protocol, and put a wrapper script in contrib/ that can wrap a
> single-shot process in a long-running process.

I don't think single-shot processes would be a huge burden, because
the code is simpler, and because for example for filters we already
have single shot and long-running processes and no one complains about
that. It's code that is useful as it makes it much easier for people
to do some things (see the clone bundle example).

In fact in Git development we usually start to by first implementing
simpler single-shot solutions, before thinking, when the need arise,
to make it faster. So a perhaps an equally valid opinion could be to
first only submit the patches for the single-shot protocol and later
submit the rest of the series when we start getting feedback about how
external odbs are used.

And yeah I could change the order of the patch series to implement the
long-running processes first and the single-shot process last, so that
it could be possible to first get feedback about the long-running
processes, before we decide to merge or not the single-shot stuff, but
I don't think it would look like the most logical order.

> And another possible issue is that we design ourselves into a corner.
> Thinking about the use cases that I know about (the Android use case and
> the Microsoft GVFS use case), I don't think we are doing that - for
> Android, this means that large blob metadata needs to be part of the
> design (and this patch series does provide for that), and for Microsoft
> GVFS, "get" is relatively cheap, so a configuration option to not invoke
> "have" first when loading a missing object might be sufficient.

If the helper does not advertise the "have" capability, the "have"
instruction will not be sent to the helper, so the current design is
already working for that case.

> As for the design itself (including fetch and clone), it differs from my
> patches (linked above as [1]) in that mine is self-contained (requiring
> only an updated Git server and Git client) whereas this, as far as I can
> tell, requires an external process and some measure of coordination
> between the administrator of the server and the client user (for
> example, the client must have the same ODB mechanism as the server, if
> not, the server might omit certain blobs that the client does not know
> how to fetch).

Yeah, your design is more self contained, but it doesn't handle as
many use cases.

> And I think that my design can be extended to support a use case in
> which, for example, blobs corresponding to a certain type of filename
> (defined by a glob like in gitattributes) can be excluded during
> fetch/clone, much like --blob-max-bytes, and they can be fetched either
> through the built-in mechanism or through a custom hook.

Sure, we could probably rebuild something equivalent to what I did on
top of your design.
My opinion though is that if we want to eventually get to the same
goal, it is better to first merge something that get us very close to
the end goal and then add some improvements on top of it.

> For those reasons, I still lean towards my design, but if we do want to
> go with this design, here are my comments about this patch...
>
> First of all:
>  - You'll probably need to add a repository extension.

I am ok to add one if this is needed, but I am not sure it is, as the
repository format does not really change.

>  - I get compile errors when I "git am" these onto master. I think
>    '#include "config.h"' is needed in some places.

It's strange because I get no compile errors even after a "make clean"
from my branch.
Could you show the actual errors?

> On Sat, 16 Sep 2017 10:07:00 +0200
> Christian Couder <christian.couder@gmail.com> wrote:
>
>> The external-odb.{c,h} files contains the functions that are
>> called by the rest of Git from "sha1_file.c".
>>
>> The odb-helper.{c,h} files contains the functions to
>> actually implement communication with the external scripts or
>> processes that will manage external git objects.
>>
>> For now only script mode is supported, and only the 'have' and
>> 'get_git_obj' instructions are supported.
>
> This "have", as I see from this commit, is more like a "list" command in
> that it lists all hashes that it knows about, and does not check if a
> given hash exists.

Yes.

>> +static struct odb_helper *helpers;
>> +static struct odb_helper **helpers_tail = &helpers;
>
> This could be done with the helpers in list.h instead.

Yeah, but list.h is for a doubly-linked list and I am not sure we need that.

>> +int external_odb_get_object(const unsigned char *sha1)
>> +{
>> +     struct odb_helper *o;
>> +     const char *path;
>> +
>> +     if (!external_odb_has_object(sha1))
>> +             return -1;
>> +
>> +     path = sha1_file_name_alt(external_odb_root(), sha1);
>
> If the purpose of making these functions global in the previous patch is
> just for temporary names, I don't think it's necessary for them to be
> global. Just concatenate the hex SHA1 to external_odb_root()?

In my opinion it is cleaner to make a few functions that are needed
global rather than have some custom code, even if the custom code is
small.
(And I guess that Peff who wrote the above agrees.)

>>  /* Returns 1 if we have successfully freshened the file, 0 otherwise. */
>> @@ -667,7 +684,7 @@ static int check_and_freshen_nonlocal(const unsigned char *sha1, int freshen)
>>               if (check_and_freshen_file(path, freshen))
>>                       return 1;
>>       }
>> -     return 0;
>> +     return external_odb_has_object(sha1);
>>  }
>>
>>  static int check_and_freshen(const unsigned char *sha1, int freshen)
>> @@ -824,6 +841,9 @@ static int stat_sha1_file(const unsigned char *sha1, struct stat *st,
>>                       return 0;
>>       }
>>
>> +     if (!external_odb_get_object(sha1) && !lstat(*path, st))
>> +             return 0;
>> +
>>       return -1;
>>  }
>>
>> @@ -859,7 +879,14 @@ static int open_sha1_file(const unsigned char *sha1, const char **path)
>>       if (fd >= 0)
>>               return fd;
>>
>> -     return open_sha1_file_alt(sha1, path);
>> +     fd = open_sha1_file_alt(sha1, path);
>> +     if (fd >= 0)
>> +             return fd;
>> +
>> +     if (!external_odb_get_object(sha1))
>> +             fd = open_sha1_file_alt(sha1, path);
>> +
>> +     return fd;
>>  }
>
> Any reason why you prefer to update the loose object functions than to
> update the generic one (sha1_object_info_extended)? My concern with just
> updating the loose object functions was that a caller might have
> obtained the path by iterating through the loose object dirs, and in
> that case we shouldn't query the external ODB for anything.

You are thinking about fsck or gc?
Otherwise I don't think it would be clean to iterate through loose object dirs.

>> +ALT_SOURCE="$PWD/alt-repo/.git"
>> +export ALT_SOURCE
>> +write_script odb-helper <<\EOF
>> +GIT_DIR=$ALT_SOURCE; export GIT_DIR
>> +case "$1" in
>> +have)
>> +     git cat-file --batch-check --batch-all-objects |
>> +     awk '{print $1 " " $3 " " $2}'
>> +     ;;
>> +get_git_obj)
>> +     cat "$GIT_DIR"/objects/$(echo $2 | sed 's#..#&/#')
>> +     ;;
>> +esac
>> +EOF
>> +HELPER="\"$PWD\"/odb-helper"
>
> Thanks for the clear test. It is very obvious that "have" returns a list
> of objects, and "get_git_obj" returns the compressed loose object with
> the Git loose object header included.

Happy that you like how simple helpers can be with single-shot processes ;-)

>> +test_expect_success 'setup alternate repo' '
>> +     git init alt-repo &&
>> +     (cd alt-repo &&
>> +      test_commit one &&
>
> Probably better written as "test_commit -C alt-repo one".

Ok, I will use that .

>> +      test_commit two
>> +     ) &&
>> +     alt_head=`cd alt-repo && git rev-parse HEAD`
>
> I think the style is to use $() and "git -C alt-repo rev-parse HEAD".

Ok, I will change that.

Thanks,
Christian.
