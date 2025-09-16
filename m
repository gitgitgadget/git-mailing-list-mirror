Received: from mail.avm.de (mail.avm.de [212.42.244.119])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C2A343207
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758034695; cv=none; b=pR89kymjuvO/KN09t3VhTkvN47RKlJLvg3WvY13ylKX6edmbyAfxAHfglUVbMzLc4TVzexbKZwO7iSGREepGJ9ZILT6DkK9tHg282SiwAJdst6uYcmBd6blWK+N4Qq3egd3chTa5u1MKMXsZRmxRzyfN78VQfshPhzFFluZjD6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758034695; c=relaxed/simple;
	bh=cV6DnyFQ4Txo7EvGaRXyD+sIKz4yy/erjE59nBgbuzs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l4C2c1quyxmW+YIzeK7Futmv5Du8MD8nlUzEu8MVVqIUr2QPanCw2Yddy9T16jlayCE1MTwYhm5W022j6/6dXqd5Vv6kQMHm4upJHXn3MTibHzZUTQ3tuNnBFvnELvAGbV1aXynVmcLwg4ECZnVMp5kJcNWx97zraS6U4EQfpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de; spf=pass smtp.mailfrom=avm.de; dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b=OjLhpvzf; arc=none smtp.client-ip=212.42.244.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=avm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=avm.de header.i=@avm.de header.b="OjLhpvzf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=avm.de; s=mail;
	t=1758034352; bh=cV6DnyFQ4Txo7EvGaRXyD+sIKz4yy/erjE59nBgbuzs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OjLhpvzfXRotQzeGITpNWncV66PxmBNUMZqBNfk4AegfkvQmmMlXUWuR4L7/wN4t0
	 Rk7FXGjTjKNUkU2YtWewjKQxKPHpZ1tp66gPQeAsOU+E6Q0I1RkFLzBIj9OLheNL3P
	 Q2WJJCLZjMZL+kS5qD4mP/exycT+Gk/cqq/G9cLA=
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <phahn-oss@avm.de>)
	id 68c979b0-5361-7f0000032729-7f000001b600-1
	for <multiple-recipients>; Tue, 16 Sep 2025 16:52:32 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Tue, 16 Sep 2025 16:52:32 +0200 (CEST)
From: Philipp Hahn <phahn-oss@avm.de>
To: newren@gmail.com
Cc: bolide2005@163.com,
	git@vger.kernel.org
Subject: Re: --shallow-exclude=ref -> "ambiguous deepen-not" error
Date: Tue, 16 Sep 2025 16:50:31 +0200
Message-ID: <20250916145032.969133-1-phahn-oss@avm.de>
In-Reply-To: <CABPp-BEzjk0PLEMjtk-0jQOAag-s_iJkKMbcU+o5vv8BzRVV2A@mail.gmail.com>
References: <CABPp-BEzjk0PLEMjtk-0jQOAag-s_iJkKMbcU+o5vv8BzRVV2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-purgate-ID: 149429::1758034352-ABEA0ED6-C5600782/0/0
X-purgate-type: clean
X-purgate-size: 2929
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

Hello Elijah,

On Mon, 24 Feb 2025 at 07:27:55 -0800 Elijah Newren <newren@gmail.com> wrote:
> On Thu, Feb 20, 2025 at 12:27 AM bolide2005@163.com <bolide2005@163.com> wrote:
> > Case 2: git clone --shallow-exclude=<rev> <repo-url>
>
> The documentation was fixed for case 2 in 00e10e07510 ("doc: correct
> misleading descriptions for --shallow-exclude", 2024-11-04) to point
> out that this usage is flawed.

I have searched the archive and git repository, but found no explanation, why
that usage - shallow-exclude by REV - is considered "flawed": I understand,
that the current implementation does not support this, but is there any
technical reason why that is not possible or undesirable?

                     A---B---C topic
                    /
               D---E---F---G master

I have a use-case for this, where we use GitLab to run some linters on our
merge requests (MRs): They examine the commits since the fork-point "E", for
which they need access to the commits + trees + blobs. Some MRs are larger,
some smaller, so there is no fixed maximum depth I can give to `--depth X` and
be sure to have gotten all commits.
Same for `--shallow-since=` as some are dormant for a year and many other MRs
by-pass them.

GitLab gives me the `CI_MERGE_REQUEST_DIFF_BASE_SHA`[1] (The base SHA of the
merge request diff) for free, which I would like to use with
`--shallow-exclude=`, but that does not work as `deepen-not` does not like
REVs.

For now I'm using `CI_MERGE_REQUEST_TARGET_BRANCH_NAME`[1] (The target branch
name of the merge request.), but there is a different problem with this:

GitLab supports a 2nd variant of "MR Pipelines", called "Merged Result
Pipelines"[2]: Instead of running on "topic" GitLab does a temporary merge of
"topic" into "master" (X) and runs the pipeline on that merge commit "X". As
"master" is a parent of that commit "X", the trick of using
`--shallow-exclude=master` fails as the linters then run only on the merge
commit "X", but not on the individual commits A-B-C, which is what I need:

                     A---B---C topic
                    /         \
               D---E---F---G---X master

Sadly there is no "ref" on "E" any longer, so I only can specify "E" via its
"rev", which GitLab provides as `CI_MERGE_REQUEST_DIFF_BASE_SHA`.

Any idea on how to solve this?

The GitLab runners do not have persistent storage, so they clone the git
repository anew each time. That includes the Linux Kernel git, which sometimes
takes 13m to clone the 1.4e6 commits, from which only the top 1-100 have to be
checked.
The build on the other hand only needs `--depth 1`. That makes the build way
faster than running out linters.

Philipp

[1]: https://docs.gitlab.com/ci/variables/predefined_variables/#predefined-variables-for-merge-request-pipelines
[2]: https://docs.gitlab.com/ci/pipelines/merged_results_pipelines/

