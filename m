Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7A53CE49F
	for <git@vger.kernel.org>; Mon, 16 Mar 2026 18:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773684644; cv=pass; b=k2pLCOwQMWDy82SMW8/i7EmUsQKR/UuXRtj5mt82dqWobq8NF6qyOfAi6cwS3LWB37V4mQjSp7l2B14NYd0fRnBA4XcdSysUeYj/F9Z1YEWPjmY30y6aboxWvBWXxOrZmIKHrnEwfu9FUGPlN/TJbKYgad3XSe0Uk7hdVuZfOM4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773684644; c=relaxed/simple;
	bh=y48Vew+hy7n1rnx+XxYQcrcW+NjSeYUqyvCFnZN9HQM=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pZxLxkUYW77S0khRh4mRS4gwkWeM7TggNpYjCxb8I+SguFo5fMtgb4/Zw4rgINmlhIr95IJgP3OR7M54dBxmlcAdBbdVJHmIZ28UePsMf/NMCc32zENMeVxNXMf+fbeF1yCY0m7gU2VqXV+w31hD7jnY/h2vgOWArYEl9jXYAZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lm26Rz0j; arc=pass smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lm26Rz0j"
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-94aaa5d3bfcso2621567241.3
        for <git@vger.kernel.org>; Mon, 16 Mar 2026 11:10:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773684642; cv=none;
        d=google.com; s=arc-20240605;
        b=PpRFgD6mEjK7vMOrzdgPO5/dvyLt1ljv1IShhNmN6oyPIxPvdl9WwZ2kHnl5b8NaTX
         NlAUCWIn4FxaOYTohkCh852zWU9blZJdQ+Fw2y1d7LTkphR9k0cVXIsDrDMClKtyHB3T
         JOto3rAdFvOJAV/0uefBUuAiF1DOBgIQbnL4kcvrC/h6OKog21SdkfOHl6NQI2/GIaxI
         kpW48H3Y+ZOivM57p4BiJ1WTHpZLS/UG+LfTcnpZrUhDgYqPR3ciL9kqyQLuiDGiEOMG
         MqJmzsPYbmBMoIk+/oV5YIg5bM/l09h7zkbF4anuRAtYi8ndFikPobL4zGWC0Mhgj/Xl
         sNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=KT/yHbVwwxT6faSyTPAT7myTCuIIOPHWJ1BovXIpXjM=;
        fh=xbYRXG6MmcDoahO0UO96zsxtpncccE5jz+JaL6YHRJo=;
        b=VlgLO5aDD3D8tXq6BF5Prvu5DpFdgw66Iprb2C2lr55+UVrhn5Z8PjyNfvIkFXjSUF
         DTH8jVYPQ2uZD84Ghqh7C8dDZqQFSWl9Rm3oNotgqN2T+PycHZWbsRleXghtDqg5dstU
         ddyMkhCuDG2nn6+VNSxId9P2OZMuq4BEZQMQ2yvCtvTeiE5KD31zNfUJGNCC2zF2jlT4
         q5b/Yc07o/ocH8yhqGLcC5f71dEsWSTprHB+Kfbb5jOtI38Fd9M1JeuuoWMFPwh+KxxX
         L0+D6coYhrgf/bNZjgOML59DeRrZ5dO3SKsMzWD/mKOFdQTQQ8g9RQe6keiI1dt3K97B
         9FDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773684642; x=1774289442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=KT/yHbVwwxT6faSyTPAT7myTCuIIOPHWJ1BovXIpXjM=;
        b=Lm26Rz0j4NtuBmIXW9v2+0YnUbtnaBlp10iNW3f7iydtWuhUo3XCpacBdaQKO51zJB
         pA/sFCvx6jd1Xvjq/ZkwBL2kTUmnJEdPojQkiJoyD5uI8qD0eQ4rIzgUMwStkhz24JL6
         nH9PfNz+di0JTiIMdNlH5MZSanjPcK0s4zz0KsnL6hyUhR7FyyeQ4XrfmMWRijjYCDe8
         bC3nCHKByKfJxG17BOOVteMZkh+mNDiuZ+b5VV4wddP001fhT/z9mq6YiDBOL8+Krv0u
         UbIIcofje7N4eSn9gFCswE0xqUs7oc2JVyQLpqMCWgAc4vTeSU0z+RlSPV5tWL1PN0f1
         RSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773684642; x=1774289442;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KT/yHbVwwxT6faSyTPAT7myTCuIIOPHWJ1BovXIpXjM=;
        b=Q7NFezruyDayce/onLWqbATlROEDo+HfaSqkJ6b/17yyZBGJYjOv5NOLEIuQ3NulEy
         Cvqxgl3U8gkIJwK6YoRW6s/9zAcaQceTdMRuVMFkUyYgqJGCWxgO+XaIQuwYol3PkR98
         FesNPSuEu+Xudt7h4aHv8H/YFwvfqa8ousZ4k3AWe50UevPSfBJjiDRH0puAH3Rbo0fA
         BBccBt9l+R4hqZEXvS9gNSLG94xc30GRrtUMX1WffSb2tmnJAu14mGiMUAEWaTBFErz9
         f5dQrbIjWh4oeAIArNFsqm2U1dMJ6lMFuYOY9T4S8zO3M9gBmbPpr3bl9UHJP1nJazSa
         v5VQ==
