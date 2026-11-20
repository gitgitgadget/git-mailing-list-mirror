Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.152
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795204963;
	b=Ugs5N9/Y4YccWpsayaSzHJY3wyY1hyhMk1fXat3cI9Kum4RFaqD9Ix+lc7gfuABQ1S3H
	 gc5kDWEshj6wQrMxGqxmer36y+MDlkxKInySyYuoBaPBIzn2w/cOV2e6UVOj/B5vWYBMU
	 uXqooJS6NfO04aPPxvgKtv/sgJFWPMUVCW0/oxSlNVypzkO4QkHEV5L3fLzKpOxLT5ROA
	 2RTt0WugL+YFGi3WmtPSiG48OjTWHkATUO7n4WpEJwuu5TYPC0OB02LOnsJBvw+IrbrTs
	 F5dJv1izXBW1ntFH5QLABPrH9mJ5ZiV/YW0GfhY2RjZwacOVNPf02qMvU1pAUmWVNlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795204963;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 User-Agent:MIME-Version:Content-Type;
	bh=NePIFpj9ULUReh/biaR1Sp/GAxgAa+a5CQtPVIfGkmw=;
	b=gtOm4hriWX6ZGAiDhxTwtdilSA0AD4apli3hqtPBQTpceR9ALWFzJVNzXURZ2N8jmGbN
	 IBm9Razabv7r9ZF5q0DqWMCIsmvWlcwvD+6PJYGheK8A3acg4LS7v2WOFED8o3EPNuu5P
	 s3nlVg0NcFplZXSQ/weLzig7sOUlZnP/sSs1DgIn9euDNePH7ueZbBnKY/s2dITou4v+/
	 Hdw6EENHE6wUfPPbrXbSEIqflN8rJlHeY1PQaFLnvgnA5vEpSpsdqH6Yy5b0juXZRplqV
	 GXYz3bfnNmsEpD1WgLlB08e35RVhGrAvDa8R2O8iPQLctWIZc2EalrLoFo7bq7nIihA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pobox.com;
	spf=pass smtp.mailfrom=pobox.com;
	dkim=pass header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SstlzQxz;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="We/GshGy";
	arc=none smtp.remote-ip=103.168.172.152
Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 689E7606A6F4
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 20:02:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 689E7606A6F4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pobox.com header.i=@pobox.com header.a=rsa-sha256 header.s=fm2 header.b=SstlzQxz;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=We/GshGy
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90204140014D
	for <git@vger.kernel.org>; Fri, 20 Nov 2026 15:02:40 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 20 Nov 2026 15:02:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1795204960; x=1795291360; bh=NePIFpj9UL
	UReh/biaR1Sp/GAxgAa+a5CQtPVIfGkmw=; b=SstlzQxz0Tuc0ACOJnPiwM6ffL
	HW3XjjBR83hkeC+E8/Kg1hOROzPqrdkHeQl5ikf7oQdNWfSv5s47eVl30m2NLgol
	xXQLG86NxXBC40nXfTdiosBa3GQjr9gWCnUzkDlOGzjakk/6gJnm62fRnveQcpkd
	Tgr+j5PbPl11f15Fd3VcYRjlAR0SnktXoBjKNF5LernY94tqZ6tsXblkbrFrdKbE
	DK4zm2pOvdFdfue+M5NXWnk29bxxmwQpS1DGfES1i3RUe0IvesqhEb5hPgpaW1IC
	A8v31mGnqtG/Dyo21iFQy9hB1ecxEx5PqXSPj4vQtg9AEXSVRdDs4gKseM1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1795204960; x=1795291360; bh=NePIFpj9ULUReh/biaR1Sp/GAxgAa+a5CQt
	PVIfGkmw=; b=We/GshGyMJTIf3SWhpuAe7n7X97yaNnyZupw6by5cd7A9PxhlW+
	pMC3YkJkmFJO9hF/7uwI1TYBT/+TiG/ZZzmYVsGrnqXcu3K2yfArlxvzpd9OHAgX
	9oiNCav4kBxDG1bXWY2hw1cadvF88sCj1CFUlmEBW8KQBV22VGpb0bheQaX2cypR
	T8vyhUzyu3bv7Ow8hmvkmSOU3QVibsdDUkvmGC4r5+ksXvB6MnZYlAscnfvTa2sw
	COQ9dmNRjzEwxz+9M2vpFuY02d/CwWTxDlWrtntq94CsKMBkA/Gatfeip1UAD6lr
	ZTTH64OWnv4cOxmV2JEbwnN4OhFMlV81WlA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1795204960; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NqZg18+AMwEncn6iyVrdLMAZwjkJgNSO8r9SrmFI56ZELbk
	9LmWe6XOKWsQTc+Yxf49M3QFnLIwzyHebV2Sut0bAFZg07imP28sGq84xRJOFwre
	yZYAaxdz+J0culvfajceUf8spDQaPFHJmQcN2of/PPN09bcXrmTc9menDGynmKjl
	PBQ0upXGNkz9bJJR63o+h4VqVrPd/3ElO3OhE+hB3n0eWtA6bWjwuPTz01fEgOyj
	jDPqbxanocM+iWD+9GE5SPW0kqN1m9NVBWY3ML6aQVEVxMmtJNr2YbMz9b0f33Jr
	dhDC5gzx4drsQjBYjhFk/4du8LKniA7R7mp6M8A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:YZ2WN6Um4KrClb6DDCCDd2iHGpzhk09JtzlF9lAjZGE=:NJcMunXehNfr5im64Pp8yvtMdVQNMPVe3PaSehrcxz0=;
