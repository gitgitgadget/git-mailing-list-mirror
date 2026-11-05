Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899448;
	b=utpxVJYjpAK/hS8RK8abrR3KwbecRqZwbSW9+n+df3UjgB4XPqSk2mbL9G9rOP1Ln4OP
	 64VsZxEkL3sHRDx7MOElJpZzeX/kZCsebI//fSx+Gs1HMOGwxT481Sk7gt8yg5p6ux5S4
	 HRbT8qw3/HVLEEgD/FofyBV23RZytrBmEMYHZsxuKCcYOqCv7sqD8hlJQ8hG6mtj6rNEH
	 +nHtoV9JHnqcOs6F9FCBEtpkWTgMMoviWP8zBAbqRYCX6YLDY0KYaFvQ2CB4lXUhmn8wn
	 tMgPlrn2YIIq8DZu9Z6cSDmFQFmhBAm8JUA4jUDlBYJSOVdVDqZJCcZ/Msx/I5QdWKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899448;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=vlIbSFgw9bhYDzMiyisV+OXcssbTW7aJ8wrXVoRSB3Y=;
	b=0KeNZYcT4C/llLl1yow3D0n5QY12Ubjml4DB+Ac+G90ECyu6vtFI8ama2YLOtfuqbbLB
	 ljFRffRjeiuMRJCa6oC5GFdgm46Wk++gjX+aGS8zxSEf73GLMzwnGPPA2xp3zMzBr1FrF
	 7zlPi4e22bE9IsSzNnPl0G92NBRuEiCdvqTFhN4aue5v7uwJmb1oTGwFkp+EpyziQvCcL
	 G8W06hBeJs6FRO4M5M9UKWFY7ZbNlq4f3S2QbOz6CmDkqyR9ak7Ary1pf3o7PUSYcwvMT
	 TnNAJsDfgrAzJ/xRIavsytjs2wI1Hsonc30WhtwL8hYgqc4gxJbgLH3AdJbKJpRBCug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=OjmC49GK;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE400606D810
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 17:24:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE400606D810
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=OjmC49GK
Received: from smtp-03.utu.fi (smtp-03.utu.fi [130.232.207.30])
	by fortymile.utu.fi  with ESMTPS id 6A5HNxHT019432-6A5HNxHV019432
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Thu, 5 Nov 2026 19:23:59 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-03.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xP1Bv-005B6g-Gy;
	Thu, 05 Nov 2026 19:23:59 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 5 Nov
 2026 19:23:59 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id e5a0eeb2;
	Thu, 5 Nov 2026 17:23:58 +0000 (UTC)
Date: Thu, 5 Nov 2026 19:23:58 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
CC: <git@vger.kernel.org>, "D. Ben Knoble" <ben.knoble@gmail.com>, Julia Evans
	<julia@jvns.ca>
Subject: Re: [PATCH v2] doc: git-diff: rewrite EXAMPLES section
Message-ID: <20261105172358.HxmMJ%taahol@utu.fi>
In-Reply-To: <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
References: <pull.2293.git.1793720007182.gitgitgadget@gmail.com>
 <pull.2293.v2.git.1793893217889.gitgitgadget@gmail.com>
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
X-ClientProxiedBy: ex19-10.utu.fi (130.232.247.50) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaWkgPARwPARwPCQwPDRwoDwUJ
 AQRGCwcFSFhIWkhZXEhZW1hGWltaRlpYX0ZbWEhQSFhIWEhbSFhIWEhYSFpYSAoNBkYDBgcKBA0oDwUJAQRGCwcFSFhIWVFIDwEcKB4PDRpGAw0aBg0ERgcaD0hYSFlb
 SAIdBAEJKAIeBhtGCwlIWA==
X-FEAS-Client-IP: 130.232.207.30
X-FE-Last-Public-Client-IP: 130.232.207.30
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=vlIbSFgw9bhYDzMiyisV+OXcssbTW7aJ8wrXVoRSB3Y=;
 b=OjmC49GKJhLGzOY83Ht7OW7ASAp3fivwhBp5nwBD9wotvW5FNRCtHcTS1OzjoXBkPptcQG5uoP/O
	EeJcpd4XRyW29oO0S4pLDdIcnQgG7a3xd0li3hVo/8QtjcSsCj7sCxnWYRqmXm4ulzpokcGF/BS8
	tr02r3ISI4kp+it7AKE6FhCs+10fNZ2buNLIy8oNCFSBXEDUmgKh4BYNrL2khFHuPgzst7KLBlq6
	F3a5i5uoWf6xspjbvjbWTKHW8XsCRlhYHBG+kuCpqAPsR5Z3WpGbXDnV2LrVmyChOOm62mliWExA
	e478HdEhBKjyBkb4SmoacIlsqZMQePKMbZzU6A==

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> wrote:

>  --------
>  [synopsis]
>  git diff [<options>] [<commit>] [--] [<path>...]
> -git diff [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
> +git diff [<options>] --staged [--merge-base] [<commit>] [--] [<path>...]
>  git diff [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
>  git diff [<options>] <commit>...<commit> [--] [<path>...]
>  git diff [<options>] <blob> <blob>

Sorry, that breaks the test number 0450.218.  Please change the synopsis of
"git diff -h" as well.
