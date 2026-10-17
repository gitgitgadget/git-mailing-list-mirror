Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038939EF14
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792231321; cv=none; b=A/lCL8LnBSvCd33YxsvDEWtCguZ9YraSAgAk9jtnJKu2SyMe7QGKpZZdS5EXzaDvg/YPVcbINPaMw9PBfFew+/wVaQoKSXahHXLXvcXV0duTasv8WRyHdYUIf6hN1L6JNUOFqggLRN421Xau0FQRI7DRyEyV0MkWZB2eaC0cXd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792231321; c=relaxed/simple;
	bh=VEKHq/h16wQPYH5dNmLscqYVkLiEjzl0MBzfKtwrLRc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LhWlZE8UnIDLXqnyW4lPs9rGQwxE/6l9yQmu1YFzUFs+noelk13CYlhMAnrsMoXF3sE42MhJg/BmA+3PIni/QX12dhCVSKhc6xlrummpzL8nyUEGL/bvpL8lJvWch4Ie94vVWL4IWnw28IptoFBFdMvWNTy50YKvHsaYuRDoYco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b=p1Ln8ZFN; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=oswald.buddenhagen@gmx.de header.b="p1Ln8ZFN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1792231316; x=1792836116;
	i=oswald.buddenhagen@gmx.de;
	bh=XStxCoLBueoCgrVWm+Ecl0DfZcCCJcZV4n4GMkEKBo8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:In-Reply-To:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=p1Ln8ZFNsDPIOiDbekeP4InEhEnn7NSE6rLmyeHEN6juvm1xeLuFwBINVafBYD2E
	 M/6cOmY82dIc/jRAxaaeiVyAKng1qIwXaE1B4QS2UkaGMtALe68FJ8MwDWwD8hjIa
	 Owu5Li2H24AGwX2zhfYcyGISHYjULkf05B5im2A5Z8syWEmKnfgNxVcG4fY06N3Ao
	 m9KfHRXbt6PneZoNf6a6IZ3qHAwOBz7bkkhXNacyyKUf2X+7B9dy3ZP/2QfH2ripa
	 XQhvdMNn3GQ79NGcTYnRqnDYpKKzTkeV8Q58xHW/oxKTLTEHEzUDOEbNxp+BlUCDK
	 W2KJ37zoe6y47gj/6w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M1HZi-1xJfvq2rog-00EORR; Sat, 17
 Oct 2026 12:01:56 +0200
Received: by ugly.fritz.box (MasqMail 1.0.0, from userid 1000)
	id 1xI1Ei-BbJ-00; Sat, 17 Oct 2026 12:01:56 +0200
Date: Sat, 17 Oct 2026 12:01:56 +0200
From: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To: Raj Ojha via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Raj Ojha <rajojha047@gmail.com>
Subject: Re: [PATCH] describe: use Q_() for pluralization of commit and tag
 counts
Message-ID: <atNHlNl9mpDqUKb6@ugly.lan>
References: <pull.2257.git.1792058069306.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <pull.2257.git.1792058069306.gitgitgadget@gmail.com>
X-Provags-ID: V03:K1:vAhhIoz/3fYknlXijFz1BWcuGtT5aW0e3ixGw/hoco6uF7AwKXL
 7a7EEDWHA2pq6nOAd+eIwsvhNUudAjyu60FMmIWToz70qbrg308pMPw68gx7E8efphtU203
 RibIoFwfrPUSKADL7l3Sr7GtI312Cn+ICi4OB6WOmOyKsoEp3O+6tYpKVCLf/9wOFs5O29Q
 thAjA2rL5zRcJwzlIAvbw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ExLBLjw3l8c=;bWhWoJKndzzMsBbAzgS/04QlHTG
 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
 PiCUMheG8e9OQsuXSDGC47X+IA==
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 09:54:29AM +0000, Raj Ojha via GitGitGadget wrote:
>In `describe_commit()`, debug messages print the number of commits
>traversed and the number of candidate tags found using basic `_()`
>localization format strings:
>
>    _("traversed %lu commits\n")
>    _("found %i tags; gave up search at %s\n")
>
i wonder why _debug_ messages are i18n'd in the first place? their=20
target audience would usually be the git developers. or is this just a=20
misnomer?
