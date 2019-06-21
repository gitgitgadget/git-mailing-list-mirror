Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B9D621F461
	for <e@80x24.org>; Fri, 21 Jun 2019 17:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726031AbfFURbx (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 13:31:53 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56852 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbfFURbx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 13:31:53 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9C530723BB;
        Fri, 21 Jun 2019 13:31:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=R5S9Kaa//rKeDuGZ5AKCR3xtu3A=; b=MNBPBT
        +2Jfu9mPNFHbqoSLGvWOGcWCRUVJZyMli2MUvBqNXNSEE16bjW9ihxrEwYSwnHfS
        ynvEACkyhfNlceUQq95AZ1RKDJrJSoO0gcXmFb3iWBhlVKmtQuqDFQP7WdFhclcs
        iEPEeQjYXxSc2T/0Et2dnQWjqrgQ04KCBS7LM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FtzYIDDIjv4Jig01Oh6DgzttNLTmNnQZ
        k86VQOjmNIayG078qnjGc1FcDzI78RK7dnBbrH5k0nNtaUZba/wMj5lh6HIBscQv
        EF7yzgJdyMr4SdJDFixG/lLViOIi39R033wp4q7uindFiSa9DL5LKMKy+nxWNOLD
        Nkk49hbrH64=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9464C723BA;
        Fri, 21 Jun 2019 13:31:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B827A723B9;
        Fri, 21 Jun 2019 13:31:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/1] t0001: fix on case-insensitive filesystems
References: <pull.151.git.gitgitgadget@gmail.com>
        <pull.151.v2.git.gitgitgadget@gmail.com>
        <c2fdcf28e725c91a1a48c34226223866ad14bc0a.1560978437.git.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.1906211632570.44@tvgsbejvaqbjf.bet>
Date:   Fri, 21 Jun 2019 10:31:44 -0700
In-Reply-To: <nycvar.QRO.7.76.6.1906211632570.44@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 21 Jun 2019 16:34:04 +0200 (CEST)")
Message-ID: <xmqqh88ikfpb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 71B574D6-944A-11E9-A8D9-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> [Re-sending, as the Git mailing list seems to have decided to silently
> drop this patch, I cannot see it on public-inbox.org, at least]

Move that below the three-dash lines; otherwise the above two lines
will make your in-body From: ineffective.

>
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> On a case-insensitive filesystem, such as HFS+ or NTFS, it is possible
> that the idea Bash has of the current directory differs in case from
> what Git thinks it is. That's totally okay, though, and we should not
> ...
> Let's address this by forcing the comparison to be case-insensitive when
> `core.ignoreCase` is `true`.
>
> Reported by Jameson Miller.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/t0001-init.sh | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/t/t0001-init.sh b/t/t0001-init.sh
> index 42a263cada..68f713884f 100755
> --- a/t/t0001-init.sh
> +++ b/t/t0001-init.sh
> @@ -307,10 +307,22 @@ test_expect_success 'init prefers command line to GIT_DIR' '
>  	test_path_is_missing otherdir/refs
>  '
>
> +downcase_on_case_insensitive_fs () {
> +	test true = "$(git config --get --type=bool core.ignorecase)" ||
> +	return 0
> +
> +	for f
> +	do
> +		tr A-Z a-z <"$f" >"$f".downcased &&
> +		mv -f "$f".downcased "$f" || return 1

It is easier to read to enclose the whole filename inside dq pair,
i.e.

		tr A-Z a-z <"$f" >"$f.downcased" &&
		mv -f "$f.downcased" "$f" || return 1

Not grave enough to be worthy of a reroll on this one alone, though.

>  test_expect_success 'init with separate gitdir' '
>  	rm -rf newdir &&
>  	git init --separate-git-dir realgitdir newdir &&
>  	echo "gitdir: $(pwd)/realgitdir" >expected &&
> +	downcase_on_case_insensitive_fs expected newdir/.git &&

It is somewhat brittle to munge what is in "newdir/.git", which will
affect later tests that use newdir/ as a repository (this one will
be removed soon, but the last one in the sequence this patch touches
will persist and is used by other tests).  It's not like we are
testing that Git will function OK even after futzing with the ".git"
pointer file (if so, we'd want a separate test that specifically is
designed to test that behaviour).

I wonder if we want (possibly local) test_cmp_fspath that can be
used more like

	test_cmp_fspath "$(pwd)/realgitdir" "$(sed -e "s/^gitdir: //" newdir/.git)"

to compare two paths, honoring the case sensitivity of the
filesystem.

>  	test_cmp expected newdir/.git &&
>  	test_path_is_dir realgitdir/refs
>  '
> @@ -365,6 +377,7 @@ test_expect_success 're-init to update git link' '
>  	git init --separate-git-dir ../surrealgitdir
>  	) &&
>  	echo "gitdir: $(pwd)/surrealgitdir" >expected &&
> +	downcase_on_case_insensitive_fs expected newdir/.git &&
>  	test_cmp expected newdir/.git &&
>  	test_path_is_dir surrealgitdir/refs &&
>  	test_path_is_missing realgitdir/refs
> @@ -378,6 +391,7 @@ test_expect_success 're-init to move gitdir' '
>  	git init --separate-git-dir ../realgitdir
>  	) &&
>  	echo "gitdir: $(pwd)/realgitdir" >expected &&
> +	downcase_on_case_insensitive_fs expected newdir/.git &&
>  	test_cmp expected newdir/.git &&
>  	test_path_is_dir realgitdir/refs
>  '
> --
> gitgitgadget
