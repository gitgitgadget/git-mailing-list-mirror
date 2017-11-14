Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E17920291
	for <e@80x24.org>; Tue, 14 Nov 2017 00:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbdKNAZy (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 19:25:54 -0500
Received: from mail-qt0-f176.google.com ([209.85.216.176]:57252 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751074AbdKNAZx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 19:25:53 -0500
Received: by mail-qt0-f176.google.com with SMTP id r39so5581577qtr.13
        for <git@vger.kernel.org>; Mon, 13 Nov 2017 16:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=AkgvVYdzuJgmzSxLGHVALBRYyQYby5wlAPF47gllVsc=;
        b=OAZX5BZZiZ2hI68nV8GBp6HZqPf7S4PARHBDXIO6oY0Wj/rIt9UmoE54pDlsVKqE+P
         HrN3fOSq0SuMVFR+NoTs45bOdVi+Equq8JmE7RTkk6YBceTJblbDZNrLUCRlbMgZxAfb
         on11aI2plxziz1qxcRTPvBKEmtiDM8E/TnFS8MK1Ul6m2cHWOAbrmdsa+4n/N9XXD6zZ
         6eKKY9MxNlC54JYMd+BiqfHi6pDfhA6IRaBOZgKkvMIs8C0BKICH5ELH/NYmM/OiMDlA
         FHLwHh8xJ3LB0OvLgoI95ESa5NC7oJNFUZXN3q9p4PHDTYRDlMi/ETn6Ieb3M3YHEzs1
         +v5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=AkgvVYdzuJgmzSxLGHVALBRYyQYby5wlAPF47gllVsc=;
        b=X2phw/kz8UEw5v1t7u4CD2e7jicY67evlwROI9O0a4jAlxZcFb7E2aMwvREYZ82Rt6
         LxmJntGx9S/Jx5FvZc1jNfJp9s6MbCqUKuOWgBZrxdnxmgdHm2VkkxZmy80cbZJ1drYo
         vG/w0yNlJPPDWtdjnSIxTtk9Az6p9fU27j6Sg6ReOKZwqRjUcY75NgOE8NW4wrqKzmLV
         sRykBN8WS4c++iZKeMZwwxNxy/P2O4Y2/e6O0wcLM67NIfPAz6gpSMwBxLg4/FoGtENX
         6dSqdgdZVrhBo2lTPoQsbjpn8sIjkRMi23IVgAyX1RSJFCxeTeH0RtAAMobPFfah+BW5
         mJMg==
X-Gm-Message-State: AJaThX4LQv5kEGpJftNk3qbmgIMxudahaYoH+5g/Oe0CLWuoTGtS2Rq0
        FBCzdftNpntUKgyPbZVcbOORK9MC9tvpqCMaoGAvow==
X-Google-Smtp-Source: AGs4zMbIdpGGrJO1oUp4VcneuWaIi2OPz333BD43pe0CuYTG79qJxWfIjGSnZAMmALXLykPflVhpxlpK8a6E7EaMEfc=
X-Received: by 10.200.55.75 with SMTP id p11mr17029274qtb.298.1510619152089;
 Mon, 13 Nov 2017 16:25:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.102.70 with HTTP; Mon, 13 Nov 2017 16:25:51 -0800 (PST)
In-Reply-To: <20171110190550.27059-10-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com> <20171110190550.27059-10-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 13 Nov 2017 16:25:51 -0800
Message-ID: <CAGZ79kbsQqAFGFVN3dOnSAFuPishF3PGS7_go+53T5Oa-4qWiA@mail.gmail.com>
Subject: Re: [PATCH 09/30] directory rename detection: testcases checking
 which side did the rename
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
>  t/t6043-merge-rename-directories.sh | 283 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 283 insertions(+)
>
> diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
> index d15153c652..157299105f 100755
> --- a/t/t6043-merge-rename-directories.sh
> +++ b/t/t6043-merge-rename-directories.sh
> @@ -1053,4 +1053,287 @@ test_expect_failure '5d-check: Directory/file/file conflict due to directory ren
>  #   back to old handling.  But, sadly, see testcases 8a and 8b.
>  ###########################################################################
>
> +
> +###########################################################################
> +# SECTION 6: Same side of the merge was the one that did the rename
> +#
> +# It may sound obvious that you only want to apply implicit directory
> +# renames to directories if the _other_ side of history did the renaming.
> +# If you did make an implementation that didn't explicitly enforce this
> +# rule, the majority of cases that would fall under this section would
> +# also be solved by following the rules from the above sections.  But
> +# there are still a few that stick out, so this section covers them just
> +# to make sure we also get them right.
> +###########################################################################
> +
> +# Testcase 6a, Tricky rename/delete
> +#   Commit A: z/{b,c,d}
> +#   Commit B: z/b
> +#   Commit C: y/{b,c}, z/d
> +#   Expected: y/b, CONFLICT(rename/delete, z/c -> y/c vs. NULL)
> +#   Note: We're just checking here that the rename of z/b and z/c to put
> +#         them under y/ doesn't accidentally catch z/d and make it look like
> +#         it is also involved in a rename/delete conflict.
> +

> +
> +# Testcase 6b, Same rename done on both sides
> +#   (Related to testcases 6c and 8e)
> +#   Commit A: z/{b,c}
> +#   Commit B: y/{b,c}
> +#   Commit C: y/{b,c}, z/d

Missing expected state

> +#   Note: If we did directory rename detection here, we'd move z/d into y/,
> +#         but C did that rename and still decided to put the file into z/,
> +#         so we probably shouldn't apply directory rename detection for it.

correct. Also we don't want to see a rename/rename conflict (obviously).

If we have

    Commit A: z/{b_1,c}
    Commit B: y/{b_2,c}
    Commit C: y/{b_3,c}, z/d

then we'd produce a standard file merge (which may or may not result
in conflict,
depending on touched lines) for y/b_{try-resolve}

> +
> +# Testcase 6c, Rename only done on same side
> +#   (Related to testcases 6b and 8e)
> +#   Commit A: z/{b,c}
> +#   Commit B: z/{b,c} (no change)
> +#   Commit C: y/{b,c}, z/d
> +#   Expected: y/{b,c}, z/d
> +#   NOTE: Seems obvious, but just checking that the implementation doesn't
> +#         "accidentally detect a rename" and give us y/{b,c,d}.

makes sense.

> +
> +# Testcase 6d, We don't always want transitive renaming
> +#   (Related to testcase 1c)
> +#   Commit A: z/{b,c}, x/d
> +#   Commit B: z/{b,c}, x/d (no change)
> +#   Commit C: y/{b,c}, z/d
> +#   Expected: y/{b,c}, z/d
> +#   NOTE: Again, this seems obvious but just checking that the implementation
> +#         doesn't "accidentally detect a rename" and give us y/{b,c,d}.

makes sense, too.

> +# Testcase 6e, Add/add from one-side
> +#   Commit A: z/{b,c}
> +#   Commit B: z/{b,c} (no change)
> +#   Commit C: y/{b,c,d_1}, z/d_2
> +#   Expected: y/{b,c,d_1}, z/d_2
> +#   NOTE: Again, this seems obvious but just checking that the implementation
> +#         doesn't "accidentally detect a rename" and give us y/{b,c} +
> +#         add/add conflict on y/d_1 vs y/d_2.

What is less obvious in all these cases is the "(no change)" part to me.
I would think that at least *something* changes in B in all cases above, maybe
add file u/r (un-related) to have the tree ids changed?
("Less obvious" as in: we don't rely on the "no changes" part to make
the decision,
which sounds tempting so far)

>  test_done

No conclusion box here, so my (misguided) suggestion:

  If "No change" occurs, just take the other side. ;)
