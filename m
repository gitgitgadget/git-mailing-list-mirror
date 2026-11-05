Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793863807;
	b=RAt9USxEnYMS1yC5iy/E93lXwu3iVgM1DsWlxP+uxDKpytXmW61NX0fVy7wsOwpsXfrm
	 lsEaWmROLFBGBVkcSaXFYLiEru6Q/duBwwdmmLi7ukO6I0Nm7CBo25kV+YziIinW7lm8A
	 CHSpK0BNy1gu99ch+j0MGxvuMUoRaGEDibSsSIBMS9GYIoHeVRWhj1bsXYggwgG/vlcxg
	 +izVPyunoiUTIoSSzO60udqklm/o9uUe+LW5pcBlNYk5IuP7OVNFlbKFcN14zBPyKQ11h
	 Ah5yhdY8+oPjegtinxcMWap6SFtvoxkYmCwxq16vRNzmteY8zNKMXDTd9Pr8UbrBBDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793863807;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=i2jqAr4IlJzqzuY0w/Z/l7U5jDHgWvvzo0dORHeJvpc=;
	b=DmFGFssGy4Bwcu2lX7NlCUtekwcdg9Yorkizp2J0DrPRSKcPVkJCr+zlzkmRewKhQB0r
	 M+nY89NPZt74iwvIkZ0SuAl8PnmPIICtC9Wfa8ZcYaHL6iSBSTlXPP0WqIB10DZzXj0qF
	 fWVVyLWvoFVIe//SLnYOZRqfCAYGo0ispLvbyKWRMghbR314eSDQiJJbU+SX0gpAx7Qhz
	 Xo4hGG4dfq3sjY3wiTY1XucAzR8/WI3GzKK5E+t7Bwnc0b++n4gG1WIF/+lBChpFVbw+N
	 3e+73lNq8apnEAIGi3Y+bPNsfFFaR03q3OwkDminJkcq/+moTawkU7t5J2uO16Z/8ww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="F6/EgHv1";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63856606A326
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 07:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 63856606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=F6/EgHv1
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A57TxPc027043-6A57TxPe027043
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 5 Nov 2026 09:29:59 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xOrv5-004EQz-Hr;
	Thu, 05 Nov 2026 09:29:59 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 09:29:59 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 3d3b1841;
	Thu, 5 Nov 2026 07:29:59 +0000 (UTC)
Date: Thu, 5 Nov 2026 09:29:59 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Nov 2026, #02)
Message-ID: <20261105072959.nzvWu%taahol@utu.fi>
In-Reply-To: <xmqqmrroxdzs.fsf@gitster.g>
References: <xmqqmrroxdzs.fsf@gitster.g>
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
X-ClientProxiedBy: ex19-01.utu.fi (130.232.247.41) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GW1hIUEhYSFhIWkhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=i2jqAr4IlJzqzuY0w/Z/l7U5jDHgWvvzo0dORHeJvpc=;
 b=F6/EgHv10AI4xxx6PL1RMX4B7XjNs+gf20fs+lqKgei1tJF3sVt9fPDvlg0f3MzGjprL1rw6kZEs
	g3MQnWRgm+DC+JcJLZ2qBJrSbN3Nk7UM/PpoRQOz6SG4LR1/4DOd9K2feHEbcq6LC7UPGdplMUxp
	Ccbw6D1+yr992YuCuBQlWJfvM3iqinde2Btv/GEBZUA5GS1LV/j3AVdH2Wr5ldPsU44xYr271CWH
	/OvTOOrHtpiWrRAtboSXMZDzQ6hBV7wCa0Vk+5Nh4bN3Mp6ch1jJahje9sHSeEBXVSzFhsfsvosg
	eYcuLl2J7OlYgN0gNo5QP6CcldUrCvwDvIdUSA==

Junio C Hamano <gitster@pobox.com> wrote:

> 
> * os/rebase-doc-incompatible-options (2026-11-01) 1 commit
>  - doc: git-rebase: update incompatible options
> 
>  Outdated cross-references to the 'INCOMPATIBLE OPTIONS' section in the
>  'git rebase' documentation have been removed, and a missing one for
>  the '--onto' option has been added.
> 
>  Needs review.
>  source: <20261101082230.141688-1-omri.sarig13@gmail.com>
> 
> 

Reading <xmqqjyncxrur.fsf@gitster.g>, I would have expected that this topic
would've been rooted on the v2.56 tag, but that doesn't seem to be the case:

$ git log -2 --pretty=reference os/rebase-doc-incompatible-options 
ebbf0e59db (doc: git-rebase: update incompatible options, 2026-11-01)
47fdf2208c (The 7th batch, 2026-10-19)
