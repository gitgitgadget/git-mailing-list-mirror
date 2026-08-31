Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C2E42376A
	for <git@vger.kernel.org>; Mon, 31 Aug 2026 18:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788200472; cv=none; b=KsbQ6pg94mwPVqCzejp1j39s0DPQeMAAvHDcWxB2n/ly69N3Dk8v9VTVNBtCSvdlAArbWg7GBerFQKu3v87u0YOuT9QsQZgSSw5yysg+JOt1fotgumV3GSeOtlSj7McTY0pj+xgF3amMoadKFB5zodaHfKEWXAIuAQ/IWzpB4w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788200472; c=relaxed/simple;
	bh=4UFFQ09vrMlTNyDXkk2wmA2+w6u17S92MD/OuixvpuI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lyg1I/iIP1jvRk0nzun5DDy2m/qqnwbPZeS1HOW66vpT9ixxzmR0lk+nPeYKa2j8JpLZ3P3jycd9dQPZ3+1mdiqAEHCOfKEyMqLIreLVmrTc445SPb3aJNIY1XCmnt2/XE+BauU7H93JZ682/DOwXnPTTKYfCM/ZmU6OTOJLA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=Lt5Zyvga; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="Lt5Zyvga"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 67VIKrDC005393-67VIKrDE005393
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 31 Aug 2026 21:20:54 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x16cn-00DknE-PW;
	Mon, 31 Aug 2026 21:20:53 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 31 Aug
 2026 21:20:53 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 02e103dc;
	Mon, 31 Aug 2026 18:20:52 +0000 (UTC)
Date: Mon, 31 Aug 2026 21:20:52 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Patrick Steinhardt <ps@pks.im>
CC: Hardik Kumar <hardikxk@gmail.com>, <git@vger.kernel.org>
Subject: Re: [PATCH] versioncmp: fix typo in versioncmp.c,
 t/t0022-crlf-rename.sh
Message-ID: <20260831182052.ppylY%taahol@utu.fi>
In-Reply-To: <apUmRknf8gnd-Izp@pks.im>
References: <20260828-typo-fix-v1-1-24e80a87ed53@gmail.com>
 <apUmRknf8gnd-Izp@pks.im>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-09.utu.fi (130.232.247.49) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhbSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZUEgACRoMAQMQAygPBQkBBEYLBwVIWEhRSBgbKBgD
 G0YBBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=g0Zw2JuCognYRJqdp3Ulu9s0Jnp5JKEwEtKDvW7gq5A=;
 b=Lt5ZyvgaLDFf7YOIteS6E9quFF/a3ALmegGSMbArk3RER4FPLzAgtUDZA8D18ZH/6ZgBb5KDDvIS
	W887kp4dkgcnkS52RlPnh1panMMJJ9io74ePnZbd1F8UsJC4gIiX1Zb4apcIL00KDWSv6FJT5Ke1
	kYAS5xcVtGzysjFLXhw088RtfBd8iVrCQiS1IJjTpZBb029rSrwNvUjLL4ntxWciMQ6dXdK6b1P0
	ZdH0DfczmjopS4Sw5eKsh8dqHlb517/s4K/d9K6f9UXL9CBYYnmdeF+w8T4npYc05yKFJjEnrGaS
	epT2D1jUl2oq0SrxUAsl5BLFWfqazyy7V+UuQQ==

Patrick Steinhardt <ps@pks.im> wrote:

> On Fri, Aug 28, 2026 at 02:38:01PM +0530, Hardik Kumar wrote:
> 
> > NFC only updating a comment and a test_description
> 
> I have no idea what this means.
> 

"No functional changes", I guess.  But spelling it out in the commit log
message would of course be preferable.
