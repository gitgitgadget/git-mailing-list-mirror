Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3B225542
	for <git@vger.kernel.org>; Sun,  4 Feb 2024 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707077871; cv=none; b=l3w9FyV0Ro+8QhYLMDvZcjhcgIFb9TTSjvLVJko4Qm42+GFp83xB/HWW5SagB6Ovf/bLTlIRUnulAP0jlai8uui2VOpbT2TdZ5Eh61mkidvHKJCxUltYDjy64Kb07KD43o2kQ/L0UApRTG7LYEBKOIiXcyd0wFfJbwsj9ExgwVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707077871; c=relaxed/simple;
	bh=3Nh/qhV+GL1KKi8JBSY06b71y7gb0UysHr2hBeYLmN4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YQvU8cWvL/ZWB140av3Y1+5B+Fe/j3efVImZD9LxfKHoesMnKFosfNAhpJjr7LlS4YCisFqVbmhbv4VtqtIyZ8Cv4kG2bj3Q63w28EMtNLkylVQXK0X92mVEUgCZ7UD6x1H+9Nv8mQ+4wLFDhwacNh9QVncq/mlw17AwKFMACBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FuYzQfcK; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FuYzQfcK"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F8921DB94E;
	Sun,  4 Feb 2024 15:17:41 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=3Nh/qhV+GL1KKi8JBSY06b71y7gb0UysHr2hBe
	YLmN4=; b=FuYzQfcKZRFYgxh4KH46lgLUa8o6azeqGlbRat76yC6+Y2TzqPGr3Y
	SgFsumbcc6cjhFb9GDGkat5bXcxSx6Vk2j+LGXW069DORRpfHCaPe1ckTwc9h88t
	wjowNcs32usMNjfhhvmmyNtUzvQKoNxmsgMT36nNPdblFQRp8mlY4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 975DF1DB94D;
	Sun,  4 Feb 2024 15:17:41 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C5ED11DB94B;
	Sun,  4 Feb 2024 15:17:40 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <Johannes.Schindelin@gmx.de>,
  Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] .github/PULL_REQUEST_TEMPLATE.md: add a note about
 single-commit PRs
In-Reply-To: <pull.1665.git.git.1707069808205.gitgitgadget@gmail.com>
	(Philippe Blain via GitGitGadget's message of "Sun, 04 Feb 2024
	18:03:28 +0000")
References: <pull.1665.git.git.1707069808205.gitgitgadget@gmail.com>
Date: Sun, 04 Feb 2024 12:17:39 -0800
Message-ID: <xmqqsf28oufw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 727D5A76-C39A-11EE-AE6F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/.github/PULL_REQUEST_TEMPLATE.md b/.github/PULL_REQUEST_TEMPLATE.md
> index 952c7c3a2aa..65fa3a37173 100644
> --- a/.github/PULL_REQUEST_TEMPLATE.md
> +++ b/.github/PULL_REQUEST_TEMPLATE.md
> @@ -4,4 +4,8 @@ a mailing list (git@vger.kernel.org) for code submissions, code reviews, and
>  bug reports. Nevertheless, you can use GitGitGadget (https://gitgitgadget.github.io/)
>  to conveniently send your Pull Requests commits to our mailing list.
>  
> +If you use Gitgitgadget for a single-commit pull request, please *leave the pull
> +request description empty*: your commit message itself should describe your
> +changes.
> +
>  Please read the "guidelines for contributing" linked above!

Making it easier for contributors to come up with the right output
is greatly appreciated.  I think "If you use Gitgitgadget for" ->
"For" is probably a good change, for two reasons (one, we do not
take pull request except for GGG gateway in the first place, and
two, PR messages being similar to cover letters, you do not want to
have a detailed PR message that (a) takes extra time to write, (b)
can duplicate what the you already have written, and (c) could
contradict what the commit log message says.

I wonder if such a rule can be also enforced at the GGG side?  It
apparently knows if it is dealing with a single-patch request or a
multi-patch series (as the types of messages this documentation
update tries to address are the only ones that get duplicates under
the three-dash line), and I've seen GGG complain on the contents of
the commit log message (e.g., "not signed off") so there is enough
support to inspect things in a PR and add instruction to the PR
discussion.  Unless the machinery GGG uses lack the ability to read
the PR message (unlike the commit log messages that it can read
apparently), it may be able to enforce that "for a single patch, PR
message should be empty" rule before the /submit instruction.  It
might make things even more helpful if it can notice the commit log
message is similar enough or superset of PR message and refrain from
inserting it after the three-dash line, but that might be asking too
much ;-)

Thanks for helping to improve the situation.

Will queue.

