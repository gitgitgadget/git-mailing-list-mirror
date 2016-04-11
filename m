From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 04/21] t: use test_cmp_rev() where appropriate
Date: Sun, 10 Apr 2016 20:07:21 -0400
Message-ID: <CAPig+cS+4G22ARfwxDnfPPS6A+oFHYtOD-99vh9EOt=qwLoZSg@mail.gmail.com>
References: <1460294354-7031-1-git-send-email-s-beyer@gmx.net>
	<1460294354-7031-5-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Mon Apr 11 02:07:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apPON-0007B0-9I
	for gcvg-git-2@plane.gmane.org; Mon, 11 Apr 2016 02:07:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbcDKAHl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 20:07:41 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:36245 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbcDKAHi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 20:07:38 -0400
Received: by mail-ig0-f196.google.com with SMTP id kb1so9305351igb.3
        for <git@vger.kernel.org>; Sun, 10 Apr 2016 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=kIQ9A38zxPeGpV4BvtW9uJqKdlZAwRRMhCtMVgDF0dM=;
        b=05r2z2Ysb4gBshbwZiWfOB+x6BfXiQCRCUfJz9yo9dTsJwTURvt/3xhJrjUHjWjNI4
         QeD0gOL+BypZOvKNzY2eDYhxpCBigcG7IV4CB3+QizQudHmndG+2waZQzhWb3xF/VQHs
         fle8fypRJTFfHhdO6kMzQfzkpxFtifRsMJN/xl3IhDz2sr83afu0JuJVhtRr1mI18cUJ
         mgSEcqnb1pHVpkgIisGsCKmGbRA/QK5/77Li6JPNWDtb9pq0uFgtawhuqq1cEtAFdM1C
         42uHuxNo1T6a50kpZWozLgriqXpzwUgHztT3vy8mkFElu0qNErVd1mtHpX5rCiM2Onzm
         0ItQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=kIQ9A38zxPeGpV4BvtW9uJqKdlZAwRRMhCtMVgDF0dM=;
        b=mYmQak2/odFFJmMn/j7hfopqDwVk4enjX0nKm0/B5IureRMZcKszrPaufh6WLVbILA
         rvW4fyr93QfPhUoo0s7ZEZmZ1qla1B4oNuYWD5l0Kz1vhqCk9SrAOHxfnTgLs+ByWIij
         TjqIyYrmK/ORYdESd0YXlTPCSzIbhRwBWxvTD+HdeCkXZCSuFthRO4HL8mW62f6zLtKx
         X8NWuqfruHP626pOJquUs1mymQviRMutS4pzAcDPpyo3SFLN6rZiZA+5N348E0QG98LQ
         bSYPYf7yZ1YawJdW2jhl/gcz6fkJiKPFp3l+wwoLP6wGmzBYR+aiisJGcXAI6n4Z99ZX
         PzNQ==
X-Gm-Message-State: AD7BkJK2a1f9MU5+SDL6Esx3juHgqGtrLjEz8DBLqWD8xtmOz/eZ2P2INpgE8ncxIIINVdrKIp52AZSKQTx00A==
X-Received: by 10.50.92.37 with SMTP id cj5mr15824503igb.91.1460333241981;
 Sun, 10 Apr 2016 17:07:21 -0700 (PDT)
Received: by 10.79.139.2 with HTTP; Sun, 10 Apr 2016 17:07:21 -0700 (PDT)
In-Reply-To: <1460294354-7031-5-git-send-email-s-beyer@gmx.net>
X-Google-Sender-Auth: dpl4lbxh5UAObzNzz46XYTmcUMg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291194>

On Sun, Apr 10, 2016 at 9:18 AM, Stephan Beyer <s-beyer@gmx.net> wrote:
> test_cmp_rev() from t/test-lib-functions.sh is used to make many
> tests clearer.
>
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
> ---
> diff --git a/t/t3310-notes-merge-manual-resolve.sh b/t/t3310-notes-merge-manual-resolve.sh
> @@ -537,8 +537,8 @@ EOF
>         test -f .git/NOTES_MERGE_WORKTREE/$commit_sha3 &&
>         test -f .git/NOTES_MERGE_WORKTREE/$commit_sha4 &&
>         # Refs are unchanged
> -       test "$(git rev-parse refs/notes/m)" = "$(git rev-parse refs/notes/w)" &&
> -       test "$(git rev-parse refs/notes/y)" = "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&
> +       test_cmp_rev refs/notes/m refs/notes/w &&
> +       test_cmp_rev refs/notes/y NOTES_MERGE_PARTIAL^1 &&
>         test "$(git rev-parse refs/notes/m)" != "$(git rev-parse NOTES_MERGE_PARTIAL^1)" &&

