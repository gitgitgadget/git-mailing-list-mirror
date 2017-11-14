Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE6E81F43C
	for <e@80x24.org>; Tue, 14 Nov 2017 20:33:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755416AbdKNUd6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 15:33:58 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:55361 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754839AbdKNUd4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 15:33:56 -0500
Received: by mail-qt0-f181.google.com with SMTP id v41so28918681qtv.12
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 12:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6da7DseR1oX+kFw3sJK6OEC/k1ggAY8aRUdmwckwEgE=;
        b=h6muhx2jAddRpBB7HW0sriiAWVpix5Dcwk5WoDvfJVCp0bpqILYptL34jrPQucmxRi
         UtDNBQh5GIFooS1QTiMF4cO7gj02KtAkjT3FNBjc2CY153VERzFmmkUjYrA55xJ8EQNq
         82h5hxWuvUciqYnFesNC86kX/XnCb4+ACEWwWzmb+Bz6ijFjXLLQ9QofaddJ74XiVyA3
         D+MYE/lCBygCgsa//Eb91iBq0kILBfH/cAdaNbPSuOEfLOBw8H6WE83qWj58Go2TsJme
         gN/LibnbMOANdDHysh4HDGs4kTgGUZnNUtSCsfy7Gb6zPg3m/TRFvJXGZHJsu8IHnLZU
         vjOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6da7DseR1oX+kFw3sJK6OEC/k1ggAY8aRUdmwckwEgE=;
        b=T3a9I78LO7Vgg7q99GDcAK0yWMdCYVXk90IPdAfoFQlNn9s9mPKEWWDq+7xgmrVAl3
         gXPXjscgwJAPn3fhccQ24xN39vOIYZ8GsvMgA/32aFUY4CI4MKWeC92Tjr7LdrGRvoxA
         WcuZmopnahoGI6cqSOwgS1828smQZ2tCLsmpitSK5cqL6JNmitkH4AmUVMe1RzTvfoGF
         X2EZ1GeOuoIYdph7A3vnzlKoauT6GhLHhRc4CmpKl1h87fFyNg+VXlwxbxvp9AvYOrvy
         ZL8TVw6iHV0jAhfG84Rzxbiaj0gsLqaSXXatdzLJnjVvHDHHux6A80Nw2g4riM9doAuu
         4NLg==
X-Gm-Message-State: AJaThX6zb+eVh/bXe01rsHmXfMNgcVIUfl09KWQFM2R8qIybLe3TPDJr
        4JH5zfSbuJ7tnFK1jlbWHQUMg1W71sstQmBc2uiltu6IFbw=
X-Google-Smtp-Source: AGs4zMb4iy5KgNsyyozRrUbC7Ktp0x2AhUU6Zp4ktTz2oswTNL3r9KMAxq7kzL9c+QJKLPGIAD2GaFSSe98kvRxbaYo=
X-Received: by 10.55.125.196 with SMTP id y187mr22763270qkc.180.1510691635311;
 Tue, 14 Nov 2017 12:33:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.96.118 with HTTP; Tue, 14 Nov 2017 12:33:54 -0800 (PST)
In-Reply-To: <20171110190550.27059-12-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-12-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Nov 2017 12:33:54 -0800
Message-ID: <CAGZ79kYCDBFwMhW4Qgwhomiv4kKRWS53cjMLuRG1NxrzULYwgg@mail.gmail.com>
Subject: Re: [PATCH 11/30] directory rename detection: testcases exploring
 possibly suboptimal merges
To:     Elijah Newren <newren@gmail.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 10, 2017 at 11:05 AM, Elijah Newren <newren@gmail.com> wrote:
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  t/t6043-merge-rename-directories.sh | 371 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 371 insertions(+)
>
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index 115d0d2622..bdfd943c88 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -1683,4 +1683,375 @@ test_expect_failure '7e-check: transitive rename in rename/delete AND dirs in th
>         test $(git hash-object y/d~C^0) = $(git rev-parse A:x/d)
>  '
>
> +
> +###########################################################################
> +# SECTION 8: Suboptimal merges
> +#
> +# As alluded to in the last section, the ruleset we have built up for
> +# detecting directory renames unfortunately has some special cases where it
> +# results in slightly suboptimal or non-intuitive behavior.  This section
> +# explores these cases.
> +#
> +# To be fair, we already had non-intuitive or suboptimal behavior for most
> +# of these cases in git before introducing implicit directory rename
> +# detection, but it'd be nice if there was a modified ruleset out there
> +# that handled these cases a bit better.
> +###########################################################################
> +
> +# Testcase 8a, Dual-directory rename, one into the others' way
> +#   Commit A. x/{a,b},   y/{c,d}
> +#   Commit B. x/{a,b,e}, y/{c,d,f}
> +#   Commit C. y/{a,b},   z/{c,d}
> +#
> +# Possible Resolutions:
> +#   Previous git: y/{a,b,f},   z/{c,d},   x/e
> +#   Expected:     y/{a,b,e,f}, z/{c,d}
> +#   Preferred:    y/{a,b,e},   z/{c,d,f}

it might be tricky in the future to know what "previous git" is;
"Previous git" means without directory renames enabled;

"expected" means we expect the algorithm presented in this series to produce
this output, preferred is what we actually expect.


> +#
> +# Note: Both x and y got renamed and it'd be nice to detect both, and we do
> +# better with directory rename detection than git did previously, but the
> +# simple rule from section 5 prevents me from handling this as optimally as
> +# we potentially could.

which were:

   If a subset of to-be-renamed files have a file or directory in the way,
   "turn off" the directory rename for those specific sub-paths, falling
   back to old handling.  But, sadly, see testcases 8a and 8b.

