Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC92FC433FE
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 16:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiJUQra (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 12:47:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJUQrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 12:47:16 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C516126C459
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 09:46:51 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 40F6C15A2E3;
        Fri, 21 Oct 2022 12:42:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EBJJxCowRBoJAJaavm4KNBEsYY4WG/t2hN1mbE
        rQq4A=; b=lceKmaki7Aw0qVUaBcTaaBcH5FPU5QUJSI42u/lKL+CjmjVhruoD3P
        Y33sflkDr9HjU8dqhzpuzo2yXo3H2/FXoEFHtEZqzeosvzrzNbimIO45IeIHeY96
        mZGbamWnOG6sisNuUEOt1ZvDqPy2zVcXsbzhCEQOOtzOZkV94RyyU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3880715A2E2;
        Fri, 21 Oct 2022 12:42:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9DFB415A2E1;
        Fri, 21 Oct 2022 12:42:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, git-security@googlegroups.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Julia Ramer <prplr@github.com>,
        Keanen Wold <keanenwold@github.com>,
        Veronica Giaudrone <veronica.Giaudrone@microsoft.com>,
        Bri Brothers <brbrot@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Julia Ramer <gitprplr@gmail.com>
Subject: Re: [PATCH v3] embargoed releases: also describe the git-security
 list and the process
References: <pull.1345.v2.git.1666142160427.gitgitgadget@gmail.com>
        <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 09:42:57 -0700
In-Reply-To: <pull.1345.v3.git.1666338109778.gitgitgadget@gmail.com> (Julia
        Ramer via GitGitGadget's message of "Fri, 21 Oct 2022 07:41:49 +0000")
Message-ID: <xmqqo7u5m8ku.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B8F7482-515F-11ED-8582-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Julia Ramer via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Ramer <gitprplr@gmail.com>
>
> With the recent turnover on the git-security list, questions came up how
> things are usually run. Rather than answering questions individually,
> extend Git's existing documentation about security vulnerabilities to
> describe the git-security mailing list, how things are run on that list,
> and what to expect throughout the process from the time a security bug
> is reported all the way to the time when a fix is released.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Helped-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Julia Ramer <gitprplr@gmail.com>
> ---

Thanks.  Everything looks good, except for a few minor things.

> +Typical timeline
> +----------------

A much better section title; I like it.

> +- Code review can take place in a variety of different locations,
> +  depending on context. These are: patches sent inline on the
> +  git-security list, a private fork on GitHub associated with the
> +  draft security advisory, or the git/cabal repository.

Here, we name "the git/cabal repository" but the word never appears
again in the document, we later refer to the same thing "private
repositories that are owned by the Git project, with tightly
controlled access", but to outsiders, it is not clear that they are
the same thing.  Perhaps writing

    ..., or the git/cabal repository (private repository owned by
    the Git project with tightly controlled access).

here, and replacing the later reference with just "the git/cabal
repository", would be sufficient.

> +  Contributors working on a fix should consider beginning by sending
> +  patches to the git-security list (inline with the original thread),
> +  since they are accessible to all subscribers, along with the original
> +  reporter.

Mark-up glitch.  This one is formatted as a <pre>...text...</pre>
under the above bullet point.  Logically this is still a part of the
above bullet point (i.e. its second paragraph), so we'd need to
replace the blank line above this second paragraph with a line with
single '+' and nothing else on it, and de-dent this second paragraph.

Or we can make it a separate bullet point, which may make it simpler
to read in the source form.

> +- Once the review has settled and everyone involved in the review agrees that
> +  the patches are ready, the Git maintainer, and others determine a release date
> +  as well as the release trains that are serviced. The decision regarding which

We typically know how involved the final changes would be (i.e. the
minimum time it would take for us and involved others to prepare the
release) way before all the t's are crossed and i's are dotted in
the patches, so setting the release date may be done much earlier.

> +- While the Git community does its best to accommodate the specific timeline
> +  requests of the various binary packagers, the nature of the issue may preclude
> +  a prolonged release schedule. For fixes deemed urgent, it may be in the best
> +  interest of the Git users community to shorten the disclosure and release
> +  timeline, and packagers may need to adapt accordingly.

I briefly wondered if we need to say something about stakeholders
other than packagers (e.g. hosting sites), but it would probably be
obvious to readers that those who can deploy before releasing their
version of the sources have enough flexibility to cope better, so
the above would be fine.

> +- Subsequently, branches with the fixes are pushed to private repositories that
> +  are owned by the Git project, with tightly controlled access.

    ... with the fixes are pushed to the git/cabal repository.

> +- The tags are created by the Git maintainer and pushed to the same
> +  repositories.

Just like "review can take place in multiple places; contributors
are encouraged to start from ..." was made into a single bullet
point, "branches are privately published to git/cabal; tags are
added to the same repository." may flow well in the same single
bullet.  I dunno.

> +- Less than a week before the release, a mail with the relevant information is
> +  sent to <distros@vs.openwall.org> (see below), a list used to pre-announce
> +  embargoed releases of open source projects to the stakeholders of all major
> +  distributions of Linux as well as other OSes. This includes a Git bundle
> +  of the tagged version(s), but no further specifics of the vulnerability.

I am not sure how much value it adds to have ", but no further..."
at the end.  Anybody who sees this e-mail has the Git bundle, which
is relative to the last stable release, and can be used to create
the full source of the releases by anybody who has access to the
public Git repositories.  The source includes the release notes in
the Documentation/RelNotes/ directory that describe everything to
know about the vulnerabilities the releases address.

    ... This includes a Git bundle of the tagged version(s), using
    which the full source code for the releases can be created by
    the recipients to prepare their release artifacts in a clone of
    the public Git repository.

