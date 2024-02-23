Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613CD14AA5
	for <git@vger.kernel.org>; Fri, 23 Feb 2024 07:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708673891; cv=none; b=t9oBcSdkf7nLwsYdXMtnCsfTW9vLifZRy06RN+PT2KErySIzPcrJkpcYNb4YqclAYfw7bkfgzTCgTrGWqYy54GSlKE8AsJ7ug4YoOWSlLaN9oNvJdRF9oLvqIJNsCBKSRgUVPsdExxlip4xYzfmb2rUHtfuDRhvS7lqqX8Ow1IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708673891; c=relaxed/simple;
	bh=i137MGZYvVBF6pHTHWr3WY3ha5dARllMOH/zLH0MnlU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=utbxLhB/X8xH7Y/0ukOydyYaoT5eeUOOyEbFbvY3GgLyBmJEE1FGGHX20gQMnRSpiXfyVIqCh6AcM9fhXv3RWpy55TRXK4cFc4yNrepe0lWWkBT+kh68ojT+zGhl3+Yqk3qJUZCF1yJtr1nFvAKuGygO1XPRr4QifCRFFxI/Fr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nLo8gBV4; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nLo8gBV4"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 229AA1F211;
	Fri, 23 Feb 2024 02:38:10 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=i137MGZYvVBF6pHTHWr3WY3ha5dARllMOH/zLH
	0MnlU=; b=nLo8gBV4XRF+VQ1BbdP/MTf/zrV63udNIzAcxgl3UVogIeyPGyRU0a
	uVKWqz4Xa2z4mBTrSN2/WXf5Kd4R/+jJ4Tw/rX2VdZ+z5bXLmc7hCPMu/YGx5xyS
	QXVFTPI/g03WfzA9K2vQuGAoiublNue9Vab+a/C4NlgLsO/KXt7Nk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1C7F31F210;
	Fri, 23 Feb 2024 02:38:10 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 32F661F20E;
	Fri, 23 Feb 2024 02:38:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Haritha D via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Haritha <harithamma.d@ibm.com>
Subject: Re: [PATCH v2 2/2] an improvement: removed configure.ac changes
In-Reply-To: <05df5d7e2d50cba77f53273c781f97d24144efc6.1708660111.git.gitgitgadget@gmail.com>
	(Haritha D. via GitGitGadget's message of "Fri, 23 Feb 2024 03:48:31
	+0000")
References: <pull.1663.git.git.1706710861778.gitgitgadget@gmail.com>
	<pull.1663.v2.git.git.1708660111.gitgitgadget@gmail.com>
	<05df5d7e2d50cba77f53273c781f97d24144efc6.1708660111.git.gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 23:38:03 -0800
Message-ID: <xmqqmsrr1vhg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7B2922E4-D21E-11EE-BDB4-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Haritha D via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Haritha D <harithamma.d@ibm.com>
>
> Hello Reviewers, as an improvement, I have
> removed the CC_LD_DYNPATH changes because
> I was able to achieve the desired outcome
> by passing it to the make step.
>
> Signed-off-by: Haritha D <harithamma.d@ibm.com>
> ---
>  configure.ac | 3 ---
>  1 file changed, 3 deletions(-)

We frown upon a patch series that makes mistakes in an earlier step,
only to fix them in a later step.  The "git rebase -i" command helps
us pretend to be more perfect developers than we actually are,
whipping your patch series into a shape that builds one small step
on top of another in a logical succession.  Such a patch series is
easier to understand than a history that faithfully records all the
stumbles the developer made until they reached the final solution.

In this case, if you know before you sent these two patches that you
do not need to touch configure.ac for CC_LD_DYNPATH at all, you can
"git rebase -i" to whip the first patch into the desired shape, i.e.
no changes to configure.ac, and drop this second patch, I think.

> diff --git a/configure.ac b/configure.ac
> index 64569a80d53..d1a96da14eb 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -463,9 +463,6 @@ else
>              CC_LD_DYNPATH=-Wl,+b,
>            else
>               CC_LD_DYNPATH=
> -	     if test "$(uname -s)" = "OS/390"; then
> -		     CC_LD_DYNPATH=-L
> -	     fi
>               AC_MSG_WARN([linker does not support runtime path to dynamic libraries])
>            fi
>        fi