X-ME-Sender: <xms:YKcAa38H-mufpwmQHHWH-4xccTaxJI8gHK3CHfPbN4zmNzrzBKYudA>
    <xme:YKcAa2Qr-dkCQcNnH1c2d2sa6aGPMfqswRDOqzuonviJhrR4v82eivNN5AAenUCHo
    nFsOZjkaW0oMkrALxburR9HQDPoan7rxjALaIHCUET1Pkl31r7jvz4>
X-ME-Received: <xmr:YKcAa4omYetc8AuA5K3TcVhnLrsCZseT-llzHspVf7QzZUR3r_89wVZiZCWdVW_2vPAyd6YRxgPXQlNr0NdsksNtvve-AEZd63Gt>
X-ME-Proxy-Cause: dmFkZTEJtRUkOKUE+uNMQXjiMrK1EgIWfe6Evf3zAcbfUf1EI6445ESFAsrpG2Jw8MEkJR
    1hocRljot7U5Hfa8gFN6R/wfKQ1zEx65AEhuJErAEy8sPBmK9LUl+SiTpbL50Yc9NyvY77
    bHXs4l1XH9kHZ30qLr4rBslRK+7bDNyqHb/QxcKQMDcMaktqaNjRUP9fkOY/rwH7eq6wQU
    GMmBzooizrCgoojbODNkNEoBUnthRm09bClNnKYQMmBACCXIniboWgBSH5EvzjvTDwJsCv
    ZHJ5CamiRHJcIt2fR+ZcjTFt5HvKHTDtqdqqpgbK9KgWC7iAjLfZO4zNbl/C+VUIwn1mNi
    Lhw4jI63HN3kG7tKkoaR9J1CEUXBjDoJX4mobAT2p6dGlR9gyAfc/hMI6T3q7Gz2gjt0+m
    Ww6T5ODqXy+TEcm5MEIyBmSEJIo5SGf943u65l1MMmg+zqT4raNp2Lu8Ty7uBiHR1WLEL+
    Rt2z15/nmW+0RfS+B4itx0JPZnP2OBqe7yBoIIBqkyij/a1uc/WEIszx5inwpQCKSGU1vt
    EyNccuNllMBbLzgGaWUU5qqqde6BcH6/PW9kZSt0JLzB2u39TJhR+t3ewXLeAjV+h8n+dt
    glBpR5PAwPhgpw/qYjS3/xq2iZPTes5EbAY/VWEx1eKF9LsRCxv+5z5XFqGw
X-ME-Proxy: <xmx:YKcAazkawsH5QBF1oAOFx8H120cwTLmZrqN7bfS314hx1v6G5j-CAA>
    <xmx:YKcAaxeQQP_dlKzJQnqK3hCl_Wi3CjAF-vdIP8IHJWxJ1DMGBY8Hyg>
    <xmx:YKcAa_q5x4izT9UAgpgN2Se9F80dLiAiRmz9j6cV8dMRysISN9zcyw>
    <xmx:YKcAa7PHn7WFiinWMMnhdy-EssakOkmaVNjc463zBXID915eve9vaw>
    <xmx:YKcAa0HuDNteW7nnrS_XyuvkpnkNFq2xJVZf89E-4Es1VzpCErmGflPY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 20 Nov 2026 15:02:39 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Jasper
 Mayone <me@jaspermayone.com>,  Tuomas Ahola <taahol@utu.fi>,  Harald
 Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH v9 3/4] branch: add --delete-integrated to delete rebase
 and squash merged branches
