Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A3727055F
	for <git@vger.kernel.org>; Mon, 28 Apr 2025 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745832658; cv=none; b=tDTl2djF+zGii1oivmk48pWXHMGOB2W94c3qsLdAw3sQf0+0gXiuO1TuTDj76ie109lLtAKVX0bZRGjiQ1iDbkmyyA7RSH11hGlsW1MSacYfaZOOtnKicnxKTdAgnKBc+6bwcVThSsqeuEjZMIhqqzGb0x0wTty2kO0+KQoEh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745832658; c=relaxed/simple;
	bh=swUr0lLaZJJ4oy5zQD9U5GAZfWtRrp+xfupwR0mZ9MM=;
	h=MIME-Version:Message-ID:From:To:Subject:Content-Type:Date; b=Gab+sYGT493O9/d50Ik8+ioYfyxy9o7AaeD53ysD9P/vi0okfTXOLBwRSz4g8+n9iLjr0tK9uwGYCxYJXl+La0gOJS2nUcKMKl0dK3C59MI+IfYeeTW9XGNGlZjv+u9puzPpsknexxahfOIkLzgCncMpwHmiJHX4YCl4+PqgkPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=anatolij_vasilcenko@gmx.net header.b=aAEswu6C; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=anatolij_vasilcenko@gmx.net header.b="aAEswu6C"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745832654; x=1746437454;
	i=anatolij_vasilcenko@gmx.net;
	bh=swUr0lLaZJJ4oy5zQD9U5GAZfWtRrp+xfupwR0mZ9MM=;
	h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
	 Content-Type:Date:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=aAEswu6Ch4qpanmgqyedb8JXo3y3i1CsC2jyu6mpIn/Sm/cfX3V53EE92exn26Uo
	 HmRfSJovsbdVuaY5q6wHuKecBa8UmuGBMxGC26rfJ3k2ZN9ZgQ80UPS8likKD8iQW
	 aVp7iVGIy2+1s0tOUnuERJbzNaZ9OrKzsvsZZfMGVVuDN8Mnzo4zXYfGCDgdlYQJ0
	 gW8Vh0MxSPGrfqwuve2GndSAdnYTNZKF0ineKnJhq21HhibV4EEKCBklr95Pxj6Gx
	 uHFaOu+xnh5f+c1bYDhZVFtZiYvL+/BI29p6pjLpNpNa/3Bo7cYzpX5WgJKOlGrYt
	 grh3h9ingtrpdked0A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [31.47.82.162] ([31.47.82.162]) by
 trinity-msg-rest-gmx-gmx-live-67758444c9-5pbm9 (via HTTP); Mon, 28 Apr 2025
 09:30:54 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <trinity-632843c8-90da-49ad-b5d1-cbf16f2d77ed-1745832654527@trinity-msg-rest-gmx-gmx-live-67758444c9-5pbm9>
From: Anatolij Vasilcenko <anatolij_vasilcenko@gmx.net>
To: git@vger.kernel.org
Subject: Feature Suggestion for Branch Switching/Creation in Git
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Apr 2025 09:30:54 +0000
Content-Transfer-Encoding: quoted-printable
X-UI-CLIENT-META-MAIL-DROP: W10=
X-Provags-ID: V03:K1:wyfeQ7sV9pmFdnIo8zJ7hfgcaAUUlSEyP56S5qlkVqwHG+95LVNcFvdnzZTIuFNQCZ5MZ
 3C1UoNmsWI1CR2PAYN4xAo3/ZH+fyY3gDukeguuFnss1P4iVJ22wcRem+Q1DyYHBPZbOvif9Yqtd
 H1Vb/Sa5yXLETo4ad3LUvMyCFie1O6rts9EE5PF1LWsaaw/Rejr9tM8k9CLrU/8LLrpiGPkoFqak
 kIJ6fld2zix5TqiJtR62JZS9zUXTckNmE0qaCeQlWghpWkLgNUdLSiXznksp+Kbkxl90wTOjRw13
 aB9aIxUGM1N3S2i50y52B1U77J11/ZZxduU+Fm2SqAgL/XZmc/pk8zAlJYio7AsZgCHvC9MKX395
 S1tve2geN3Y
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:R6hGpVwQeAs=;e6BIRDc4m/RqyqgpXDAbHpRXGR4
 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

Dear Git Development Team,

I hope this email finds you well=2E My name is Anatolij Vasilcenko, and I =
wanted to share a small suggestion for improving the Git experience based o=
n a recent scenario I encountered=2E

While working with a branch that had an upstream counterpart, I mistakenly=
 created a local branch using git branch <branch-name> (instead of 'git che=
ckout=2E=2E'), unaware that a remote branch with the same name already exis=
ted=2E This resulted in a local branch that wasn=E2=80=99t linked to the re=
mote one, causing confusion and unexpected behavior=2E

It seems that Git currently doesn=E2=80=99t notify users in such cases, wh=
ich can lead to accidental missteps=2E A simple warning could make things c=
learer, such as: "A branch with this name already exists on the remote=2E W=
ould you like to connect this branch to the remote counterpart?"

Adding this kind of confirmation step would be helpful in avoiding such si=
tuations, particularly in collaborative environments=2E I believe this smal=
l change could enhance usability for many users=2E

Thank you for considering this suggestion, and for all the work your team =
puts into making Git the exceptional tool it is=2E Please feel free to reac=
h out if further details would be helpful=2E

Kind regards,

Anatolij Vasilcenko
