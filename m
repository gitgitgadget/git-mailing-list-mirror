Received: from wfhigh4-smtp.messagingengine.com (wfhigh4-smtp.messagingengine.com [64.147.123.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F28928691
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 11:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707476616; cv=none; b=BjRLb/zAq9JvjF1beucz1GJcNAo+U8WwsmDDsnUqALud5WRhclakERDWXegzbjk4U3ogpTrr0crWJ5oSDGTDHhqzqk4a9woPDT8lATwfDKkVVJzg6wPrjE8GvXI+o/u3FxCklEsa3Kp29k+KfQKluf6wl6lZS0JqEWuZble70Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707476616; c=relaxed/simple;
	bh=/ZegZ+YaeQg1mJ+DD9UsVn8vaO5y7d36pua2KXoe9Fs=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=huwBPpBSkHYmQs13oi63w7/epmobqr51C+h0f0AepfLx0iztu+sJRXgkvsl1c6wLoGKuCpCpovKDMnT2XSq6yBok+Pzrs43/LxDsXOC9q0uLb3hktMXdNLT7VERZa3XIJJTA6VaIY7ch6Od7W1QM6kA6mBejQq6xqkIOwOS4BI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=gOATbne7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AIaDMesG; arc=none smtp.client-ip=64.147.123.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="gOATbne7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AIaDMesG"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 24C871800074;
	Fri,  9 Feb 2024 06:03:33 -0500 (EST)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 09 Feb 2024 06:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1707476612; x=1707563012; bh=NWs3C2IlTnp1fKvXb0c6L////g9aOvi7
	lFXmyGdWTZA=; b=gOATbne7aiKyWX3t1uhy244fwc1oHSdCEuaYzPSwuZF+uJvK
	DghKQXOdnVygimOEK3nub/FYzDTn8z8QNCSpisuX/ShKdM8NrFCdYE9gG/jedg8k
	gV/wGlSlytThGpl1/k6kELM4H2PRWN73NgLoxboaLWoZqOqrgTJvYkmxNEhBeOcF
	lu54AXfkJyHzPTsSfIYQAP7W8FnY6gXKFDwbXKAKj7nJYSZdgZ5QPFeZ1aoQG/El
	idnHzl/yvlNKeHeHD+BJIDzUluqeOGA5rucWKj2iKJjZBuW5A4z2dV4oHvWU0q+7
	/VBmmyoVTeri1mia2uNzsaFCbkJ3rSiRnj13jw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1707476612; x=
	1707563012; bh=NWs3C2IlTnp1fKvXb0c6L////g9aOvi7lFXmyGdWTZA=; b=A
	IaDMesGJTpbTSkzxQjY3LLn3lB1cNNPNEmEz3XEyz9PCTW0tFRCk+s4WeNVEd4lr
	pA41SgO9JrVaCPBiltrfQ6cG59H1j/j/+4l848bui5/AYUvm6/vy/zj6q1h1mdZI
	A7YFSDodSzrEWirnrsGqHE3jpUqM21X1lS4PrNaS3KuhyqPudKxJL+XxJk8DCUMk
	XYMqjUUF4P16TCbflndbTLke5EUEgk07CIy63mw3/PX8VPYSB6qmof/IHlb5xF4G
	CCWFmjcuWSNF9szA/Etavdkc5todZmjeL0Sw4YGiwK/TRP9eYCIv+9HuRrjc7TPM
	Gz7VjWOZOEChB8Wp2jZ+g==
X-ME-Sender: <xms:gwbGZfjqtIbXWu9_DhoE9uZXXmuus0IIZWMKHM3dP-1cq9F9qMqCjJU>
    <xme:gwbGZcD3uNpkW2FJEtedKFQKFXJyfhDIjMqH-Uo96KtUsRNu0KzKBtMwgDNIarBrd
    Kp9lS-hEGwVlFcWng>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtdeigddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeehhfel
    iefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:gwbGZfFUuCvJ_cBxOTa2DNhkYOrM6ICzhfj95FDzjGO_0wUWUClxZg>
    <xmx:gwbGZcQc3Mq0mldwPPqCiKf0cY5AQHe8AAFe-Sfq-zT-leaQvZeNUw>
    <xmx:gwbGZcwbhNp-Wb3wY-MiyyGyppOcLwYMLsO4r-p69_RM_iOBkfvcEw>
    <xmx:hAbGZX9Wkq3i82JTLwSZla2LuqwofJ3KsyH0iD60JwasSwYbTIIRBvFuV9k>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9C9BD15A0092; Fri,  9 Feb 2024 06:03:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-144-ge5821d614e-fm-20240125.002-ge5821d61
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5c25da43-c886-41d2-b057-b95a84b107ba@app.fastmail.com>
In-Reply-To: <26317088-7020-43EF-8B60-41D719A6D145@qt.io>
References: <F7D40DCD-2331-44D8-B4BF-8E6CD9EE64A6@qt.io>
 <51599394-3f75-4b75-a4c0-f13f117e73bc@gmail.com>
 <60512662-9BE1-4DF7-A4E0-FD2E852E8E76@qt.io>
 <3c3db003-1506-47c4-a010-a8b783dff959@app.fastmail.com>
 <26317088-7020-43EF-8B60-41D719A6D145@qt.io>
Date: Fri, 09 Feb 2024 12:02:43 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Marcus Tillmanns" <Marcus.Tillmanns@qt.io>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>
Subject: Re: Bug: Commit fails when no global email address is set even though --author
 is used
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 9, 2024, at 09:46, Marcus Tillmanns wrote:
> Everything you said is true. But it misses the point.
>
> If I try to commit for the first time, don=E2=80=99t want to set the g=
lobal
> config, look at man git-commit and search for =E2=80=9Cauthor", it says
> =E2=80=9C=E2=80=94author=E2=80=9D to specify the author.

That reminds me of a mistake I once did. I was setting things up on a
different machine and I set `author.*` in my config. Then I got very
confused when `git commit` complained. I totally failed to see that I
need to set `user.*`, not `author.*`.

Ideally I think I should have gotten this error:

```
Committer identity unknown

The `author` config is set but not `committer`.

Did you mean to set `user` (author and committer)?
```

> Since =E2=80=9Ccomitter=E2=80=9D is such a hidden feature that even lo=
ng time users of
> git don=E2=80=99t necessarily know about it, when I then specify =E2=80=
=9C=E2=80=94author=E2=80=9D and
> get the =E2=80=9Csame=E2=80=9D error message again, I have no clue wha=
t=E2=80=99s going on,
> since I just specified my user name and email, and still I=E2=80=99m t=
old it
> cannot be determined.

This is a very good point. The _committer_ is pretty well-hidden in
normal workflows. And probably irrelevant.

So when a user gets this error:

```
Committer identity unknown

*** Please tell me who you are.
```

And have never heard of =E2=80=9Ccommitter=E2=80=9D before=E2=80=A6 what=
 is she to think? I
think it=E2=80=99s very natural to conclude that =E2=80=9Cauthor=E2=80=9D=
 and =E2=80=9Ccommitter=E2=80=9D are
the same thing. So she thinks:

  =E2=80=9C Okay, so the program is complaining about the author not bei=
ng
    set. (It calls it =E2=80=9Ccommitter=E2=80=9D here for some reason.)=
 But I have set
    the author=E2=80=A6

Maybe this is another case of: it all makes perfect sense if you already
know all the concepts.

>> Your report would have been more clear if you included the error:
>
> Had I had any idea that the report was different between with / without
> =E2=80=94author I probably would have added it, or found out what the =
issue was.

You don=E2=80=99t know what you don=E2=80=99t know. That=E2=80=99s why i=
t=E2=80=99s best to include all
context.

Cheers

--=20
Kristoffer Haugsbakk