X-Forwarded-Encrypted: i=1; AJvYcCXM7TwDM8CwWzGlaR1Fb0qqdVBshHy88b1O8tWMHr5a/UJCQLfiR7HFtUk6a7HwC8ULa4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfWHic9VQt7YiphvSp+0BEAiUAiiNrzOIcqAangCZXWKJBKys7
	erseNrMUP8aMNY+drYItsifuhfBWPW1+qhudjqIk5Qt5m71T+9yuSPvBwBU7Nvh9y6nw28ROcqZ
	fNsQ6aDF3pWBF3OoqFqZXhOvlduI7X1w=
X-Gm-Gg: ATEYQzwbWnMREwfqanev/7zawn8bhz/ukjptTWqK3wa3VWn/7/XOshSEWFS3KsKkFwt
	Tp6YfB4YXQhiFDwPBtn0xnWENAhy2XLzubMb2TmmWGCGJnBrQahrVg+YNyCRWeWGC+5il8EJHTx
	dS/iauUv7mbcfmOcLajl6KAigxivGl1S9LaU921jqTnSijiq28fhFFFrAXGFQq9l4w4EM2n617L
	ESBIHRBv5GBTCA6sLgi3yRiOtZmpCH2FmW8u+qNnpkVcSm1c8d1Mq0LXwTyYcV3aBFaN6MBXma5
	xFEtZqc9/eutBB1reiPc7jetuIeA3bPRjKXfhL3l
X-Received: by 2002:a05:6102:38c8:b0:5fd:ea66:92e5 with SMTP id
 ada2fe7eead31-6020e8b0a8fmr6363726137.22.1773684642017; Mon, 16 Mar 2026
 11:10:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 11:10:41 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Mar 2026 11:10:41 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260316130431.1318-1-pushkarkumarsingh1970@gmail.com>
References: <20260316130431.1318-1-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 16 Mar 2026 11:10:41 -0700
X-Gm-Features: AaiRm53_eIuAakD2CxU0_ywtD4Bw9t4CrR5-fBGwl9DfnJUbcs4d6ZAJqEVJ7xE
Message-ID: <CAOLa=ZRpRv61Z7bkch53LJjsvZV2T3S+yRKOxYdK6U=oKW10YA@mail.gmail.com>
Subject: Re: [GSoC][RFC v2] Proposal: Improve the new git repo command
To: Pushkar Singh <pushkarkumarsingh1970@gmail.com>, git@vger.kernel.org
Cc: lucasseikioshiro@gmail.com, jltobler@gmail.com, 
	siddharthasthana31@gmail.com, ayu.chandekar@gmail.com, 
	christian.couder@gmail.com, peff@peff.net, gitster@pobox.com
Content-Type: multipart/mixed; boundary="0000000000000814b4064d28234b"

