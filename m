Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792840757;
	b=aED4PHtwiVOU4Bv192aKmXKEjjrwiwUMVx6Z6rIxyXoptNhfXW1JZn6/+8zrNboofua6
	 FmNacinl0cVi6e9y2K6qqJLZfweEtM//PMR4ONx/RUcbU2sVwylxTUmrgsWyn6HFlF/kh
	 JDj54gIQaNQsuBMQ5eKKy674pSPN5jYitSTuO3miAOnIHmqVuKHZI9326Fdpc63cEkkWl
	 5f+AhFiyEpdJiwE9ez3WVeM62bHoWojl/zMxHyH7IdqaPvBZFP+c03l9aMBSV2H+n2j3s
	 YVV+C49VlNUZDMmko9FZakrxBawhRAMA2yk66LGsVPIoQcpwkiomWIyJp2c7I2QgHIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792840757;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=fKtOl8EAAV5s5iNp9d3p/SLrK+P6Uc56vKu0m9YJcgU=;
	b=SKBuMgYsf43HSEGmNm3IH8UlYcelLJFNfP3VYnsN3zsR/J0IW8jiVyypqg6FihJKNXIx
	 mt4Pl4fL1jhBwCFEuBiK6Gpr2S1eWh/7J26TBKWK8y7RXEtbssh/hPFeBh+qg78IExP9p
	 2AIGPr/pcSHHDFHVD7Ozag5G+3+QfGdB0sdshSRiqBIq4p5Vplu6yk21nM0g0vcsUjUPd
	 LGJmId/ApM+ldfv4vCrwxZPPB0tGAww7WeZ4bjGHgkh/kMl2P1g/JWkMWDSfdncL7qWbk
	 gYyEN9ZPPM3xxoIAxSByCbZZ8Ln0cdwY61BrQ3AIxKhaIcYfHDEnVGyJgXczD7C6GMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="NB/krgTm";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC36606A31A
	for <git@vger.kernel.org>; Sat, 24 Oct 2026 11:19:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBC36606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=NB/krgTm
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 69OBIvwt013287-69OBIvwv013287
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 24 Oct 2026 14:18:57 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xKZm5-005Ze3-D6;
	Sat, 24 Oct 2026 14:18:57 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Sat, 24 Oct
 2026 14:18:57 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 59599027;
	Sat, 24 Oct 2026 11:18:56 +0000 (UTC)
Date: Sat, 24 Oct 2026 14:18:56 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Phillip Wood <phillip.wood123@gmail.com>, Emily Shaffer
	<nasamuffin@google.com>, <git@vger.kernel.org>, Justin Tobler
	<jltobler@gmail.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <20261024111856.8s8qu%taahol@utu.fi>
In-Reply-To: <xmqq4iedc99a.fsf@gitster.g>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com> <xmqq4iedc99a.fsf@gitster.g>
User-Agent: s-nail v14.9.22
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-05.utu.fi (130.232.247.45) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUEgCBBwHCgQNGigPBQkBBEYL
 BwVIWEhaSFlcSFlbWEZaW1pGWlhfRltYSFBIWEhYSF1IWEhYSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFlfSA8BHBscDRooGAcKBxBGCwcFSFhIWVBIAgQcBwoE
 DRooDwUJAQRGCwcFSFhIWllIBgkbCQUdDg4BBigPBwcPBA1GCwcFSFhIWVtIGA0ODigYDQ4ORgYNHEhY
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=fKtOl8EAAV5s5iNp9d3p/SLrK+P6Uc56vKu0m9YJcgU=;
 b=NB/krgTmJTBNt5jGrpcVyhgj1fQnBCyWHFrknWtzYVzIrLCCJMXMjoWKTV0+2n3V++5Kh8QgDQOU
	HJuJ6CpatsGm2NuTy4TsF5cgwqapWz3qJslu2pkkOUPD/1udMsUxxcNQ0KrmffW8NgBfXd2yXp34
	4Fu6/IJ/TzXNuygzEqdiP6KPlimXOphJ/2M541wFKn0BcN3c9Fv9+ODgjjAxQHr2Rs4i2kWb0Iu1
	V5M4ljo8k6jmwZCTSHtZEwcqX8yfmfBOu5nTBbF42NeB4ApsAGbbVe0vrKTln0antas9gUcq0h+r
	ycx/i5kQDpmT36wD0K7eN7C/fDCFAdHGSnd8kg==

Junio C Hamano <gitster@pobox.com> wrote:

> [...]
> I previously mentioned "topic count", but commits are far easier to
> count.  So instead of requiring two topics in released versions,
> perhaps requiring five commits would be easier to implement and
> explain.
> 

Quoting the summit notes:

} * Emily: Have we used a voting process for something like this before?
} 
} * Patrick: We need proposals and a vote. Who would be allowed to vote?
} 
} * Peff: Active developers with a track record; perhaps a threshold such
}   as 50 merged patches.
} 

So it seems that Peff's proposed threshold was substantially higher
than what has been put forth in this thread.  Any comments on that?

--Tuomas
