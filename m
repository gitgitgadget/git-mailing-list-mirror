Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.147
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793001484;
	b=GJEykErselqMXAOrUq0lfBOXVOejobkeameUQSJtWwlNPlFoP5pr5+pIv2orjAJmKZLC
	 3zxsfKn/YuXzKdowkwAuSGGW/N9mX03nJrasXq7OSkDiuSSbyC/K+E9bpPYdlb3pGd74w
	 ZEnugsxpXiQx4VedRZPYcqcbTqYeo7+TZnqJXI0QpMgYca60PK5ADog9gRV3b6iFMKgb/
	 DwA1yTaFFA7QBSbRJ9laSC4Ri2wlcbji0mhx1dypPUh+1tK4SDmB4/SUgoEBekBnzrI2V
	 eJd1aIJH/VsMI5lTkQCdbwA5lcBALxgY9HLZp6+GcMfAj+HqRdnaOQp3xcnGTmT+ybQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793001484;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=LUVKDsDqKDrJclq2TPPAN+N76Fg6XC5gSP261YB7Ufw=;
	b=iy8tMhdeGJdzvcfmY0alVIk+8JWOtKyO3na9RSHpHd3biIRVDTk7ucMXV0WDLSpKrGn8
	 0aCPdvTfRjjmQ+OEq+0iQF4HtKAqe9fOTDGWvlfjJ86KhhzYKIALe2L7ROU6STYxmHYBs
	 1V1USXaJ2Ql+s60bZA8NQlYOVmekO+oEdLirN3DrwOKZBsOWG4423JWMpj2L8Zv8phX7J
	 yy13wI35hLoSJMdLzGJuq6xFLxaqJcWh9YQGmh+oya27WRbOJHehZCe77ViRHFziqwnmS
	 AY0N4iOGpfXqLNJoUkWbAQUe9Z2SlKxkqr0O+U27GK3B9i7ZiUU/2Vc9xDdAf4bgiZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pks.im;
	spf=pass smtp.mailfrom=pks.im;
	dkim=pass header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AHiuxINN;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZsjCNBpV;
	arc=none smtp.remote-ip=202.12.124.147
Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BA7606A31A
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 07:58:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21BA7606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=pks.im header.i=@pks.im header.a=rsa-sha256 header.s=fm2 header.b=AHiuxINN;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZsjCNBpV
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 620F41D001EF
	for <git@vger.kernel.org>; Mon, 26 Oct 2026 03:58:03 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 26 Oct 2026 03:58:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793001482; x=1793087882; bh=LUVKDsDqKD
	rJclq2TPPAN+N76Fg6XC5gSP261YB7Ufw=; b=AHiuxINNg6hV62FqmiPCYlPfHZ
	FdEbtV0e7mn6NM1XVrl2Atnw+vTQizguwX6nTPxkn2SpHbPativp7XKUXDNn+TLB
	3NcxrThNKmVtgKB9ORfMIeVT2bDBir6vl1rubjtKzU4wsjqb1S6HIBdNQg8FdLvn
	RbskvdnzSHFVQcFrcfRdY632KvLGXE7HF3/OAhi9JkNbCOpOmAglL6hsAfcwu2Ci
	XNYqb/9W80q+OEzKj97FmYsGhGp9ANOIwNI/hF/ruoK5X/BljH2mWC7N7xkRqscr
	9yZUHeYrwEyuH5Kp9Wy5KOobRN/rKt1hMt3pGfMC/ulxcJfUWX99qopVWDRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793001482; x=1793087882; bh=LUVKDsDqKDrJclq2TPPAN+N76Fg6XC5gSP2
	61YB7Ufw=; b=ZsjCNBpVN6ojcNPLw+Tahx2W4hf/HcYtOs27DSpeyF3W3KmGb/h
	V83mBLR67PeiEXXiMqd+hPKh1jNJcaeeCPJfAr/jxygzB/6cvdNAvzDx/xOKQpw+
	G0UMM6wW9+Ju9/JyhBNoMy4NxcAo2s2m3LBWyH+llkbX1o7dbKx9xDJ4gg5icQa6
	W80p5yDTS/io67gCmMM3m0fv7ng+hefNogWmJapc0LwB8Znkoi93k6hFmiVjqVGx
	fOEOA1qbkQjGhTRjgNQNrp0A1X3XH9xHkxRbLAwRk30MZ1aLM0UrGaRWjPuzh1Xs
	O0m1rtgFYYJ1duWmj7O1KdM+n0EpS3kdjFA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=pks.im a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793001482; d=pks.im; mf=PHBzQHBrcy5pbT4=;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Xh7c58x5xhKkLqP00DgOMuYW2G4qoQVxS26kR6xJHA9dRB0
	bHmm7//jQu/33I3ZEyh0Guj2j+cnd3gHe9sN08KB8mGbdIZS/ZklYDGUPUVScQ0g
	B/B/fz3Z9X0/PJO6MEpPXeZdWtqMGBv6CZwkx8b1DDlPAbQrQwAGlBpD7gRB+GcX
	SZbNHZzZORTeUshjIk4gKwtZboU+ZU1eefHlsStO4IlAdLpY2x1xbJVcNhiYn1AG
	XKLkgYqXp0zIYn6dB+nAeUS1qeUNyr1RWGkCZSc+6+lE3us9xvrQ39Abtbkt9oiB
	FejbNG+U+LjzaJW+ZaM4IHnhaARmFeyaVgiA6lw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:+vcFCyzqB8qILLu/KdQixp8yvgVS2c2VMM3xp+1QaXQ=:8i8kaRF7NVfdmBp/mXgsWCo+Zmig058PdMSPwCR5qRk=;
