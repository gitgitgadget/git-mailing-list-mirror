Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB16641C70
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 17:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711128548; cv=none; b=Y1vtGLa43YIA4ZxxiUzNcuv5wAR/ot1CjAxokjDcbK7oT2rYLuit6oLvIBF2sIWyNoCA7cBl1VXsCdFOykg9z1qDBXJrtyU/Lgp03PXAp/6EzTQy/cF2WxBaANTsZu737EHPGMOwiVUeKgXEaDJkZ6aocrwB61V1kNC8ZBkmbK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711128548; c=relaxed/simple;
	bh=ZQx613lLdF+xHmCC04vtsl0DLg9nsGiyQ8OH9UF6ZPw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ZbZhTFhTtGFc2B18UT9cSGvSad3vW2wQDTLmPjJDN4zuEvq2BrOrwJ/v4wGb3AreX62s/HW9TiRmchr3rMW1eqPQTyuwHhbCJILW7fWHUXRx728QcEQ+L3OUe2J7y3nOlPPS4bPyvT2bRbk8fKym7QJO70SnZdKmF5tw1BDeUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=sP6QXIEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YLPLUlBm; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="sP6QXIEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YLPLUlBm"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id D084013800C2;
	Fri, 22 Mar 2024 13:29:04 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 22 Mar 2024 13:29:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1711128544; x=1711214944; bh=UUYBOK9mzdtcVDoty3UQx7oB2h3g9RUX
	KhRVYpjEY0E=; b=sP6QXIEUGUb5V5coKHjq+St239+5AwgKmvYfbqEz45xMbvph
	Qx+UEbJ4SQMvc5eCI1ZRw4PreDPNXoJQtNsL8YprlsQYAVGmjKQgERTmo34/ryus
	j/oylRWvgqKhOHIoJI8g5dXYnI8O3fqKht9cSNxtFYitBI2vJvjy5NIGn9cgZK4F
	YwNEc0iI+CQh/+xIYCNVkASwbf5VppspD3j08leM8wpzHkktg0KNINp1q/TRqBx6
	H/dmguuYLkgeLlxSJhHNQVeyjlLJAyDcNBN7xo/0Kdx8FKh3DI9jSmnE2bRkBGmI
	BAwh3zg05i0nO5R3co6cJlJOeUEr3V2VB9Iu1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711128544; x=
	1711214944; bh=UUYBOK9mzdtcVDoty3UQx7oB2h3g9RUXKhRVYpjEY0E=; b=Y
	LPLUlBmXB0Y5i7bnQwz0j0pGsb6rdctJ/xYpUX3XotEnLvKLZn5WlSKLdvqAkbLt
	3np2ny/tuG+SmZQ90MJDE/c5uyxQQhXBPvcrqK4yCksyKOI3Vf/D/CMaV83tTep0
	aAf9G+OvMHL76qDfe5c/NEV4qjRHuic5K/x7CfZMnB0EPdW0C5ChEe5MBFvVHcDB
	LuUr22149SANE939sqEQRIyDZO1NTUn4d3b1PAjqlZ3NpIbNNm1LYL/d224PKc7G
	x1MWmnhHBSR9FVw+JVAQ7+Dsib8oR7Lg3UONkR+PUt2vMb1mVJ8Aj9nsC6q8kI6i
	hzNpvRIAhQHxuEqI1x7Kg==
X-ME-Sender: <xms:4L_9ZbxGShAx_rPASa7HnRAczC04hfC9Z0sPSI3W_-NnhM-HAb9IPuM>
    <xme:4L_9ZTQiczDSkgNakimGEXaaLp3NjoMIGHjnxZUbMgyA5KXAZNUc6clM147cI5dBw
    -RR0Fhd_dGHfbkVHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddtvddgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:4L_9ZVWgEKkMVcJIpTyDrwE5nUtHgf1WzFRvVtUfa0NzKQUImPsqFQ>
    <xmx:4L_9ZVgOYLWneUc0_rlfxZD_1n6-O-iXbi8YN5INZGVU6BmdYB0h5w>
    <xmx:4L_9ZdDvLExqzMjzk99nOvcSENHVzWTEPRXjugYQaIkgg8LV52UKYQ>
    <xmx:4L_9ZeKXPcPep_rwUz84rM2iu_TIX2ZkRBn8S2gAvKeCRmD6yy48hg>
    <xmx:4L_9ZcNXmKNX1-kJ-6jZs2TziPXqS-oCk5lZIlzDv6Oo8AGzzQU_-A>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id A3C7D15A0092; Fri, 22 Mar 2024 13:29:04 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0f65aae3-15a1-456d-8285-7923a880deea@app.fastmail.com>
In-Reply-To: 
 <CA+2m0i8E5Qnj520LXitoE49U_8V17v_NUnrqcRfzHz0cA_ONSQ@mail.gmail.com>
References: 
 <CA+2m0i8E5Qnj520LXitoE49U_8V17v_NUnrqcRfzHz0cA_ONSQ@mail.gmail.com>
Date: Fri, 22 Mar 2024 18:28:44 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Bill Wallace" <wayfarer3130@gmail.com>
Cc: git@vger.kernel.org, =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
Subject: Re: Worktree shares a common remote with main checkout
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 22, 2024, at 15:50, Bill Wallace wrote:
> This issue is just to fix an easy to make mistake when working with
> multiple remote origins and worktrees, where it is too easy to push to
> the wrong remote origin because one can't set the default origin on a
> per-worktree basis.
>
> What did you do before the bug happened? (Steps to reproduce your issu=
e)
> Used
> * git worktree to create a worktree
> * git remote add to add a custom repository
> * git commit/push to try to push changes
>
> What did you expect to happen? (Expected behavior)
> Expected to have the git push recommend a remote origin that matched
> the worktree, but it defaults to 'origin' all
> the time, which means I need to checkout a clean clone from the
> specific origin I'm making changes for so that I don't accidentally
> push to the default origin.
>
> What happened instead? (Actual behavior)
> Suggests 'origin' as the default origin - which is CORRECT for the
> main git branch, but I want to use worktrees to allow working against
> several remote origins, with the default being determined by which
> worktree I'm in.
>
> What's different between what you expected and what actually happened?
> Suggested 'origin' for the --set-default rather than allowing me to
> define the origin I want, for example 'wayfarer' as teh name of my own
> remote that I have cloned on github.  The default origin is still
> supposed to be 'origin' for pulls/naming, but when I push, it needs to
> recommend the matching origin.
>
> Anything else you want to add:
> This is a bit of feature request, but the reason I'm listing it as a
> bug is it makes it very easy to make a mistake by pushing to the wrong
> origin for a new branch.

I don=E2=80=99t understand the expectation. git-worktree(1) just gives y=
ou a new
worktree to work on a branch, do a bisect, maybe a rebase and so on. I
expect `git remote add <remote>` to have nothing to do with the current
worktree that I am in. A remote ref is for the repository, not
per-worktree.

If you are creating a local branch based on this so-called
worktree-specific remote and this branch exists on this remote (and
*only* on that one) then you can use `git worktree --add --guess-remote`
to automatically track the remote branch.
