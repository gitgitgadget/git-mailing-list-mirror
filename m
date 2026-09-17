Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B4F33BB695
	for <git@vger.kernel.org>; Thu, 17 Sep 2026 16:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.232.247.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789661826; cv=none; b=bPRENtTIX8ShA9zWaFxR2sT11pNjGtz239Qi0d+Emtx6sLhjnsOXG7d+JWY39qTytpPDoV6w7fzgTN4SiqhPEbGmrtYzgcJURtkosyNXsLW8kFmbCbA9XCIx1Uul4eClM4Vy3Xu1O+pvDeffskzwJrVvwKEONnwyB2QCsX5q21Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789661826; c=relaxed/simple;
	bh=PTawUnIBIS+SaRHUsjgJno91z3libo7RfWJNBju6Xf8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mhQnsq+NfrDbPYbY5RRJ0V0xqsptUgUT+lzz/K64W1S9+/AwMMYvdjl4Xe8rnP0FGbvyd/bhvzTzJCNoTqL4nHuIEfp4rrEczZ1ZL+DUtJ5V4dlVPuXFjr2gMtgguNmz1JcBg4UkStkjIJAaWvWswCujILJI8aF66cs6n5g8fUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi; spf=pass smtp.mailfrom=utu.fi; dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b=bXOSUFAI; arc=none smtp.client-ip=130.232.247.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=utu.fi header.i=@utu.fi header.b="bXOSUFAI"
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 68HGGopT008913-68HGGopV008913
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 17 Sep 2026 19:16:50 +0300
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1x7En4-005yNb-23;
	Thu, 17 Sep 2026 19:16:50 +0300
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 17 Sep
 2026 19:16:49 +0300
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id c9ded257;
	Thu, 17 Sep 2026 16:16:49 +0000 (UTC)
Date: Thu, 17 Sep 2026 19:16:49 +0300
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.56.0-rc1
Message-ID: <20260917161649.EtOVz%taahol@utu.fi>
In-Reply-To: <xmqqh5jpvzxo.fsf@gitster.g>
References: <xmqqh5jpvzxo.fsf@gitster.g>
User-Agent: s-nail v14.9.22
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: ex19-03.utu.fi (130.232.247.43) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhaSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhY
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=P1SxOu1/bA1Y2DhfCVBqtmJhVCNFiXw2QZBszNLr4+s=;
 b=bXOSUFAIf4/BUipiGIyBjUrGDnDM5ywUqHLCMM5P2tNdduA5dvYkOpX8D57XiiPcTwmNTqXRlkDm
	3C1vECAYoecxEdvK4x9pYQ5rhIdcyuRNP+0CZ2FcGZ95hnmYcXWBdYg/5vK1i12ltTgB8VvJ7jU2
	3x7by0c6K1ZtGR5KqYUEFhDDBTfnznqvNzY7XFpqFP1hq+bFXgdpykk+Dp04O9PMXhjHqqvT8GwM
	RTqdxggEGi5a8Y3RxNimDVwW9oCc/gbVBUPctxjmVDvdmkpg4C4PfhOvyfzzJMKV2X0knocCdfSP
	49fb71ES3K//ILGCuT1Ap+S+06PfWcbjzDtvyA==

Just a small suggestion:

> 
>  * Running "git history" in a corrupt repository can (unsurprisingly)
>    segfault when a necessary tree object is not found.
>    (merge 76621488e8 jc/history-missing-tree-errorfix later to maint).
> 

Not the most urgent issue but perhaps that entry could be amended with e.g.

	...which has been corrected

before the final release?
