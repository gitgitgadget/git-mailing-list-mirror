Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3961CAA62
	for <git@vger.kernel.org>; Tue, 27 May 2025 08:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748335002; cv=none; b=Xqs7uc8Hc3r4zW+e2zHhvb9CsEZnGBGnbswCj91GfJDCh0YQL/ueScGswqIO6yGFv86bxJG0fJvT0w6XhJRfJZXXjMojkq30rGL82q1QnSefSeRUrH/81HwaBXnYB2ECvMyCSG6XJKCpw+x0bwniFpkieiYOdegDrkXcw2F4MpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748335002; c=relaxed/simple;
	bh=zxmxdYuVzn0VPTqzQFm044+8u6amiz6V/R+q8wXBrFU=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=De0MJ4NmllctD39gifMzwv1L94MtKGxpMPjGAg+4iu2kqzx+lpVi92f13VmbzYyzZcp7A8QhUAR5HRXOgMdAOA/URtLfQKNLQPakA+AI/Tkt1FWpU+6hi0KnNEjyA4B8KAN3EyaE3+uoJicXXe1IZzJTus01QTY0/7K0Y6dClso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=E4YzD7x2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S/8tAFV+; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="E4YzD7x2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S/8tAFV+"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 0EE7525400C9;
	Tue, 27 May 2025 04:36:39 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Tue, 27 May 2025 04:36:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748334998;
	 x=1748421398; bh=+5TkJBbp+Xdhb5W9w/mhThX/5KOPW/uqoLflQBVVGC8=; b=
	E4YzD7x2a5MQdYcRmAgYyC63vc3p2Cjh26QUP7phj9+13jO4K0DX2LOxWfI9ZGRx
	3Mhr0rFr3t9H4tSH+WfKjwnRLz+pR/PzQhG3gi44+h609ZZTl7FekJGsOJITzRgt
	6q63g2bys5/6T7VddDlzjf67sLIsYlXiWmIHJa5VhlVB232g48iIQbFSEfbdACTq
	FTg3/lZhtqPGp1YnsXIfu3QlZsXmLxcwlU9hUm+3kFHjChrj6DR4oZGWUmYi+bhI
	+iP1DD3KHskJOkcORHVf2MIGkmOFF6tUCkg1KEj/wxysrNPv7kT/hJ4+myHNzxdi
	1YlUU4QjF1jSJhO735euEg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748334998; x=
	1748421398; bh=+5TkJBbp+Xdhb5W9w/mhThX/5KOPW/uqoLflQBVVGC8=; b=S
	/8tAFV+xtWSSb5pEjDAksM1eiiSRueNtmBYHYG31Qy5K1wEsMeicxobFLBHKWCx5
	vuXfNzU98yRVZFEiI+Z3p2YIIm8LQM+N7tys9KbeYAQ4tmLbycjywWtlgpnlQ7f1
	l3xJX6e/jUFpdKKZZ03Oj72e0iaxAlKvlsiBqf2N4MTLatv3O7NvTk/lKpBq0aoo
	EH+UVHblUF6tynyvGmv3s6QZ8dugrTNxtLBHBfD+M2yqkUDz+dMTEtJAjLFTzexb
	LcbnM13Qnv9QHcMnB6fQ2VsQrij//rpqLB2h3LPUSMtO4ZnZYkOZ9XngcU/Ms3mF
	gShO1lJs+FkUkTPfpBsZQ==
X-ME-Sender: <xms:lnk1aHJbrlDbwa4Mzmyu8eleaIYTrQ6Iws49_pT30esh2UWC3Exir6o>
    <xme:lnk1aLJ3c3GKEEXEtxnL5BRQpFcdVRwkmaZuMJy-vxKtxQX0WdLmtig7amSsC6fve
    xcX7E2CILOndKXpJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdduleeludculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvvefk
    jghfufgtgfesthhqredtredtjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruh
    hgshgsrghkkhdfuceokhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgr
    ihhlrdgtohhmqeenucggtffrrghtthgvrhhnpedtiefggeejgeejhfehuedvgeejkeelge
    duudekleejkedtveejgfeigfefkedugfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrg
    hsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhht
    pdhrtghpthhtohepuhhlrhhitghhrdifihhtthgvnhgsvghrgheskhhishhtvghrshdrug
    gvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:lnk1aPs6LLcz-u1N-e9t9Iel6idhil-Apyv9tdgsX-l8U2sJPOIWNw>
    <xmx:lnk1aAYLGgmrTtAyBeWqnzi_U5PjW6R-t9SLmmtD7m8_eudcKomQxg>
    <xmx:lnk1aObZyd-O5SF7bhtwvNDvInHOhQPYoJ_JVuIGfT8uN008e3sf4g>
    <xmx:lnk1aEAHpXcZtQyr5AJbaI_ar_cm3ko7QTipqwdscca3UQHRQHzSSg>
    <xmx:lnk1aAwPmItoMDeAlBpWwosrTDoT42WdXq9dWJZkR5OENBFEqKugi67B>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9CDDF1EA005E; Tue, 27 May 2025 04:36:38 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T02049728c729551c
Date: Tue, 27 May 2025 10:36:18 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Ulrich Wittenberg" <ulrich.wittenberg@kisters.de>
Cc: git@vger.kernel.org
Message-Id: <580a4d79-841f-4731-88cb-f68fc27d9e8d@app.fastmail.com>
In-Reply-To: 
 <FR0P281MB2879A89B0E1B775DB4B037749464A@FR0P281MB2879.DEUP281.PROD.OUTLOOK.COM>
References: 
 <FR0P281MB28795FB4A108A6044273B39C9464A@FR0P281MB2879.DEUP281.PROD.OUTLOOK.COM>
 <24a091bf-daef-4c97-b233-1a0f5c329f25@app.fastmail.com>
 <FR0P281MB2879A89B0E1B775DB4B037749464A@FR0P281MB2879.DEUP281.PROD.OUTLOOK.COM>
Subject: Re: Bug in git branch --show-current
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remember to reply-all on this list. Thanks.

On Tue, May 27, 2025, at 09:58, Ulrich Wittenberg wrote:
> Well, the commit hat I am sitting on was made on a branch. The question
> is: What ist he name oft he branch?

You say that this is a Jenkins job where it=E2=80=99s on detached HEAD. =
 Git
doesn=E2=80=99t record in the Git database itself what branch the user w=
as on
when the commit was made (if any since you can commit on detached HEAD).
Unlike Mercurial (as I=E2=80=99ve heard, I haven=E2=80=99t used it), Git=
 doesn=E2=80=99t store
that information.  A branch in Git points to a commit.

But the ephemeral reflog (git-reflog(1)) can record how a branch (and
HEAD) was updated.  From that you can find out what branch the user was
on when a commit was made.  But the reflog is local only.

But I wonder if you really need this information.  I=E2=80=99ve never ha=
d a need
for it.  Git is not designed in such a way that makes querying this
information simple.

> I tried your command and it also return nothing.
> All other commands also suddenly keep it Top Secret on what branch I a=
m.
> Only an interactive "git log" shows it in the first line, but if you
> pipe that output into another command, this text also is suppressed.
>
> My next idea ist o dump the branch name (which the jenkins job knows)
> into a file and continue from there...

You might want to describe

=E2=80=A2 What commit Jenkins is on
=E2=80=A2 Where the branch or branches of interests point to
=E2=80=A2 How you expect branches to work
