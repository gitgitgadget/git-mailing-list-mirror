Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FCA4F8B2
	for <git@vger.kernel.org>; Wed, 20 Mar 2024 20:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710967573; cv=none; b=edJ3paBRRJVNJCIq/J4iEbuGynNRwNliHwj+ziIqvTJkmkuhKCGN0uLHwX7nCh3V1/G9hu+1o1T4fpBq9fCxqq6iydaOc06/Rho4bPmm4KpoGvrQuoTSTJlICCzLiXxbS97GVn9MSFC9oT6oV7EnFIBnquZVMPFTPIsezYzhYo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710967573; c=relaxed/simple;
	bh=quOhniM0BeblkgBYQ4+5aonm9N+KPjD+aPLtY5fTGAk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oTKMSucvdWERZORuWBXHTVFLSV4K8QuFhuqcTR0xDeJC1nZiid6fh6dz0fptlhrw8Ul7tyNj4CV74R7jcs+TrBgWeiL0Q+WncxpBfjAx+41PKe3DN7Q53FDEkCmgIweuP4Y+t0bPGF4gfjpTokbI0WLsMt/H9u22ShgWdQ8ipbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Fpj+ko4G; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fpj+ko4G"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 99B1032520;
	Wed, 20 Mar 2024 16:46:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=quOhniM0BeblkgBYQ4+5aonm9N+KPjD+aPLtY5
	fTGAk=; b=Fpj+ko4GNKZE9t2okbzG56zngFxsCwksGM4RiruK2Li88H/w8LjYxZ
	hsG5zbFUDEHVF32nP7oYBU5thYLpIkgYSDkjrOEZ6lg6SE1oN7ri+pA+q8qQzkCV
	gvuEmFcDkYsi+jSLwWjDIv2ySmjTITiF2Yfx7VbfEh0R1PFu5iFf8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 927CD3251F;
	Wed, 20 Mar 2024 16:46:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 209383251E;
	Wed, 20 Mar 2024 16:46:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Sanchit Jindal via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Sanchit Jindal <sanchit1053@gmail.com>
Subject: Re: [PATCH] t9803-git-p4-shell-metachars.sh: update to use
 test_path_* functions
In-Reply-To: <pull.1700.git.1710964109659.gitgitgadget@gmail.com> (Sanchit
	Jindal via GitGitGadget's message of "Wed, 20 Mar 2024 19:48:29
	+0000")
References: <pull.1700.git.1710964109659.gitgitgadget@gmail.com>
Date: Wed, 20 Mar 2024 13:46:06 -0700
Message-ID: <xmqqle6cfx81.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 E0B8EA22-E6FA-11EE-84DC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Sanchit Jindal via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: sanchit1053 <sanchit1053@gmail.com>
>
> Signed-off-by: sanchit1053 <sanchit1053@gmail.com>
> ---

>     t9803-git-p4-shell-metachars.sh: update to use test_path_* functions
>     
>     I have updated the statements test [!] -[e|f] with the corresponding
>     test_path_* functions The statements are at the end of their respective
>     texts and can be easily replaced
>     
>     I am having trouble with the git send-email and my institutes firewall,
>     that is why I am trying to use gitgitgadget

A few minor points.

 * As our test numbers uniquely identify test scripts, your commit
   title can be "t9803: use test_path_* helpers".

 * We prefer to see the patches signed with real name.  As you seem
   to have let your name known to GGG, I am assuming "sanchit1053"
   is not a name you chose for anonymity.  You would want to, at
   least while you are working for this project, have something like

     $ git config user.name "Sanchit Jindal"

   in the repository you use to work on Git.

 * The proposed commit log message is empty; you seem to have a lot
   more after the three-dash lines, which probably came from pull
   request message you gave GGG.  The single paragraph that talks
   about "test [!] -[e|f]" should go between From: and Signed-off-by:
   but refer to Documentation/SubmittingPatches:[[describe-changes]]
   while reading the message again and updating it.

The patch text below looks good to me (but that is to be
expected---a microproject is not a practice about coding, but is
a practice about interacting with reviewers and going through a
contribution process).

Thanks.


>  t/t9803-git-p4-shell-metachars.sh | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/t/t9803-git-p4-shell-metachars.sh b/t/t9803-git-p4-shell-metachars.sh
> index 2913277013d..4905ed2ae9e 100755
> --- a/t/t9803-git-p4-shell-metachars.sh
> +++ b/t/t9803-git-p4-shell-metachars.sh
> @@ -33,8 +33,8 @@ test_expect_success 'shell metachars in filenames' '
>  	(
>  		cd "$cli" &&
>  		p4 sync ... &&
> -		test -e "file with spaces" &&
> -		test -e "foo\$bar"
> +		test_path_exists "file with spaces" &&
> +		test_path_exists "foo\$bar"
>  	)
>  '
>  
> @@ -52,8 +52,8 @@ test_expect_success 'deleting with shell metachars' '
>  	(
>  		cd "$cli" &&
>  		p4 sync ... &&
> -		test ! -e "file with spaces" &&
> -		test ! -e foo\$bar
> +		test_path_is_missing "file with spaces" &&
> +		test_path_is_missing foo\$bar
>  	)
>  '
>  
> @@ -100,8 +100,8 @@ test_expect_success 'branch with shell char' '
>  		git p4 clone --dest=. --detect-branches //depot@all &&
>  		git log --all --graph --decorate --stat &&
>  		git reset --hard p4/depot/branch\$3 &&
> -		test -f shell_char_branch_file &&
> -		test -f f1
> +		test_path_is_file shell_char_branch_file &&
> +		test_path_is_file f1
>  	)
>  '
>  
>
> base-commit: 3bd955d26919e149552f34aacf8a4e6368c26cec