X-ME-Sender: <xms:CgjfarPi2MoL3LbkLSIkGV5M6F38z_NaahQSVFMsmZohKY0IMMc31g>
    <xme:CgjfaoNc12_nTmpccKs4aNAGmSgrA8auE8Zqe5FAUn0yd1oF6cqtHzVQMclqlet3A
    dpULBlBqTECRInc3wfFKePjgkYoId2cWvnv8SM-BbXcXAW7FZYvERc>
X-ME-Received: <xmr:Cgjfasjx1-ngeeru2F_Evr6aAm1Dcy1A06STclD_T2Wm6bJhFi5DQA>
X-ME-Proxy-Cause: dmFkZTGMO4lG8K98nOyVR9Meq2oa1yfo5g2w2Df682L4fsPSyDT1oi5bre6PhA6UDerULl
    UzeIU2oNz4bRk4QaU/UpKYURdXoLW1E2JICYecuC5R0h165uR4Ohh+Ae3OrGZRdyZQPtmX
    M8cVMwGubUzy2XphiXIeV9f4GB1eIE2BeG3Bwu7bwPE6wg3PWNV8pG6w955GaRBkaUd60I
    aEgayZIP+j0WmVFXMj412XcppaS44wjKqR4kNXyM1lwFGytiNfNSC3gEnkQsaE07zEwLMh
    9x4EmTZc+tzKGdisHCYLhfeS+DooAn+Cw+B/R8i9wYEdsMeSxfo55vB1ePZY/uIvVUguT0
    3GZ4v3PKvN4S/cB4Qt/ejQJzXPVFtCRrpnTgnWhSgvwjUXW31pUtAcFKp2esca3DJXEukw
    Gj7wxvCc4yZVAkwNjlgIFdnBj+fOmLP2e+VWm3sWVEHoGoKkVZsdhjZMdBY8b0ViIqFkNq
    Z4XCPPAuBCsn/4cJq+djQrZv2I4PyMFfVd8nEbhpFiDgZrQaR/hZCvAsSIOX+PznehFzH6
    /5DeS9PnmlIizkh1Aee5IbbU8qOzPEeNPMnc+T5Y89Y+7m3o6lY8TnWLWLyAa3znX2YlhO
    PNzn/uXEoyGBZ91/a/xU4zbKQtRHElgC1TRsbwyI4o7CbfWzdKt0Z5fpAxDA
X-ME-Proxy: <xmx:CgjfalsQO3f0UUm_gDs43ULlrnV_ZVXthkSXSkudAKYT4QtMaT65ag>
    <xmx:CgjfaiSNcBp20YUblKYfuLlrkzxckyF_NrCcLKVNZHV40loCPNQnLA>
    <xmx:Cgjfah3QNwjUujrbo2Cd1GQQMHDrt81RuQaeF6lOufAieTINCWwIeQ>
    <xmx:CgjfavsFVBncfO3xeHGL1hfp3LlP-6LrtG_U_U4BG9NsE_YBXKTMGg>
    <xmx:Cgjfamz2DZylm2_52fGGdra2wqHCg5M5kEuSNpiD6iBF2Nn3GBp59IpR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 03:58:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b0063232 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 26 Oct 2026 07:57:59 +0000 (UTC)
