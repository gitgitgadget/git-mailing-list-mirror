Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.155
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333591;
	b=tehJtXcv8AjUwrmyHWJWyNFJuwAqW/2MF3NCxVvF9lU0dbSy4SYOHyZdJxbyGTOyOGmb
	 S3eGffBWTYrfzB2tXAwOcx82Rb16EnOUi2U8pZm5Yr2W0y1TPb+h9zkomUuH0H+s/EhY/
	 nQnA+Mig6C4JEVOH0upwT9T90bGEpoM1HSYXef5gQFbzwadoUm3h+rPQwvVo9vJLPx91Q
	 HyFhephqHyQx1S4UrwwFclyzTqsZov6FURQBlq/0w4dt5Fro5wLZh59fNlKlp82E7e+1E
	 BkkTL8b1gKeRJ2JhC5bHFXqqXxrFet+xeg87Y1lbc8XWZJx+PGWP0kFuV86PvySVMkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333591;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=PxOEvbXldsU8IbwLKASQSjMGWUUASGTnxvK6GI2RSeo=;
	b=VWZrNnspo89tEXFtjc+Ej9Dysg8dP9IbQbkm26oeLJGTbCxiKPGihGrsuXiS6szh0fMC
	 OYW+SSMSDc3AX+PrLHYQy5vIPaOS/+FVoZB9+AtsmvAmXgthu6wGKj3BRWNO+7/hWbQ3j
	 4mNNXg0BLjjwSe7ggF09le4Pq1TeO6DJu2mWqwbJqrlaIN2cFYOwY32Cmz5ZLniCXONGG
	 CpLLklhVuKfshWtfD1izNYYialLSjA6LDSp+ixlhOvIIKIaCJmNgT95o73z6DgTqvROAU
	 DcWLgQG4029OYv2yxKgWehvxX3hNme02i3p7O+fFBTx7N819aNPrXizOGKSBXi5ZcXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=nqUv3z6V;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b="S/V4k0ux";
	arc=none smtp.remote-ip=202.12.124.155
Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5536A606A334
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 17:59:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5536A606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm3 header.b=nqUv3z6V;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=S/V4k0ux
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9C0637A0341
	for <git@vger.kernel.org>; Tue, 10 Nov 2026 12:59:49 -0500 (EST)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-05.internal (MEProxy); Tue, 10 Nov 2026 12:59:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1794333588;
	 x=1794419988; bh=PxOEvbXldsU8IbwLKASQSjMGWUUASGTnxvK6GI2RSeo=; b=
	nqUv3z6VmsfTuPnDDQU3RhAuzUCttUJbV40F2q1Rvfb650/Pv2WX6LajV9Un4aKq
	bC3YlhP0fTAbyW5MFCrV3Z5ui1wY3S7MvMgeT5EbMmt74zeB5VT9pXk0iq2BOvLK
	6pfYdi+HCcwnbpF/BFhpaB/Nn2MwGGT1gwvLSzm19DLctT0yxpAmPR/13g+UO9G/
	6gjzm6z4JEA+IAQGbzSioKL8YDg5+rLZzlyuyb95itg6A3dStW8ZkNtdVWk8g/bh
	xkH25HzRhyjzg1IWd4o3j4Hp2amB+FBOv4IaDsSUERHhH+YIur3UpGHzzM6QOyBO
	CJcTNHlopo1ftsnkDB4CYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794333588; x=
	1794419988; bh=PxOEvbXldsU8IbwLKASQSjMGWUUASGTnxvK6GI2RSeo=; b=S
	/V4k0uxxADnJHJgpa4k6cNkwWzsJ/+nOThHs7HMhP3XIFSZDA3p6xYEPCztOFQus
	Cg3p9QWA89VDKOqU68mKawMHj2lVHK/I4ACHso+N4mVpKEaxyxa9lzhTLmcuzEf4
	QrewwPNcPR7D4UxB82omSZ1rdQwt/JfgnNnfe20Vjsgsgp1fRWtY6I6gshgZX9Eg
	atgS4Tafkf9YlWh6+wCSxcnJtxstdu+LhEj9WcNsssl2GSTO1zX6ktvRxkboN/PL
	bAF//Is184UeOUIO30IIK+/Ul9ZJJZTj0SnvYEQzNwAawmvbeVJHF5e5HD504zDa
	wrcduwi/iAuJzV9ZwJaBw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794333588; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:h9tZN+Y9SstB/JDoSM0+e4BvZ7qGnuuiV3yEPyPv8ZT3d9l
	iI2iWg8EaAdRNcDhLwB93NlS8O2drBjser51cH5HRMnzDqHTF8q/Qm0bMNahll+t
	3BdRdFsK7hSPjgRBHVEneDvw9Zc4pJRExBKWD7GDrBXZ1BF4Cxfu55+igruKhltz
	apnsXuw2wugovfbxLcc+9z2tJIA7AqfCOYyToY08u7UvB5/GaPJ7DyiYZ9pCi7C4
	TcDLmsMx4DT5cPSE17q+PBRyFnazP730Z5hx0U4R4VA6cVnjw4/45ZDvCpccFl62
	XHtTCDyJBsfEeF6SBo21E881fhCgKh8m8mmHHfA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:X6af+JYVUfcEP7SqfacnmytfTPzDTEPbTgAbtj6LEPY=:PxOEvbXldsU8IbwLKASQSjMGWUUASGTnxvK6GI2RSeo=;
