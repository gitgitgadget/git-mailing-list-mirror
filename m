Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26272F22
	for <git@vger.kernel.org>; Sun,  4 May 2025 14:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746368578; cv=none; b=ojpc3U9KNBx273pbIPKO//Td6DJlIMVSG5Kko1cYw5dZsXmTpBfPZEOMsNaXVVpRdwVHzjT25Zf46aq94iUfuF7g1q6/u8DK915mECiBAG8svpwrCAJQG19Ms/ncc5DD5fIFI8NUsngtuQXK8BC40DPLWZJ33GGGp/xXCXNX8X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746368578; c=relaxed/simple;
	bh=+UrscV23fF/mTHIqv9S/ssVt95ACI06wrIBB1Cg1XEI=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=at06y8p5U0eCSqpteMj+P2r7P3zS34L9p6Xs2DuwA+bjYuOQXiwrGme7AumQpAR9cRQ9ahwHyLIoAoee+ErS7B/2QzTwcNXJiN4ffCew5QxMbjqItmhj4aEqDM/pKZjPxlpf7FMB6CdIEVaOrcRo4avrzyMHsTtESJLzbtnJQB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=Z66NGf2s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uXI+z0na; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="Z66NGf2s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uXI+z0na"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C5E981140187;
	Sun,  4 May 2025 10:22:53 -0400 (EDT)
Received: from phl-imap-09 ([10.202.2.99])
  by phl-compute-09.internal (MEProxy); Sun, 04 May 2025 10:22:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746368573;
	 x=1746454973; bh=Oe4NR+9ogcxyt+2/4IbWUfY9zAMg2nF/Bg3zra5Ew/I=; b=
	Z66NGf2sV6WcWblHCrK6D+t4CY0pVeoVQiyPqPUdgb0GUtmwWf4JIaUnyXf+VRzx
	kLGppDToVzth8YFmV1xloFyh6CH3ZAk2PVCjRR62EA9aI9AbnrG9242GThPs0IPc
	T1t1JSMLIdvsX28avQYeW7S3brdbwFotpmRU7F/+G5A0SpJB/QIg+kctA7t93sr7
	7nmdEHPZr7fXr3y6dCcFof3saQFdQYj41cMQquYyxJYKrk8GM2ox/OeDr0fwyUSP
	XmlJ26sbk4t6blE7IpMxfHiKGZ+wY5kR7QaJ1d5K0fVV7me9e1GTzlokBqVf1YZC
	T5upb2wWnF4G39NFbMRmHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746368573; x=
	1746454973; bh=Oe4NR+9ogcxyt+2/4IbWUfY9zAMg2nF/Bg3zra5Ew/I=; b=u
	XI+z0naycU0NVY6gVsAiVvzyq3EmHPVmKxA52YuVS/i3O+5hn8+MtN/Jpomlyr/y
	YD64CKYLa1ohhyXK4rJGvU60fNvn8nMeV222kf5fZnf515keIF8jp55vpd5XjCis
	vanIvsN7u5X0AYpXzO7yDn8OFdEEb6z/8VUSvmwdioswSETB13hKy4QlfRKCxD5/
	XM6I/AlKQN1yd2oaaccj7Nm46FFP/Fi4M0nzxExc2sdSTt88hoirV9tMmPV7DoBw
	gHCXEznycSbzThfIde9dvE0G2MUBi4tFWicKVytHAQXssbLOIAm3/snsPZL1Oxar
	YLVUYcHUXBxgEeVVVzjEw==
X-ME-Sender: <xms:PXgXaGxnXt665IWYbSRDkE4eMpNDR4_Ew9Bd0hPk8sh_XvLXNRO5f8Q>
    <xme:PXgXaCQto8aCT237YQLvLD4lVKBZyPun_WT6Bv6vEH4ZqR4CWe5kGuH4C-RBu5Lvc
    Lw2gajgIbrgbOx4ig>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjeekgeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtqhertder
    tdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoehkrh
    hishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomheqnecuggft
    rfgrthhtvghrnheptefgveetgfelhefhhfefvdeuhedufeeufeejffekfffguedttdegud
    egffeggfegnecuffhomhgrihhnpehivghtfhdrohhrghenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssg
    grkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihthhoohhthhhprg
    hsthgvrdhnvghtpdhrtghpthhtohepmhhirhhthhdrhhhitghkfhhorhgusehgmhgrihhl
    rdgtohhmpdhrtghpthhtohepghgrrhhgrgguihhthigrtdeksehlihhvvgdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepjhhulhhi
    rghnsehsfigrghgvmhgrkhgvrhhsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:PXgXaIXomPp-XLCvzB2XgVp1yAuq5gMj8-efNfkeff4gzaWTKN6Apg>
    <xmx:PXgXaMjqgQmKo0MLNR8XNXzKkTYiYYqGZ05Vy_zbiyvo-YkzWOUBXw>
    <xmx:PXgXaIBr5OEwT9ELZZwj_hNbxxoi55-s4V429VfBPDCQqOKXYIvr2g>
    <xmx:PXgXaNJhvQHkov5JM91rSsHb8UW---oedcl-py14rZFh7fWKl-FdOQ>
    <xmx:PXgXaBbIOtVqjoKGLluBwb-J5m9nw1eL9ZpLnaMfCcbu60mDj1k5Zjfn>
Feedback-ID: i8b11424c:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0140C780069; Sun,  4 May 2025 10:22:52 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T7c57673a799ce033
Date: Sun, 04 May 2025 16:22:32 +0200
From: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
To: "Aditya Garg" <gargaditya08@live.com>,
 "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
Cc: "M Hickford" <mirth.hickford@gmail.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 "Julian Swagemakers" <julian@swagemakers.org>
Message-Id: <a2ceea8b-8354-4316-88ec-54111fb98d69@app.fastmail.com>
In-Reply-To: 
 <PN3PR01MB95975D45B072101812714C72B88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
References: 
 <PN3PR01MB9597FADD19D6BBCE3FCD4FBCB88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB95975D45B072101812714C72B88F2@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Subject: Re: [PATCH 1/3] send-mail: improve checks for valid_fqdn
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025, at 15:54, Aditya Garg wrote:
> [1]: https://datatracker.ietf.org/doc/html/rfc1035
> Signed-off-by: Aditya Garg <gargaditya08@live.com>

Finding the s-o-b here works fine since only 25% of the trailer block
must be valid trailers, but it=E2=80=99s probably best in general to sep=
arate
footnotes and the trailer block with a blank line.

> ---
>  git-send-email.perl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/git-send-email.perl b/git-send-email.perl
> index 4215f8f7e9..4c143e24bf 100755
> --- a/git-send-email.perl
> +++ b/git-send-email.perl
> @@ -1359,7 +1359,8 @@ sub process_address_list {
>
>  sub valid_fqdn {
>  	my $domain =3D shift;
> -	return defined $domain && !($^O eq 'darwin' && $domain =3D~ /\.local=
$/)
> && $domain =3D~ /\./;
> +	return defined $domain && !($^O eq 'darwin' && $domain =3D~ /\.local=
$/)
> +		&& $domain  =3D~
> /^(?!-)[A-Za-z0-9-]{1,63}(?<!-)(\.[A-Za-z0-9-]{1,63})+$/;
>  }
>
>  sub maildomain_net {
> --
> 2.49.0
