Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BE15F85A
	for <git@vger.kernel.org>; Sat,  3 Feb 2024 17:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706980754; cv=none; b=N++xuhIk6MjEtYzXFSSTkJFuwA16ZIaRouTQp9b341o80t0CfAnMP5nCAlWHJjhnSdUMxr45h2hgpu2jh5wYpd/OmSL3Osj04u8omxA+X90iKYQaVe1nreV++js8UU4NENyzIfWWMCg+2rLL2DVBfW+zwGE24OfrDrZJ71sTIjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706980754; c=relaxed/simple;
	bh=NwdBqZ2/WVDdoh07hZCP5VtOHvyn/X2ZNJVZqbfyTSQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hHxSWDN2i1aRiHiOxR7Z5Z6STfXJk2h4+w/d3+3CzG9M3Bx2aFlF7RlQosCoi+CVHRGP4pn5mk98LtsVzSCr8p/Qhw98UpAkCOgtvayuwsKtWNxh0hE2CyX1yH5NJurpaYtoMjsjPcnhT/H8rQDwLzhMR2Ow1EiAVSN+hAw6iW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=TnPE7qHs; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TnPE7qHs"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 13C9825056;
	Sat,  3 Feb 2024 12:19:06 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NwdBqZ2/WVDd
	oh07hZCP5VtOHvyn/X2ZNJVZqbfyTSQ=; b=TnPE7qHscHBIwKRU5nEargwNnekB
	pOU9c67ONorLLIRKBxMs4bC7YPGtSykwQGp9rafjtnCt+D5brjvodi6CWHDmCpRZ
	aKqcOUdQd4Ex0035H3QcA38wrxlBKOXNg/jKEZrtJOkDw8OJH1qR6w2avy8kNepF
	WOyfNWwKHbYyRTY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0BA7325055;
	Sat,  3 Feb 2024 12:19:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0A59F25053;
	Sat,  3 Feb 2024 12:19:00 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?=C3=93scar_Dom=C3=ADnguez?= Celada
 <dominguez.celada@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] GitHub Actions: update to checkout@v4
In-Reply-To: <CADCFv=4Gjh5B6RFF3P--FO9T7R+uGg2dyN8hT4VR0yJtJt-UsA@mail.gmail.com>
	(=?utf-8?Q?=22=C3=93scar_Dom=C3=ADnguez?= Celada"'s message of "Sat, 3 Feb
 2024 12:39:00
	+0100")
References: <20240202203935.1240458-1-gitster@pobox.com>
	<20240202203935.1240458-2-gitster@pobox.com>
	<CADCFv=5=uwp_NVpndTYFiRRK4hEwmMdA2At80cXuS91V5mKN2A@mail.gmail.com>
	<CADCFv=4Gjh5B6RFF3P--FO9T7R+uGg2dyN8hT4VR0yJtJt-UsA@mail.gmail.com>
Date: Sat, 03 Feb 2024 09:18:59 -0800
Message-ID: <xmqqh6ipsby4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5298DCCC-C2B8-11EE-97CB-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

=C3=93scar Dom=C3=ADnguez Celada <dominguez.celada@gmail.com> writes:

> I am adding non-html e-mail reply to keep track in git@vger.kernel.org:
>
> The switch to checkout@v4 for GitHub Actions looks good to me. I
> wonder if we should be updating other actions to v4 so they start
> using Node 20:

No need to wonder.  I only noticed the ones involved in the main CI
job that triggered the warnings, and dealt only with the "easy" ones
;-)  The primary reason why I CC'ed you was because I hoped you knew
better about the "container jobs are pinned at checkout@v1", which I
left as-is.

Help in updating other actions to newer versions, if needed, is greatly
appreciated.
