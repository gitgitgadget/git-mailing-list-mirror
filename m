Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588C23FF89E
	for <git@vger.kernel.org>; Wed, 29 Apr 2026 18:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777487378; cv=none; b=pjTXk+NslB2kO/RWzmN88IhTNMqZnw68RcZv8XVd8pNSgVOPCIEvcyYRtGseNp7lwal4P1t8Am2dRiP8diKIJypR3NFVZ9jZXgER/kiYwDEb2z5nwDviTwfMKwMS+1yg7Q/55YJt3O/xJtp1ZZqoKNHhy/p7almqNS4HhUFs2FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777487378; c=relaxed/simple;
	bh=8X3Cb9PsgZQOgthBV5vMDHHkLWg3P4fNsUxDkXCyBeo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=jFdlplsIaemKbO4m2HgQFEGcKZ6UPocd89b6sz/BDpW8k0Pe9qmUuis66pKkESRsoTdRMpqmy7KoNi+8PP0JptsF7lAGwlc4ti0c1GN23+jHbINykbeH3GJER3u412y5N2qX7Ylrgnpw6kebeXbzNetzWbG48fM1ZYPeX4/i+2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=GW4hyb+6; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="GW4hyb+6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1777487362;
	bh=xVAyUMvxIwTWm+nxhcZBo/gkymNPPW74x3E7cDku00Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GW4hyb+6u3MIjg/LdIzmuCty/qCUu1XLPR260YBIeUCCrgO3unUUlv5FQLmcrL+k3
	 2GywkGdHUOYMyE4dK8Y41bZbFPgapFiKHqgMnA0zi596bLi5OOA5DPZ33tIznipUrC
	 aX4XHKls4uJkFBzJi0f3NUnbFMS2hSBBuauDP39c=
Received: from DESKTOP-31CF0TC ([117.188.249.188])
	by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
	id 7503A4C1; Thu, 30 Apr 2026 02:29:16 +0800
X-QQ-mid: xmsmtpt1777487356tfh1csz1r
Message-ID: <tencent_38DC315B635248A3A19F1A426A95A3E19208@qq.com>
X-QQ-XMAILINFO: N/WmRbclY25GCgRw1RSMQzjIX7tNUCJiJ/17imnzWPUhEc3POGoHHntqvvjd6v
	 pewckJkxSOfjxmAepZq7nDrAMqzp4b0E3Eb9Ui+N4MY1VSzL7ZZAKMdd02XGDl2bGGl69AIwJgMh
	 T06cwYmM8ezeAy/SlFJNv+g0Cw0EwYuV1y0H3qrf/+AjVp+iKyjzsjR+NqZN/SVTKmRSGp+R4qPo
	 CV2GqodYrsRZ0uWtSiv5nm6khXRCF8RACT4zSN4Ko8wzkaG4bu3Kc13JxE6ncjaHfbEZcGqmPbAs
	 7+44mXtxof1GMAJynaGjmOXyXNvo//iCmy4Bnj2xXY+Iq+VtnxgqvkJfpZOvAEAmO6A6tO4c1rwn
	 dOmjc/2P/f/H3kqBeanih2SKqgEkOkbGvG90SsPoYs8uNmvfIMsJSFBoK/4VzrUxSHgv/51OfjaM
	 CD5HrOuHRTOGYnSsL9gQAyVbVpSA1Rz7M9LzOgd4GY3D/ZxYdb9aYCeYV64Z7cj5vk489OsJT3Iu
	 TD96ftKSaknrkN33R7QGSVHmi/Ki8t62bpWOyWlovWMqXZOGzxwyrcpZxm9bXKLwg71beBsLLDyD
	 wQunUM4Gn/3v8L1eosNZ3KdWo5/nV8jPp3yZOkeWX8/e+0mHc8j6WeEKaTGt3qCKk6JsSI6KUKYK
	 XMvPMQYbgpxzhPur0lznyhgqJfoWz68HWHEbf2OzTBb3R9x5cYXWljvs3lnfT2UprNmRFYM36ub1
	 HxbVq57wgAftBfD8dt4459unfKDARURZ4vUzUezMHLgl7Iwsf6wrvQ4ozY0Wo4vxHZN5QF2TdTQt
	 Tztjn0xVA2c2FNfx0yFyuN7PoEx3j3qJpwv3SmRDKINIGIJD7VxCXr7ti/b9IazooASGiHbiBLG7
	 yWXzlpg86skjuwYYLsOm90HPl7+10t1jVZWN0A5FzzyRzsXI+pV0zeZhqTbkn0YuPVLkoeks2WiY
	 iqxZY+OVptZGm7mO59TEC5YdctGPbmdzLIClZfyA+uWN0lGWvowMXj3tLRKoNQlb4A85xrZzryB/
	 sPjPd7IhHU0sTN1H/2b8jAuPQYrrZkuaC5ihtDP5Kq7P7zzi2VXELUV1zfd7Ov+fNOcJF3Uv29TR
	 3etR8t
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Shroom Moo <egg_mushroomcow@foxmail.com>
To: git@vger.kernel.org
Cc: Shroom Moo <egg_mushroomcow@foxmail.com>,
	Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] git-gui: handle bare repo or missing worktree
Date: Thu, 30 Apr 2026 02:28:22 +0800
X-OQ-MSGID: <20260429182827.407-1-egg_mushroomcow@foxmail.com>
X-Mailer: git-send-email 2.52.0.windows.1
In-Reply-To: <308229f2-0d20-4f3b-8e6a-c962bd9c3a6e@kdbg.org>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Hannes, =0D
=0D
Thanks for taking a close look at the patch.  You're right that the =0D
minimal crashfix is just protecting the `rev-parse --show-toplevel` =0D
call.  The existing error paths after that line already handle bare =0D
repos and missing worktrees, showing an error dialog before exiting. =0D
That alone would prevent the fatal Tcl error =E2=80=93the original crash is=
 =0D
fixed. =0D
=0D
The extra logic is not about incomplete error diagnosis (the other =0D
checks cover that).  It's about improving the user experience in the =0D
specific case that prompted this report: a colleague double-clicked =0D
git-gui.exe inside the Git installation directory, where a third-party =0D
program had accidentally left a HEAD file.  That caused git to treat =0D
the directory as a bare repository, even though it has no . git folder. =0D
In that context, showing a "Cannot use bare repository" and quitting =0D
was confusing =E2=80=93 the user simply started the program without choosin=
g =0D
that path. =0D
=0D
So the additional detection and the `choose_repository::pick` call are =0D
a UX improvement, not a correctness requirement.  When the program =0D
detects that the current directory is an unusable repository, falling =0D
back to the repository-selection dialog (as we do when no repository =0D
is found) is better than failing with an error.  The user can pick a =0D
valid repository and continue without restarting the GUI. =0D
=0D
Since a minimal patch is preferred, I have prepared v2 which only =0D
protects `--show-toplevel`.  The dialog fallback could be revisited as =0D
a separate enhancement if desired. I've already sent the v2 patch to =0D
the list.=0D
=0D
-- Shroom=

