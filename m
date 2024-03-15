Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD21F922
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 19:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710529998; cv=none; b=rm/sEXCdEDUe5j2GjU/D6DDZmbk6VRt3OjH9wpH1Js8jNH3pWjihgxRB31cXkgtTeGFihP0tIVrVB6QXe0WWttiDJLWsL1oxdRxAM+7jgDs+nPwaBEhv1pc9pbQW6OUuCTTIKe3Uq4oVaKmE8S5CpUV9xbcvNbxaeC05poSDE1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710529998; c=relaxed/simple;
	bh=3rXjdxGJfdSph0JLeEv47Mk7FFmpd85PVLR8hG4GWfg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Sa0t3JSYPv6H4yJMen5B4bpPS9yvuQd260ZXmgZh7B6HmdjKC/CGyGceXEWdIjYINfjWUpQ9txjhWuObdNm/gvGbJZC8b3qFjz4QbLLqIXmXiND3+q0c6Ixk6kldBsaWpucJiR2JLeMaBNhPq5RuXONi/ynevA9UOG/SwYeRlAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=iZRemmuq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZW/YGz6D; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="iZRemmuq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZW/YGz6D"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8FE9E11400AD;
	Fri, 15 Mar 2024 15:13:15 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 15 Mar 2024 15:13:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710529995; x=1710616395; bh=9bM2b3/8KjrGcVu1m0vMacKln/2Xl2CL
	csFmsQjaDRg=; b=iZRemmuqws8YcpTsxP1I6lfd5Ope4CehgPHA8NhM1V8Qn7J/
	nbMD1RvhMohuxrWAiJIlV2imvXV8wtL+ohp7BpatZHork8/8U8LQAIfBpvtykcTA
	LqE71wfPhjGpV34fdOdBiOlbuR/mNe+SiRQ7V0peCauCfYmpuyVe8Z3ouKhiAsWU
	evsuce9N2OM2qsFUnHJMFvu2b3+U850OWosaYp4NRB7VlD2BnJatp3Y9mV6mmS3N
	ZLQxtlG6HEYa86u+pEZyvOGwyANfr25SBd+0pl4CsYYgkTVr5PIET23dGTNPZSMr
	6jHdkstSY+2Du4UkxUQLbP1Ll/TKgYoBbQhURg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710529995; x=
	1710616395; bh=9bM2b3/8KjrGcVu1m0vMacKln/2Xl2CLcsFmsQjaDRg=; b=Z
	W/YGz6DB64v9UvNVN4hHDLa7x6daqZXcDzK/MlVp85IIOTjDShVaVmi8PJSH9rpO
	vCoi77D9XoWS5Tjvp/wjGQ4Tp4DZRYwWx6x0iRYwvBNpoon1t4lFbMN1ERkKDqL/
	3vpSeiLGltKYEbR/pIdwbx5mwzsbDMhh11likx9aadeBbMnLiVRd/Mr7x09stnjY
	RBu4l5446UZHhP7v7ebVMQJRotGnyLFs7NXmWKKYvex4zcRZmr3kP5UyPGIxAfzG
	qOKWUmhkO/5qOgZ+s62+4pwAGy7q6bZvyZFret4HHr5dzb8YlT0CsH6JT+S5k7RU
	PkKikMidNqcvJ/LKqOJWQ==
X-ME-Sender: <xms:y530ZTYnVhdMtXOmOPqNkK0R3OG9zyOfO0fEY2uQ98_qJf-czp9CoPA>
    <xme:y530ZSZSp5iWRO5wax19gMOQ5qA5P_fwMLyz1KMjJ4C8cdkG2wncIKcCmpUoePoDw
    ilo889yamixqYVEaA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjeelgdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:y530ZV92dPmRlmD7dowbjxQNCTeg2XKuc9C9znmuIWEZJciuiTKmNA>
    <xmx:y530ZZosZ59rlFla5SFfEIHbe59ZmC1NlBwqbkU5FXYnBiS73IL-WA>
    <xmx:y530ZeodPHf0rKxLmbYw8fPdBrLoqHa80gCvoKjZuXKPUEGavtWb6w>
    <xmx:y530ZfSUF8i8fvLvQC7qJDSXvsqKOyramMFofIeo97gnQsyVk-YFbQ>
    <xmx:y530ZV0-8RrwwiVicdcctwVx7gwzduRwY7-FcwVzs4qEVbXqMdCSzQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 0A61015A0092; Fri, 15 Mar 2024 15:13:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-300-gdee1775a43-fm-20240315.001-gdee1775a
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <028f7834-7695-4702-ada3-7fe74e8cbea7@app.fastmail.com>
In-Reply-To: <CZU56XWOUT4P.1WZ2BSE0VLN01@bit-artificer.com>
References: <CZU56XWOUT4P.1WZ2BSE0VLN01@bit-artificer.com>
Date: Fri, 15 Mar 2024 20:12:54 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Thomas Lowry" <thomas@bit-artificer.com>
Cc: git@vger.kernel.org
Subject: Re: Expanded worktree tooling?
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello

On Fri, Mar 15, 2024, at 08:23, Thomas Lowry wrote:
> - throwaway/temp workspaces
>   One use case that I've seen alot is creating a workspace to handle
>   some hotfix and/or debugging and possibly commit the fix. Instead of
>   needing to actively manage this workspace (mostly the cleanup) I
>   imagine it would not be too dificult to these in the /tmp folder and
>   then cleanup/ignore their entries. Temp workspace file paths might
>   make this kind of tooling pointless unless you also automatically
>   change the working directory to the new workspace.. I've seen people
>   advocate for a git aliases that jump between workspaces but if your
>   adding the workspace and typing out the file path anyways then
>   `cd path` is shorter than an alias anyways.
> - move hunks between workspaces
>   In my experience it's more common for a hotfix/debugging use case to
>   get the report and just use the current branch since it's not often
>   that your current branch is either completely broken or directly
>   conflicts with the reported bug. I usually don't stashing and changi=
ng
>   branches until I've got a fix and want to commit it. I recently tried
>   a workspace for this situation but I ended needing to retype the fix
>   in the new workspace, after reflecting a bit I should be able to do
>   `git stash -p` in the main workspace then `git stash pop` in the new
>   worktree but a dedicated way to move hunks would be quite useful.

For these two I use branches and commits. Like a WIP commit similar to
stashing if I want to get the changes out of the way quickly. I don=E2=80=
=99t
use worktrees for this.[1]

I really like worktrees. I might use them for two very different
versions of the app. so that Intellij and other tools won=E2=80=99t get =
all
confused about their build state and indexing. Or a dedicated =E2=80=9Cd=
eploy=E2=80=9D
worktree for deploying the app with Docker (so that I can do whatever
else in the main worktree while it builds). There are a lot of
use-cases. And for the hotfix scenario: I might use a worktree when I
have to both commit some hotfixes and deploy them so that I can have a
dedicated scratchpad for that while I work on other things. (But also
not too much: too much multitasking is bad for me.)

But I don=E2=80=99t see how worktrees enter into the picture in these sp=
ecific
outlined scenarios for me. In particular I don=E2=80=99t understand movi=
ng hunks
between worktrees. Moving uncommitted hunks like that seems like a
version control layer on top of the Git database, like an extra step.

=E2=80=A0 1: My git-stash(1) bias: I don=E2=80=99t use it unless I am go=
ing to pop
   within the next half a minute. Mostly when I have an unintented dirty
   worktree in the middle of an interactive rebase.

Kristoffer