In-Reply-To: <1f922a00344f6b86dcc0054b3117f1bbad247810.1795184664.git.gitgitgadget@gmail.com>
	(Harald Nordgren via GitGitGadget's message of "Fri, 20 Nov 2026
	14:24:23 +0000")
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
	<pull.2425.v9.git.git.1795184664.gitgitgadget@gmail.com>
	<1f922a00344f6b86dcc0054b3117f1bbad247810.1795184664.git.gitgitgadget@gmail.com>
Date: Fri, 20 Nov 2026 12:02:38 -0800
Message-ID: <xmqqzev3nue9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v9 3/4] branch: add --delete-integrated to delete rebase and squash merged branches

The title is on a tad overlong side.

"rebase and squash merged branches" sounds awkward.  If a branch got
intergrated by squash merging is called "squash-merged branch",
shouldn't a branch that underwent "git rebase" to sit on top of the
upstream be called "rebased branch"?

IOW, "rebased or squash-merged branches"?

> diff --git a/Documentation/config/branch.adoc b/Documentation/config/branch.adoc
> index c2acd89c99..be9b296bda 100644
> --- a/Documentation/config/branch.adoc
> +++ b/Documentation/config/branch.adoc
> @@ -106,7 +106,7 @@ for details).
>  
>  `branch.<name>.deleteMerged`::
>  	If set to `false`, branch _<name>_ is exempt from
> -	`git branch --delete-merged`.  Useful for a topic branch you
> -	intend to develop further after an initial round has been
> -	merged upstream.  Defaults to true.  Explicit deletion via
> -	`git branch -d` is unaffected.
> +	`git branch --delete-merged` and `--delete-integrated`.  Useful
> +	for a topic branch you intend to develop further after an
> +	initial round has been merged upstream.  Defaults to true.
> +	Explicit deletion via `git branch -d` is unaffected.

Does the deleteMerged configuration variable affect the behavior of
the "--delete-integrated" option?  Knowing how the feature evolved,
it is understandable to me, but I suspect it won't be natural for
mere mortals.