The tricky part is y in this example as x,y "swapped" its content in C,
and moved 'old y content' to the new z/.

Makes sense, but I agree it might be painful to debug such a case
from a users point of view.

> +
> +# Testcase 8b, Dual-directory rename, one into the others' way, with conflicting filenames
> +#   Commit A. x/{a_1,b_1},     y/{a_2,b_2}
> +#   Commit B. x/{a_1,b_1,e_1}, y/{a_2,b_2,e_2}
> +#   Commit C. y/{a_1,b_1},     z/{a_2,b_2}
> +#
> +# Possible Resolutions:
> +#   Previous git: y/{a_1,b_1,e_2}, z/{a_2,b_2}, x/e_1
> +#   Scary:        y/{a_1,b_1},     z/{a_2,b_2}, CONFLICT(add/add, e_1 vs. e_2)
> +#   Preferred:    y/{a_1,b_1,e_1}, z/{a_2,b_2,e_2}

It may be common to have sub directories with the same path having different
blobs, e.g. when having say multiple hardware configurations in different sub
directories configured. Then renaming becomes a pain when they overlap.

> +# Note: Very similar to 8a, except instead of 'e' and 'f' in directories x and
> +# y, both are named 'e'.  Without directory rename detection, neither file
> +# moves directories.  Implment directory rename detection suboptimally, and

Implement

> +# you get an add/add conflict, but both files were added in commit B, so this
> +# is an add/add conflict where one side of history added both files --
> +# something we can't represent in the index.  Obviously, we'd prefer the last
> +# resolution, but our previous rules are too coarse to allow it.  Using both
> +# the rules from section 4 and section 5 save us from the Scary resolution,
> +# making us fall back to pre-directory-rename-detection behavior for both
> +# e_1 and e_2.

ok, so add "Expected" as well? (repeating "Previous git", or so?)

> +
> +# Testcase 8c, rename+modify/delete
> +#   (Related to testcases 5b and 8d)
> +#   Commit A: z/{b,c,d}
> +#   Commit B: y/{b,c}
> +#   Commit C: z/{b,c,d_modified,e}
> +#   Expected: y/{b,c,e}, CONFLICT(rename+modify/delete: x/d -> y/d or deleted)
> +#
> +#   Note: This testcase doesn't present any concerns for me...until you
> +#         compare it with testcases 5b and 8d.  See notes in 8d for more
> +#         details.

Makes sense.

> +# Testcase 8d, rename/delete...or not?
> +#   (Related to testcase 5b; these may appear slightly inconsistent to users;
> +#    Also related to testcases 7d and 7e)

> +#   Commit A: z/{b,c,d}
> +#   Commit B: y/{b,c}
> +#   Commit C: z/{b,c,d,e}
> +#   Expected: y/{b,c,e}

Why this?
* d is deleted in B and not found in the result
* the rename detection also worked well in z->y  for adding e

I do not see the confusion, yet.

> +#   Note: It would also be somewhat reasonable to resolve this as
> +#             y/{b,c,e}, CONFLICT(rename/delete: x/d -> y/d or deleted)
> +#   The logic being that the only difference between this testcase and 8c
> +#   is that there is no modification to d.  That suggests that instead of a
> +#   rename/modify vs. delete conflict, we should just have a rename/delete
> +#   conflict, otherwise we are being inconsistent.
> +#
> +#   However...as far as consistency goes, we didn't report a conflict for
> +#   path d_1 in testcase 5b due to a different file being in the way.  So,
> +#   we seem to be forced to have cases where users can change things
> +#   slightly and get what they may perceive as inconsistent results.  It
> +#   would be nice to avoid that, but I'm not sure I see how.
> +#
> +#   In this case, I'm leaning towards: commit B was the one that deleted z/d
> +#   and it did the rename of z to y, so the two "conflicts" (rename vs.
> +#   delete) are both coming from commit B, which is non-sensical.  Conflicts
> +#   during merging are supposed to be about opposite sides doing things
> +#   differently.

  "Sensical has not yet become an "official" word in the English language, which
  would be why you can't use it. Nonsense is a word, therefore nonsensical can
  used to describe something of nonsense. However, sense has different meanings
  and doesn't have an adjective for something of sense"

from https://english.stackexchange.com/questions/38582/antonym-of-nonsensical
I don't mind it, the spell checker just made me go on a detour. Maybe illogical?

> +# Testcase 8e, Both sides rename, one side adds to original directory
> +#   Commit A: z/{b,c}
> +#   Commit B: y/{b,c}
> +#   Commit C: w/{b,c}, z/d
> +#
> +# Possible Resolutions:
> +#   Previous git: z/d, CONFLICT(z/b -> y/b vs. w/b), CONFLICT(z/c -> y/c vs. w/c)
> +#   Expected:     y/d, CONFLICT(z/b -> y/b vs. w/b), CONFLICT(z/c -> y/c vs. w/c)
> +#   Preferred:    ??
> +#
> +# Notes: In commit B, directory z got renamed to y.  In commit C, directory z
> +#        did NOT get renamed; the directory is still present; instead it is
> +#        considered to have just renamed a subset of paths in directory z
> +#        elsewhere.  Therefore, the directory rename done in commit B to z/
> +#        applies to z/d and maps it to y/d.
> +#
> +#        It's possible that users would get confused about this, but what
> +#        should we do instead?   Silently leaving at z/d seems just as bad or
> +#        maybe even worse.  Perhaps we could print a big warning about z/d
> +#        and how we're moving to y/d in this case, but when I started thinking
> +#        abouty the ramifications of doing that, I didn't know how to rule out
> +#        that opening other weird edge and corner cases so I just punted.

s/about/abouty

It sort of makes sense from a users POV.
