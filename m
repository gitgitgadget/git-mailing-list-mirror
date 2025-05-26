Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9919995E
	for <git@vger.kernel.org>; Mon, 26 May 2025 19:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748288714; cv=none; b=HpTKdR3RggSH/EKaGH0/HreCl3M+APrWypmEmflZlf08V2/UBqnlvuBIGCkuYMxNuMN8VUEsdQUd4h2ympqBvFi88Q8Tai0nLSVdHlUQHlSTT5KWdXrUQW1rrjzJanjt2Uxpf+0YFspmdpYLd2zdTx1yGk0HnDrfp0GpByCQ8Ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748288714; c=relaxed/simple;
	bh=FWu4VbZgKo4JZtgRQzZhIeiejRezZ4PeGWcPiCqRT4w=;
	h=MIME-Version:Date:From:To:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=rJKU1Ir0KnKK9z5HFPK3iU5NBb0MpyhEIMc2op9G9o49/6EiMaee3nVqEn+244LpM++EGCGahGaiYBNIQW4+W8g42HIf5IqKy8v+moXNyqPIWfRR29cHEN4E6lO1ZOJBWl7o8QS6bptEPej5ZlVilkB93AvKVtPSpd76R3lgZ9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=VPb6ojYy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ICxsbmrI; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="VPb6ojYy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ICxsbmrI"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 756F225400F4;
	Mon, 26 May 2025 15:45:10 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-09.internal (MEProxy); Mon, 26 May 2025 15:45:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748288710;
	 x=1748375110; bh=osSJtxtUw6fWP6Q5GNLlm7JuByFzjhPrG8pTH3xQcSs=; b=
	VPb6ojYyi75fq2PMmZHH/p1gTd8AlMPv+y5L+f1gUOxRc6oeq3o9FkAYkph2mJ5R
	Oz06k2e6jPe7g0V01HNfYSfZZvpPyaGreRDza2j4PdO4pBWJuw2Ku+B9UwoGvHaq
	+1t9YvB9rWO2NK3yTicYSHzXOy3sCWto0nG55Kbmulk+Jic5L3NAZ1bbchCzcwuq
	fZG8eA9Ibmgnyh2w6mBXGbFrHlbf2ytUQS28Ww4WRfaaJAAIepB+Sv6erjXsAe5M
	CpF33WNFOWjDkaUNlmWdRJM/KLMHXN3IOH2veb26VdiM4lXPyEgccSL9YdhvDhkl
	Lz7KiexJVKYWykw/5/SVrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1748288710; x=1748375110; bh=o
	sSJtxtUw6fWP6Q5GNLlm7JuByFzjhPrG8pTH3xQcSs=; b=ICxsbmrI1p6XXVGzq
	DNsRJFaR21srp/t+b0kk4HJ2PUqHhiP+vUuCfN9WrEqaDnK5fa07YLRQI9hzb2Vj
	65dAlOxLGoz4DuVLtYib0AhY2EIY6DwhcwQYSppIlnuE+hlMlwrQqSlUIRzV86Sr
	EirJ2Vomio7wrjurKULXU8yR2d0rEr7TCpm8k+R9eXeViqtnqWCv8Bmcwqsl9EJB
	17xn+Bn8jYQDd62usQXS2XqsVI+VdNgMkcmER+BuH27X8YFE0bIzF7IOLKqUTtPj
	vsHF+Ii8U9zUC91D452qwW3Nc5VM6TGO9TRp87uU9X+rEjFH/NlmlVyGL4HzmI+J
	gDiig==
