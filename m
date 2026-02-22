Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3081A1400C
	for <git@vger.kernel.org>; Sun, 22 Feb 2026 02:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771728250; cv=none; b=qMhuVC+z7U1rs5dtmkV2OPxI72RHorH8QsZQNtUkXCSypMr6eCRkTO7wNfGjjVmca6TV9A+wmG+ACIgQ48BkqBps9xUr6vzzhBygkqT5D4o2vuBhbsWaXMRsqvhrMmDrAZl4vSV7SHTD0l3QSxgfgYHgh4rDlYpTNXdugh69iik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771728250; c=relaxed/simple;
	bh=OCEKIj+GOndxk5TUFf8fj4dgTjDuqc/ygmqZwJnzQ3I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4oLoyyFi+4WPMrKGMt7t9MTRboDR4mDcsZVh3bpArRdFAP4sHvgn56Ks+44JWPsovngcpJKgHbzn+x64RJaCeByGb2Jssa9GQH2jHYj4LNFNpsV7Iwu6MSEYaUlaVeDALeOI3dtbz2Y/1IWmXwKF10z3xJhwwQIynYBNx1/69c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=gfKKunS8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PBkjCUoE; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="gfKKunS8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PBkjCUoE"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 4CFFB1D000B9;
	Sat, 21 Feb 2026 21:44:08 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Sat, 21 Feb 2026 21:44:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771728248; x=1771814648; bh=ByyqxP1HAd
	0ZK2Gkt0yrnL7zPt3C8bFuYHFqqw91hfs=; b=gfKKunS8Min/2OYoiZFCO8yBRb
	HqsyH5W3ZSRs3/UOhP0gmWf8HsbGQg/m/mPaC7HiQM7Wg4szBbYRMQbjiwcejjWc
	PA4/rqfNm4XNq+BZw6ZZv/Ay6kMnqgeWo3rS5qvoU5sjJvqbrDuELM0BaqayUqHY
	Z0rGllH8y6EKtjWJSN5+IvobxmBrlWoM5mWQ08Os1ToKPcFHMh9EQDXl+zazTUVD
	d6r2dleaWf5V4QckpNbzxtcvvT9sXGfkyUlRH01OlLXPIGdfdtxqjNPmrhWuY7vn
	BcQPqR8wmoK+vfLtH/TzkOfDba9dfDorZ8pfGKkR+rb9YeZUBmlayuo6lqTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771728248; x=1771814648; bh=ByyqxP1HAd0ZK2Gkt0yrnL7zPt3C8bFuYHF
	qqw91hfs=; b=PBkjCUoEpbzrQEHhdsvNhp2sIlSrhOv07Xr52Db7LnVxoq33brp
	wDt9I6ePAJITVdw7ft5Xy9pw9epIaRKdjjE6cKqTSLk/xluzATSp6BVGmqu41wD9
	MoKDqCxNH7ZbdTJNk4X6uQtGVzDiD7Pk+CyfZR60/hzCBFBJmONZAumLYrmDF5b1
	kX260BL8O5kdReEFHGHTiQ9C5IyvtaVjfDtKxd3o7CztRRHXWWFFl2i80XXx1ePS
	HkjSkgaWxCAo6tP63TNlaB7iWOatYiylJ7exqwazKLFjbfCsZ4HwuBM6GlIMwSke
	GCPgdk05EGmnYawYLKkH4bvyVqkUizb36XQ==
X-ME-Sender: <xms:eG2aaVwDiuwm-5U8_l566FfBrvbmr5hL5ddLfvnxU8EuaiFRZUONuw>
    <xme:eG2aacL8xLEQjtsI64jBm2_SlZ1EMekCC6uoznhQp8P4DfXrm5K0Ia_3Y_luODY0A
    KaWSxZuIEln2qW7woiFYEkeY1TtYExu8dZZEstenKuOs1FQwZ-1>
X-ME-Received: <xmr:eG2aaXp94I3IS3KMAne8ty1gR6FotfL2zVGOf5T9y2Lx88hXyp-KN4F50J-XdyI8VscZ17gws9ZG-nW7WaswHQUudyEDYq7sSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeefudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrmhhishhh
    hhhhrggrrggrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtgho
    rdgtohhmpdhrtghpthhtoheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:eG2aaTIzahcm4RjH9I6nqLDPLhnPHiUb1auwCCp83rzEyFwtpaXUgg>
    <xmx:eG2aaUR1ZCU3-LXeDNESM04b5F0wvn9Aq2cqhkfSK27OGpKTuUfuGg>
    <xmx:eG2aaatfzUOZIMVA3MmxThpmP3GyZjJuwtNLg4f6ZWybq9Nr7ywcSA>
    <xmx:eG2aadalQjQtZlCVeTmBd8R1EpxbWPvVAWny42iaJPM2sgFr44IqEg>
    <xmx:eG2aabavRwLUw90NaOLIzkK44-F5m0rmb0W3weeMBC3hFQJ-25GlGJU->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Feb 2026 21:44:07 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Amisha Chhajed <amishhhaaaa@gmail.com>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  avarab@gmail.com
Subject: Re: [PATCH v3 1/2] sparse-checkout: use string_list_sort_u
In-Reply-To: <20260221162359.43336-1-amishhhaaaa@gmail.com> (Amisha Chhajed's
	message of "Sat, 21 Feb 2026 21:53:58 +0530")
References: <20260212041017.91370-1-amishhhaaaa@gmail.com>
	<20260221162359.43336-1-amishhhaaaa@gmail.com>
Date: Sat, 21 Feb 2026 18:44:06 -0800
Message-ID: <xmqq8qclsdjd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Amisha Chhajed <amishhhaaaa@gmail.com> writes:

> From: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
>
> sparse_checkout_list() uses string_list_sort and
> string_list_remove_duplicates instead of string_list_sort_u.
>
> use string_list_sort_u at that place.
>
> Signed-off-by: Amisha Chhajed <136238836+amishhaa@users.noreply.github.com>
> ---
>  builtin/sparse-checkout.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

An exact copy of this patch is already in 'next' since Feb 17th, if
I am not mistaken.

> diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
> index cccf630331..34e965bfa6 100644
> --- a/builtin/sparse-checkout.c
> +++ b/builtin/sparse-checkout.c
> @@ -94,8 +94,7 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix,
>  			string_list_append(&sl, pe->pattern + 1);
>  		}
>  
> -		string_list_sort(&sl);
> -		string_list_remove_duplicates(&sl, 0);
> +		string_list_sort_u(&sl, 0);
>  
>  		for (i = 0; i < sl.nr; i++) {
>  			quote_c_style(sl.items[i].string, NULL, stdout, 0);
