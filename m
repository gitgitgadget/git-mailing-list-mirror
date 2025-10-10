Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630C1748F
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 13:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760104185; cv=none; b=m17qNr5RLdL817+Xy73Sa47VBAiA+DgyI9Z7xTkjjWxyU5M4vy/VVSk92wZHW/qIFBBaGKx7kOtFg+5ZZFY7EY2RK+FaZAasQ/fEKh+ByQUGDh7WN5WLsOSINKCWE+cumMtwZ39DkpXbX5w8kaxKVfCiZ3ICb+lGRn9xLMgPS0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760104185; c=relaxed/simple;
	bh=ndKQl4Lh0jGTUZTqR9FpNvT/h6ONWJbohDSB/KxsK9A=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gnxrXKBQe/9x6knS91poNM9e5vNluEO0D7RBBopuFs9l/8o/7h46KDRyXyqytCe7z83qlkr2hgsA2Y+4qE7JAAZ2aP2XA1Rn5AOWxDtgCN9I3mLx7gL/ajPP8GIo0MmPh8qitcUCrs/yYFej7HccaeBSEJJF/jyR+qq82kh1kOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=awNnaakC; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="awNnaakC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1760104179; x=1760708979;
	i=johannes.schindelin@gmx.de;
	bh=sRFWtkYE/IeEqkMtunOsn5p4+c8mQ7+8fRDyqpLw5D4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=awNnaakCANGUqtq3N9ehBUjfqAqyaN+57AoMKLvQL6r5ukY/ZtEPzyNWvSjinVwm
	 wbI3WFFTBaUMQSAeIdLGCS3TKovgfzNkV8LaYl9V1eUU1ojIk7Scyh/RH5QLJngJ+
	 WFmAj/4YwyZNy6Tng91Njryqf8m05ULtpn9uMWXcjEK9JvG8yNuoICR3KC5Ed7PwR
	 Jxay0Zh+R8fzywTQCa6ojbdkZbwf6etDyCbSj6Z3FMAefiEEzJ/qp+2O6ZWtNJFhd
	 HRsDXc2fF3W1Dl4JbgI+039sbj4tGnI9r4gihgabitGD2/m8g3qpw4xN95JF/63kr
	 cG/mY1PeBsZ9MPiIGg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.213.255]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72oB-1vAnKn3IWl-007Etk; Fri, 10
 Oct 2025 15:49:38 +0200
Date: Fri, 10 Oct 2025 15:49:37 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org
Subject: Re: [PATCH] refs: forbid clang to complain about unreachable code
In-Reply-To: <aOia55_sjFQjw1UQ@pks.im>
Message-ID: <2346bcc7-b60e-0ad6-14fe-c0b49e427921@gmx.de>
References: <pull.1984.git.1759995982220.gitgitgadget@gmail.com> <aOia55_sjFQjw1UQ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:7yjqULPzm9W+StqzEaO8w8ChdqXj8V+AZiaKTlJoiOGkhGNW1J9
 DkKPRqAlycT210RVj61HmCqmgTFJLZ22WYTl3LPsDPf9AXj2M/OWJi+DMEgto5cPwko7b8o
 u78veFdQLaTRjbecPMiPg2mBcrE4ySMu2y/8Wk+Cax6zj35cQmGtFTsUE3tOzRTs2pxkiBp
 5muJGl4EF4mYXmRnwkGcA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rUHPrXUO1eM=;ILDpGt72g2/ywvQirTUrA8MEw9/
 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
 7kRAA==
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Fri, 10 Oct 2025, Patrick Steinhardt wrote:

> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index bb2bec3807..cb402a2a54 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2115,7 +2115,7 @@ static int commit_ref_update(struct files_ref_stor=
e *refs,
>  }
> =20
>  #ifdef NO_SYMLINK_HEAD
> -#define create_ref_symlink(a, b) (-1)
> +#define create_ref_symlink(a, b) NOT_CONSTANT(-1)
>  #else
>  static int create_ref_symlink(struct ref_lock *lock, const char *target=
)
>  {

While this is correct, and "closer to the root", in my experience it is
better to have work-arounds closer to where the symptom appears. In this
case, it would be directly in the condition of the `if ()` construct.
Therefore, I would prefer to keep the proposed patch as-is.

Ciao,
Johannes
