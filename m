Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 212C31F454
	for <e@80x24.org>; Thu,  7 Nov 2019 05:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725940AbfKGFLo (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 00:11:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59594 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKGFLo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 00:11:44 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 733408C937;
        Thu,  7 Nov 2019 00:11:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GCrFbao2h6/vCYdfvrtZ0h4HaLk=; b=cIfUj+
        I16MjnVLgmqiX3qyHNIz1nP7xAaNMNu3W4TXng/TF9le3oaiHirsxUc5QBfWBpyF
        0dRoVz5WjFhrWRTGnISW/c/gmyw+jksXklop8rEMNh/7Ixxjwaf7rdXv6YNztg31
        w9w3O1C55eRqxWAsHHJT2BfCWepxhCqNdsiQE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dd6ujSwiIMIoXnU/LSXP1snjur9+40ek
        meJb94w19q0Ove71yVQVofJtcRMr1D/c0ORy/pNO+Za5L97evgBENqqQdi+pIxwM
        HvvJ5TEqVRWL2slkB6tzGSsGRNtyfL7RnoWtk94TEoslMBHK6YNu0qlhVGxt47ov
        CRQcDXNEJFY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6C1F18C935;
        Thu,  7 Nov 2019 00:11:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 9ED6D8C933;
        Thu,  7 Nov 2019 00:11:40 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 03/11] Prefer 'up-to-date' spelling
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
        <466aead9af6516ff94a5d217e58ab894e63088b7.1572973651.git.gitgitgadget@gmail.com>
Date:   Thu, 07 Nov 2019 14:11:38 +0900
In-Reply-To: <466aead9af6516ff94a5d217e58ab894e63088b7.1572973651.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Tue, 05 Nov 2019
        17:07:22 +0000")
Message-ID: <xmqqlfsss22d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 15068D2A-011D-11EA-9091-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  gitk-git/gitk                  | 2 +-
> ...
> diff --git a/gitk-git/gitk b/gitk-git/gitk
> index abe4805ade..50a5b60c13 100755
> --- a/gitk-git/gitk
> +++ b/gitk-git/gitk
> @@ -9696,7 +9696,7 @@ proc cherrypick {} {
>      if {[catch {exec sh -c "git cherry-pick -r $rowmenuid 2>&1"} err]} {
>  	notbusy cherrypick
>  	if {[regexp -line \
> -		 {Entry '(.*)' (would be overwritten by merge|not uptodate)} \
> +		 {Entry '(.*)' (would be overwritten by merge|not up-to-date)} \
>  		 $err msg fname]} {
>  	    error_popup [mc "Cherry-pick failed because of local changes\
>  			to file '%s'.\nPlease commit, reset or stash\

Not very satisfactory for two reasons.

Procedurally, I'd strongly prefer to see any patch that touches
"gitk" (and similarly "git-gui" and "po") to be separated from the
rest, and not directly sent to me.  Further, "gitk" is merged
one-way into my tree with -Xsubtree=gitk (similarly for "git-gui"),
so a patch to it would be to change "a/gitk" to "b/gitk".

Content-wise, because "gitk" (and similarly "git-gui") is a project
that stands on its own, we (at least this is a wish by its primary
author and maintainer the last time I checked with him) want to make
sure that slightly older/newer gitk is interoperable with slightly
newer/older git.  Preparing to also see "uptodate" emitted by the
version of git it runs would be a good way to achieve this.

We do not promise interoperability between vastly different versions
forever, by the way.  I see "cherry-pick -r" used in the precontext,
but "--replay" has been the default for the command for the past
dozen years, and now it is just an unadvertised noop.  It probably
is OK now to remove "-r" from the invocation here ;-)

Thanks.
