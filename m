Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=130.232.247.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006659;
	b=bLS+ftPr+mtk/l7MHdI/kjKFccfAuiVqk3/RrbM7R0AMe3jtApdIA6kmFL0egLIwADP4
	 IxbzFPHL4M4hx3E2HHKlYrIK4xG4aSoKFBW9VpAk1Qf9xHVwS29+VN5oXdE+Xkd+Aku/2
	 ISdz03pM9ZVX8VbSvqwr1JWmf6JgqcNZqPpGOrJwIrXtSzgwDy7SEkoQMxP3eGmEylT41
	 Lv8cFMO92z1QZSiVYQJ7DINbFjsUcaMOvvxnkm/S0gfrbBlLDF+ZiyUMMQ2/MSFBE5+aV
	 PpR3EvPuOu1Qs7k7i+gK7jzbPMJEAug0ySGhtxRUJ7p2j/TpBPM+bJSv5twnKe2LEug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006659;
	h=DMARC-Filter:Received:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:X-Originating-IP:X-ClientProxiedBy:X-FEAS-BEC-Info:
	 X-FEAS-Client-IP:X-FE-Last-Public-Client-IP:X-FE-Policy-ID:
	 X-FE-Hostname:DKIM-Signature;
	bh=WdFGMOwfD/KTwJn9dBXp2sS1Pruxox8lVraxbPKF9TE=;
	b=Xhse6bqjSZWgEMBLheJluj83FfyHyqEZm0dVsmnwgJSLPZ+RXp2+YLQ1bkAQPKzNp7cv
	 bVHBmt49wuG5H6NErsyTHfXE0FRg/VTSok8ltReTbqfNR/1Zr4F6vsq7kmgIGt+NypnxK
	 FOyqM7CADM8oSKSvb9fROfmq1LaHLqUVZw4yQQP9RosJHCHyKAh+fOEnODWoRBPA95sGo
	 bUWfcSSo/4dOe6TW7RaEDaE/Puv+m9g8NRyoS1VPLul2YzSMmy2CA9I7w42d0rDNRCEF5
	 Rpt27Dk02b6dqz/OJOr4MxbMzyblKLYvvQSP6V7Mpiap67kvI96bj8sxcVXcUo6FJLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=utu.fi;
	spf=pass smtp.mailfrom=utu.fi;
	dkim=pass header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b="E5/4BQ5e";
	arc=none smtp.remote-ip=130.232.247.4
