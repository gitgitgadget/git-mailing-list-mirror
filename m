Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6152920291
	for <e@80x24.org>; Tue, 14 Nov 2017 00:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751151AbdKNAPa (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 19:15:30 -0500
Received: from mail-qt0-f170.google.com ([209.85.216.170]:53770 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751028AbdKNAP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 19:15:29 -0500
Received: by mail-qt0-f170.google.com with SMTP id n61so21837456qte.10
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 16:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UIev/8UMs52zp+SrtyW9EjQZ1zMLTktlKm84zp7KC08=;
        b=ABjQMzU/MA2S/KHvb8hx1vC3X1szIGhjR+GQgIG2Lfnl/1UW/AFsR+YLiBDRT1UcPe
         PLcIlp+OfAO0UI++vT5NH3Gb+8e4l68jj601w4i7SY+0P+UW6IABEXZq+oiss3slqloM
         idKB0VZeCUPdRcDRL9GJ3NNb8N1QpifZTo0/fBTIgKgtJe99f3DOF4gZwxS83AqpI0gu
         PH/hokYyPkUt+73ltAfEJDRMv3iPhs+WlGtEcUGR6ZQG62ZwciQZqDtUdv4QTCnwfxbR
         yqQjAur1qVWw1jLjCmW+cusSK52RbOLMu3637gC4lxf78BZ5dO1VCyxnpwHDusvdw/ID
         zE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UIev/8UMs52zp+SrtyW9EjQZ1zMLTktlKm84zp7KC08=;
        b=r0ET7and3EaartCffdvAdaC76SfhqNnoL1ooxFL5lwzK/+yW2x/1A2FYhi5hAB7WrP
         won3OUvDqnQccapfo/TTVgesBt7Ft8DEWX3WstBJY7eoC0QYvbYDD8FqJ799Ca+ba3I8
         gnB5BFsxt6aVR1mS5SdBYJBZV8rukVNU+UWmTzYwcN0aFSFFlNcoHKV1kb1pMRU3F5oL
         bnJ2qTXg9oNFmnUjJJmSk/lvNjDmFNJwQY2+7gNNY+YBc38zLj/leOhh5sqrOf3058nQ
         7I2fiEW6pCaKkF/KkVVMO3SU6xHTn7SJ2xjngyAUGknx+sxY/Ig4DKZ3OIlMbqzuPEYH
         RGJA==
X-Gm-Message-State: AJaThX72xLYDv6+D6RvOtrv61zieajQQscP0KzyR8gx8qbbbiwliRcab
        JnSJtuAtfF1wj5W3uBb+VzgI999niszBmhdRs7Hd1M+8
X-Google-Smtp-Source: AGs4zMZJwxNN7hdeuCz0CK2LiHTTt4wVnXPkHQ84Pu0WVRQt14wTcgCB1kfqQJn9WMHctwcw+12pN8rU9d1URHpbHTQ=
X-Received: by 10.237.34.201 with SMTP id q9mr17149494qtc.198.1510618528057;
 Mon, 13 Nov 2017 16:15:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 16:15:27 -0800 (PST)
In-Reply-To: <20171110190550.27059-9-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-9-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 16:15:27 -0800
Message-ID: <CAGZ79kana0_9N+gG+m2BT5Tnu_q4MC=WSTuvtwkdeD_Wn70ydA@mail.gmail.com>
Subject: Re: [PATCH 08/30] directory rename detection: files/directories in
 the way of some renames
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
>  t/t6043-merge-rename-directories.sh | 303 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 303 insertions(+)
>
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index ec054b210a..d15153c652 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -750,4 +750,307 @@ test_expect_success '4a-check: Directory split, with original directory still pr
>  #   detection.)  But, sadly, see testcase 8b.
>  ###########################################################################
>
> +
> +###########################################################################
> +# SECTION 5: Files/directories in the way of subset of to-be-renamed paths
> +#
> +# Implicitly renaming files due to a detected directory rename could run
> +# into problems if there are files or directories in the way of the paths
> +# we want to rename.  Explore such cases in this section.
> +###########################################################################
> +
> +# Testcase 5a, Merge directories, other side adds files to original and target
> +#   Commit A: z/{b,c},       y/d
> +#   Commit B: z/{b,c,e_1,f}, y/{d,e_2}
> +#   Commit C: y/{b,c,d}
> +#   Expected: z/e_1, y/{b,c,d,e_2,f} + CONFLICT warning
> +#   NOTE: While directory rename detection is active here causing z/f to
> +#         become y/f, we did not apply this for z/e_1 because that would
> +#         give us an add/add conflict for y/e_1 vs y/e_2.  This problem with
> +#         this add/add, is that both versions of y/e are from the same side
> +#         of history, giving us no way to represent this conflict in the
> +#         index.

Makes sense.

> +# Testcase 5b, Rename/delete in order to get add/add/add conflict
> +#   (Related to testcase 8d; these may appear slightly inconsistent to users;
> +#    Also related to testcases 7d and 7e)
> +#   Commit A: z/{b,c,d_1}
> +#   Commit B: y/{b,c,d_2}
> +#   Commit C: z/{b,c,d_1,e}, y/d_3
> +#   Expected: y/{b,c,e}, CONFLICT(add/add: y/d_2 vs. y/d_3)
> +#   NOTE: If z/d_1 in commit C were to be involved in dir rename detection, as
> +#         we normaly would since z/ is being renamed to y/, then this would be
> +#         a rename/delete (z/d_1 -> y/d_1 vs. deleted) AND an add/add/add
> +#         conflict of y/d_1 vs. y/d_2 vs. y/d_3.  Add/add/add is not
> +#         representable in the index, so the existence of y/d_3 needs to
> +#         cause us to bail on directory rename detection for that path, falling
> +#         back to git behavior without the directory rename detection.


> +
> +# Testcase 5c, Transitive rename would cause rename/rename/rename/add/add/add
> +#   (Directory rename detection would result in transitive rename vs.
> +#    rename/rename(1to2) and turn it into a rename/rename(1to3).  Further,
> +#    rename paths conflict with separate adds on the other side)
> +#   (Related to testcases 3b and 7c)
> +#   Commit A: z/{b,c}, x/d_1
> +#   Commit B: y/{b,c,d_2}, w/d_1
> +#   Commit C: z/{b,c,d_1,e}, w/d_3, y/d_4
> +#   Expected: A mess, but only a rename/rename(1to2)/add/add mess.  Use the
> +#             presence of y/d_4 in C to avoid doing transitive rename of
> +#             x/d_1 -> z/d_1 -> y/d_1, so that the only paths we have at
> +#             y/d are y/d_2 and y/d_4.  We still do the move from z/e to y/e,
> +#             though, because it doesn't have anything in the way.

Missing the expected state, only the explanation is given.


> +# Testcase 5d, Directory/file/file conflict due to directory rename
> +#   Commit A: z/{b,c}
> +#   Commit B: y/{b,c,d_1}
> +#   Commit C: z/{b,c,d_2,f}, y/d/e
> +#   Expected: y/{b,c,d/e,f}, z/d_2, CONFLICT(file/directory), y/d_1~HEAD
> +#   Note: The fact that y/d/ exists in C makes us bail on directory rename
> +#         detection for z/d_2, but that doesn't prevent us from applying the
> +#         directory rename detection for z/f -> y/f.

Makes sense.

> +
> +###########################################################################
> +# Rules suggested by section 5:
> +#
> +#   If a subset of to-be-renamed files have a file or directory in the way,
> +#   "turn off" the directory rename for those specific sub-paths,

Makes sense.

>  falling
> +#   back to old handling.  But, sadly, see testcases 8a and 8b.

You seem to be hinting at these all the time.
