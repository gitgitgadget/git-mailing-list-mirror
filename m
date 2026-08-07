Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A051C862D
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786071707; cv=pass; b=L61DwuUWl2hedbI6Gs9JwAW68AbTP+1+mhjHL0pP2LRLto7Ic9DV+Q758albyybGK2z5fkEX6+utpJIO+ENsHyglanQEZUrb6xHMTraDRNpKM7jZ4Z9pQ9l4cPwsnIPqOXu9rcD4eZFlAabsfAHZPvPo24AyPNxJsL/Tor0zWB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786071707; c=relaxed/simple;
	bh=xvAvQxMHv9TIShvdM18X30v061toa/MeVl9Qmj/PeXw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P3FdoJ+fJoV6KpLd+xL9v0aA25z1WeXYbTRqD0aLvqeTmYWXBAvIB8BaX82H4KDhTmj9xjFpmovqj8cHZWiSUroz/B5f6wNg//PQfq0JPsv+MW0QC/waeZBCZV2KEbpxl5SFBsvOQZFrkViobPAQST4KX1grRDeJYFoUEeWNttE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qMsEnBNf; arc=pass smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMsEnBNf"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4a40bcc8d69so1881414b6e.3
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 20:01:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786071705; cv=none;
        d=google.com; s=arc-20260327;
        b=G0FrdJQNORKbYkJcpRF8GVt+Ehbnmd6kawEgZ2B7LlXfciYEX8CEoq8g5tZx31TbQ/
         3/AwMQma8NCPPEugWeMbJq1YhMIh+gPOGAViU5PXXZ+C8yAK0HRKuG+QhiemQq6P6Wl5
         bIf3KdEcthxzVJgVxcowg+gs9t71P6T7oQZm5Fd8xoo6gfy0wkt9IUC+TsKgma6rbIA7
         9pB2cVTIAiEnPbwaa7KTBo16e+NEGSHdX9jjJGe53tCFGGLQnq+af4nV+uahx/kft/ob
         KlnP7YLaI/fBHrIjU4T3SG9cR1obeiHZrdwhoL+LaYxCmoyQIgi+G8x1GYoSxEHXlB/6
         qHlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4THuUe4ZmsuDQYvlLxivfnOHLMbk/bbCn1yLyXhRcHg=;
        fh=PdGuLsJN9JVZy5BHY9bPXqzeWCeYFKwbJ2iGslXTO1Q=;
        b=NcNGAwJL0f9GMI2mpnqxHG5cLWO+1V8pgcvdnKL3d0Tx83g9EWHzn2wI0iKOrbOacE
         eukFk8JiQsl0p+0wPuU8LOLnRZmWXt5UzwqMC2jYkTSKhl6hK/VO8ftu2h8ilvVYoKvQ
         DmFwHZ5RWahiNkWeT6sZngvn8iP0afCzBpb0RpgFzRYCNd/7bdaGb0OEnxJxNaFr21sC
         RS0jlZmY9mFytQeD5CkBpiBOiRXg5n2W4BAIDuWWpEnXa87CFdt3IW6OjRLUnBKKYPBW
         d3jgj1kELxbhbfgsRlHyGX7VaWThPf89Tz1RLNP3zOnsjK/AphD6UGKHljwkcTHUjWW9
         htwA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786071705; x=1786676505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4THuUe4ZmsuDQYvlLxivfnOHLMbk/bbCn1yLyXhRcHg=;
        b=qMsEnBNfiDQZqM04lnbBJ2S6MVbkpM8HHESIiSv00ie13WW/3elYsENyIL3uBAfLPS
         gygh9NC4rUsyqOZKwoV2+I8Grz4LqGJB3hiM2i7opxZiIWW3AiDZxjDEgkPP4iO3Tiw1
         b9pNtc9ZmIlaT9UIoiA/zRIG35RPjm0OjoZe6E0wYyZvS/GennI4t58ChVg9gBVfri1P
         4YYd/v4Fpg24y6nUcjtkl3Pt9DvgV6MIxBel7W5FAvF3/bnhF205nyt0cDMkiZjgHdik
         vrtAPeMHrQnUoBPUo1w4YOsubpAGH+jbgCHZ6g7Nmo3cyzN1jY8OXcflfFTQeC8mILbp
         Vtuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786071705; x=1786676505;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4THuUe4ZmsuDQYvlLxivfnOHLMbk/bbCn1yLyXhRcHg=;
        b=PdieKyR1x5MEUOIyMwiBRxW7yH5I2JyBcb6Cla43D7WIMioVfzNmdz6hjIqf1UNqPt
         2MY9ImotWi2lktTzCmIBdNZAZZgGLtmKBc32I3Y68AjQpO8JzBRZEP258+egizKK5sO+
         DFfAPAxjYIRRdUx4dPNq2Zm1wU6EyeBM2VYri/G4/VcoSQStC88sCC5Q77YfMQm0/GIF
         iRN9yEibw5sYrFoq60+P/B1O+dgfz4QX1J9ktswGZ5krmBweupo5CbU81tzyzXGqTiFi
         OCYJ+hW5ZAI5DWDQBx0UFsoHSsuq9tG3Iu0wS28u3BDB2QGY2Jd/3rZ8APq6zb9lJbrk
         1gpw==
