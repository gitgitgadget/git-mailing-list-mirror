Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171B235050
	for <git@vger.kernel.org>; Sat, 27 Sep 2025 21:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759008423; cv=none; b=mlm126Mu4BGuUDpZw9aUI1yl6Gke69FcJvKD5zT/udbQZZkh30PaXg7stduDkRFJYyA+4V5ZrL7zdaa3uAgZAB11tGgtB084zjpIJjHJI8xFWROG8T5uyfiJOiS+r3nV98gV6TC9ILSdM8uC/dOR3fz8KHhBJQJ4IZVoaN/Lxks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759008423; c=relaxed/simple;
	bh=CWKIIN3xSyT58EKO/2NiNJE/7i1aYE5hPT4/2B1dJdM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ypf3Bmvaw0AfciIFeYl+CYhVOKWFW4PpGB5tXDOPYaycjQG/Fccsb0JY4b1NAF5wlJPM4vvmY05Nc/PJi9KtoJzko4KrvsQvdzqOM7Bpj8Httrzn/Ux+gmorDG/Lk+J/x+QhIryJkBws9YgUWqCI2GUT8V2dKKFP2VoNPeYplYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BxQZFTXg; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BxQZFTXg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=udsk55p2yvgabdzmgszrmjquoy.protonmail; t=1759008419; x=1759267619;
	bh=CWKIIN3xSyT58EKO/2NiNJE/7i1aYE5hPT4/2B1dJdM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BxQZFTXgz21hKgPbNTw6PCec90HiU04dXCf7FlFHMd1xiJXPqEeNWXRcFIypE8l/c
	 hRKC1H4oP3xJPzWlQ0LjWVjHX+a732/1QGHbOzciXyKGqPm8ECftwbonKfH5nWB5er
	 oW71xIGMTa0r5GK58ohi3egcMsNspY+gcTl6BNw0DScdo2HcTZiM6fAYAvH5jE1PlE
	 Qkzz0ONddUkSte3o5svj1VVRJ+w8dYSM4ofJ+tUGftTZMZ9bHPDutbTBienHDqJGGt
	 mbA5KYadmxN99GYYY34Z3pHRS2tDbnNGz/9hry5q7lUQ4tjNWSkI0TGfjjU+Fzjk3l
	 tPk/gpNvH0uiw==
Date: Sat, 27 Sep 2025 21:26:54 +0000
To: =?utf-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
From: Jason Cho <jason11choca@proton.me>
Cc: Junio C Hamano <gitster@pobox.com>, "Jakub T. Jankiewicz" <jcubic@jcubic.pl>, git@vger.kernel.org
Subject: Re: What is the reason behind not hiding git worktrees from git?
Message-ID: <GY1ni5SFkgBgVIHm9HoO9dtLuLWbUPCv5mjcsy5VGi09PyRLV_gv3MMw2zsinKpi5Aon9J-LESzTUuwMOUNLRRLqyXM7ON-98WTzhH7RIYY=@proton.me>
In-Reply-To: <KUIfhZpMUwujq7A0Qdiri2OEhWabUXUVVpHZb7o0A-iqAC_46qQd5acUqN9TlkFMGe2t-aY4IXFQCjs6gKsawBCGSazI3QDPigdI7KrRf_A=@proton.me>
References: <20250927152824.3132af88@jcubic> <xmqq4isn96s7.fsf@gitster.g> <aNglDzeOT5_4ZbdV@kitsune.suse.cz> <KUIfhZpMUwujq7A0Qdiri2OEhWabUXUVVpHZb7o0A-iqAC_46qQd5acUqN9TlkFMGe2t-aY4IXFQCjs6gKsawBCGSazI3QDPigdI7KrRf_A=@proton.me>
Feedback-ID: 126703824:user:proton
X-Pm-Message-ID: 7d1698467da1608e6bbb7d6135659a8298cdfedb
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I think the best practice is to not add a work tre within the master work t=
ree.

Suppose a repo is at the master branch, and you export a work tree in the d=
irectory f.

Then, you check out the main repo to another branch which so happens to hav=
e a file named f. In this case, the check-out will fail due to the name col=
lision.


