Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8347C433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7233520838
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 22:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="m12VFL/o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389197AbgJLWWS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 18:22:18 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50173 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389660AbgJLWWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 18:22:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE76CF2F31;
        Mon, 12 Oct 2020 18:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K2wM3kguFUmeFbWMY6OIDVNrQJE=; b=m12VFL
        /omprfXxdu+EnfM2+qPyRfQl+2FNHD/ddTmYib3Ynod0Cvtrh4SMPE8EZK5zEdvR
        ORLeH71mAY1vCgtz9iK8RE7tmgM2caZZkz/wNDM1OEt3HyTxn+R4vRt9o+WYyayH
        VI3lAQv9ZDS7nM6+vSv+SBCv9oQC0xCahqgXQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DgqGNk26Dwc7U3VpEzibbj0w8FQTS2Ph
        CJx6mSAnSrFAJGxuuC7Q9CfXMWaW+OXjrGLi3b6lLsGBR495BIwdV82EvYtoAA85
        tWwFHhva0TReGjGGNridRWC8qCsxShXa2uFcL7o2c0RnCpRB8id5NvhQLrOuHTsi
        ZHzpYNMr1c0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D61C9F2F30;
        Mon, 12 Oct 2020 18:22:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2FC43F2F2F;
        Mon, 12 Oct 2020 18:22:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Michael J Gruber <git@grubix.eu>,
        Matthieu Moy <git@matthieu-moy.fr>,
        John Keeping <john@keeping.me.uk>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v3 1/3] t: add lib-crlf-messages.sh for messages
 containing CRLF
References: <pull.576.v2.git.1583807093.gitgitgadget@gmail.com>
        <pull.576.v3.git.1602526169.gitgitgadget@gmail.com>
        <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com>
