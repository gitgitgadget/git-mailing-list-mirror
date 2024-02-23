Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A73175B9
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 08:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708676288; cv=none; b=po/nP6gvGYYHa7YqHmHujd+yhFNW11lmX7GSsbbY357x2nWXwAyOj9NOjgC/P4NdvgQVbqK7jR8H1EH3LFdnIYHXgxFIPH/BgDW1gDZmqgIrwkpwiQzWtdX8Teela7HjOh0tAXLTXYzxSWtuevW6lcDCuiBLVNzaSfXo7R/any8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708676288; c=relaxed/simple;
	bh=UKaI0lnVI867tjAnqKVaxRGz2Xof7S2vYvfyMvu/p90=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DbjxHe3TRgRu3HSIJMP15YXW5X7mV1kXNTgJ4HFQGQkHmPWLAIuidVDh0yhpYrnF3alfItNIdsaE8ZnQ1Uy3Sxma95INv1RQPnKAbG/KhqVvgRbkFm/Rl0FB7oLjYAijgCyeC6JosQNHOFFfkUeXA4uED50xIU1Bc6Ysip4wFlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CIx5BuXA; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CIx5BuXA"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 25E0F1DC3FD;
	Fri, 23 Feb 2024 03:18:00 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=UKaI0lnVI867tjAnqKVaxRGz2Xof7S2vYvfyMv
	u/p90=; b=CIx5BuXAHt+gz2B6QyQbV3lUcyqlBQoK2qdIHxyF2kMV4WbqX1y+pV
	mqQyTKXdvrxmqyyP76X2mYxffdGOUCvcVMMpShzhdkFlJKKKjqUtsshR5cGe7TW3
	yDeSxMZFaeWueXM+XUhkbcpCtCbfRZTVglasII6xRAuITi/jdEr10=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1C83A1DC3FB;
	Fri, 23 Feb 2024 03:18:00 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 820B41DC3FA;
	Fri, 23 Feb 2024 03:17:59 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Jeff Hostetler
 <git@jeffhostetler.com>,  Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH v2 03/16] t7527: temporarily disable case-insensitive tests
In-Reply-To: <dad079ade7f8817f235d59c5339b82aecf4a17db.1708658300.git.gitgitgadget@gmail.com>
	(Jeff Hostetler via GitGitGadget's message of "Fri, 23 Feb 2024
	03:18:07 +0000")
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
	<pull.1662.v2.git.1708658300.gitgitgadget@gmail.com>
	<dad079ade7f8817f235d59c5339b82aecf4a17db.1708658300.git.gitgitgadget@gmail.com>
Date: Fri, 23 Feb 2024 00:17:58 -0800
Message-ID: <xmqqh6hz1tmx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0E4AC730-D224-11EE-8687-25B3960A682E-77302942!pb-smtp2.pobox.com

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhostetler@github.com>
>
> Add non-existent "SKIPME" prereq to the case-insensitive tests.
>
> The previous commit added test cases to demonstrate an error where
> FSMonitor can get confused on a case-insensitive file system when the
> on-disk spelling of a file or directory is wrong.  Let's disable those
> tests before we incrementally teach Git to properly recognize and
> handle those types of problems (so that a bisect between here and the
> final commit in this patch series won't throw a false alarm).

You talk about bisection, but hasn't the previous step already
broken bisection without these SKIPME prerequisites?  IOW, shouldn't
this step squashed into the previous?

Also, it is much more common to replace "test_expect_success" with
"test_expect_failure" to indicate that the steps are broken.  Was
there a reason why we choose to do it differently?

> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  t/t7527-builtin-fsmonitor.sh | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
> index 3d21295f789..4acb547819c 100755
> --- a/t/t7527-builtin-fsmonitor.sh
> +++ b/t/t7527-builtin-fsmonitor.sh
> @@ -1051,7 +1051,7 @@ test_expect_success 'split-index and FSMonitor work well together' '
>  #
>  # The setup is a little contrived.
>  #
> -test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
> +test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
>  	test_when_finished "stop_daemon_delete_repo subdir_case_wrong" &&
>  
>  	git init subdir_case_wrong &&
> @@ -1128,7 +1128,7 @@ test_expect_success CASE_INSENSITIVE_FS 'fsmonitor subdir case wrong on disk' '
>  	! grep -q " M dir1/dir2/dir3/file3" "$PWD/subdir_case_wrong.out"
>  '
>  
> -test_expect_success CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
> +test_expect_success SKIPME,CASE_INSENSITIVE_FS 'fsmonitor file case wrong on disk' '
>  	test_when_finished "stop_daemon_delete_repo file_case_wrong" &&
>  
>  	git init file_case_wrong &&