--0000000000000814b4064d28234b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Pushkar Singh <pushkarkumarsingh1970@gmail.com> writes:

Hello Pushkar,

Thanks for your proposal

[snip]


> The Plan
> --------
>
> I will be iterating on this project in blocks and with the
> review-driven approach. By introducing every changes in small,
> logically isolated patches, I'll ensure clarity, ease-of-review,
> and architectural stability.
>
> First I want to cover foundational repository path keys,
> because they create instant structural value and more closely fit
> with existing functionalities of rev-parse.
>
> For every key proposed or enhancement made, I will:
>
>   - Ensure behavior matches with existing helpers.

Which existing helpers?

>   - Clarify semantics(absolute vs relative paths, edge cases) by
>     discussing on the mailing list before finalizing the behavior.

It would be nice if you explained a bit about this, what is the current
condition what are your thoughts and what do you plan to implement.

>   - Add one key (or one closely tied family of keys) per patch.
>   - Add targeted tests covering:
>         * bare repositories
>         * linked worktrees
>         * submodules
>         * shallow clones

I'd be very interested in what the current test scenario looks like and
how we'll improve on top of that.

>   - Update documentation accordingly.
>
> I will avoid large changes and focus on small, reviewable patches,
> instead of rapidly expanding features.
>

I agree, most often students underestimate the time needed for iterating
and getting reviews on the mailing list. Having smaller well defined
patches helps.

>
> Path Key Expansion
> ------------------
>
> I will incrementally expose selected repository path values
> currently accessible via:
>
>   - git rev-parse
>   - git rev-parse --git-path
>
> My initial focus will be on foundational keys such as:
>
>   path.git-dir
>   path.common-dir
>   path.toplevel
>   path.superproject-working-tree
>
> Subsequent patches may introduce additional --git-path
> equivalents such as:
>
>   path.index-file
>   path.objects-dir
>   path.config-file
>
> Each key will be evaluated individually to ensure clarity,
> necessity, and consistent semantics.
>
>
> Optional: Category-Based Queries (If Aligned)
> --------------------------------------------
>
> If agreed upon through mailing list discussion, I will introduce
> explicit grouped queries, such as:
>
>   git repo info paths
>
> The expansion will still be deterministic and predefined.
> I'll not be introducing any implicit or dynamic grouping behavior.
>
>
> repo structure Enhancements
> ---------------------------
>
> If maintainers deem it appropriate maybe I will tackle some
> carefully scoped improvements to git repo structure.
>
> Potential areas include:
>   - Distribution-oriented metrics, only if aligned with the
>     tool=E2=80=99s long-term direction.
>   - Low-friction structural metrics (e.g., path depth),
>     as long as they do not add excessive traversal cost.
>
> Any such enhancement will be introduced in small,
> standalone patches, taking performance, maintainability,
> and output stability into account. If scope or review
> timelines demand, this stage will be delayed.
>

I'm curios to know about the timeline and how this plans into it.
Reading along.

>
> Architectural Considerations
> ----------------------------
>
> Where appropriate, I will:
>
>   - Prefer explicit repository context over global state.
>   - Avoid duplicating logic already implemented in rev-parse.
>     Where possible, I'll reuse existing helper functions rather
>     than reimplementing path resolution logic.
>   - Preserve conservative output stability.
>

I'm not sure what the last sentence here means.

> Structural refactoring will only be undertaken when directly
> relevant to git repo and supported through review discussion.
>
>
> Timeline
> --------
>
> Keeping Git's iterative and review-driven workflow in mind, I've
> designed the timeline to focus on core enhancements in order to
> ensure that I can produce meaningful deliverables even if review
> cycles extend.
>
>
> Pre-Coding Preparation (Before Official Start)
>
> - Continue participating in git repo discussions.
> - Improve and restrict scope of path key expansion.
> - Confirm semantics for absolute vs relative path handling.
> - Define patch ordering to keep the submissions small
>   and logically independent.
>
>
> Community Bonding Period (May)
>
> Primary objective: finalize scope and ordering.
>
> - Confirm priority list of path keys.
> - Align on output stability expectations.
> - Clarify whether category-based queries are desirable
>   in this cycle or deferred.

