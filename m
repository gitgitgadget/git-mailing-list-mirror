Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD621F463E
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763386635; cv=none; b=mfMB82F8CQCiHG4LiPssW2aPXUxpST2LxDcXIWjeX4l3HZQJa7lYJ/kgq2B7fvizCQAdyxmKZqeLf5Z0BREmiiEB+doB+1cxsytQR9yBH8rWuVRh0XO9WSRi3WPryPtCwD9BTXibbTDMW3wy51SAh62zzh2BHKMkwkwaZZ6PbxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763386635; c=relaxed/simple;
	bh=T48N2urfu76uVu99W+T54n92G3cBtZLAo3fWOpmYWhY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VGNomYuYRxbffZ2j31v4uRm4sru9a+hIBJeAXlfh/FBGX8Xp7/5SSjOcSgprJfNykTztu/79rxYy2nEQSVgX8uq4wlyKNMMZ9bKzDIe6N1LZMt++mkf5CwcfMGylxwX0xaGV8Typ+iwKpUHEYQYwK8gL0Df/pi0kzGSfRQ9sLc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=nHyGLpEo; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="nHyGLpEo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1763386624; x=1763991424;
	i=johannes.schindelin@gmx.de;
	bh=a35MMDj2TmgvwOkjFDirE6BCs13wht/vkDT8ReZnX8U=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nHyGLpEooKtm52ZiHs2aEcrIO/P6AFCRcqQBMQGtAENfxXE7sQkP4lh8auxKpYOk
	 Lu0lEX5EN+CMgKvvQezpAZYteJ7F3I86p1HHmD/wxwXRSRD/EGkbVShzv1vHIpC+k
	 f2FeDtqqNh7/o5niEaSoWBNHvFgWW6KZeKRKkftwtRSWo9oCVMvH/NsG+WtZo+8/B
	 b5sRtU2f59Fb+U6/J5+GYuoKYToUK2XZ/FxtgaperGNu1yGIQPNJ9k8zGRUSBL5KV
	 U6azy2l6MozAWZKEaaJ1rO2HhPBi1BKQCzUUoJn19DGbpQkJib+cmEb4xyeI8VmWU
	 KNVO+USKrApnNA/CaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.224]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N3bSj-1wJw0J1fwx-00t0xx; Mon, 17
 Nov 2025 14:37:04 +0100
Date: Mon, 17 Nov 2025 14:37:02 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: phillip.wood@dunelm.org.uk
cc: Jeff King <peff@peff.net>, 
    Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, 
    git@vger.kernel.org, Elijah Newren <newren@gmail.com>, 
    Ezekiel Newren <ezekielnewren@gmail.com>, 
    "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: gitoxide-compatible licensing of Git's Rust code, was Re: [PATCH
 6/7] xdiff: conditionally use Rust's implementation of xxhash
In-Reply-To: <ea27273a-378e-4f75-90f2-6615ce297a43@gmail.com>
Message-ID: <51c8c538-4baa-02e3-c8c2-4004626efd59@gmx.de>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com> <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de> <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
 <9818dc92-3569-3e6f-0252-245c2bf0bf84@gmx.de> <20250923174825.GB1136654@coredump.intra.peff.net> <bfaaf26f-5759-4812-9057-b3e0bf7c7949@gmail.com> <20250925022555.GA3202669@coredump.intra.peff.net> <20140030-6bf1-4393-a941-bfdbc69c79fb@gmail.com>
 <20251003031805.GB6381@coredump.intra.peff.net> <ea27273a-378e-4f75-90f2-6615ce297a43@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:c4npl9FMaC2ePpgmjKuwXRFG2EAODSCxpEh6pklxwK8IOonqHsW
 v6OKpFFirq511dkWqiSm+o9LlmW9K413Qlx7KfDdOIYLLAjd/GvjB9NCNlmsI1z8s6TZJ5G
 /D9+CHtIkkRd8kcMCVgWH8qVkdEMXaiU2uE795x3t6dR04VDav8eK4OpAaURHuTj2rvXnT1
 fazhBBVxo5TwT/2S+ih2w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:x2x/ClF/Wyk=;oidnqUd5skZPEVABa/orJjN7Pgy
 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
Content-Transfer-Encoding: quoted-printable

Hi Phillip,

On Fri, 3 Oct 2025, Phillip Wood wrote:

> On 03/10/2025 04:18, Jeff King wrote:
> > On Fri, Sep 26, 2025 at 11:06:38AM +0100, Phillip Wood wrote:
> >=20
> > > > If I understand the suggestion correctly, it's not to license it
> > > > specifically to GitOxide. It's to use a permissive license (like G=
PL
> > > > with linking exception) that would make it compatible with other
> > > > projects with similar licenses (like GitOxide).
> > >
> > > I was responding to this paragraph in Johannes' message
> > >
> > >      Note the exception? For new Rust code (and of course excluding =
code
> > >      that has been ported verbatim from GPLv2-licensed code), GPL v2
> > >      could be used with an exception along these lines: This file is
> > >      licensed under the GPL v2, with the exception that it can be fr=
eely
> > >      used in the Gitoxide project.
> > >
> > > That suggestion is pretty close to what libgit2 has in its git.git-a=
uthors
> > > file[1]. I'm not sure how practical it is to special case just one p=
roject
> > > though.
> >=20
> > Ah, yeah, I may have misunderstood the proposal then.
> >=20
> > I don't think that really changes much with respect to my concern, whi=
ch
> > is for existing code.
>=20
> I agree it doesn't change anything with regard to that, I think it just =
adds
> more potential problems.

While we were discussing this, the decision kind of has been made already:
https://lore.kernel.org/git/20251027004404.2152927-1-sandals@crustytoothpa=
ste.net/

This saves us the effort to discuss the benefits and risks of opening up
to collaborating with e.g. Gitoxide (or with Jujutsu, which most likely
also would have preferred a more open license), at the expense of closing
that door gently, quietly and firmly.

Ciao,
Johannes
