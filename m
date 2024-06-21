Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705B8364AB
	for <git@vger.kernel.org>; Fri, 21 Jun 2024 06:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718953112; cv=none; b=bwUfhKd2aAH9G+KYRMZWQaMjcj3XPgZG4zqKV8XABXLOSgJp/5+qYSpb3Cow7fU2WnwsMEHSLlaW953Ib9o7mEu1MeGvp72KeRdQJ4gkkJhW/cEo7JqGdLMvvmqNJDJbUEw1D2dxAtuueEAq1IXY9GkYTRGNuep7FFOCf0WawMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718953112; c=relaxed/simple;
	bh=7XvKB7RJGgwEQCSpzkAUp3elPxb12v189AhMQtUEZ4c=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=OA0y0jz74yQX05RPkNfr1fhHOmwjoJjJ5WS7nAPp1nIUnxe1oJ4jahMVGn0ZjL2i1ySSApj7lSQIfuqSftMUDywBvLU+hzyC4J+C0yZzZJdFRJ/QxQId+6H0xFMuagD+73kMPM9UqEpZkFIMZJwZAZKNRbyKn5vs+fW22nnt2gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=rbcc2BR+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hIbnqmYL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="rbcc2BR+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hIbnqmYL"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 858021380297;
	Fri, 21 Jun 2024 02:58:29 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Fri, 21 Jun 2024 02:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1718953109; x=1719039509; bh=4YzZe3fDK9PRpDCIGT7/dsWbsQci43Qn
	os+YlW6AGuo=; b=rbcc2BR+GbVH82lAdtgOve8dKeoL0YeqsdnnOhT4DP7CjsB6
	D3m8C9LJq7bb0QE1DJ4M5SmhvQrLJvYWozlRQHHdpiq9GruFVc/HMOtq0XctgZxE
	C7iQ1WNJNhMXiRjiYejoJ5SFcvUCpOY5i+JaUDaVawHT27iSSczVayd6bUOz1pIi
	rQNgQh+C36SywwTLF6zfeqLgyY8hKHOEhIaLK3VUrZi6juXuNFjdXO1NZqh2eZUi
	oknjQuLJI5jYx9DAFbR0f9HGC0KX7D5/OWfprkpp48ms+wWszYFbofR5NK3HgZuL
	SVTNcwu7lypGr8Kloa8NGJhjTYoc3a+6Lwl0kA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1718953109; x=
	1719039509; bh=4YzZe3fDK9PRpDCIGT7/dsWbsQci43Qnos+YlW6AGuo=; b=h
	IbnqmYLWFeekOHkTX+aFdY6jcL+o3+TeGYRxNaeDAWuvXbJ3jc6z4binBd0Qo0Gc
	dXxHZVX2i19TUUzPi8fUIdW9sEy6efjQ9LcG6B95Zw3OaCsq2V062reopjC8umlT
	1Nq+/1hBZljRIouYyqWTp2ag6MLPlBNWl3Myr7wuxTFCSS8C5GALV8CFlQSgPOkq
	zB4LkXHVBr71lT2J7ENvX8NS+2Xm2s5aOMJknPiYKADLMcDhNdVWjouJVlZNbNIR
	F0rYW+Yp++CnCw+9XGhSylnvNm7Iu6T5K9u5hO18gQGQJLVV10HJF8buJsAbUcP5
	WeK146B3xMK/9g6uVKEDQ==
X-ME-Sender: <xms:lSR1ZsCbgbzZ3sSpv5NQkRjyJXngiyUu4OWgXoqQ8lw_Gwyhb7bZGXU>
    <xme:lSR1ZujsExKGTgGFCbEhP7hnc7WNTiKLKuOtDGVCsDJMtSeLABZHgziqyGw1OJF0j
    YC_ELRhNakGo4tNmQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeeffedgudduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepgefffeeludegudefffegteeuueel
    keetfeelgeevvdfftdegiefgteeghfdtfeeinecuffhomhgrihhnpehsthgrtghkohhvvg
    hrfhhlohifrdgtohhmpdgvughithhorhdrhhhofienucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvg
X-ME-Proxy: <xmx:lSR1ZvmmlCa-Fs0VGqWbhnbtKlS7Xx9NCkwTGE2BWXWI6tMFxxDUoQ>
    <xmx:lSR1Ziw6vhuO5n7StB3aQBcJs85cEISMV1uM8MuRCbzY1GQaoR-oKQ>
    <xmx:lSR1ZhQRFr1Fs6QzfAFnD2s2PyyWzKPi0Ms0vPcmjaRRmjyK0cQEvQ>
    <xmx:lSR1ZtbZE-0uZPtGMnWxDV_I_YBPd1sNjFTLZWjgx4QDm7o4LEHHsw>
    <xmx:lSR1ZgLfWZE89udOSxGpTtUiO7ovmtJ_tb05l4WXEEaeRAeTk_2xiTq0>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 3CD7315A0092; Fri, 21 Jun 2024 02:58:29 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-522-ga39cca1d5-fm-20240610.002-ga39cca1d
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4480de3f-851f-4cf7-889f-b5ab7c4e0223@app.fastmail.com>
In-Reply-To: 
 <CAG=Um+1EyB08n7oH6rgqPmmn0OWndUdv4vEsY5Hcv3aaf-BHxg@mail.gmail.com>
References: 
 <CAG=Um+0LXVRHmvKdTB9WHJujjh9agK_ZHdv45ffzMsqX65NLVw@mail.gmail.com>
 <665f77a0-f301-40ae-ab94-2920d15fcc8d@app.fastmail.com>
 <CAG=Um+1EyB08n7oH6rgqPmmn0OWndUdv4vEsY5Hcv3aaf-BHxg@mail.gmail.com>
Date: Fri, 21 Jun 2024 08:58:08 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Shubham Kanodia" <shubham.kanodia10@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Bug: Git Maintenance does not register multiple repos
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024, at 17:34, Shubham Kanodia wrote:
> I've seen libraries in a few language ecosystems use `ini` parsers for
> parsing the config file, and there's several blogs (that perhaps
> incorrectly?) state so, so
> I assumed that might be true. But you're right in that I don't see it
> be mentioned on git's official site.

I see no warrant for such an assumption.

In my experience, plenty of syntaxes are described as like-X=E2=80=9D. J=
ava and
C# are C-like. That doesn=E2=80=99t mean you can use a C parser on those=
 other
languages. Config files are simpler but the same principle applies.

> 1. What spec does the config file follow?

Apparently there isn=E2=80=99t a spec because it is bespoke.

https://stackoverflow.com/a/68461700/1725151

> 2. What is the correct way then to get an "effective" git config
> value? Typically, I assumed that if a value appeared twice in the git
> config, the second would override the first (for say, `core.editor`).
>   How does git parse "overrides" vs "arrays" if they are defined using
> the same syntax?

There are two dimensions

1. How config variables are parsed
2. What is expected of the specific config variable

`core.editor` is a single value. You can test with

```
[core]
	editor=3Dvim
	editor=3Dnano
```

The last one wins here. `core.editor` expects a single value.

But you can define a multi-valued variable

```
[customsection]
    mycustomvariable =3D value1
    mycustomvariable =3D value2
    mycustomvariable =3D value3
```

```
$ git config --global --get-all customsection.mycustomvariable
value1
value2
value3
```

--=20
Kristoffer Haugsbakk
