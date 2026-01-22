Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C619634847A
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769073996; cv=pass; b=RG/khiYpQUmg6iIl0SeSXqj+CtZeAk0fqkFbMFj/WED1pe2CLifff3T+tdkLZxae8TcrfjPnurTRcZ2LfPKaDOn9ezl1BoxvdUS+Pr7TeH3uklMEJGusU6+W2GcJXPMb3Ex9nAp5YP45ML+pCEcPKg88XqU5ULE/4P/5vEqNDoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769073996; c=relaxed/simple;
	bh=7GqUzHY8gE5Stjg03h+lYN2MZbzg+nhbNpkXRriptuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SFmwGBof/MNOvqQULO61F+wArRgSFmA9r2QbjyW6GS/qntLoHay+AIyRQ1VF65B+xFESMkW9dmMXrh43T8RCtmjKB+0s+lw5Egn08eZiEzeI0azuU+JKwX6iHVwHZ4ikPE/S52SGvAyLwwP6R0jTxJfGJPsUCNc+ZZdWwVHtCh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=DEuzR3wR; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="DEuzR3wR"
ARC-Seal: i=1; a=rsa-sha256; t=1769073981; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JiVbYTm3Qc2pov6X0w4avtBofH/cPzTC/0ARhf8wzGFwkoIWnd1o53nDXNBbV5kh7zKAHqMr6yLT4GBybzm3km6seiEoOIL7n86G+3vr+Hb6o4ybVjHK/nGPCyjP89oxNizVCisW1WhNkn3JRWl0N/1kEuIOzT4zOfU8T5rykvg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769073981; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=7GqUzHY8gE5Stjg03h+lYN2MZbzg+nhbNpkXRriptuk=; 
	b=HV9B7cyBcrjvD05lD9LG2JKkkrc+9mpVPoxJY2jKEhpGTbPJr/hi2bTKgynS+6zLO7Kl2rPMLO8C3GMFniOOHylkQTYsV0RZSeK5kQjFywzQP5ADyldxJc9QxVacpp3hlTDrxkON784+XaM2+rCNYXqTZIItEMR2pLHjo1Dx3k8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769073981;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=7GqUzHY8gE5Stjg03h+lYN2MZbzg+nhbNpkXRriptuk=;
	b=DEuzR3wRI7OhMlOYU3b13O4eKCk0FeQ4sjxHUNlVv4DmTJTXhlBZNxncWZ3Y+lUT
	2IcHkqJaUY9MXcyV9Zpc1O8gwaY71THys86Yafc9UDaObDvoKKjfHlRkHel51+NyJvm
	7D+zO/mSHnXlCjTj8K4IQ+LdMP1Bu96cI6IG54No=
Received: by mx.zohomail.com with SMTPS id 1769073978959449.31641373575223;
	Thu, 22 Jan 2026 01:26:18 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org, Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>, Junio C Hamano
 <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Josh Steadmon
 <steadmon@google.com>, =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason
 <avarab@gmail.com>
Subject: Re: [PATCH v7 11/12] receive-pack: convert update hooks to new API
In-Reply-To: <376ae697-efcf-41f9-b92d-e62ca12a77a2@app.fastmail.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-12-adrian.ratiu@collabora.com>
 <376ae697-efcf-41f9-b92d-e62ca12a77a2@app.fastmail.com>
Date: Thu, 22 Jan 2026 11:26:14 +0200
Message-ID: <87cy32q9qh.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External

On Wed, 21 Jan 2026, "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.c=
om> wrote:
> On Wed, Jan 21, 2026, at 22:54, Adrian Ratiu wrote:
>> The hook API avoids creating a custom struct child_process and other
>> internal hook plumbing (e.g. calling find_hook()) and prepares for
>> the specification of hooks via configs or running parallel hooks.
>>
>> Execution is still sequential through the run_hooks_opt .jobs =3D=3D 1,
>> which is the unchanged default for all hooks.
>>
>> When jobs=3D=3D1 the async muxer thread reads the hook stderr and writes
>> to sideband 2, so run-command's poll loop is avoided and there's no
>> need for ungroup=3D0 when running sequentially (Jeff's suggestion).
>>
>> When running in parallel, run-command with ungroup=3D0 will capture
>> and de-interleave the output of each hook, then write to the parent
>> stderr which is redirected via dup2 to the sideband muxer, so that
>> parallel hook output is presented clearly to the client.
>>
>> Suggested-by: Jeff King <peff@peff.net>
>
> I don=E2=80=99t understand why the new (in this round) trailer is here. W=
ouldn=E2=80=99t
> it be better to put it before your signoff? Now it looks like Peff
> suggested something and then Emily and =C3=86var signed off later.
>
> And I don=E2=80=99t know but `Helped-by` is often useful here. This is an=
 old
> patch that he improved. To me =E2=80=9Csuggested=E2=80=9D suggests that h=
e proposed the
> idea for the patch or something.

Indeed a "Helped-by" before my sign-off seems the better fit here.

While at it, I also noticed I accidentaly reset the authorship on this
and another patch when reworking on top of the new design suggested by
Peff.

Will fix in v8. Thanks!