Does this one deserve the same type of treatment (but prefixed with !)?

    ! test_cmp_rev refs/notes/m NOTES_MERGE_PARTIAL^1

I could understand avoiding this conversion if temp_cmp_rev was still
noisy upon failure, however patch 3/21 silenced it.

Aside: Would make sense for test_cmp_rev to accept an optional ! as
its first argument to signify that the revs should not match?

>         # Mention refs/notes/m, and its current and expected value in output
>         grep -q "refs/notes/m" output &&
> diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
> @@ -354,8 +354,8 @@ test_expect_success '--remap-to-ancestor with filename filters' '
> -       test $(git rev-parse moved-foo) = $(git rev-parse moved-bar) &&
> -       test $(git rev-parse moved-foo) = $(git rev-parse master^) &&
> +       test_cmp_rev moved-foo moved-bar &&
> +       test_cmp_rev moved-foo master^ &&
>         test $orig_invariant = $(git rev-parse invariant)

At other places in this patch, you also converted lines such as the
above, so why not here?

    test_cmp_rev invariant $orig_invariant

>  '
>
> @@ -372,8 +372,8 @@ test_expect_success 'automatic remapping to ancestor with filename filters' '
> -       test $(git rev-parse moved-foo2) = $(git rev-parse moved-bar2) &&
> -       test $(git rev-parse moved-foo2) = $(git rev-parse master^) &&
> +       test_cmp_rev moved-foo2 moved-bar2 &&
> +       test_cmp_rev moved-foo2 master^ &&
>         test $orig_invariant = $(git rev-parse invariant2)

Ditto.

>  '
>
> diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
> @@ -79,17 +79,16 @@ test_expect_success 'merge c1 with c2 and c3 (recursive in pull.octopus)' '
>  test_expect_success 'merge c1 with c2 and c3 (recursive and octopus in pull.octopus)' '
>         git reset --hard c1 &&
>         git config pull.octopus "recursive octopus" &&
>         git merge c2 c3 &&
> -       test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
> -       test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
> -       test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
> -       test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
> +       test_cmp_rev c1 HEAD^1 &&
> +       test_cmp_rev c2 HEAD^2 &&
> +       test_cmp_rev c3 HEAD^3 &&

This drops the check:

    ! test_cmp_rev c1 HEAD &&

Is that intentional? I suppose the argument is that if c1 == HEAD^1
passes, then c1 is certainly not == HEAD?

> diff --git a/t/t7603-merge-reduce-heads.sh b/t/t7603-merge-reduce-heads.sh
> @@ -46,11 +46,10 @@ test_expect_success 'setup' '
>  test_expect_success 'merge c1 with c2, c3, c4, c5' '
>         git reset --hard c1 &&
>         git merge c2 c3 c4 c5 &&
> -       test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
> -       test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
> -       test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
> -       test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
> -       test "$(git rev-parse c5)" = "$(git rev-parse HEAD^4)" &&
> +       test_cmp_rev c1 HEAD^1 &&
> +       test_cmp_rev c2 HEAD^2 &&
> +       test_cmp_rev c3 HEAD^3 &&
> +       test_cmp_rev c5 HEAD^4 &&

Ditto.

> @@ -69,11 +68,10 @@ test_expect_success 'merge c1 with c2, c3, c4, c5' '
>  test_expect_success 'pull c2, c3, c4, c5 into c1' '
>         git reset --hard c1 &&
>         git pull . c2 c3 c4 c5 &&
> -       test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
> -       test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
> -       test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
> -       test "$(git rev-parse c3)" = "$(git rev-parse HEAD^3)" &&
> -       test "$(git rev-parse c5)" = "$(git rev-parse HEAD^4)" &&
> +       test_cmp_rev c1 HEAD^1 &&
> +       test_cmp_rev c2 HEAD^2 &&
> +       test_cmp_rev c3 HEAD^3 &&
> +       test_cmp_rev c5 HEAD^4 &&

Ditto.

> diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
> @@ -30,9 +30,8 @@ test_expect_success 'setup' '
>  test_expect_success 'merge c1 to c2' '
>         git reset --hard c1 &&
>         git merge -s resolve c2 &&
> -       test "$(git rev-parse c1)" != "$(git rev-parse HEAD)" &&
> -       test "$(git rev-parse c1)" = "$(git rev-parse HEAD^1)" &&
> -       test "$(git rev-parse c2)" = "$(git rev-parse HEAD^2)" &&
> +       test_cmp_rev c1 HEAD^1 &&
> +       test_cmp_rev c2 HEAD^2 &&

Ditto.
