Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794640974;
	b=tezRfevnVhYCBHo0m45qFq9lhOlnUGjJGHYAIXWjk3awoQxCBXKyD+qXm9ZchVx68ktk
	 jGDcAMbRpmOv8Vj8o6jAfptYbdcBcjWH0e4fgc+XOTjcB4Blr4uDgaqd2n7tHtSBMQFzs
	 OTKxvQRxsZGxtmzqd8LLNEuTtmMNiR7aDYkuOng6Hcnf6RjqUcvicqvF6CF0cfc+5dnZm
	 tnHgFkVfivjg+ygWYn2nSRiEXFHWhRLXgCAeVSa7muxJIYFqVUQRM0GOTZWfhAkgKKCUK
	 Pkn73Z4Bq6NTrMkHeD0xQrIRZ0hSn2cyjLVYRjuliDqwAAzWS6bDmuORHZ4SJLabP2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794640974;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=03VGSy8DhlxR0tvKNhK3da9qEdjc4Q2kW90k90hD5bA=;
	b=kB/Yz+xA/GQHPuEWL0aSRORf0oQfO8MZc6WOMtbjlM1oR6TLl+AC/rQU/a5QuVLSyUU5
	 8p9Hj+JaVVIQXgt0Agx06oryyD4HTjhHrJMXJv7vC1axGi/2COOMHTlJsc8XxEtSKiBzI
	 VwyK2AVdUpwWQbYmm38pFd2RYgFlEm1akn9hASlov1lS44oYGqj/OYz7+dmw8a4cl7+v5
	 hXJ82ICYlq4YNLq4/JR2ay5fK4u2dB3Pd4rxanLbMnwmMQDxGX3JPLxES6T5FV0yqu7BY
	 H0lUVVbsGVar89fd95EW+0FT2ROyy0bbYQsn3h9Pl6IBkKPQjTHkOmmUo2X29RP172g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=KpgYA+IE;
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8A606A329
	for <git@vger.kernel.org>; Sat, 14 Nov 2026 07:22:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86C8A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=KpgYA+IE
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 6AE7MfIu007915-6AE7MfIw007915
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Sat, 14 Nov 2026 09:22:41 +0200
Received: from ex19-03.utu.fi ([130.232.247.43])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xS85x-00Fiz2-2e;
	Sat, 14 Nov 2026 09:22:41 +0200
Received: from localhost (86.50.95.90) by ex19-03.utu.fi (130.232.247.43) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Sat, 14 Nov
 2026 09:22:40 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 691255bf;
	Sat, 14 Nov 2026 07:22:40 +0000 (UTC)
Date: Sat, 14 Nov 2026 09:22:40 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Junio C Hamano <gitster@pobox.com>
CC: Phillip Wood <phillip.wood123@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>, <git@vger.kernel.org>, "Mark C.
 Chu-Carroll" <markchucarroll@fastmail.com>
Subject: Re: [PATCH v4 00/12] builtin/rerere: convert to use subcommands
Message-ID: <20261114072240.DBIRJ%taahol@utu.fi>
In-Reply-To: <xmqqtslk9zk2.fsf@gitster.g>
References: <20261027-pks-rerere-subcommands-v1-0-d836c36ce0c5@pks.im>
 <20261111-pks-rerere-subcommands-v4-0-df0c8bf79e16@pks.im>
 <CAOLa=ZTAYtq0K4YfcSBocf-fxadTiaJp+AV5-_6_pbNMBwYQXA@mail.gmail.com>
 <ava6Q1u65ASVeth5@pks.im> <xmqq33t4eh84.fsf@gitster.g>
 <1ebac86a-6674-4c6c-bcff-a71c05b26d3f@gmail.com> <xmqqtslk9zk2.fsf@gitster.g>
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
X-ClientProxiedBy: ex19-01.utu.fi (130.232.247.41) To ex19-03.utu.fi
 (130.232.247.43)
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZUUgPARwoHg8NGkYDDRoGDQRG
 BxoPSFhIWkhZXEhZW1hGWltaRlpYX0ZcX0hQSFhIWEhdSFhIWEhYSFlRSA8BHCgeDw0aRgMNGgYNBEYHGg9IWEhZX0gPARwbHA0aKBgHCgcQRgsHBUhYSFpZSAMJGhwA
 AQNGWVBQKA8FCQEERgsHBUhYSFpfSAUJGgMLAB0LCRoaBwQEKA4JGxwFCQEERgsHBUhYSFFIGBsoGAMbRgEFSFg=
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=03VGSy8DhlxR0tvKNhK3da9qEdjc4Q2kW90k90hD5bA=;
 b=KpgYA+IEuywtYZj98uBXJv6jsXJO3A1NS/g4IRYXrgQo5st+EgHnmLFv8O2jEdkSa9oJDImAacHq
	TKVvU/hSkydVz9x6bcNl5Y/WeidVpCaf1lFTCIHvbMMDDVHSsYWL87MUOYqvIjHnoZqnQ3BJtlih
	WWY2Wnctlhvplg3VjKh0KU7EqahfXLg7axxkM9pW1cQwRXNfrgnanRpZKSjddEjMTs7wOS8FEMZf
	1xU3pL7DzemvxHmn5kESDrMKvvQeTFN1Nrzz9m+KqN/4FNPba937HkUJi+A6ilO0zbxI4oWm1snb
	UHCWUI+GlbBfV0+YGWnX4nt+JbtduDy6Rk/V9A==

Junio C Hamano <gitster@pobox.com> wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
> > On 13/11/2026 18:09, Junio C Hamano wrote:
> >> 
> >>      $ git checkout ps/rerere-subcommands
> >>      $ edit rerere.h
> >>      $ git log --oneline --first-parent master..
> >>      $ git commit -a --fixup HEAD~10
> >>      $ git rebase --autosquash HEAD~11
> >> 
> >> By the way, I wonder if we can simplify the last three steps in any
> >> way?
> >> 
> >>   * We can use 'HEAD^{/^rerere: convert flags}' instead of counting.
> >> 
> >>   * The last "rebase" does not have to be on HEAD~11; as long as it
> >>     covers HEAD~10 it is OK, but we cannot use 'master' as I am *not*
> >>     interested in taking any new development from there, and I do not
> >>     want to worry about what the command would do on the merges the
> >>     topic has as synthetic base.
> >
> > So long as you've set an upstream branch, you can use "--keep-base" and 
> > omit the upstream commit.
> 
> I do not think I want to set upstream for ~600 topic branches (among
> ~100 are still in flight) I keep around.  I was hoping that after
> making fixup changes in my editor and adding them to the index
> 
>     $ edit rerere.h
>     $ git add -u
> 
> A single command that names the target of the added change
> 
>     $ git fixup HEAD~10
> 
> would automatically do the two "commit && rebase" commands.
> 

Which is exactly what 'git history fixup HEAD~10' strives to do, isn't it?
