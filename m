Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793388472;
	b=WXT2yJvO8jF9So971seUgk+IP1w0c8YNQtpdOoo4YoKXXcPFmYEWUl3RTry8GL7aHwbP
	 /FW9ur9zQdjGVbH59FO+GAcrgbEsG3TZTscZ+OyxcmEFMAB1CQOyyAxV7f+Gqed5wvtsf
	 EmOzlVv/3HfO1YHhRIhhXHQEHMC1lR8ZonQaS4C4jBCT61PVkjHYBCm3pYas+gF3KuY2K
	 z4Yq2jFM40duF6DRS/A089dGBzT8+1RjrFGrbdLbhKNbzetGydPRkSXTkL+8x13QbFX2U
	 rcpmk8xKSh5nJUgTgoF428cmXcv/1nQ5GPfQRjbpBqJWJJ7AfCYxMs9UYZlqvvuXdpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793388472;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=chPMTeqm5dsXi8v0B5jKiscFtlMWLxBsLPBOOEChkV4=;
	b=c7jG3aPJyEwErmBnOFGFwBsq7gPu0PnQunqOC27vUj2vNVMeLVbzRytBzOwXXTAK1jqA
	 tIudkN2cH+Fm2knC15liOv1dlEUeu3PbIOS6ncqztRHBZGqQkWDOLZYra6NVT+eqdcBhf
	 dEgzXnd5JEMXk+bBjeTFNK7CpC3aJZawBAFSYijibpOc1BR+d7e4x+e8ggiiIH0itrMYk
	 WuKiKehro1av5XNcKWIDQ4TbLbMqrxeZ/XJh8InWzDkmozLurgo1svb511fTUxR5DqLzk
	 7wqAfhEGLnmUo6Zmo7kKPPCVUVunjyxxEzi07gMAlPlJNCJOx4sq7j8uIuqhDqUJnFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Oqi6eUj7;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B070606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 19:27:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B070606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=Oqi6eUj7
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69UJRKSD027027-69UJRKSF027027
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 30 Oct 2026 21:27:20 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xMsG0-00E8hA-9g;
	Fri, 30 Oct 2026 21:27:20 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 30 Oct
 2026 21:27:20 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 536611bc;
	Fri, 30 Oct 2026 19:27:19 +0000 (UTC)
Date: Fri, 30 Oct 2026 21:27:19 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Omri Sarig <omri.sarig13@gmail.com>
CC: <git@vger.kernel.org>, <gitster@pobox.com>, <julia@jvns.ca>,
	<me@linux.beauty>, <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v5] doc: git-rebase: update incompatible options
Message-ID: <20261030192719.8KtoR%taahol@utu.fi>
In-Reply-To: <20261030163841.31840-1-omri.sarig13@gmail.com>
References: <20261025110759.204336-1-omri.sarig13@gmail.com>
 <20261030163841.31840-1-omri.sarig13@gmail.com>
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
X-ClientProxiedBy: ex19-12.utu.fi (130.232.247.52) To ex19-06.utu.fi
 (130.232.247.46)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhaXkgYAAEEBAEYRh8HBwwoDB0G
 DQQFRgcaD0YdA0hYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXkhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZ
 W0gCHQQBCSgCHgYbRgsJSFhIWV1IBQ0oBAEGHRBGCg0JHRwRSFhIWlpIBwUaAUYbCRoBD1lbKA8FCQEERgsHBUhYSFpeSBgAAQQEARhGHwcHDCgMHQYNBAVGBxoPRh0D
 SFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=chPMTeqm5dsXi8v0B5jKiscFtlMWLxBsLPBOOEChkV4=;
 b=Oqi6eUj735whZ048k3/MljrdMt4L5vCXauCoCsZbmTa/V1g9F8jf77BIBtHuCL+J3lGa3RtCUlGD
	P/PI785ZCK0+wZB7ArPxc7rP5qY0S+GN5TQGFLgIkWaMUYOhcvR9K3gMKYU8xxsBEEdu+YeZ4S8P
	OOERepY7/QOIb8clgP+dDbphcJcwsuduoSEIP9CL8sLXvqIIDcIsSprvYsdRrW2fJzXK0tyLJxCm
	qC3pP7EntDQVyzQEc4xjQ/vzrSLjb7SrSbHkr/LuWWKih4bvsRXldz6QaAR659CuIi5LmNF1SPwh
	hpmStT2D9PvXM+JbvQdx6ms6YApqM3a4taHuyw==

Omri Sarig <omri.sarig13@gmail.com> wrote:

> A few options in the rebase manual page link to the "INCOMPATIBLE
> OPTIONS" section, but they are no longer incompatible with any other
> option:
> - Commit 1a66d8c6f6 (rebase: remove --allow-empty-message from
>   incompatible opts, 2023-01-25) removed "--allow-empty-message" from
>   the INCOMPATIBLE OPTIONS section, but did not remove the link to that
>   section from the option description.
> - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
>   2021-09-07) removed the `--preserve-merges` option from rebase, which
>   removes all incompatbiilty references to `--ignore-date,
>   --reset-author-date` and `--signoff`.
> 
> Additionally, since 414d924beb (rebase: teach rebase --keep-base,
> 2019-08-27) the `--onto` option is incompatible with `--keep-base`, but
> doesn't link to the INCOMPATIBLE OPTIONS section.
> 
> Update the description of these options, to have correct references to
> the INCOMPATIBLE OPTIONS section.
> 
> Signed-off-by: Omri Sarig <omri.sarig13@gmail.com>
> ---
> 
> Thank you for the review!
> 

The range-diff against v4 makes it clear that v5 only changed the commit
message.  Unfortunately, the reroll introduced a new typo:

           section from the option description.
         - Commit a74b35081c (rebase: drop support for `--preserve-merges`,
           2021-09-07) removed the `--preserve-merges` option from rebase, which
    -      removes all incompatibility references to `--ignore-date,
    +      removes all incompatbiilty references to `--ignore-date,
           --reset-author-date` and `--signoff`.
     
Otherwise v5 looks good to me.  Thanks!

         Additionally, since 414d924beb (rebase: teach rebase --keep-base,
         2019-08-27) the `--onto` option is incompatible with `--keep-base`, but
    -    it is not mentioned in the INCOMPATIBLE OPTIONS section.
    +    doesn't link to the INCOMPATIBLE OPTIONS section.