Date:   Mon, 12 Oct 2020 15:22:10 -0700
In-Reply-To: <f17d182c3bf5e758490441801423cdb0da17060d.1602526169.git.gitgitgadget@gmail.com>
        (Philippe Blain via GitGitGadget's message of "Mon, 12 Oct 2020
        18:09:27 +0000")
Message-ID: <xmqqlfgbm6el.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5FF2AFE4-0CD9-11EB-B714-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> A following commit will fix a bug in the ref-filter API that causes
> commit and tag messages containing CRLF to be incorrectly parsed and
> displayed.
>
> Add a test library (t/lib-crlf-messages.sh) that creates refs with such
> commit messages, so that we can easily test that this bug does not
> appear in other commands in the future.
> ...
> The function `test_crlf_subject_body_and_contents` can be used to test
> that the `--format` option of `branch`, `tag`, `for-each-ref` and
> `log` correctly displays the subject, body and raw content of commits and
> tag messages.

I am not sure about the wisdom of this arrangement.  Surely you do
not want to write duplicated set-up for (existing) test scripts for
for-each-ref, branch and tag subcommands, assuming that these test
scripts are separated for subcommands they test.

But you can have a single test script, that is differentiated from
all other test scripts by what it tests: having to deal with commits
that use CRLF.  Then we do not have to add dot-includable test
library that lets various tests to create these same funny commits.
Instead, we can just do these as normal set-up step(s) for that
single test scripts, and then in that test scripts, verify what is
shown by various commands that share the underlying ref-filter
machinery.  No?


> diff --git a/t/lib-crlf-messages.sh b/t/lib-crlf-messages.sh
> new file mode 100644
> index 0000000000..10a2b57280
> --- /dev/null
> +++ b/t/lib-crlf-messages.sh
> @@ -0,0 +1,90 @@
> +# Setup refs with commit and tag messages containing CRLF
> +
> +LIB_CRLF_BRANCHES=""
> +
> +create_crlf_ref () {
> +	message="$1" &&
> +	subject="$2" &&
> +	body="$3" &&
> +	branch="$4" &&
> +	printf "${message}" >.crlf-message-${branch}.txt &&
> +	printf "${subject}" >.crlf-subject-${branch}.txt &&
> +	printf "${body}" >.crlf-body-${branch}.txt &&
> +	LIB_CRLF_BRANCHES="${LIB_CRLF_BRANCHES} ${branch}"
> +	test_tick &&
> +	hash=$(git commit-tree HEAD^{tree} -p HEAD -F .crlf-message-${branch}.txt) &&
> +	git branch ${branch} ${hash} &&
> +	git tag tag-${branch} ${branch} -F .crlf-message-${branch}.txt --cleanup=verbatim
> +}
> +
> +create_crlf_refs () {
> +	message="Subject first line\r\n\r\nBody first line\r\nBody second line\r\n" &&
> +	body="Body first line\r\nBody second line\r\n" &&
> +	subject="Subject first line" &&
> +	branch="crlf" &&
> +	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
> +	message="Subject first line\r\n\r\n\r\nBody first line\r\nBody second line\r\n" &&
> +	branch="crlf-empty-lines-after-subject" &&
> +	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
> +	message="Subject first line\r\nSubject second line\r\n\r\nBody first line\r\nBody second line\r\n" &&
> +	subject="Subject first line Subject second line" &&
> +	branch="crlf-two-line-subject" &&
> +	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
> +	message="Subject first line\r\nSubject second line" &&
> +	subject="Subject first line Subject second line" &&
> +	body="" &&
> +	branch="crlf-two-line-subject-no-body" &&
> +	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
> +	message="Subject first line\r\nSubject second line\r\n" &&
> +	branch="crlf-two-line-subject-no-body-trailing-newline" &&
> +	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}" &&
> +	message="Subject first line\r\nSubject second line\r\n\r" &&
> +	branch="crlf-two-line-subject-no-body-trailing-newline2" &&
> +	create_crlf_ref "${message}" "${subject}" "${body}" "${branch}"
> +}
> +
> +test_create_crlf_refs () {
> +	test_expect_success 'setup refs with CRLF commit messages' '
> +		create_crlf_refs
> +	'
> +}
> +
> +cleanup_crlf_refs () {
> +	for branch in ${LIB_CRLF_BRANCHES}; do
> +		git branch -D ${branch} &&
> +		git tag -d tag-${branch} &&
> +		rm .crlf-message-${branch}.txt &&
> +		rm .crlf-subject-${branch}.txt &&
> +		rm .crlf-body-${branch}.txt
> +	done
> +}
> +
> +test_cleanup_crlf_refs () {
> +	test_expect_success 'cleanup refs with CRLF commit messages' '
> +		cleanup_crlf_refs
> +	'
> +}
> +
> +test_crlf_subject_body_and_contents() {

It does not excempt a script from being subject to the coding
guidelines to be a test library.

> +	command_and_args="$@" &&
> +	command=$1 &&
> +	if [ ${command} = "branch" ] || [ ${command} = "for-each-ref" ] || [ ${command} = "tag" ]; then
> +		atoms="(contents:subject) (contents:body) (contents)"
> +	elif [ ${command} = "log" ] || [ ${command} = "show" ]; then
> +		atoms="s b B"
> +	fi &&

This is the part that made me react to the organization.  Even
though this helper "library" pretends to be generic, it needs to
actually know exactly what subcommands are going to be tested with
the helper.  It is probably easier to read and understand if these
helper functions are defined in the same script as the one that
tests these various commands but for one specific aspect of these
commands (i.e. how the log message with funny line ending convention
are split into subject and body).

> +	files="subject body message" &&
> +	while  [ -n "${atoms}" ]; do
> +		set ${atoms} && atom=$1 && shift && atoms="$*" &&
> +		set ${files} &&	file=$1 && shift && files="$*" &&
> +		test_expect_success "${command}: --format='%${atom}' works with CRLF input" "
> +			rm -f expect &&
> +			for ref in ${LIB_CRLF_BRANCHES}; do
> +				cat .crlf-${file}-\"\${ref}\".txt >>expect &&
> +				printf \"\n\" >>expect
> +			done &&
> +			git $command_and_args --format=\"%${atom}\" >actual &&
> +			test_cmp expect actual
> +		"
> +	done
> +}
