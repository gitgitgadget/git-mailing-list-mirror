Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A521E1A01BF
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 12:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726057809; cv=none; b=KuKjXq/qGi5WBRackN+Sk3gezaPSi7n3exKhtNNZv5TftVVbj4i3edy9777puQJtd+TOh325YdqdjIaMiGWrCpD7pGk8c6q0sS+O1L8AsqyWAFLLzYVjOib1HGLgFUc76pCeYhnjQitdAxI0mpqHRgShEd70Bgp+fBUF/D8ygh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726057809; c=relaxed/simple;
	bh=VH6+81DtBXHCQ6UUe15Z5xX3xlEXZEXrGZZS+MB1XMM=;
	h=MIME-version:Content-type:Date:Message-id:Subject:Cc:To:From:
	 References:In-reply-to; b=FKxzHzCCI971lGo3nJJViNcn+NKmdIIzqjbI4QVsWL19YiIhyDitrs0wPGehk998tbO3J+gFeaAFgMNRpE3nprS63zfRiukPjADhnJlWZUMw0euxVIn483TM77oSpebUmi3wqh8cOoqNgWp7MVqvEX6TG12axYXnnU6Zy1c7GIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=gY6bAku8; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="gY6bAku8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=d3w4lcp6YRgPvjl9ZsApB8LQp0rojlLXc1evaMaHn04=;
 b=gY6bAku86s4zDpiMx1fIsnzY0qo+LsWHRwcfDEeW6yqOZPwffrw7Q2l0PR5+hs9kvBSqzCs/M+HE
   9uCeKLQeTu/uPDnhUoh249lC08PU5EjcDFVFAzuPHZPP0XjCuUy0Cx7Bp4GFj6k5nWOfzu/YuteA
   4w3Q+ls7lR+lrELKeHKOnUwQZd0LbruXnOTfbtts6dgClK411ZcAM51IilRwD8El/iozNfW0hwzk
   zoUkoWX0lNFF8MMkHKQJ8Zdsh0p0uf1wNsYcT3Glb/zKdGKLSEpVhtEL+udjkRsSl9XR2Tz3EIZG
   1xRdGS4t/xHZgpXVzAWLr68TiqchwrcltKACWA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJN00MJIEHMAPG0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 11 Sep 2024 12:24:58 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: quoted-printable
Content-type: text/plain; charset=UTF-8
Date: Wed, 11 Sep 2024 14:24:42 +0200
Message-id: <D43GB8KUM7RF.3Q4SYKM4JCQ5L@ferdinandy.com>
Subject: Re: [RFC PATCH v2 0/2] set remote/HEAD with fetch
Cc: <git@vger.kernel.org>, "Taylor Blau" <me@ttaylorr.com>,
 "Patrick Steinhardt" <ps@pks.im>,
 =?utf-8?q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
To: "Junio C Hamano" <gitster@pobox.com>
From: "Bence Ferdinandy" <bence@ferdinandy.com>
References: <20240910203835.2288291-1-bence@ferdinandy.com>
 <xmqqldzzcfcv.fsf@gitster.g>
In-reply-to: <xmqqldzzcfcv.fsf@gitster.g>
Reporting-Meta:
 AAHBw3gR7SKEuVSaCj4IIMiHYIjgXeumVbnS+L5vBjbVex8nHwBHtsj5gikslSm8
 3u2oZ/bgIsTM0vEFTajsnYnyewXaWESMBNNcvALlf5A29mpttjHUnFVlyl7FAGt4
 O3NjKWi9U+0Lylql2BL3HVzjJFzV93Ek4zCL8vBGfscgZTxAqWRCAnun6gO5HOuk
 w3sDEbGXsjpEcgiFYZcWCOXf7VnfLNXF6HpM82v53aG/zuOAFQIjppoypkDrDXVg
 pP6iXhF6UimV4M+xloxRrrGYGW89nzWY0rwt7B8inyqcsY/H40xpvqO7Be4X25je
 Wg2aXprqyIjpZvQlJSUvff1qwCXCtEtPv/g9EEb01oNSOeOMBIdO9R7Mx7cP9Azx
 pG7lqIkBElxGBrLOYfh/xRTrNpsu8MnmsHa7lLPd5xR6CcCUKValHwNfRMh/ZyP3
 yBHPmm410pYguQDsZszyZA3qGXaY2/kVY6mfATswCP3Cew8d0ABJSK4N


On Wed Sep 11, 2024 at 00:29, Junio C Hamano <gitster@pobox.com> wrote:
> Bence Ferdinandy <bence@ferdinandy.com> writes:
>
> > What is missing for sure is:
> > - documentation
> > - tests (if needed)
>
> What change does not need tests?

Fair enough, for the next iteration I'll look into tests as well!

>
> > - settings
> >
> > For settings, my idea would be a fetch/remote.set_head that could take =
three values:
> >     * never
> >     * missing: run it only if the ref is missing, this setting would ba=
sically
> >       allow replicating the result of a clone
> >     * always (with the other patch, this would still be a no-op if it d=
idn't change)
> >
> > This would probably also require a --no-set-head flag, to disable an
> > always/missing setting. A --missing-set-head or something of the like a=
lso may
> > or may not make sense. Alternatively, only two behaviours might be enou=
gh
> > (missing and always) since clone already sort of does this.
>
> If we were to assume "always" is needed, then the tristate like the
> above may be a reasonable way to go.
>
> But as I outlined in my response to [1/2], I suspect that an
> approach without configuration or command line option would give the
> users the most smooth experience.  They are used to seeing "clone"
> to give them a remote tracking HEAD and nobody complained that we
> lack the option to "clone" to prevent that.  If "fetch" notices we
> do not have remote tracking HEAD for a remote [*] and stores what it
> observed at their HEAD in remote tracking HEAD, that should not
> bother anybody.  No matter what mechanism gave you the initial
> remote tracking HEAD, if you want to update it to something else, we
> already have the "remote set-head" command.

So I guess we did conclude that no settings are actually needed.

>
>
> [Footnote]
>
>  * One thing we MUST be careful about is that some remotes may not
>    have ANY remote tracking branches (i.e. you only want to use the
>    remote mechanism to give you a shorthand for URL, but you do not
>    have fetch refspec at all).  Even if refs/remotes/$repo/HEAD is
>    missing for such a remote, we should *not* attempt to create it,
>    as we are not populating refs/remotes/$repo/master and friends at
>    all in such a case.

You mean that somebody does git init && git remote add origin $remote, but
never does calls fetch? Currently remote set-head -a origin will fail with

error: Not a valid ref: refs/remotes/origin/master

Although if everything is done _after_ a fetch, unless I misunderstood, we
shouldn't be able to be in this situation at all.

Best,
Bence