In this cycle? IF we do go with category-based queries, isn't that a
design choice which affects all 'git repo info' keys? Would we need to
specifically solve for path keys?

> - Identify architectural considerations relevant
>   to builtin/repo.c.
>

What do you mean by this?

> I will get to implementation once the semantics feel reasonably
> aligned through mailing list discussion.
>
>
> Phase 1 (Weeks 1=E2=80=934): Foundational Path Keys
>
> Objective: establish core path parity in git repo info
> with essential rev-parse values.
>
> * Weeks 1=E2=80=932:
>   - Submit path.git-dir
>   - Submit path.common-dir
>
>   I'll present these foundational keys early on to keep
>   semantics consistent, and stabilize output expectations.
>
> * Week 3:
>   - Submit path.toplevel
>   - Submit path.superproject-working-tree
>
>   These will provide working-tree inspection coverage to
>   and submodule-aware contexts.
>
> * Week 4:
>   - Submit selected stable --git-path equivalents
>     (e.g., path.index-file, path.objects-dir),
>     introduced incrementally, one per patch.
>
> I'll submit each key independently. When semantics are
> already aligned, I'll send consecutive patches while
> older ones will remain pending, which allows a significant
> overlap between submission and iteration.
>
> Midpoint Goal:
>  Deliver foundational path keys that are either merged or
>  in next, with consensus on semantics.
>
>
> Phase 2 (Weeks 5=E2=80=938): Additional Path Keys & Refinement
>
> - Finish the remaining agreed --git-path parity keys.
> - Address changes from review cycles of Phase 1.
> - Stabilize behaviour across edge-case environments.
>
> This phase purposely leaves time for review-guided
> iteration without expanding scope.
>
>
> Phase 3 (Weeks 9=E2=80=9310): Optional Enhancements
>
> Only if Phase 1 and 2 stabilize earlier than expected,
> I'll begin:
> - Introducing the grouped category queries(e.g., info paths),
>   subject to prior agreement.
> - Carefully extending repo structure with one metric
>   at a time.
>
> I=E2=80=99m not going to attempt any bulk metric expansion here.
>
>
> Final Weeks (Weeks 11=E2=80=9312): Consolidation
>
> Over the last weeks of this program, I will:
> - Address remaining review feedback.
> - Adjust patches if requested or rework them.
> - Finalize documentation.
> - Ensure CI stability and cross-platform behavior.
>
> During this time no new features will be introduced.
>

Something we'd also like to see is if you have other events which might
affect the timeline, like exams at college. If not, worthwhile to call
it out.

>
> Prioritization Under Constraints
> --------------------------------
>
> Considering Git=E2=80=99s iterative review process, I have structured the
> project so that foundational improvements are delivered first.
>
> If review cycles extend longer than anticipated, my priority will be:
>
> 1. Core path parity (path.git-dir, path.common-dir,
>    path.toplevel, path.superproject-working-tree)
> 2. Additional agreed --git-path equivalents
> 3. Category-based queries
> 4. repo structure metric extensions
>
> This ordering ensures that the most architecturally meaningful
> enhancements are completed even if optional improvements
> must be deferred.
>
>
> Post-GSoC Continuation
> ----------------------
>
> My involvement in Git is not limited to the GSoC period.
>
> After the coding phase, I intend to:
> - Continue refining git repo through incremental improvements.
> - Address follow-up review feedback or deferred enhancements.
> - Participate in reviewing related patches where appropriate.
> - Contribute to ongoing efforts around repository introspection
>   and gradual libification.
>
> Over time, I hope to contribute not only through patches,
> but also by helping new contributors navigate the mailing
> list workflow and patch iteration process.
>
> If given the opportunity in the future, I would be glad to
> support mentoring efforts and help the community grow further.
>
>
> Availability
> ------------
>

Ah, seems like you do go over it.

