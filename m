Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793902088;
	b=AsuaEYBR34vF6IKf6Am4s2clPUZDAPXMU8h5MysTpo3KqTKGgqSEJ0UoOgcfgdYkZC/N
	 dktu9D31fpxhS/oweqtgcaOTnfqX22nu6tYH/lxiHPJBkEKIoIxIz80Gc+myKjf8x9nsE
	 6pcPXKoCXmCm1pe8fURwwkySYL2Z2ci1//TmCIRBT1293xKri3vbdVMYBW+SV2ab1vh4f
	 wjeok2pTLgIurMN6MnpV9dyIqXixti6zlGIqrcRl9AHkczZUlCOsvDCPQy8KZPXorXRyv
	 kzaTpZLH+WFnjcDvJDHwTi539ypJJPIFMTDseYd2uavuWql5ByMtxSkX0lr5ynnrJ8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793902088;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=yuTMPL40gd/h6spAL5y8v//RPt4+GOfCB5tLKauvqkQ=;
	b=SVDlqmMhbi02vfG7hvhlNwA7KhBogJN9aNA9WxTgQQgkEiif0PFOpSuuIE835N6r/6fk
	 HwMb5gS182RjK0MsRHzKPxkYhJ7u/8JyKMv4tcCwzMT5ptDdHmsawgiG43TvENk/im0IY
	 lHZiqFU4F0dczHMBiJPFx+THlvg1LFr2F6HKMcCa6UxVVzpwVJPgHmMZbWEqIVFpmm3oc
	 3VQhpVdMz7djgAgMk+wJoEW144PxtJYgxOsq3467TC2i/K646CWelYzQDMrv0yDhTrro9
	 A4X69dLh9ec/TEQKSlT3CdBDNhTQNj4Nu6bX5+Tq13MPIHQatp6cdKUbLQjWqCzSn9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=JzAnLjJ3;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3B3606A31B
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 18:08:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A3B3606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=JzAnLjJ3
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6A5I7mAR013673-6A5I7mAT013673
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 5 Nov 2026 20:07:48 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xP1sK-004hU6-6K;
	Thu, 05 Nov 2026 20:07:48 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 20:07:47 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id b2c50777;
	Thu, 5 Nov 2026 18:07:47 +0000 (UTC)
Date: Thu, 5 Nov 2026 20:07:47 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
	<git@vger.kernel.org>, Kristoffer Haugsbakk
	<kristofferhaugsbakk@fastmail.com>, Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 0/2] [doc] Remove gittutorial-2
Message-ID: <20261105180747.P-kMC%taahol@utu.fi>
In-Reply-To: <xmqq5wybw4gg.fsf@gitster.g>
References: <pull.2241.git.1790627122.gitgitgadget@gmail.com>
 <pull.2241.v2.git.1791231610.gitgitgadget@gmail.com>
 <20261006055002.M9X9O%taahol@utu.fi> <xmqqfqyieokd.fsf@gitster.g>
 <20261105065723.Q3ED0%taahol@utu.fi> <xmqq5wybw4gg.fsf@gitster.g>
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
X-ClientProxiedBy: ex19-14.utu.fi (130.232.247.54) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhaWkgPARwPARwPCQwPDRwoDwUJAQRGCwcFSFhIWV9I
 DwEcGxwNGigYBwoHEEYLBwVIWEhZW0gCHQQBCSgCHgYbRgsJSFhIW1pIAxoBGxwHDg4NGgAJHQ8bCgkDAygOCRscBQkBBEYLBwVIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=yuTMPL40gd/h6spAL5y8v//RPt4+GOfCB5tLKauvqkQ=;
 b=JzAnLjJ3t8wnRNbwKMgee1fUlq6WjxyilsNPqsSVcIsANvva/AzfYoz+a+WEfHJtbsotRenG7p0i
	JE70gHy9jwpPXxbr/WgyhwdBpzA5Rkfrwd8Pg8KGx8JZoAWwzxqs/uNQF5sfsck2no1i2pQWCoTz
	jy3qZpUC+QU2Vg4ouI6OR6WXqLzW9Tch2UgflgKNxuw2QlUv7xMrj7yFCPJ370XtajstldTS0Grt
	OpKvIwNiY/y1kzaYJj29X+8LQkPTPBv3HAweetIBAGlcNVOyOg/Xna+XBHoZ99l4EWvsy8rGVQ5H
	zgOusMAQKvRU1Y3rxWaD5dh8z4zJp4JZAN75TA==

Junio C Hamano <gitster@pobox.com> wrote:

> Tuomas Ahola <taahol@utu.fi> writes:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> Tuomas Ahola <taahol@utu.fi> writes:
> >> 
> >> >         gittutorial(7)
> >> >             A tutorial introduction to Git.
> >> >  
> >> > +       gittutorial-2(7)
> >> > +           Obsolete tutorial.
> >> > +
> >> >         gitworkflows(7)
> >> >             An overview of recommended workflows with Git.
> >> >  
> >> >
> >> > And let's not worry about that exception you mentioned.  After this topic hits
> >> > 'next', I can rebase mine on top on of this, and deal with all necessary
> >> > integration work.
> >> ...
> >
> > This topic has graduated to 'master', so we should be more than ready for the
> > last bullet point.  Please pick up the rerolled ta/command-list-guides-sync-lint
> > at <20261029184834.2273-1-taahol@utu.fi>.
> >
> > $ git cherry -v origin/seen ta/command-list-guides-sync-lint
> > + 9a1ba61ac0e4491a4f028250be478cfcf05c9ef4 command-list.txt: add gitformat-loose(5) and gitpacking(7)
> > + 5d36d7585956d17172012c8e42d77597524708e8 lint-docs: check the guide list in command-list.txt
> 
> Sorry, I have no idea what you are trying to say with that "git
> cherry" output.
> 

Just double-checked that the topic is not in 'seen' (the lines are
plus-marked).

> Earlier you said "I can rebase mine on top".  Is the patch
> <20261029184834.2273-1-taahol@utu.fi> the result of such rebasing?

Yes it is.
