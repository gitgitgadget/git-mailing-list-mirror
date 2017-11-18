Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C7A3D202F2
	for <e@80x24.org>; Sat, 18 Nov 2017 01:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1764002AbdKRBdU (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Nov 2017 20:33:20 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57745 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752048AbdKRBdT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Nov 2017 20:33:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB8E4B9C0A;
        Fri, 17 Nov 2017 20:33:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iHdazdU1RgN6bJIV9OXeS2tBh68=; b=iC2gjo
        SIQCXH3G1zNfset8Aw6vz2l3qw+aaTHsF+W5bAn0pao7gOf5F9HxMURIM0UevMVC
        8PTviuB40TSa7P/MNe1l+a9WXbApqZwS98eaY5edefuVh4ipDdPUXpajZzwlASyv
        Pa+9S6TkvcAjI3JUKGxaipHUSbf+qtuiqdPWA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kSk9GirLEWBo6MMG3MSY7/7S8/j+e9i4
        8ITH9iIkgytPJmrY7XJBmXl0Pa8MQvbxlpUxupXH9gYYi7rtNqwmPKkY1ujC3dtQ
        9WmFG1T+i7p1rB9Z+2ZtGylDPsnMsjlHPAoCpaNIqvvByDTpzCB5Yor4NT+iQLUr
        UcKNzBfORxo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4039B9C09;
        Fri, 17 Nov 2017 20:33:18 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0F1E0B9C08;
        Fri, 17 Nov 2017 20:33:17 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Bensoussan <danielbensoussanbohm@gmail.com>
Cc:     git@vger.kernel.org,
        ALBERTIN TIMOTHEE 11514771 
        <timothee.albertin@etu.univ-lyon1.fr>
Subject: Re: [PATCH 1/2] Documentation about triangular workflow
References: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
Date:   Sat, 18 Nov 2017 10:33:16 +0900
In-Reply-To: <20171117160759.6397-1-daniel.bensoussan--bohm@etu.univ-lyon1.fr>
        (Daniel Bensoussan's message of "Fri, 17 Nov 2017 17:07:58 +0100")
Message-ID: <xmqqlgj4qskj.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 74441FF4-CC00-11E7-AFA4-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Bensoussan <danielbensoussanbohm@gmail.com> writes:

> +TRIANGULAR WORKFLOW
> +-------------------
> +
> +Introduction
> +~~~~~~~~~~~~
> +
> +In some projects, contributors cannot push directly to the project but
> +have to suggest their commits to the maintainer (e.g. pull requests).
> +For these projects, it's common to use what's called a *triangular
> +workflow*:
> + ...
> +Motivations
> +~~~~~~~~~~~
> +
> +* Allows contributors to work with Git even if they don't have
> +write access to **UPSTREAM**.
> +
> +Indeed, in a centralized workflow, a contributor without write access
> +could write some code but could not send it by itself.  The contributor
> +was forced to create a mail which shows the difference between the
> +new and the old code, and then send it to a maintainer to commit
> +and push it.  This isn't convenient at all, neither for the
> +contributor, neither for the maintainer. With the triangular
> +workflow, the contributors have the write access on **PUBLISH**
> +so they don't have to pass upon maintainer(s).  And only the
> +maintainer(s) can push from **PUBLISH** to **UPSTREAM**.
> +This is called a distributed workflow (See "DISTRIBUTED WORKFLOWS"
> +above).

I probably should not be judging if these additions to
gitworkflows.txt is a good idea in the first place without seeing
any explanation as to why this patch is here, but I think it misses
the place where "triangular" sits in a larger picture.

The workflow to contrast against to illustrate the motivation is a
centralized workflow, where everybody pushes their updates to a
single place.  It does have problems inherent to its structure
(e.g. "review before integration" is much harder, if possible), and
also has its merits (e.g. it is simpler to explain and reason
about).

If you want to wean a project off of the centralized model, you'd
need to use the "distributed workflow".  The workflow to review and
apply mailed patches in public, and the workflow to have the project
pull from many publish repositories individual contributor has, are
two that allows the project to go distributed.  These two are
complementary choices with pros and cons, and it is not like one is
an improvement of the other.  Projects like the kernel even uses
hybrid of the two---the patches are reviewed in public at central
places (i.e. subsystem mailing lists) in an e-mail form and go
through iterations getting polished, and the polished results are
collected by (sub)maintainers and sent upwards, either as a request
to pull from publish repositories maintained by (sub)maintainers, or
relayed again in e-mail form (the last mile being e-mail primarily
serves as a transport vehicle for changes proven to be good, not as
material to be further reviewed).

The reason why projects make these choices is because there are pros
and cons.  A large collection of changes is far easier to integrate
with one command (i.e. "git pull") and with a need to resolve merge
conflicts just once, than applying many small changes as e-mailed
patches, having to resolve many conflicts along the way.  In order
to ensure quality of the individual changes, however, the changes
need to be reviewed and polished, and the reality of the life is
that there are far fewer people who are qualified to adequately
review and help polishing the changes than those who make changes.
Asking reviewers to go to different repositories (whose number
scales with the number of contributors) and leave comments in the
webforms is much less efficient and more costly for the project
overall, than asking them to subscribe to relevant mailing lists
(whose number scales only with the number of areas of interest) and
conduct reviews there.  Other factors like "offline access" also
count when considering the two models as "choices".

As long as the document uses phrases like "forced to", "isn't
convenient at all", etc., it is clear that it starts from a wrong
premise, "one is an improvement over the other".