> My end-semester examinations conclude on March 28.
> Following this, I will not have academic obligations
> during the GSoC coding period.
>
> The project is expected to fall within the 175=E2=80=93350 hour
> range. I am prepared to commit at the higher end of this
> range.
>
> During the official coding phase (approximately 12 weeks),
> I will be available for 30=E2=80=9335 hours per week. This allows
> for approximately 360=E2=80=93420 hours of focused development time,
> comfortably covering the expected project scope.
>
> I will also remain active on the mailing list during the
> community bonding period and will use that time to refine
> design decisions and prepare patch sequencing.
>
> I do not anticipate any internships, travel, or major
> commitments that would interfere with this schedule.
>
>
> Blogging:
> ---------
>
> For the past one year I have been writing technical articles
> on Medium, mostly related to Git workflows, developer tooling,
> and lessons from working with real codebases.
>
> I will be sharing weekly updates for the GSoC period to document
> progress and the discussions on these mailing lists for
> transparency, and more importantly, to help future contributors.
>
> Medium: https://medium.com/@pushkarscripts
>
>
> Risk Assessment and Mitigation
> ------------------------------
>
> 1. Review Cycle Duration
>
> Considering Git=E2=80=99s iterative mailing list workflow, existing
> patches might go through several updates before being
> accepted.
>
> Mitigation:
>   The project is structured so that foundational path
>   keys are delivered first. Independent patches allow
>   parallel review and refinement.
>
> 2. Scope Creep
>
> Expanding both path keys and structure metrics
> may introduce unintended scope growth.
>
> Mitigation:
>   Optional enhancements (categories and additional
>   metrics) are explicitly deferred until foundational
>   work stabilizes.
>
> 3. Semantic Ambiguity
>
> Path-related behavior (absolute vs relative,
> worktree interactions, submodules) may require
> careful alignment.
>
> Mitigation:
>   Semantics will be clarified during the bonding
>   period and validated against existing helpers
>   before implementation.
>
> ---
>
> Thank you for your time and consideration. I look forward
> to contributing further to the project and continuing to
> learn through the review process.
>
> Regards,
> Pushkar Singh
>
> ---------8<----------8<----------8<----------8<----------8<----------8<--=
--------8<----------8<
>
> Changes in v2:
> - Updated status of my recent patch activities.
> - Added recent patch reviews I made in Mailing List.
> - Improved clarity and readability across sections.

Regards,
Karthik

--0000000000000814b4064d28234b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 48d1af0251bf768_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1tNFI1OFdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNHUxQy9zRS9KaWtiMlFPUDc2bXJTbFlvQzhiUHBzRgpYZ01mTENvdDFq
RmJqTHVkSTlkS2FCU3ZCaHFtYlhvb0F6M2RteTZQRERxd0ZJK1F3LzU2YTBLZENOaGR2TEVyCmFt
bXZHMVlUa0s2cElicGJqMCsrVFRYZXZrdS9GSEp5VzlqZ2JPUHMxV2kwRVlKL3F0Z2QwUlJNWjNO
cGxTVlQKSjVIQmFxUkdlbHVFOEM0UWhVcXNoMnB0OFFUcWEyREN6UHRWTHBQMFQ5VzJtbEVJb1dl
OFE3dnlZZUp6ZDQ5cQpBSS8wWjVrbFdhelJ5c3M2R2F1OGpVenZsNmRoaktNQTdPZGlST2RSbjU3
d2gyMHlQTHlMWkMxbnMyZk9qYnB4CjhPV2FEZUw0bFlPWjh4d2hzY2JHZm9peEtWR0MrVWtJVzNV
Q3h1VTYzam9JdHV6WnZrTS9kNVNnd2xzVVlFdisKTThmZFVwZTIvTWZxZEozOXVzT1FBSlMzYlJu
K2JmNGwwbUNPc0ZGWEdQeGlvVWVtTDg5Z1lpMk1CdzZmWndiVwp0NjU2Y1dPMlhOZklEWUFtck9H
VnYycjhuTTIyam9kL0c0bmRBY1lEcy9PSURQQzNSRjZ0aGt1KzJlalFLRm9GCk5XaFNNcHMwOVpi
MVNGTmRMbEhuZGhyTXAzc1ZDL0I1amwvZGU2QT0KPU5mZUYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000000814b4064d28234b--