X-Gm-Message-State: AOJu0YxG/d1UlRYRXuomrO+vX4ZltLysYeXjaiipjSeJHnK4dn2UUNbn
	RAKfpnJN4xWwE2YqF4JPtGQoapfN8RbWHYVITegI/i04SahIH/RS2hYmCQjCRRSQGQ8ETxjIgyg
	AHRgMb4pPV0Xq/5mJDh2CCN1XZy7TpVo=
X-Gm-Gg: AR+sD10Lz4Apmv+Nk98aCMwFQnKY8xJDUp8J5anjyQqER1rg+JThQ/duC7lOgYNwz3X
	x9lNU86veA1/wVTUaknWFwitowzaRItYdBrKyZmOZ1MHxrbiJOZZ2VbMwfoXeCR7Pzq9VQpJnBy
	BJ88Nr9A5DFsx3bPAKp8DKoDyqlsOuV+1suskHSORuLc0nu9iu5MH3Z1OxloQA5P7JzTb470lap
	M3YP5YGTYundqM9p5MBvVX87hTaicCmxCxLSNlAak9pK58r562VMPKjfkCiGtFi5q6gnIBHkShG
	UtFcpSfp/J88JkD6lbRhJFefbBRXcysJKtqqkcpnJRorRTtpvImQKPWMrVxKHkSF0IICzqN3iqC
	LPCH46SR67tJhVxvLLF+jN2Lt8T33swdk0V2Uem/tE1DImUJzPkHtM4FQVHI1yVs=
X-Received: by 2002:a05:6808:1b90:b0:4a3:95f3:68e with SMTP id
 5614622812f47-4afaddfbde6mr10298582b6e.9.1786071704775; Thu, 06 Aug 2026
 20:01:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
 <pull.2149.v7.git.1786013982.gitgitgadget@gmail.com> <e8565ce0203e7f94f3f1ac193eb1fd703fe50463.1786013982.git.gitgitgadget@gmail.com>
In-Reply-To: <e8565ce0203e7f94f3f1ac193eb1fd703fe50463.1786013982.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 6 Aug 2026 20:01:33 -0700
X-Gm-Features: AUfX_mxAD44rjeccUm1QSD4ETsH-Z32Ts75CLUNPR7UZl2WE1gMURxGhRwIVEd4
Message-ID: <CABPp-BHp=-fA1Mwo3zqNAROjjdZ4gCq8G7h=e80qLfzrAb3VxQ@mail.gmail.com>
Subject: Re: [PATCH v7 04/10] t6099, t6600: add side-exhaustion regression tests
To: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 6, 2026 at 4:04=E2=80=AFAM Kristofer Karlsson via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Kristofer Karlsson <krka@spotify.com>
>
> Add t6099 to test the case where multiple merge-base candidates exist
> and one is an ancestor of another. This exercises the side-exhaustion
> optimization in paint_down_to_common together with the
> remove_redundant safety net in get_merge_bases_many_0.
>
> Add a mixed finite/INFINITY test to t6600 where one tip is outside
> the commit-graph (INFINITY generation) and the other is inside.
> This exercises the region transition: the walk starts in the
> INFINITY region where side-exhaustion is disabled, then crosses
> into the finite region where it can fire.

