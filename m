Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0781BC41
	for <git@vger.kernel.org>; Sat, 12 Jul 2025 08:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752307312; cv=none; b=fNEbpLAUnY7/zBXk+jl+TdI75U5pUe+EGrD4zGzOm40J99cTSYwJEHBZhsypLQNfUkBAjHHN4ZQhQxqJHPiIpz51mkbnWOZdtKAFM8yLTYrpdasqEJZF59WXAYzLNAkAoxy9pvVkOVdRkVk9Msnlk9RwNAosio/LdMZ2XsypN1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752307312; c=relaxed/simple;
	bh=CMu6l3NMW6rif3QlRU5KGlpi6P/AyIfyOv1I1s4ddKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UhUZVQ2BhJHXTrMOwmxkZ114xYxPi5L+9iCEz/dkmkViGjAqoM5sJ6bZOhYRaanLJ/99TiBRbU/3FQ6aey2S++wdkS5EoKl3L3VCRJgfN4HX0jaczhTAgh4ueedXqq6yFHqzb/0QJs5OLD7cDFmdlIXarGkIdDKT8oFzMkTlrnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=pmrQNAAS; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="pmrQNAAS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1752307306; x=1752912106;
	i=oswald.buddenhagen@gmx.de;
	bh=uYm1IJfeZ48kCGHw05JLPan1QMtlR4lWObgApf2TX+o=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=pmrQNAASJAOFW5QD2k+mAB0b01lM6qCEQWr0ZuL7Jb8peK5s0wN08QkJqsNK5oxM
	 X3/E+JGqqIxJq7jVZ+Xhf/mNk5rsXOtq6xErfbupH2uBVBS9s5IX09zCxvPqKENK6
	 G8DnvSi4mut6hvvlXaXmkMVnPrRAEjJJ/kPRPl0BfB+9+8ANC/7b3ATTX/dGHKvUT
	 AXNaZMjaQsBxLPGaN16ssHiWmLww4meZaGMaFcpuoE2FUSt/nX3UzS4wrV6ZnZSiq
	 u1sNqKTLgMdj2/P7jN3d5iSMdQc7w01JmjVMaVXhzbGJ0+I4fFUBiQBrin4HRGRh7
	 inaGwNoIRnRZGvxtew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from ugly.fritz.box ([89.247.162.110]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1ujXfV2i5A-00thmj; Sat, 12
 Jul 2025 10:01:45 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1uaVB3-uY7-00; Sat, 12 Jul 2025 10:01:45 +0200
Date: Sat, 12 Jul 2025 10:01:45 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Ayush Chandekar <ayu.chandekar@gmail.com>,
	Taylor Blau <me@ttaylorr.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH 0/2] breaking-changes: deprecate support for
 core.commentChar=auto
Message-ID: <aHIWaQUC_wQbMw-V@ugly>
References: <cover.1751983009.git.phillip.wood@dunelm.org.uk>
 <xmqqjz4iv7mt.fsf@gitster.g>
 <f679151a-c843-44d4-9e28-27112d26f30c@gmail.com>
 <xmqqfrf5nxnq.fsf@gitster.g>
 <b811a0dc-fb49-4f66-a9ae-89a45d7ff104@gmail.com>
 <xmqqsej21wsq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <xmqqsej21wsq.fsf@gitster.g>
X-Provags-ID: V03:K1:WlXsIJDh9xdd/krVyZpMluzMvJ3Ezr+Z9RaYuXjZHW1rUs867z8
 CrQnus7VinqGmHdit9T//wRvP8AobAjyunABfKuKhWEZVU32AdZ01NlzSMTPPayFdXXAmdT
 ysZpMPe3m4Jeq/KxVDBc19NljzRI6ATYObjfVn6K9z41BeY3huQSyN2vF7axHVA8fg+5jXM
 p3i1Wl2PiWEIeZcsdtMcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kHL6DlbQO84=;BW48oWfUHSkC8L/YiT10n7Lojyd
 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
 u6svtj00c64kMNIqHfqFf+hmr6/UkghYOzR
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 11, 2025 at 10:07:01AM -0700, Junio C Hamano wrote:
>Isn't it last-one-wins?  How about just telling them to do without
>any "git config unset" [...]
>
i wouldn't bother suggesting specific fixes, and just suggest using `git=
=20
config list --show-scope` to figure out where the config comes from. =20
waaaay simpler, and avoids the pesky policy questions.

i'm also in favor of just refusing to operate when the 'auto' setting is=
=20
encountered, as that also is the simplest and fail-safe approach.
