Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BE313D538
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 22:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711491182; cv=none; b=WJgeV6eqiLvWUSSb8ySxsPD8oZyFtr/DUKASJc7+1GgTvzjUjDJ57upX2JnTh6FQ+90bGWLIZk5PsPs63NYNL3ZrWAhuWceyOS/zvROToil2121Bptj3MFPbXgcY3odumRGA47KYC+ndqaD5vyZqLU0LK8U8f3h5fG1u3/MH+CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711491182; c=relaxed/simple;
	bh=hxIO3JFREjQ1fzQ+fbX23irHeWwFODldcS098GbO4zw=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=RmdFGNL9nfY6Q/StZCglNCt3JI4KkFjYgLXT0SgyObXtluc/fWuR7Zam+jp6YSEdZhr9jZAMuIIF22jJ/f3vGSrK/qliWbf6rBwVNRZkvzsBJeUxyPpxv1TmK0wzDby4CAFCSPKB3xCPgvpKZgdU7kJr87tweg5PHDrR0D/73rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=e0jeJBjc; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EAberWW6; arc=none smtp.client-ip=64.147.123.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="e0jeJBjc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EAberWW6"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.west.internal (Postfix) with ESMTP id 54EA53200A02;
	Tue, 26 Mar 2024 18:12:58 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Tue, 26 Mar 2024 18:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm1;
	 t=1711491177; x=1711577577; bh=pySJbe5xVK7iMyRB+zGeFLbjunC+vXus
	YapU3Mup2/E=; b=e0jeJBjcx2XAn3ZtOSMjJaol0g8aFR/tJlhn80CQeVFFM+lb
	Rmpq4lIdu+NRHFICbGfW0I7Fu9E7fVFcjGWnESZPQRknFfuL2EswWq0/0sIZmmyK
	zuSWjyttVPumpTUTKi524OiT42dp/czhPQNd2gex76uqx7ZRpWvBq7FA8eDak710
	7ghbGtZYzQ3eGzqrn3QHU1HiHWJKJasUxBkZhIfTbLP8mnTC0WWnjL2ELv1tK+TN
	zjCNeidjzjJwrAKBe/+AzyzVWII8liBqJ8D2RzvqrNX/zMdAIaFBUEuv2alZ4bOF
	MeYlVB5O577TFTe5dX+P2J4KNQqNdToVB0fgyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1711491177; x=
	1711577577; bh=pySJbe5xVK7iMyRB+zGeFLbjunC+vXusYapU3Mup2/E=; b=E
	AberWW6yXFcL4nuY/TazqQOqM3SJFmX9JiOacS4GDCd2zdPeNUPODX6KwKe/9gUg
	IXPdKiBQ23hiU6l04lm5P+1kySvUZDFIYg8rXC4GgKCqqgmwAUkxUAAPOiH7odH5
	b1FuRG6b6qFgVmgJqNaXxj0kd05s//00nzrLIR92fAjRlnbSfl9hpDXPsIcWEPeT
	tVHeh4dhZSEbbDsknLdnz3pc700MUzikQV9xFkZJGtsTxs7ZVv7LJK3i0RpdFrNU
	diRuy9pqiGm44g72p4JeWMSuuKdvRGidecG19kZUDVE6pC6ejqtgCEOhFH+lpfZ6
	xEot6GQ5Lnj0pm/4YTFpA==
X-ME-Sender: <xms:aUgDZtJRiNLKIURaquhKuE6qBzETa5ggyukBB79UqOtx-c3QFyTPyTc>
    <xme:aUgDZpKeG--l_Fteu0tDmaPZ0RO0aTek73Zqcj1Jgre0GXnk23YeT3c7TjYpDOiUX
    KXvKrht9FCiyMHs0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddufedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedf
    mfhrihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssg
    grkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepvdevheeiudefheffvdetueevkeeh
    hfeliefgkedtieefudetueehueeftefffedunecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:aUgDZlsIMmFNcmFJ2JWTUJGtSmChfWighS8f9kCK7Z8xDaeRuH1ClA>
    <xmx:aUgDZua8ljh_eo3s0I57jUVDq9ghlM5hFAHDZmhqfup_CcPsRTZEnw>
    <xmx:aUgDZkbWMFq5UsC-ambEHx1JLwKzAFR8s21I9MYfRNL2TrwWxzLgEQ>
    <xmx:aUgDZiC8vAT-5DKy6aJK8xs-B-y9UIHgD8n9zIlJYOYyOT7YriEv8g>
    <xmx:aUgDZpPP1QMHKCqBh148LFhrrlaRsrzbnGPSEyXICuyCtMTyd6n4PQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 2C45315A0093; Tue, 26 Mar 2024 18:12:57 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-328-gc998c829b7-fm-20240325.002-gc998c829
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <aef18cfa-e5fb-4575-9d9b-095ada1d03ef@app.fastmail.com>
In-Reply-To: <xmqq8r247igg.fsf@gitster.g>
References: <20240312091013.GA95442@coredump.intra.peff.net>
 <20240312091750.GP95609@coredump.intra.peff.net>
 <0426f7bf-6032-4fc7-886c-c4278c6e105b@app.fastmail.com>
 <20240315055944.GB1741107@coredump.intra.peff.net>
 <6be335ed-8598-406c-b535-2e58554b00e9@app.fastmail.com>
 <20240315081041.GA1753560@coredump.intra.peff.net>
 <xmqq8r247igg.fsf@gitster.g>
Date: Tue, 26 Mar 2024 23:12:36 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Junio C Hamano" <gitster@pobox.com>
Cc: "Dragan Simic" <dsimic@manjaro.org>,
 "Manlio Perillo" <manlio.perillo@gmail.com>,
 =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>, git@vger.kernel.org,
 "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v2 16/16] config: allow multi-byte core.commentChar
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024, at 23:10, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>
>> So anyway, adapting your original suggestion based on discussion in t=
he
>> thread, maybe squash in (to the final patch):
>>
>> diff --git a/Documentation/config/core.txt b/Documentation/config/cor=
e.txt
>> index c86b8c8408..c5a8033df9 100644
>> --- a/Documentation/config/core.txt
>> +++ b/Documentation/config/core.txt
>> @@ -523,9 +523,8 @@ core.commentChar::
>>  	Commands such as `commit` and `tag` that let you edit
>>  	messages consider a line that begins with this character
>>  	commented, and removes them after the editor returns
>> -	(default '#'). Note that this option can take values larger than
>> -	a byte (whether a single multi-byte character, or you
>> -	could even go wild with a multi-character sequence).
>> +	(default '#'). Note that this variable can be a string like
>> +	`//` or `=E2=81=91=E2=81=95=E2=81=91`; it doesn't have to be a sing=
le ASCII character.
>>  +
>>  If set to "auto", `git-commit` would select a character that is not
>>  the beginning character of any line in existing commit messages.
>>
>>
>> That's assuming we don't want to go the commentString route, which wo=
uld
>> require a bit more re-working of the patch. I'm also open to a more
>> clever or pretty multi-byte example if we have one. ;)
>
> It has been 10 days since this discussion petered out.
>
> My preference is to introduce core.commentString to avoid confusion
> coming from an older Git using the first-byte of a multi-byte
> string, or dying upon reading a configuration file meant for a newer
> Git, and then let core.commentString override core.commentChar, but
> I would prefer to see the discussion participants to raise their
> opinions and reach a conclusion.
>
> Thanks.

Sounds good to me.

--=20
Kristoffer Haugsbakk