Received: from fortymile.utu.fi (fortymile.utu.fi [130.232.247.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218F4606A31B
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 09:24:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 218F4606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=utu.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=utu.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=utu.fi header.i=@utu.fi header.a=rsa-sha256 header.s=out-utu-v3 header.b=E5/4BQ5e
Received: from smtp-04.utu.fi (smtp-04.utu.fi [130.232.207.47])
	by fortymile.utu.fi  with ESMTPS id 69Q9Nt3E027618-69Q9Nt3G027618
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Mon, 26 Oct 2026 11:23:55 +0200
Received: from ex19-06.utu.fi ([130.232.247.46])
	by smtp-04.utu.fi with esmtps  (TLS1.2) tls TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <taahol@utu.fi>)
	id 1xLGvr-007MTX-B5;
	Mon, 26 Oct 2026 11:23:55 +0200
Received: from localhost (86.50.95.90) by ex19-06.utu.fi (130.232.247.46) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 11:23:55 +0200
Received: from localhost (localhost [local])
	by localhost (OpenSMTPD) with ESMTPA id 09fab9c6;
	Mon, 26 Oct 2026 09:23:54 +0000 (UTC)
Date: Mon, 26 Oct 2026 11:23:54 +0200
From: Tuomas Ahola <taahol@utu.fi>
To: Patrick Steinhardt <ps@pks.im>
CC: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>, Phillip
 Wood <phillip.wood123@gmail.com>, Emily Shaffer <nasamuffin@google.com>,
	<git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <20261026092354.Zbs4K%taahol@utu.fi>
In-Reply-To: <at8IBMQZtJP3bQ9-@pks.im>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com> <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
 <20261026011731.GA3575069@coredump.intra.peff.net> <at8IBMQZtJP3bQ9-@pks.im>
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
X-FEAS-BEC-Info: WlpIGw0aAQkEARIJHAEHBlJSCRoLAAEeDUhZUEhYSFhIWkhZXkguLT4lWFxYWFhYWFBeUVxfSFhISFlbSBwJCQAHBCgdHB1GDgFIWUhZX0gPARwbHA0aKBgHCgcQRgsH
 BUhYSFpIWVxIWVtYRlpbWkZaWF9GXF9IUEhYSFhIXkhYSFhIWEhZUUgPARwoHg8NGkYDDRoGDQRGBxoPSFhIWV9IDwEcGxwNGigYBwoHEEYLBwVIWEhZUEgCBBwHCgQN
 GigPBQkBBEYLBwVIWEhaWUgGCRsJBR0ODgEGKA8HBw8EDUYLBwVIWEhZW0gYDQ4OKBgNDg5GBg0cSFhIUUgYGygYAxtGAQVIWA==
X-FEAS-Client-IP: 130.232.207.47
X-FE-Last-Public-Client-IP: 130.232.207.47
X-FE-Policy-ID: 3:5:2:SYSTEM
X-FE-Hostname: fortymile.utu.fi
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=utu.fi; s=out-utu-v3; c=relaxed/relaxed;
 h=date:from:to:cc:subject:message-id:references:mime-version:content-type;
 bh=WdFGMOwfD/KTwJn9dBXp2sS1Pruxox8lVraxbPKF9TE=;
 b=E5/4BQ5eVRE/BhAPmmuHOFYeavzgkgljl8X0t/du4sPmXOOnHlKGxJfsoPznNWT95Ifw0Ua9/BcA
	pkyVb3P26E9ugoXIpunC0E8nHf33m4+b9vfr5BBVnYmvFixSxp/tUYiX6eb7vCWqCZ7hbflGpMIb
	ZAqr3DED7/kxXQvs3N6ANOrmlxJdHKgCVFFqLGJ3pynXqw3Cq51zqGy+dZzTIn8tga0FO8HusS+T
	T8y/WYv+Zl6iyhvZj63Eue9uSxVfcez8uUrTDUlO7fxstIcvd5A2QI5xRMjdzJE5naBrELXr9NCC
	2KZpAcrBOkWbOC50ID3UnMa1yn8ekqfrZbtLFw==

Patrick Steinhardt <ps@pks.im> wrote:

> On Sun, Oct 25, 2026 at 09:17:31PM -0400, Jeff King wrote:
> >          [...] But if you just intersect "N commits over all time" and
> > "has _any_ commits in the last M years", then you can get a table like:
> > 
> > total    | Active in the last N years
> > commits  |  N=1    N=2    N=3    N=5
> > ----------------------------------------------------
> >     200  |   17     22     24     30
> >      50  |   34     47     56     67
> >      10  |   71    104    124    155
> >       1  |  239    357    457    628
> > 
> > Those aren't necessarily perfect metrics, but if we consider them good
> > enough and just want to tune the parameters, we could probably pick a
> > spot in the table that has about the number of votes we'd want to deal
> > with.
> 

Ah, brilliant!  That adds, quite literally, a new dimension to the debate.

> That sounds very reasonable to me. Though I have to say that we
> shouldn't only consider "the number of votes we'd want to deal with",
> but also the shape of the voting population that we want to see.
> 
> I think it's fair to say that everyone has a single vote to cast no
> matter their seniority so that the vote doesn't get overly skewed
> towards the opinion of long-term contributors, as those tend to be
> employed to work on Git. But the other side of the coin is that the vote
> would get overly skewed towards newcomers in case we set the total
> commit bar too low. So picking the right spot in the table would
> essentially be balancing out the interests of oldtimers versus
> newcomers.
> 
> How exactly we want to balance that is a different question. I am of
> course heavily biased as an oldtimer and would thus think that 10
> commits is a rather low bar. So from that table I myself would probably
> pick 50 with N=2 or N=3, but maybe a commit count of 25 or 30 would be
> more reasonable as a middle ground.
> 

My argument isn't exactly the strongest but if we calculate the average of
`git shortlog -s`,

	$ git shortlog -s --no-merges | awk '{sum+=$1} END {print sum/NR}' 
	25.7022

that number does look quite nice to me.  So something between 25 and 30,
perhaps, for the commit count threshold?

> In any case, there is no "correct" value anyway.
> 

Very true.

> Patrick