Perhaps a single .deleteDone variable that governs both would be
more future-proof, as it anticipates that we may find other ways a
branch becomes "done", other than by getting merged or otherwise
integrated, and when that happens this variable will also deal with
such a new destructive operation.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 44336eef81..54461e90b3 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1963,6 +1963,39 @@ check_branches () {
>  	test_cmp expect actual
>  }
>  
> +test_expect_success '--delete-merged does not delete unrelated branches' '
> +	setup_repo_for_delete_merged &&
> +	(
> +		cd repo &&
> +		git checkout -b unrelated-topic --track origin/next &&
> +		test_write_lines 1 2 3 4 >file &&
> +		git add file &&
> +		git commit -m "add file" &&
> +		git push origin unrelated-topic &&
> +		git checkout --detach
> +	) &&
> +	(
> +		cd upstream &&
> +		git checkout next &&
> +		test_write_lines 1 2 3 4 >file &&
> +		test_write_lines 5 6 7 >elif &&
> +		git add file elif &&
> +		git commit --author="unrelated user <uu@example.com>" \
> +			-m "unrelated commit adding an identical file" &&
> +		git checkout main
> +	) &&
> +	(
> +		cd repo &&
> +		git fetch origin &&
> +		git branch --delete-merged origin/next >actual 2>&1 &&
> +		test_must_be_empty actual &&
> +		check_branches <<-\EOF
> +		main
> +		unrelated-topic
> +		EOF
> +	)
> +'
> +
>  test_expect_success '--delete-merged keeps cloned main without explicit push configuration' '
>  	setup_repo_for_delete_merged &&
>  	(
> @@ -2017,6 +2050,143 @@ test_expect_success '--delete-merged deletes only selected merged branches' '
>  	)
>  '
>  
> +push_topic () {
> +	branch=$1 &&
> +	shift &&
> +	(
> +		cd repo &&
> +		git checkout -b "$branch" --track origin/next &&
> +		for commit in "$@"
> +		do
> +			test_commit "$commit" || return 1
> +		done &&
> +		git push origin "$branch" &&
> +		git checkout --detach
> +	)
> +}
> +
> +squash_merge_upstream () {
> +	(
> +		cd upstream &&
> +		git checkout next &&
> +		git merge --squash "$1" &&
> +		git commit -m "Squash merge of $1" &&
> +		git checkout main
> +	)
> +}
> +
> +rebase_merge_upstream () {
> +	(
> +		cd upstream &&
> +		git rebase next "$1" &&
> +		git checkout next &&
> +		git merge --ff-only "$1" &&
> +		git checkout main
> +	)
> +}
> +
> +test_expect_success '--delete-integrated deletes a rebase merged branch' '
> +	setup_repo_for_delete_merged &&
> +	push_topic rebased rebased-one rebased-two &&
> +	(
> +		cd upstream &&
> +		git checkout next &&
> +		test_commit before-rebase &&
> +		git checkout main
> +	) &&
> +	rebase_merge_upstream rebased &&
> +	landed=$(git -C upstream rev-parse --short next) &&
> +	(
> +		cd repo &&
> +		git fetch origin &&
> +		sha=$(git rev-parse --short rebased) &&
> +
> +		git branch --delete-integrated origin/next >actual 2>&1 &&
> +		echo "Deleted branch rebased (was $sha, landed as $landed)." >expect &&
> +		test_cmp expect actual &&
> +
> +		check_branches <<-\EOF
> +		main
> +		EOF
> +	)
> +'
> +
> +test_expect_success '--delete-integrated deletes a squash merged branch' '
> +	setup_repo_for_delete_merged &&
> +	push_topic squashed squashed-one squashed-two &&
> +	push_topic partial lands-upstream stays-local &&
> +	squash_merge_upstream partial~1 &&
> +	squash_merge_upstream squashed &&
> +	squash=$(git -C upstream rev-parse --short next) &&
> +	(
> +		cd repo &&
> +		git fetch origin &&
> +		sha=$(git rev-parse --short squashed) &&
> +
> +		git branch --delete-integrated origin/next >actual 2>&1 &&
> +		echo "Deleted branch squashed (was $sha, landed as $squash)." >expect &&
> +		test_cmp expect actual &&
> +
> +		check_branches <<-\EOF
> +		main
> +		partial
> +		EOF
> +	)
> +'
> +
> +test_expect_success '--delete-integrated deletes a squash merged branch that was reverted' '
> +	setup_repo_for_delete_merged &&
> +	push_topic reverted reverted-work &&
> +	squash_merge_upstream reverted &&
> +	squash=$(git -C upstream rev-parse --short next) &&
> +	(
> +		cd upstream &&
> +		git checkout next &&
> +		git revert --no-edit HEAD &&
> +		git checkout main
> +	) &&
> +	(
> +		cd repo &&
> +		git fetch origin &&
> +		sha=$(git rev-parse --short reverted) &&
> +
> +		git branch --delete-integrated origin/next >actual 2>&1 &&
> +		echo "Deleted branch reverted (was $sha, landed as $squash)." >expect &&
> +		test_cmp expect actual &&
> +
> +		check_branches <<-\EOF
> +		main
> +		EOF
> +	)
> +'
> +
> +test_expect_success '--delete-integrated reports a merge plainly next to an unmerged branch' '
> +	setup_repo_for_delete_merged &&
> +	push_topic a-unmerged unmerged-work &&
> +	push_topic b-merged merged-work &&
> +	(
> +		cd upstream &&
> +		git checkout next &&
> +		test_commit upstream-work &&
> +		git merge --no-ff b-merged &&
> +		git checkout main
> +	) &&
> +	(
> +		cd repo &&
> +		git fetch origin &&
> +		sha=$(git rev-parse --short b-merged) &&
> +
> +		git branch --delete-integrated origin/next >actual 2>&1 &&
> +		echo "Deleted branch b-merged (was $sha)." >expect &&
> +		test_cmp expect actual &&
> +
> +		check_branches <<-\EOF
> +		a-unmerged
> +		main
> +		EOF
> +	)
> +'

Does "--dry-run --delete-integrated" combination have test coverage?
If not shouldn't it?

Does opting out of "--delete-integrated" feature by setting
branch.<name>.deleteMerged to false have test coverage?
If not shouldn't it?

>  test_expect_success '--delete-merged keeps main despite a different default push remote' '
>  	setup_repo_for_delete_merged &&
>  	create_merged_branch on-next &&
> @@ -2216,4 +2386,10 @@ test_expect_success '--dry-run without --delete-merged is rejected' '
>  	test_grep "requires --delete-merged" err
>  '

It now requires either --delete-merged or --delete-integrated.
At least, updating the expected message in the test we can see would
be helpful.  

Having said that, I do not agree with the design to make "--dry-run"
require anything.

If "git branch delete master" is run, and 'master' is checked out,
it would error out.  "git branch delete --dry-run master" should say
"we would not let you delete the currently checked out branch" the
same way and exit, no?


> +test_expect_success '--delete-integrated cannot be combined with --delete-merged' '
> +	test_must_fail git -C forked branch --delete-merged origin/next \
> +		--delete-integrated origin/next 2>err &&
> +	test_grep "cannot be used together" err
> +'

Good.  You added die-for-incompatible-opt to make them incompatible.

Also do we want to ensure "--quiet" does what it is designed to do?
I do not think I saw anything added to t3200 by this series that
mentioned the option.

Thanks.
