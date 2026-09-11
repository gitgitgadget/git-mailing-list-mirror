Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DBFE486404
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162432; cv=none; b=R/7XCb57VTJoN9Tw0RnAHowvsPFKsyztpfbLtWaPmt7oeFpNICe0wOf/vmO8uagXYmq711k88czTk1gUYwVE+XYmc7s5fPfVM8/i9N8AraeN2OUb24Z6ZCKoBGaOKKttNGneDRCKXVlRhXeCz/A/8Kqg4qK6p1DFH1NRc1XnfPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162432; c=relaxed/simple;
	bh=LQPtYHJ9G+9dS8xYzfdPPSieaAR30rFJxJjGK5NdNIg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOExdxLp1L4hworxBxSRcBReHzB4xxMTVHEDK1CR2KyIkIL2dxGUCdkRXCX99TmSKSNT4O+KCy1F0X/c8B6W4HZqgotI+iN+AF1hdjxLGsyluwo3+GsqCSrTeYEz86qwygLV7W3t0p6b7CTKRueTw/ONpowAcsphUu1LE53Pu1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=aqeOmVwG; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="aqeOmVwG"
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 68BLXc3Q027899-68BLXc3S027899
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 12 Sep 2026 00:33:38 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x58sM-006d7C-Mu;
	Sat, 12 Sep 2026 00:33:38 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Sat, 12 Sep
 2026 00:33:38 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 6a0f0d5c;
	Fri, 11 Sep 2026 21:33:38 +0000 (UTC)
Date: Sat, 12 Sep 2026 00:33:38 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>, =?utf-8?Q?Jean-No=C3=ABl?= Avila
	<jn.avila@free.fr>, Jeff King <peff@peff.net>
Subject: Re: [PATCH (RESEND)] ci: use system asciidoctor
Message-ID: <20260911213338.kLh69%taahol@utu.fi>
In-Reply-To: <xmqqeceza4k9.fsf@gitster.g>
References: <20260902071113.GA70165@coredump.intra.peff.net>
 <20260911195250.31201-1-taahol@utu.fi> <xmqqeceza4k9.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
X-ClientProxiedBy: ex19-01.utu.fi (130.232.247.41) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIXEhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZXkgCBkYJHgEE
 CSgOGg0NRg4aSFhIWVtIGA0ODigYDQ4ORgYNHEhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=TO5FHGidoLHQqq/eChoUylTlZYNr/Dpi2cITu3+sqms=;
 b=aqeOmVwGkf6xQpkDf8SPEiPjjpe0OhGvh7ajLlsRC0E1Kn0H+A0RUSmOlQN/1nsN3Z3Hgbjca5Iq
	arAgC9NfhYbhrzrUPkBIcVIMDXkRPS/7qb/bgi/2hvLauA0Hrv+f13Fe5kEzETW/TIGKS7i5mZtu
	kA0dlOaGvzPBg3qkRy+iWAROdC8FwTrseKDtwxCrousxePgz7frBrCGWQhR0zyDJfwLhbiuoX0PI
	H9kR9OzkhjMF0XVKXfuo1OVArFTPcrTOwrKtZLN9MHnLv7jz3Hk9+B6gP11aq2X5JSei8qzKTrw1
	ao+jt8WLyRwzgtPPWzMV2AmX1cF5QVWxvF79xw==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > Notes:
> >     The release notes draft for v2.56.0 already claims that asciidoctor
> >     has been updated to be installed via the system package manager.
> >     Clearly it refers to this patch which isn't, however, anywhere near
> >     the master branch.
> 
> I think the description was added to the release notes in 47ce80527c
> (A bit more for -rc1, 2026-09-11), one integration cycle after the
> 2.56-rc0 was tagged.  This patch and Patrick's "gem" patch were
> merged between 2.56-rc0 and 47ce80527c (aka "today's master").
> 
> So there is nothing to see here, I think.

These two were indeed merged:

* 4340a709bf (ci: fix missing Ruby dependency in "documentation" job, 2026-09-01)
* 1c1eed13bd (ci: drop ALREADY_HAVE_ASCIIDOCTOR variable, 2026-09-02)

But this is a third one (ci: use system asciidoctor)---it seems it was never
picked up.
