Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E77BA4A
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 05:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730265065; cv=none; b=ORzHbBBmSggKwJfsV2+0fkb3aapCKfm9sFLGQQ9lEo479+9ZQSKq6RWJY5oeoLdUml7k7PsrRd+XUYj9r3otqJZp5QNnG0QVGGq1iyKbGqgDS52XO9KBjsC5Z4Vn4uSEaXPe1J/ae9X8XUg1ZIdc9u4sgxABrk1wW4dt7KlCBmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730265065; c=relaxed/simple;
	bh=j9Ds/sWeUOUmTCo8Pk8kGi3JRUKTtD9m4DIzO7exmxs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XXAEbMtI6g/+C31TFcifSTOS12EzQ9e5haTU8FrTJ68ugO2asoYFJA/ycUpVnLVyAtNxK/qj9YHP1v6vERGQHN+docUlQu/j8OV6UpFgjtUzV1MhLItdA//sQGg6FxpqYtJ2GeiIjntRTH5Cw//UpBpJxmSQixj8oFANmmrotDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=dYtzs/wE; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="dYtzs/wE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1730265061; x=1730524261;
	bh=j9Ds/sWeUOUmTCo8Pk8kGi3JRUKTtD9m4DIzO7exmxs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dYtzs/wE46SoxoSVM0sbZFLRlelKIUv7GjYKYKZRp7OT5BEWeoVU3zjHQ4eAIYhey
	 mTGZXtX0hJkkgJ/kVF7TblFAXbWATRT97DL8Tohnd0jFxo7+namC7Ep8LouHTkzGFo
	 ExLcv3sfqPK7PnVq9Xm51MCyiAwZRT+uxGj340WvsWEgAdjmsLVuyTHXA/a3S8Qn+L
	 2AwdE3VA4FUkfNls7S4EDgKVAoYLwUMcJEh8bB/a+Hie3A4lnk+MU5mkJjKvzDOCFB
	 a9D86MDjmbcrDAqI2G9i7g44JPK+bq9vEfZNuaw8bBg6UKXAUv67kGc4ehg9GJWU1V
	 enzxAMDf6K7YQ==
Date: Wed, 30 Oct 2024 05:10:56 +0000
To: phillip.wood@dunelm.org.uk, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/5] worktree: add tests for worktrees with relative paths
Message-ID: <D58VRRC59S1E.X68LFI4SFMDA@pm.me>
In-Reply-To: <aeec08e2-29da-4e5e-8a73-7ed7e3a79177@gmail.com>
References: <20241028-wt_relative_options-v2-0-33a5021bd7bb@pm.me> <20241028-wt_relative_options-v2-3-33a5021bd7bb@pm.me> <985646c7-8a16-4014-a379-644408157934@gmail.com> <D58DMTM9YPBE.8L5WT8ZNG1CU@pm.me> <aeec08e2-29da-4e5e-8a73-7ed7e3a79177@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: ccea74993af40bd040c25c51475cbea85442be04
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Oct 29, 2024 at 10:43 AM CDT, phillip.wood123 wrote:
>> I had received feedback that the original patch was too large, so I
>> was trying to split it up into smaller, more digestible pieces.
>
> One way to do that would be to convert the "add", "move" and "repair"
> subcommands in separate patches changing option handling and appropriate
> tests in each one rather than changing all subcommands and their tests
> at once.

That makes sense. I'll implement that.

Best,
Caleb


