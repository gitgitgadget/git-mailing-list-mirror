Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F52107A6
	for <git@vger.kernel.org>; Mon, 11 Mar 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710152980; cv=none; b=iJ1p7M6MTilcm7Gpbr7bhbuPk+X+p/F2SmxAbDkdZzJwgPoupoA+MB4cHUtyevfDOj7JzTEgJmACSOtxS1A3UClvPW5wBuj1V9+1/ycGTPx1JfgZQtMmwoCgll0r29EdUC42r5K2ATDi0gDBfpMz3t3T8C5L9ViF6CNsdbHScME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710152980; c=relaxed/simple;
	bh=khXFiOrpPrVYrnsH0bXgn52W2wYtuNTCspiF06W/C2g=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=J6UWzp1XvWYYrDkzHQLGQss2jAfvzsJpSfMlyzQsA6Q+rr+39srK1uUA4lHTVWxSyzRiU55mF0tI+HsiZ+cCoWbhfIz/R3YwbtexFitMA95t0lV3i0YXGsbDd9MvZGKLX6/5KZ1E/TSc4MSHU8vyWAFkuSaZEHBtUJUQ/lFQduY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name; spf=pass smtp.mailfrom=khaugsbakk.name; dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b=PkSTjwdy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HelwT41y; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=khaugsbakk.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=khaugsbakk.name header.i=@khaugsbakk.name header.b="PkSTjwdy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HelwT41y"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id E2BC011400D1;
	Mon, 11 Mar 2024 06:29:36 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Mon, 11 Mar 2024 06:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm3;
	 t=1710152976; x=1710239376; bh=K3xRLU8u0ZqaTxMVYUlytQXiIZrURsAE
	cDaaSQw5dxE=; b=PkSTjwdy9EM6T9ZVpj/TxKhcr8l3R5iwftDRJkM5YUooG+Yg
	i7p3zdwNL2yQQkDCIG2gAD5vN9gscisenBve69FV7NLb9AuZNYi+/CybdJu09hXu
	oojFcQAvQvRZPo4UXcXdoT4mjah4lxxaHLzjWbwLrrr54xAQPnmxZRMyvLVprXIT
	bxRj3IiivxQnL345o01n0D9ZpQrQr2t3PVZr+Zjx4MRQi/zwfOUNRFQ5Ot9L5uX7
	/xg3ruLX2CrRBKKRxW1fookUplTpXv6H3MaJTkbROzJZtUpekL7+zb2qImwDBcRc
	fB3yRONtJ8CkUSD4zGSqjnTkH+kEdrRj92/Krw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1710152976; x=
	1710239376; bh=K3xRLU8u0ZqaTxMVYUlytQXiIZrURsAEcDaaSQw5dxE=; b=H
	elwT41yTjgTRmq+0tJIq+oLcsmRGlPhDpMncMUCr7OkRABBgNJFbuXIEe6dy9+hD
	/hbnfSy70a4aSpTpjVqyGkTdSgS/IO+eOgqtBQfqwiZBafXOOCB4MROljcUIcx1N
	SKus5rYL/7tMdNY/crSb8C7RCBDBvxQu925laXvyHBZGkrkH5dM4z/n/2ZwqIRS1
	rgiQTPO4oi1iVp9iNUMU1DggOrhA/5C8wwH0+GQj51/mKcnuS5yRLPJ5CJAK/rSo
	fbzNNRG1PHw11PKFP5C8TyW9Lo9wup/a/2QG6ra3LHEMIzdNd4dIelQIsYu3h6LL
	26h0q9DOyGrioZn2fDLNw==
X-ME-Sender: <xms:EN3uZQC9PUHVy1q5yf19JIqV-p2M_UlBkQnY8BzUaXx3DyQ7KlrPxa8>
    <xme:EN3uZSiVDcNqkWZHWMStr5G8nDfQncRowQ97U6Zd83PkPWIADUZp1HxlSZXri7DFZ
    -haspO8Z3n_TlFaWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedugdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedfmfhr
    ihhsthhofhhfvghrucfjrghughhssggrkhhkfdcuoegtohguvgeskhhhrghughhssggrkh
    hkrdhnrghmvgeqnecuggftrfgrthhtvghrnheptdekudevtdfhleeuveehffehvdevieeu
    ieehheduheevgeeuteetuddutdefleeunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohgu
    vgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:EN3uZTnKCmkOGFZ9FysKSCu8CKiSYzhavzZ74L9JNjm3MziCCeKS9w>
    <xmx:EN3uZWy8toor3yon52DE0jCZopcVdAFUru2w-BEqcQ0Enu3nRdGg3g>
    <xmx:EN3uZVQG69TgKzEi-sl9PIBLkv7rNYpb8G77x-ax7ay43LDhai0SjQ>
    <xmx:EN3uZUFilFuSec_Vx7ySHDTg6SL-GuKC8dXskpNixsHPmrreUo9tCA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 4BFBE15A0092; Mon, 11 Mar 2024 06:29:36 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <15049e66-09b8-4baf-887d-e9118b9cd175@app.fastmail.com>
In-Reply-To: 
 <a2ce6fd24c270fcc89439cd7d119c701dd262ec5.1710100261.git.gitgitgadget@gmail.com>
References: <pull.1682.git.1709396291693.gitgitgadget@gmail.com>
 <pull.1682.v2.git.1710100261.gitgitgadget@gmail.com>
 <a2ce6fd24c270fcc89439cd7d119c701dd262ec5.1710100261.git.gitgitgadget@gmail.com>
Date: Mon, 11 Mar 2024 11:29:11 +0100
From: "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To: "Josh Soref" <gitgitgadget@gmail.com>
Cc: "Elijah Newren" <newren@gmail.com>,
 "Phillip Wood" <phillip.wood@dunelm.org.uk>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
 "ZheNing Hu" <adlternative@gmail.com>,
 "Philippe Blain" <levraiphilippeblain@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] sequencer: allow disabling conflict advice
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Philippe

On Sun, Mar 10, 2024, at 20:51, Philippe Blain via GitGitGadget wrote:
> diff --git a/Documentation/config/advice.txt
> b/Documentation/config/advice.txt
> index c7ea70f2e2e..a1178284b23 100644
> --- a/Documentation/config/advice.txt
> +++ b/Documentation/config/advice.txt
> @@ -56,6 +56,8 @@ advice.*::
>  		Advice on how to set your identity configuration when
>  		your information is guessed from the system username and
>  		domain name.
> +	mergeConflict::
> +		Advice shown when various commands stop because of conflicts.

Given that topic kh/branch-ref-syntax-advice is in `next`, maybe this
should be changed to =E2=80=9CShown when=E2=80=9D?[1]

=F0=9F=94=97 1: https://lore.kernel.org/git/7017ff3fff773412e8c472d8e59a=
132b0e8faae7.1709670287.git.code@khaugsbakk.name/

>  	nestedTag::
>  		Advice shown if a user attempts to recursively tag a tag object.
>  	pushAlreadyExists::