Date: Mon, 26 Oct 2026 08:57:56 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Tuomas Ahola <taahol@utu.fi>, Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Emily Shaffer <nasamuffin@google.com>, git@vger.kernel.org,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH] Documentation: propose community voting process
Message-ID: <at8IBMQZtJP3bQ9-@pks.im>
References: <summit-2026.94e33e9ddf234334.06@ttaylorr.com>
 <20261021200341.378978-1-emilyshaffer@google.com>
 <CAJoAoZnhc6Tjm9m9dmTA6UD18HzkxAv2_ifB5x74ectqX8YieA@mail.gmail.com>
 <b36dcec9-ad9c-4ddd-b3e1-e246d2fc093e@gmail.com>
 <xmqq4iedc99a.fsf@gitster.g>
 <20261024111856.8s8qu%taahol@utu.fi>
 <20261026011731.GA3575069@coredump.intra.peff.net>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026011731.GA3575069@coredump.intra.peff.net>

On Sun, Oct 25, 2026 at 09:17:31PM -0400, Jeff King wrote:
> On Sat, Oct 24, 2026 at 02:18:56PM +0300, Tuomas Ahola wrote:
> 
> > Junio C Hamano <gitster@pobox.com> wrote:
> > 
> > > [...]
> > > I previously mentioned "topic count", but commits are far easier to
> > > count.  So instead of requiring two topics in released versions,
> > > perhaps requiring five commits would be easier to implement and
> > > explain.
> > > 
> > 
> > Quoting the summit notes:
> > 
> > } * Emily: Have we used a voting process for something like this before?
> > } 
> > } * Patrick: We need proposals and a vote. Who would be allowed to vote?
> > } 
> > } * Peff: Active developers with a track record; perhaps a threshold such
> > }   as 50 merged patches.
> > } 
> > 
> > So it seems that Peff's proposed threshold was substantially higher
> > than what has been put forth in this thread.  Any comments on that?
> 
> I'm a bit behind on the list and haven't been following this discussion
> closely yet, but I'll just say: the number 50 was made up by me on the
> spot. So I wouldn't read too much into it.
> 
> But if somebody is picking a number, looking at "git shortlog -ns
> --no-merges | sort -rn" may be interesting, just to get a sense of how
> many people we are talking about:
> 
>   - there are 44 people with >= 200 commits
>   - there are 133 people with >= 50 commits
>   - there are 439 people with >= 10 commits
>   - there are 2388 people with >= 1 commit
> 
> At some point it gets kind of unwieldy.
> 
> I saw proposals elsewhere to cut it by time. I think "N commits in the
> last M years" is awkward, because there are people who have been around
> for a long time with steady but slow participation steady-but-slow
> participation. But if you just intersect "N commits over all time" and
> "has _any_ commits in the last M years", then you can get a table like:
> 
> total    | Active in the last N years
> commits  |  N=1    N=2    N=3    N=5
> ----------------------------------------------------
>     200  |   17     22     24     30
>      50  |   34     47     56     67
>      10  |   71    104    124    155
>       1  |  239    357    457    628
> 
> Those aren't necessarily perfect metrics, but if we consider them good
> enough and just want to tune the parameters, we could probably pick a
> spot in the table that has about the number of votes we'd want to deal
> with.

That sounds very reasonable to me. Though I have to say that we
shouldn't only consider "the number of votes we'd want to deal with",
but also the shape of the voting population that we want to see.

I think it's fair to say that everyone has a single vote to cast no
matter their seniority so that the vote doesn't get overly skewed
towards the opinion of long-term contributors, as those tend to be
employed to work on Git. But the other side of the coin is that the vote
would get overly skewed towards newcomers in case we set the total
commit bar too low. So picking the right spot in the table would
essentially be balancing out the interests of oldtimers versus
newcomers.

How exactly we want to balance that is a different question. I am of
course heavily biased as an oldtimer and would thus think that 10
commits is a rather low bar. So from that table I myself would probably
pick 50 with N=2 or N=3, but maybe a commit count of 25 or 30 would be
more reasonable as a middle ground.

In any case, there is no "correct" value anyway.

Patrick
