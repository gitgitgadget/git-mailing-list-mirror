Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4063FBAF
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714400704; cv=none; b=f08MnhadKzImYeAw17NTsQWYjYmLHNuvCH+TU3n+AmhXXkaLpvi/90Np0+32Ta6B09Na4hOqLB5s6dTHG1aeeE8/5xttrvmGChTGXlcWGSuAxgNHZD9m3p6SzoyP0BQeQFW4UHqpxIwWPQNI+dtNWGP7/LwnzJVFACIIENAOpYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714400704; c=relaxed/simple;
	bh=8IqSXxM0lyLlezo4jtOmriLCQq9+ncFmz7Lg8s6Z2EY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n3iQDER7StRmk8jcGn/SsmX+nkarlCnlyTOm3l745PJMo6NWyAnQQ/mL/csiYpioMT/FsyKsgJm9uTFfNOcaeAnuLc7JvOFwCPxqA9ASGxV8AIFHO/7Vwr3QpaQ7sl8SdEEkW1K3AR0J7If72IRSLIm8Invpvk01imSeOTNT3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com; spf=pass smtp.mailfrom=yadavpratyush.com; dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b=qtiFWGOV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HZhcdpkK; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yadavpratyush.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yadavpratyush.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yadavpratyush.com header.i=@yadavpratyush.com header.b="qtiFWGOV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HZhcdpkK"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 423981C0017B;
	Mon, 29 Apr 2024 10:25:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Mon, 29 Apr 2024 10:25:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	yadavpratyush.com; h=cc:cc:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1714400700;
	 x=1714487100; bh=EnwTU7GdY8HfO3Tilyk5/kkjS9od6dwurXnhx73LT04=; b=
	qtiFWGOVYgCF955m/mCkzpvZ4A8hfEt6NbgUvqqA2TSWUKdJANFpwVkV8ZEm8zGd
	T1Gkr/IsEpGAtuDjdKnUfldXjNhyjwZ3PFZo64vZgKcdbvpcAvPXIgA7RUxSUINv
	HyWZhElj1XqFm8PklUfYlAwkdVEmvSDMCWrzHu/atSOFXaWgM8fu/DH+BvwjE8KU
	t+IAvOS8T4F23kfS0MzQVH9DIV5KjvDK0eZtvoIqwFN8XsAFAewUohi4iylyrG4O
	SJ11V8qZ7B5FphdIwe12N+nC8hemEvuPz7cwg4m6BBl6G0VaeV04f+0BVElh7Qsp
	pN8eO2/PUyTx1uAxyP2tjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714400700; x=1714487100; bh=EnwTU7GdY8HfO3Tilyk5/kkjS9od
	6dwurXnhx73LT04=; b=HZhcdpkKb9PbAu5UL5F/R+bUedSJ7E/AEQ0oOxLHwUCH
	Xp3rOLvjCoNEs7JV8DCDOvW8KIvc+apMkEsvjb7q3JByN046jk801uFDKG1cFh3P
	HLiVsYIASOwY8UlbOZAGrS7HiDC6ZRdyh0mebistRUIIGwNPIZAs17f58UuCVsJq
	bGuD6wXTPSkoNKeBu8pT0ObbrxsnGbn2RQRHUjEsZs2MsasX0FPnycAlVEULCSXT
	NW/flByJ3yQWDd1uooZY672w9pSYgEAkoNSufIYD5yzwOXX4wuGsJldQTxq73KMu
	gLsbQfDI61aUC+Z2PP7arNbyPxqBsY0nd8nFyuL0tg==
X-ME-Sender: <xms:vK0vZpgjiFte1H17_ONS4kRNsLj5AiZ4QTzVRW1B-9v9QrZwRJgGNA>
    <xme:vK0vZuDTBzE6WPLjbcAqcUDz4VBsBFBXQF-BknN2FZrdpbVbbQsussYrp2H6p1ocd
    zZ9Ych8j35UE3VtuzA>
X-ME-Received: <xmr:vK0vZpHOkHKmreGNiJOJHtqyArEgMFwUuXwHw279qvrWu5HKk5Zh13eaW1xSM36ZSudFCNW6dFOIyUB8F0sa37oZ3P6JVx-3GJYFAB7BqvhaOgNyu8knyUnXDYR7gjTdOVK0Ij7JcKCZwsPuwnrCpPk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdduuddgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttd
    ertddtredtnecuhfhrohhmpefrrhgrthihuhhshhcujggruggrvhcuoehmvgeshigruggr
    vhhprhgrthihuhhshhdrtghomheqnecuggftrfgrthhtvghrnhepvefgffeuffelffeive
    eghfffffeikeeivefhvdeuueetfeekkeegtdehheeuueeknecuffhomhgrihhnpehkvghr
    nhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehmvgeshigruggrvhhprhgrthihuhhshhdrtghomh
X-ME-Proxy: <xmx:vK0vZuSlzVFNPnIvaYEof10baGTfKutJ0w1h15gtNGIAFA_oJQ0q3w>
    <xmx:vK0vZmw-DnpzN-jvXR1Xzr2zjCI2jkE_GoDpc4VUDSKMy_Fk5BODVg>
    <xmx:vK0vZk44nHjgyCSGGenwf_S2z2TBKf0DrFHH1GTnO6AN5zEzYYusow>
    <xmx:vK0vZryen7Nz2nKOqvYEJsWGbv0HsZsC0yOpwLrbxLEsU9-rAsHN-w>
    <xmx:vK0vZgvJR1WS7_7J6RFiVDth4mYk-Wdle8oM6sHI0ky44x05Kfww2wIx>
Feedback-ID: i93f149c1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Apr 2024 10:24:59 -0400 (EDT)
From: Pratyush Yadav <me@yadavpratyush.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,  Pratyush Yadav
 <me@yadavpratyush.com>,  Junio C Hamano <gitster@pobox.com>
Subject: Re: Git-GUI change of maintainership
In-Reply-To: <0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.org> (Johannes Sixt's
	message of "Sat, 27 Apr 2024 16:27:52 +0200")
References: <0241021e-0b17-4031-ad9f-8abe8e0c0097@kdbg.org>
Date: Mon, 29 Apr 2024 16:24:59 +0200
Message-ID: <mafs0r0eob610.fsf@yadavpratyush.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Sat, Apr 27 2024, Johannes Sixt wrote:

> Hi all,
>
> In [1], Pratyush has expressed the wish to hand over maintainership of
> Git-GUI. Since Git-GUI is an important tool in my toolbox, I would
> volunteer to pick up the task.
>
> Pratyush, please let us know if this would be OK for you.

Yes, certainly! Thanks for taking this up and thanks for your work on
git-gui in the past :-)

Acked-by: Pratyush Yadav <me@yadavpratyush.com>

>
> I will let you all know if and when I have set up a repository to pull
> from or to fork.

Would also be good to send a patch to update Documentation/git-gui.txt
and Documentation/SubmittingPatches.

>
> [1] https://lore.kernel.org/git/mafs0wmxkcs3o.fsf@yadavpratyush.com/
>
> -- Hannes

-- 
Regards,
Pratyush Yadav
