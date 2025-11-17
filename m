Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAF31531C8
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 03:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763350701; cv=pass; b=krqdg1isBGFy27+mfuXK+Fv9HlWFZGvL+PXsITZj3wtuq26zM/170v1GWeFyiB8JNsUlWG79CxQ1bxUOWA82cLtwgsX+MZXt6j7+ih098HkPBpKQqvmdvLEm16/lFAtF2HJnG4szw9FEP7jFzY6NFp24gSWXbywpz/CgjUJeuZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763350701; c=relaxed/simple;
	bh=B5NCoBK/zkhgnvd/f9+1yBOZ5DkjctGiRw99b7KXVvE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=D12Q8BHqVCVikxY+vN3hHMCJji6tOeDnl9LFHlt9vU9PjWWX0N7hs4KIjyQwJox+8w/S5N8hQ8S+RSAuva+Eok+V+5lk5f4yt+TMPojTWgPgd1nHMJUcseAqwfng8MSyr9+3dJ90CvqTcEANeWnzfo31Ps8LlEkQT2PAihR7YLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=gkoiJw0c; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="gkoiJw0c"
ARC-Seal: i=1; a=rsa-sha256; t=1763350687; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=bSNS4FFonvFsUAUKYSPOl6C165WbedF0xzVuLW4B/RtlzmkZareBn9d02OGUoGAE5900p9CZe5s6YNcmMrRR6tkQUHHuSF/TUsPPVOnJ7qHbwZlq5UemIs6Ap0JQS3pxq4u3LrYJ7BbL9NUe35elpG6nCIcKWOclgLggdT0BF24=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763350687; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=6xWrP9qXSw1t8n5g9w+rCxaz19kg0HCR6Z++Rt9tdVk=; 
	b=EYVn2EbxURfcYlAWtB+AQXEXwbvKJ5CDqSMppHQ+QNWS4pSpdkdZRpmATuOXFm7nYl8yW12is2+otTkHajKZ0YwyzCH3/2qwEGUuaI2UGLVONjMPUki7W8RmHhN1sLhj/u0jWX8zXtC5qMsT3INxBz2gPmnweFIVBQsyPk/rBuM=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763350687;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=6xWrP9qXSw1t8n5g9w+rCxaz19kg0HCR6Z++Rt9tdVk=;
	b=gkoiJw0cJH+5+v8O7iT9PmM8UAKisJsaugVMYnH9jBrzwc1uEg5kDLxjKxzJaROv
	mxBjLIrPX2mJ++VDbsnEO4cFegwHwcEQRybfmeBWpDsigyAyGH9rVrIrZUt4hO+KFUO
	gvTmhmyOSJTt9WBGABmcgOhZs9g2qQdlBHZ7Iayk=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1763350684519807.9806882607196; Sun, 16 Nov 2025 19:38:04 -0800 (PST)
Date: Mon, 17 Nov 2025 11:38:04 +0800
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>
Cc: "git" <git@vger.kernel.org>, "Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Message-ID: <19a8fe42354.3909481a3912041.7970296104893780556@linux.beauty>
In-Reply-To: <bfa6c82d-f0b9-4248-88be-8a95bc22ebc1@gmail.com>
References: <20251105142944.73061-1-me@linux.beauty> <bfa6c82d-f0b9-4248-88be-8a95bc22ebc1@gmail.com>
Subject: Re: [PATCH v6 0/4] rebase: support --trailer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail

Hi Phillip,

Sorry for my late reply.

 ---- On Wed, 12 Nov 2025 22:50:27 +0800  Phillip Wood <phillip.wood123@gma=
il.com> wrote ---=20
 > Hi Li
 >=20
 > On 05/11/2025 14:29, Li Chen wrote:
 > > From: Li Chen <chenl311@chinatelecom.cn>
 > >=20
 > > This series routes all trailer insertion through an in-process path, r=
emoving
 > > the fork/exec to builtin/interpret-trailers and tempfile juggling. The=
 first
 > > three commits centralize logic to reduce overhead and simplify error h=
andling.
 > > The final commit adds git rebase --trailer, currently supported with t=
he merge
 > > backend only (rejecting apply-only scenarios and validating input earl=
y).
 >=20
 > I've left quite a few comments but overall this is looking much better=
=20
 > now, it needs a bit of cleaning up but I didn't spot any major issues.
 >=20
 > Thanks for working on it
=20
Thanks for your kind reviews! I will address them in the next version.

Regards,

Li=E2=80=8B

