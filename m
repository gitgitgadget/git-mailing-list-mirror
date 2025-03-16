Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F7515C0
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 16:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742142729; cv=none; b=Sa5C6M8yTvUTTz0zt18R3cIn7yT8Wdk00+RHE8F0mX2eGg+biBeW9urdgQ53/J7FxnDwez4193vwPPceBSUeQlKB10V0e6NUM/y/57AAbebZPoUz1Ax1n30Z6FYl6uFRa87lOmyXq7Gvxf0dQRdF5gGxrKHkZjz4BHNXtJ4ftik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742142729; c=relaxed/simple;
	bh=4EDM/7Ndu+/dv/7QZnV+KYJeAFRIpWjtHh/sjaMduH0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=UYIqKdDv/fVCcuEhC2528ZTFfj133FL0yKNcFncodg6p4STjC1svXRb/H+5g+s50V17N70AekHKHiY1Sjnnx7dhZHL68w4NJO5329nlTMaN0Z9UMWl4XKpkG3Uw51ym9VxzyHZ73GGYfTWwtE3VOOoIHijcR+03WkmeLuRuW2gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=puVqbgnL; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="puVqbgnL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1742142724; x=1742747524;
	i=johannes.schindelin@gmx.de;
	bh=Qe84XlPoYrR1/FKfX7x1SP4+hbFvWC140mwPUsfiTg4=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=puVqbgnLEfN7WiNT9TuVAfkFPIv1a9CYUsVj2Fce2OQLnX/dXAIF1eRbxmuGrRAL
	 jOe5ah9v/i6k96DlXcaZ19q9SKaPZRGF5aAP4A0djk3TZYe/vtds4qT0rWj/RaG69
	 EtpWEMwXJtVQ376dhyGQ5wlC4b42ptR6QMcdxZeCwIMjl5riMQIpFuwg0ITUoPb3r
	 LDBxu8XHqwD3+rU8L+xMWZtpUEE6OEuXFy0QoVP7awIizyoLqvUAwpKFjqQZifNyn
	 P6s+rYnPpvxO62qYXVh1ph5DdQkPe9+iMhAIgn1TrsHJYFl6hZ1QwReKxUbETMorf
	 2Vs/JVZGlvCcUO0Peg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([213.196.212.73]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJZO-1tERso3I1e-00irNJ; Sun, 16
 Mar 2025 17:32:04 +0100
Date: Sun, 16 Mar 2025 17:32:04 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
cc: git@vger.kernel.org
Subject: Re: path-restricted log vs. subtree merges
In-Reply-To: <Z9WSbUQw4VBQiOqi@ugly>
Message-ID: <2d53bebd-e85e-7414-c7ba-bd1f31810cea@gmx.de>
References: <Z9WSbUQw4VBQiOqi@ugly>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vnK4AsYxW29n5BeDl1+Ud/sw9Ec5x+ekXHsWEOKyZrd+F3MDDnX
 /bau1mQzxoa/+sPiEEl7AzsU4HnRVb5cgqNM92O9Zo1NJXVL4rToQaOL3qB/YNqCThH3sk+
 gcK9jIAvji0Q7nwqyR2yfXo+Wv7lQGOvP/QDuAJhuZNZbldOMYrgjg9ILm9oXnEFmpQ4pSn
 1Ov2L21SyFSWnV9S49HKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Y9BjBFXKDiA=;LiNg99HcbVURcuyGD4EHUoDwyFm
 u3LSm1pypm/6CmcVWCa0Z8K7S9RB/eWEpOH43eJMDWeZwRlq2aI/zWkr2ER6aS/0zp97xgkVm
 bZ3QVC6vSJGsNfSwMRi3qrM7iYkZJlK50idZPsbBDjcUKFM4IAD/4siALkOD9YYQ91/pA0ivo
 IPv4C8xUY5l9Hr+5bJHrGM2AhVCDm3DsoFuV1BXAH8zH8WNtEtVfqN69O1IVhQBG55ZASGD9q
 xOHjdXxo6mhUwmCz+NlNeCYHQXFJbE/4dkH0A1DPLcAy4rtrzblRINbFYtWsp/yOcNJRhQgqn
 ryVQ1TsnW0D/hrg7/kpPF/4YQ/9lw6GjMKPH/3/Zc59fDGexc9K+R+peCRWx2biqrnUDvEJgV
 HE6HUTlNBzyLxKgJdevLJm5hNSiUknj9YVS/Dn8iM7WpfEMFbRVatjWTxSNZN9UAkR0vfma9P
 KnShfr19uY9hFnD5MoIWhFeQEs68c4W7lGF4Llz6UD3HheWcQ80MzNvrXNzMTrLirjHYpAOtM
 lL8b1pTavhDBqMw1IFzxXkHXCE/Sra3ULEpnEeickXsmGWc35zzTHJYm1iG/PU9Y02CXXyhKT
 EtC3+jfycmuFXhfJbAizzWfeNl7iR6C8xbV380yc1KR5g/Atj6FPRAOtL1UIx6q0iDRZTZUpl
 n+PwGCkPIlccgSKYv4WTNa+RbrIH1DOTc75O9HqW6EHorpnf5SEyI35PvmIDHXIe4PZOg21Y3
 rEaX5qxHToPm1fCz6TBtgraAzkB0tjN0Pb3gGhsjUp+R0QK3Wy+FCfjCb/ZkVwDF5lvZzhO6g
 7MqwUFb5HU0tOcQWU+Ck6gpsLFRRd6Yq1Ya5Kl6eJyGpINaTZtoy2tD1S8ErAy+XO4hM2n9X1
 ZyoTI6177h+7T5hOoZf6ce/A+d90lRz6EQxmnhvqA3bcTZltTBlRnOFQM1dYR3zWGXtPbIa7w
 ZRaijAe2USrfnAp8Q8CbTVMUVyHrtuUTf6I3st8uNGYiyQfQbOcvcWQ300SGWq+BTi3Wi70GP
 E6NkbNoZ7NjkAWwLbYcUiOx9w9NEMdauwe4mvV8cEmt4RuF6AhmYqCl18LuFbZ/Vdb9WoGwWY
 +9tj5xb9zZV5BCF05eAAN5JAmGMjCRR1s4SBi2CetFX72oTxFaSV2JO6upPGAb9/050XTrMec
 er7GyLGwlUSwiTzrNfdHU0mwmYmKb64bRv2qgil3n2X/4XdL2NZGaHTieR6SOKDZTYHwtyI9B
 b2g1P2anNZ9WCj88PIS6/vPoh0rg3QUWzSuSJGy8lxJwT9d5mT7Kp45oHAiM5IytQxqrLiOXx
 0q3NAxQSvE0QQ00OnsW7+zY2JavmmUrGIZ+ITG65HFgyDeYV4GJg0LFNAXR6b7cRpMW3XxWPd
 Fao2skOIp5SYzoecfkA7y2q7WMly71SF3xb8UUwsqNpkP+PSYvCZTh/VcFjZ1mGNGU6G/bqU1
 isAhlBKtMDnac2Vp4LCCsv9PHjmw1bUqEI8ewCk4QT1WZQets
Content-Transfer-Encoding: quoted-printable

Hi Oswald,

On Sat, 15 Mar 2025, Oswald Buddenhagen wrote:

> in my quest to prepare for hacking git-gui, i ran
>
>   cd .../git/git-gui
>   git log .
>
> the result is ... unhelpful. apart from a few commits that were done
> directly in the git repo, there are only merges. notably, there is no
> trace of the commits that are being merged (and the way gitk presents
> this partial log is even more unhelpful).
>
> i'm speculating that this is the result of git log not handling the
> subtree merges in any way, with somewhat predictable consequences.

That sounds highly plausible.

> i suppose there is overlap with the fact that --follow works only for a
> single file, which is also unfortunate. (a recent test case in the repo
> would be templates/hooks.)

I just ran `git log --follow --raw upstream/seen -- git-gui/` and it does
not error out, but as you say, it is unhelpful.

It's probably not easy to fix this.

I had a quick look at the relevant function (`try_to_follow_renames()` in
`tree-diff.c`), and my intuition told me that

- `choice =3D q->queue[0];` would need to be replaced with a loop that add=
s
  the `q->queue` elements to a `strset`,

- `!strcmp(p->two->path, opt->pathspec.items[0].match)` would need to be
  scrapped in favor of testing in a loop whether `p->two->path` is matched
  by any of `opt->pathspec.items` (because there would now be more than
  1),

- `const char *path[2];` would need to be replaced by a `strvec`, and the
  entire `pathspec` replacing could only be done after the `for (i =3D 0; =
i
  < q->nr; i++)` loop completed,

- The `break;` out of the loop could only be done once all of the input
  paths were accounted for.

However, the devil lies in more details. For example, I expected that `git
log --follow -- git-gui/` would error out because `--follow` requires a
single file to work. This suggests to me that the logic would have to be
modified to expand such implicit pathspec into a full list of files.

And I imagine that the performance of this new logic may be quite
horrible, what with adding a nested loop for the `pathspec` matching
inside `try_to_follow_renames()` existing loop.

Of course, the fact that Git silently accepts `--follow -- <dir>/` despite
the fact that it cannot handle `<dir>` renames at all is a bummer.

Ciao,
Johannes