Junio already commented on the second paragraph not following your
earlier split.

> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  t/meson.build                         |  1 +
>  t/t6099-merge-base-side-exhaustion.sh | 82 +++++++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100755 t/t6099-merge-base-side-exhaustion.sh
>
> diff --git a/t/meson.build b/t/meson.build
> index a25f37d2f5..655c94f860 100644
> --- a/t/meson.build
> +++ b/t/meson.build
> @@ -795,6 +795,7 @@ integration_tests =3D [
>    't6041-bisect-submodule.sh',
>    't6050-replace.sh',
>    't6060-merge-index.sh',
> +  't6099-merge-base-side-exhaustion.sh',
>    't6100-rev-list-in-order.sh',
>    't6101-rev-parse-parents.sh',
>    't6102-rev-list-unexpected-objects.sh',
> diff --git a/t/t6099-merge-base-side-exhaustion.sh b/t/t6099-merge-base-s=
ide-exhaustion.sh
> new file mode 100755
> index 0000000000..4f1e0d50ef
> --- /dev/null
> +++ b/t/t6099-merge-base-side-exhaustion.sh
> @@ -0,0 +1,82 @@
> +#!/bin/sh
> +
> +test_description=3D'merge-base with ancestor among merge-base candidates
> +
> +Test that merge-base --all correctly handles cases where
> +multiple merge-base candidates exist and one is an ancestor
> +of another. The side-exhaustion optimization in
> +paint_down_to_common may exit before STALE propagation
> +removes the ancestor, but remove_redundant catches it.
> +
> +Graph shape (parents are below children):
> +
> +   A ----------- X
> +   |\           /|
> +   | B---------/ |
> +   | |           |
> +   e2 \         f2
> +   |   |         |
> +   e1 d1        f1
> +    \  |        /
> +     \ |       /
> +      \|      /
> +       C
> +
> +A and X are the two tips.
> +B and C are both reachable from A and X.
> +B reaches C through d1.
> +Only B should appear in merge-base --all output.

Was this graph created in an editor using a variable width font?  In a
fixed width font, it makes one assume that C is not an ancestor of X,
but instead that C and f1 will likely eventually converge on common
history.  One might need to know what your original variable width
font was in order to see it right.  The description below if very
helpful, but could we replace the graph with:

   A ----- X
   |\     /|
   | B---/ |
   |  \    |
   e2  \   f2
   |   |   |
   e1  d1  f1
    \  |  /
     \ | /
      \|/
       C

?

> +'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +test_expect_success 'setup ancestor merge-base candidate' '
> +       test_commit C &&
> +
> +       git checkout -b d-chain HEAD &&
> +       test_commit d1 &&
> +       test_commit B &&
> +
> +       git checkout -b e-path C &&
> +       test_commit e1 &&
> +       test_commit e2 &&
> +
> +       git checkout -b f-path C &&
> +       test_commit f1 &&
> +       test_commit f2 &&
> +
> +       git checkout -b branch-A e-path &&
> +       test_merge A B &&
> +
> +       git checkout -b branch-X f-path &&
> +       test_merge X B &&
> +
> +       git commit-graph write --reachable
> +'
> +
> +test_expect_success 'merge-base --all excludes ancestor candidate' '
> +       git rev-parse B >expected &&
> +       git merge-base --all A X >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_expect_success 'merge-base (single) finds shallowest' '
> +       git rev-parse B >expected &&
> +       git merge-base A X >actual &&
> +       test_cmp expected actual
> +'
> +
> +# Without commit-graph: generation numbers are INFINITY,
> +# side-exhaustion optimization does not fire.

This comment made me think the test would run with trace2 regions
printing in order to verify which codepath it went through.  That
might make it a stronger test (if coupled with trace2 regions above to
ensure the above code is testing something different than what below
does), but certainly not worth a re-roll.

> +test_expect_success 'merge-base --all without commit-graph' '
> +       rm -f .git/objects/info/commit-graph &&
> +       git rev-parse B >expected &&
> +       git merge-base --all A X >actual &&
> +       test_cmp expected actual
> +'
> +
> +test_done

I like the tests added here; look good to me.
