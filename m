Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA9764A8F
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 19:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732303643; cv=none; b=c0Fl9tRaAvRFDcrHKrCyTgxw47V81ixxppzCvE+G5TDNn98/YO6eOp+H97ufaE/Xfpa9pcsvqcJlUkwBWdnMfSON34GC0Tc4Q/Ku8MeioHuiFx8UCHOSPfiXMgoCpGWaJvSJZ6YikxigOAHD7JHOJW4x8ZIYMiltIUlJnsXcFOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732303643; c=relaxed/simple;
	bh=bLtzYiL7AcZYxv6wx2IyGcvHQQot8cB8UKhhUv4YMII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tp+TrLmREmk+524IGOhdhykxltrMacGUFoi/RULkZC5C9d2h35SUVSNi4BT2SaaIDeZ7NsuVTU/FUx4Icg7mFQkI9cJWu9TpKH0cK1EUdeMCciId0lP4CUFR/zu/UeKjPVNzz6Pwtz0c+AUYJijgGMiStWtUg0twKjUerJa1+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=bu4Je5iA; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="bu4Je5iA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732303640; x=1732562840;
	bh=bLtzYiL7AcZYxv6wx2IyGcvHQQot8cB8UKhhUv4YMII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=bu4Je5iA6RaeblKD7aRFI+QiAG49HcWT+S0Ai9pyg4u6qKkfsFPb9wZDlYhQ4xvka
	 U+U9Em03syotmyWh9j0BYO0aBudZhz1fsd48+pwDfRFhLn9OCMrIdy8Dy5SX5FtnuQ
	 +3xdVW7XLoy1gQEspHn3fLLDZEgYJfyEP9BoybYuyk8wyOhvXNskHdjpoSoaAZ9fjP
	 U9fYn3byPl0DacVvYXDt+2IoTJDzxsdBEiaTXHLYBrBliq4MFNlcT4umRqS61gcCoM
	 sS8+Rf+fIDty6QjVUiuN1gWvse0YCUNVRfdmvaSDgZwNeW5BT17S+lYXoJi2RVKI3Q
	 eceAtcqdtqU3w==
Date: Fri, 22 Nov 2024 19:27:17 +0000
To: phillip.wood@dunelm.org.uk
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 2/8] worktree: add `relativeWorktrees` extension
Message-ID: <3El2QMJvXAu8Y_znK4CRouDl7FPQLWczoqz3Fkwl8D44cLGctSw86pXw6B-uVKqf0-G99SMjSbHAYY0dTJVKs9VJLvDYlpC_kIaTqdRw2xU=@pm.me>
In-Reply-To: <e207382e-3e6d-477a-9a1d-48949df06160@gmail.com>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241031-wt_relative_options-v4-2-07a3dc0f02a3@pm.me> <47f2b6bf-1e10-4b01-8365-467cc5ca7779@gmail.com> <D5QQZ2X595GX.2FRO57TTXZ548@pm.me> <e207382e-3e6d-477a-9a1d-48949df06160@gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: a28a3780c23e6fbd839a93ece3ad466a5ba0906e
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Friday, November 22nd, 2024 at 10:44, Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> On 20/11/2024 05:13, Caleb White wrote:
> > The extension would remain set. I was going to try and unset the
> > extension, but it is only safe to do that if all worktrees use absolute
> > (meaning they would all need to be checked) and I decided it wasn't tha=
t
> > important.
>=20
> Yes, I don't think we need to do that just now
>=20
> I suppose the check could be added in the `repair_worktrees()`
>=20
> > function during `git worktree repair` if it is deemed important.
>=20
>=20
> That could be a nice addition in the future

I'm glad you think so too :), and I'll keep it in mind for the future.

Best,

Caleb