X-ME-Sender: <xms:k1vzahkXG3dVZi6PeG2J-ZosqozJ71RvyoWovqRJOZFadLJx0MI0DA>
    <xme:k1vzanof5OGNogU7XemF6Y32306R7M1OD-wsKsQR7FMOV8K-w-_EiZ8jaD0oZXjPZ
    mZ-hz7La27Sfd0Ywjoptwhm5P2pB9MAADiFNfVfOy6T2SvV4eQwyF3n>
X-ME-Proxy-Cause: dmFkZTFW7VDqPBdK0edM3n2q1igR1TcGcjTifskW13bw7YYn1Rq7geQpcK2kriUJgr0l/Z
    EE5Ip2G6Uw5lqJvCdb6aNxxd7CPmIUveQPHsVLybxrZHoxojuumIrnocS2jVrlHU50CkfK
    OYDsftUmuM8gAxAir9mB7rwXYtOD34VV9z54btiEgy3/dzZQzmg+9qKdpjdYYgztp7ODEM
    8i8ozoPPW8Y0W6E27CUbqcs89XgZ0DW8Wo0tcv4woHYUaQaWcamd8/+O3Zuf+6z0LYph5z
    ybH87fy44Bk3RNEETJNf/2FxKNgDY65LUCsdwSmBO+tBN0Gv+DKfAC9nxrKCyc4yI2GEZ/
    9aKKwAvvGqZRUw8DEyCmfv1FapWJR5SuHCsTaG8esEIunHve3DF8KQu7PfiXtzPhGXtP7H
    D5+4CRAKCoyCT+ED54FIW1rzISnjjqZop6tEZSMd7+nr/mpWj14OdknUMwyyvnn5XaPZ0e
    EgInt0iFG1kS7x2+oH3/83HDk4tXNgFgwpDzJf/vRIkXbBobmEm8frcjcnpYNE2t2Oln7+
    r0/NjexSNn6wSB4xWvvQaY/WIKkNhrLLp4DkLgtkEsVlbrk7VT9msIoJPyleMIyZA6uezI
    01XqFNQEysaUJbaT1XyA6WsD/OSVk24rs3hs1nU5PoJ3OXkB4Of8ayPEO4vw
X-ME-Proxy: <xmx:k1vzaoSWQvb4qwYWV8CZZx-5LX-Yq7HxXdnrDReBgFyqlU3zxtzEvA>
    <xmx:k1vzatIkTfVZc6KEQmeNC0zDcF1btsx1QYLCVxT51YTDaaAA4f0h2w>
    <xmx:k1vzarZdU80XqWkdt_snmZ4P9No0cZiDof0Tc2buv9aQBJwFBHbm-Q>
    <xmx:k1vzan9GvHXWgt3q7Dlr4mU9pJe3ya3zqQmO0ppo2YtEwDrz69u4ig>
    <xmx:lFvzauWf-RKgJxQ73YhDB5RgOhg7FFycq-j_WrFU_A1aX6rNTp-MaEOs>
Feedback-ID: i2aa947c3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9B79A78006C; Tue, 10 Nov 2026 12:59:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: Ai8eYB3nm2BB
Date: Tue, 10 Nov 2026 12:59:26 -0500
From: "Julia Evans" <julia@jvns.ca>
To: "Omri Sarig" <omri.sarig13@gmail.com>,
 "Junio C Hamano" <gitster@pobox.com>, "Tuomas Ahola" <taahol@utu.fi>
Cc: git@vger.kernel.org, me@linux.beauty, phillip.wood@dunelm.org.uk
Message-Id: <b5bf86d8-5a2c-4035-a8c6-f6e8c44cf7de@app.fastmail.com>
In-Reply-To: <b77fcd1c-21aa-4029-91d2-38c89a53f788@gmail.com>
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
 <20261101082230.141688-1-omri.sarig13@gmail.com>
 <eaa965fa-05fa-4945-aacb-2fc99b02159d@app.fastmail.com>
 <b77fcd1c-21aa-4029-91d2-38c89a53f788@gmail.com>
Subject: Re: [PATCH v6] doc: git-rebase: update incompatible options
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


>>> +See also INCOMPATIBLE OPTIONS below.
> Thank you for looking at it!
>> Elsewhere in the document we're now linking to the section like this,
>> since 2fc11e33820:
>
> As per Junio's request=20
> (https://lore.kernel.org/git/xmqqjyncxrur.fsf@gitster.g/), the current=20
> version is built over the 'maint' branch, and therefore does not have=20
> 2fc11e33820 available yet.
>
> I've discussed=C2=A0 whether this update should include the links, or =
not=20
> include them, and understood from Tuomas that the right way to do it=20
> here, is to keep the file consistent with itself in the maintenance=20
> branch version of it, and update the links everywhere in a future patc=
h=20
> (discussed here:=20
> https://lore.kernel.org/git/20261029080317.wWchf%25taahol@utu.fi/).
> Additionally, the INCOMPATIBLE OPTIONS section cannot be a target to a=20
> link yet, so this won't apply cleanly to the 'maint' branch with these=20
> links.
>
> Please let me know if I should update these links, or keep them=20
> consistent with the rest of the file in the 'maint' branch.

Ah, I hadn't read that part of the thread, sorry about that! I'm not
familiar with the process around the `maint` branch so I definitely
don't have opinions about how that should work.

Thanks for explaining it!