X-ME-Sender: <xms:xMQ0aEuObjhJWiD9KB5IpbPKQWMUJpkbtWHayP6o0yY8XRI9EM17H_w>
    <xme:xMQ0aBcUBNqcGz-MMuEXOBsYPJtTH2HrsbvW2So0GlOSrL1j_fhsUNIaTXAbE2Zxc
    J2eG4U6kySWgA5pdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddukeefleculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefoggffhffvkfgj
    fhfutgfgsehtqhertdertdejnecuhfhrohhmpedfmfhrihhsthhofhhfvghrucfjrghugh
    hssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgr
    thhtvghrnhepudeihfeigfethfekgfeghffhgfeuffdvtddtvdeuhfdukeeuudduteeitd
    ekheeinecuffhomhgrihhnpehophgvnhhgrhhouhhprdhorhhgnecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:xcQ0aPyPXezs5K9xP4mwkTvizBS7MANu0hykdLc8jtTkQOCu5pr84A>
    <xmx:xcQ0aHMiZjyqWAFe31bylupM2r5zxzqfOUu6f7hdR6e39dFU4kSPng>
    <xmx:xcQ0aE_BtzJHrJ8bc885kEPOqFyehoPKh7OuCrsKIuCm9b3sFbCHkQ>
    <xmx:xcQ0aPXkpOfL9V8yKzQgCO925sMrLm0fsLz1YDKy1wpRwhQIvR_GbQ>
    <xmx:xsQ0aN-lv82LiYTxQlPoIlUHoIzxFULBqA67_C6o85juvPRUfj_h4YK1>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E60AB1EA005E; Mon, 26 May 2025 15:45:08 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: Taf9fec3ba48f0e1f
Date: Mon, 26 May 2025 21:44:48 +0200
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org
Message-Id: <10280d7d-af36-468d-82b8-e0e780c38ef1@app.fastmail.com>
In-Reply-To: <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com>
References: 
 <c59ae2c0c7c8420ec1c5bedb87f28c7f5b573a60.1748122397.git.code@khaugsbakk.name>
 <66e92d69-8372-47cf-a350-95365f72ca1c@gmail.com>
Subject: Re: [PATCH] notes: remove trailing whitespace from editor template
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi there Phillip

On Mon, May 26, 2025, at 16:01, Phillip Wood wrote:
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> index a3f433ca4c0..ca4782eca19 100644
>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> @@ -180,6 +180,8 @@ static void write_commented_object(int fd, const =
struct object_id *object)
>>   	if (strbuf_read(&buf, show.out, 0) < 0)
>>   		die_errno(_("could not read 'show' output"));
>>   	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_s=
tr);
>> +	/* strip trailing whitespace introduced by blank lines */
>> +	strbuf_stripspace(&cbuf, NULL);
>
> It doesn't make any difference at the moment but I'd be happier if we
> stripped the trailing space from the commit message before commenting =
it
> out. That way we know we are only stripping space from the indented
> lines produced by "git show". If in the future this function were to
> start appending the commented log message to a buffer passed in by the
> caller rather than a file passed by the caller we wont mess up the rest
> of the buffer content.

Do you mean doing the operation on the output buffer instead?:

	if (strbuf_read(&buf, show.out, 0) < 0)
		die_errno(_("could not read 'show' output"));
	/* strip trailing whitespace introduced by blank lines */
	strbuf_stripspace(&buf, NULL);
	strbuf_add_commented_lines(&cbuf, buf.buf, buf.len, comment_line_str);
	write_or_die(fd, cbuf.buf, cbuf.len);

I think that=E2=80=99s cleaner.  But I don=E2=80=99t see how it makes th=
e code more
future-proof.

>
>>   	write_or_die(fd, cbuf.buf, cbuf.len);
>  > [...]> +test_expect_success 'git notes add has no trailing whitespa=
ce
> in the editor template' '
>> +	test_commit --signoff 23rd &&
>> +	GIT_EDITOR=3D"cat >actual" git notes add &&
>> +	test_grep ! " $" actual
>
> Should that be " \$"? What you've got seems to work with dash but I'm
> not sure if it is POSIX compliant or not.

`$` is the anchor metacharacter in this context (end of string)
according to Posix.

https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html=
#tag_09_03

    $
        The <dollar-sign> shall be special when used as an anchor.
