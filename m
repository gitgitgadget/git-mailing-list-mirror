Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55D7320A40
	for <e@80x24.org>; Tue,  5 Dec 2017 16:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753155AbdLEQDg (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 11:03:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58103 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753145AbdLEQDX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 11:03:23 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B73BEB2F77;
        Tue,  5 Dec 2017 11:03:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0shnzoGcyzBe5X3ul9gv8CwnFlI=; b=Zc1eKG
        UqVZ29/G41D5hdip2LkxsWRuGSdRkWv8Nf6iOhLVXq+OhjZPAOBbBNJKE/mVnrDj
        skvjKop59De51EuemXhtSN64/486ZVOh7rm+EEMgGTjjQibrnO/pzlwAJEtWuHHw
        QE15t2eH2ea0zK42DfrScyp2THM5H5f8t8F3o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Eu3UxhmAI8FBbDXy/Z5C/tuzQDzXHx9i
        o9khJZNgKBLHAM0HXFHXKtnhh1MBHilJNpwz3XjqWt43VbDTBKmdL5jFqScCTjru
        4IS976gZXNgba8ATyVJMBWjPEm0GFfnKadHlKUydCZK35rQiev4XRQfTp5VuQ7EA
        wcRC2PwM3TA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AE43DB2F76;
        Tue,  5 Dec 2017 11:03:22 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0F8CAB2F75;
        Tue,  5 Dec 2017 11:03:22 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ann T Ropea <bedhanger@gmx.de>
Cc:     Philip Oakley <philipoakley@iee.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git Mailing List <git@vger.kernel.org>,
        Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v6 4/7] checkout: describe_detached_head: remove ellipsis after committish
References: <20171203212743.10228-1-bedhanger@gmx.de>
        <20171119184113.16630-1-bedhanger@gmx.de>
        <20171113223654.27732-1-bedhanger@gmx.de>
        <83D263E58ABD46188756D41FE311E469@PhilipOakley>
        <xmqqfu9pmsx3.fsf@gitster.mtv.corp.google.com>
        <20171113223654.27732-3-bedhanger@gmx.de>
        <xmqq1sl17e1u.fsf@gitster.mtv.corp.google.com>
        <20171119184113.16630-5-bedhanger@gmx.de>
        <xmqqzi7hlhkx.fsf@gitster.mtv.corp.google.com>
        <5AE7AD53CF184A27BF8F484D415083D9@PhilipOakley>
        <xmqqo9nuuadm.fsf@gitster.mtv.corp.google.com>
        <FDCFD8EC7A754412A6369F03E91926C5@PhilipOakley>
        <CAPig+cT-r0uLLv_GyTRddPe=ATX883S1jt-8gc=ANZW21S81Mg@mail.gmail.com>
        <CAPig+cT4MvjLDvFEB6hJOSip=dqkp10ydnpfnoUabK=53OmQkw@mail.gmail.com>
        <20171124235330.15157-1-bedhanger@gmx.de>
        <xmqq4lpjkl4g.fsf@gitster.mtv.corp.google.com>
        <xmqqd145k9td.fsf@gitster.mtv.corp.google.com>
        <20171203212743.10228-4-bedhanger@gmx.de>
        <xmqqshcqmoe7.fsf@gitster.mtv.corp.google.com>
        <20171204231313.17929-1-bedhanger@gmx.de>
Date:   Tue, 05 Dec 2017 08:03:20 -0800
In-Reply-To: <20171204231313.17929-1-bedhanger@gmx.de> (Ann T. Ropea's message
        of "Tue, 5 Dec 2017 00:13:13 +0100")
Message-ID: <xmqq8tehjh6f.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D15690B8-D9D5-11E7-8164-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ann T Ropea <bedhanger@gmx.de> writes:

> v6: polish to take Junio's comments from <xmqqshcqmoe7.fsf@gitster.mtv.corp.google.com> into account

>  t/t2020-checkout-detach.sh    | 114 ++++++++++++++++++++++++++++++++++++++++++
> ...

Thanks; with this one replaced, I'd expect that poisoned gettext
test to pass now.

I saw some style issues, so I'll queue a tentative fix-up on top.

> +	# The first detach operation is more chatty than the following ones.
> +	cat 1>1st_detach <<'EOF' &&
> +Note: checking out 'HEAD^'.
> +
> +You are in 'detached HEAD' state. You can look around, make experimental
> +changes and commit them, and you can discard any commits you make in this
> +state without impacting any branches by performing another checkout.
> +
> +If you want to create a new branch to retain commits you create, you may
> +do so (now or later) by using -b with the checkout command again. Example:
> +
> +  git checkout -b <new-branch-name>
> +
> +HEAD is now at 7c7cd714e262 three
> +EOF

It looks somewhat strange to explicitly say 1> when redirecting the
standard output.  Also we prefer to indent our here-doc to the same
depth as commands by using "<<-", i.e.

	cat >1st_detach <<-'EOF' &&
	Note: checking out 'HEAD^'.
	...
	EOF

> +	reset && check_not_detached && sane_unset GIT_PRINT_SHA1_ELLIPSIS &&

It also was a bit irritating to see multiple commands form an
overlong single line, like this one.

> +	test_i18ncmp 1st_detach actual && sane_unset GIT_PRINT_SHA1_ELLIPSIS &&
> +
> +	GIT_PRINT_SHA1_ELLIPSIS="no" git -c 'core.abbrev=12' checkout HEAD^ 1>actual 2>&1 &&
> +	check_detached &&
> +	test_i18ncmp 2nd_detach actual && sane_unset GIT_PRINT_SHA1_ELLIPSIS &&

This part uses "set and export only for a single invocation of git",
and because the variable is unset at the end of the previous step
after 1st_detach and actual are compared, this unset at the end
feels redundant.

> +	GIT_PRINT_SHA1_ELLIPSIS='nope' && export GIT_PRINT_SHA1_ELLIPSIS && git -c 'core.abbrev=12' checkout HEAD^ 1>actual 2>&1 &&

But now this part sets and exports the variable for the remainder of
the script (until it is unset).

Is the use of these two styles, i.e.

	VAR=value && export VAR && git -c core.abbrev=12 subcmd
	VAR=value git -c core.abbrev=12 subcmd

intended?  If so for what purpose?  It's not like we are testing if
the shell implements environment variables correctly, so I'd expect
that the result would be easier to follow if it stuck to a single
style and used it consistently.

