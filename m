Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.145
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792519181;
	b=ZlQS997RAoslHyGj73FNCW/6UiAyEcHi2qFty1STxhU5PNYknf+eLbhwO5ybO7P1bsgF
	 Rvmr3LfrBFGRwBsccn+YwAfybmS4HFV+vc/13Je9qKijuXehNrelgue3iqpzoVFjZQkxA
	 oxScwcO9Pfwu96gAhjvU3Tduf5If0zefirWL7vylAHZT17dUv3s/8FqZVNx6mZWuBl49o
	 GEYISbRcexjedDHB4ZjrJXdxocio83UMpb1w7/tUsjBun7NzubhFuJZqyZalMKAjXxeFU
	 xz1yBLlqa2NUYG0ELnWQDE0nY6vRRvf00JTSMJJGc49NGeYITIr5o+iZNX5vXEMxAkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792519181;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Content-Transfer-Encoding:Message-Id:References:To:X-Mailer;
	bh=1fsPz1FS02D6bSiiFizhpFmHbSqhFoJ1i4vBv1iqrRA=;
	b=vMUe/Hx9QWLcUslLXLCX3fRYP9UGEsdwpHSYCq1aUf+MfJ9a3VcRhgQx9SqbVIdbzLzX
	 +1wSqBuR+EAAY5/AMbWsZOCrFLWLSWWe7Y9ihFdBbm2jDlzKULN78aK9NI6wAU9PVumtI
	 DN3aU80LcUkzwxEnzcmSf9UYtokAVjOmCGkql/aArJ041Z9N8TEbhRXJ9R9HWsnb/PeST
	 4/Kek1mj2u1/MWuCBZv4U7tcHPvjDoUp9xlZ1BE2GMaf/OKFhjqkhBOI8595rvqD2oKQ9
	 U6k/m4+HXurFHL6ayUY3PEAhOCGvL1sxDTSP/BZ0v4CeYTtzSkgbvZ+hfkBsAawM2bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=jvns.ca;
	spf=pass smtp.mailfrom=jvns.ca;
	dkim=pass header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=FSt+IbjF;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RqKZl5ez;
	arc=none smtp.remote-ip=202.12.124.145
Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF08606A319
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 17:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DAF08606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jvns.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvns.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jvns.ca header.i=@jvns.ca header.a=rsa-sha256 header.s=fm2 header.b=FSt+IbjF;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=RqKZl5ez
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 3D6FB1D000F4
	for <git@vger.kernel.org>; Tue, 20 Oct 2026 13:59:40 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 20 Oct 2026 13:59:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jvns.ca; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1792519179;
	 x=1792605579; bh=1fsPz1FS02D6bSiiFizhpFmHbSqhFoJ1i4vBv1iqrRA=; b=
	FSt+IbjFfB0rzpD+yTCC0Q5Y1O7zY0JZZXYyfbjQUt5jkUIU2WhHpPM7EhylKQi4
	x1z40JfW3bbBgMvD8drbjsltvmZn9qUMXnnlJ9CVfsP/gyAs5uwjC4FmnRZLWak0
	itEyverkPxH/X2vN1gvGV7nvGYcwFpmF1RzoO7+t997kuDF+W4wO7CHiksCFY0Io
	2ISnQtxt+H9NnJ5yHyOCwQfN7ZIGncpeIwMy8GXgr/gKvZLyp6FFnv7NBpxa8prw
	Bysh8vxwdDFThrCYQRkBvDMSxsy8x/xClBBfmF9s6tHICwOv2xuqWju6wK6RaZYh
	mCM+LL9jOPeT8+8nCDlAIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792519179; x=
	1792605579; bh=1fsPz1FS02D6bSiiFizhpFmHbSqhFoJ1i4vBv1iqrRA=; b=R
	qKZl5ezonaQLpYzSfxqp+a6vDF99125XBRHAMecnlxGet1G1jyz8N7FRnDJ/m0no
	rLeamUZWbUyyvGjgtV9at3vT3LXF+fpW/BNFYgG2mLGgKNN0L9FvgnHFKNZGRfDv
	/FwOfCWhYX/URDFtfgyOwNlLB1Py5AaSZc86Vvs6au0tcoGcnxN9ZqPRBVBxecwo
	7zRLS9KIVIhouo7KiyNHz2C6o/ssR4ZgTHciiGD5c/UdF5H2ot9skz+wI0zJoGip
	+ddDkYUAXj+q5XYXhwEvtTXGsFpC6MlOm37HuVxeRFtGVUhUPBI3mQg1//NducBO
	yirQerUxpIPZe5gNrsB/w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=sign d=jvns.ca a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792519179; d=jvns.ca;
	mf=PGp1bGlhQGp2bnMuY2E+; rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:FGdl/un9bwQti2C/hjBlUN3qCvKb0UCRqOF97kKYfHpAZvI
	jXeG4PwdRCXOa/ld6SLtUWpidgsHZMMN9rB2RfY0seHEoAW52k0GYhrTxiAn8xfW
	Qf2tkzb1gkcoebszy4Xots3GhivEjKQEdGeRMfTRbxExLghHMVdO2ahRhXbKfSNK
	SP1LYZYCvoKSGtu3cClkNqf7ou2sonR/ksRpii6TuMwOF6l77jpT0YDYY8CtNrDU
	TxLkEiJxH2OcMwbsMYydGGCsQ6vzLnMsnTV8modSlUyZgvqkG3wl6aHAK9dvhjd8
	VxyESIyWg/NN+5rdgyyY+i9ygL7r4ZTPxXHYjhA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-08; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:C3Fyq7D4Q8YK6/1iD8z/puegdIIHwb3rPZ8mSBuJ6Co=:TaYGmZm/c0b2bWNUsfAwyu0kngwZOvahLIeUpdvYbDc=;
X-ME-Sender: <xms:C6zXaq6j1s5pY3b_G44IU9fQWBWTROmXzVIXiupiuI0S5SCy-OMpyQ>
    <xme:C6zXarX8q2Lhd746j7gfeuNu5s4aJZTP8ft6LHjiZBwgtmHSOvYnAvsJvYpv3GKf_
    5Qj4RdUYGgae39ZWXecyxyKoDHLEy8JgQfRkhrDqJ3WuTUGm7wrerFYPg>
X-ME-Received: <xmr:C6zXam0_n6nDwA0_2XbLhzYJ2vv8m3-1I_p-cw8ZKosRc4g5AWR-l7e_HCBScmDaHpvb-VWebfyh5o_LJS9RoWC_hanWkWY9aHJM5n3_PuFl5NM>
X-ME-Proxy-Cause: dmFkZTE725CciBU9+4QJdaVuqKS2zzypb0EUngksqhdZsd9PmThGDdk+uKRnDVr/cdfx5Q
    QWffE4d8CiKGdk/hjKPeUrH1wyatMT0vIBEBYUdSnCPcEwvNd5+Nx+iG1NNTgXy6Yu3Q61
    e1mCcvCMVfIdhcyY0chA5763TLSvHlfw94jTsT3wlvGRv+vnGWM8JHcYNeDHGwhd6mk9Q3
    mjlPFqlo5LUM/Ce9uKD8uBs3tKz5TQHIcu9A9RO4RYif8QmkGNEiXg1/Z3DtVla5Q4cqDp
    6wKRSKF7ld6ZaD0Ism4J9658iRlhNtkaNLjcbYrmHzwSM3eK8ywP7TWuqC/aQ14CZGciLv
    dZ4Pb8dKm1ibjRrm8QgZWF56iuIjs0WsWK8zgrOmWaVBDkas8BKCr2eEx7WmjUTLVbtvN0
    Q/9MaGDs//tdFTzO9V8Tr6Rr2xPs/zQPifZptd18VePp8lUDOxYt0dVT7Wi4abj0xbpG3M
    T323VNRjCcCGML/SKQK+1COpQngXGRyNeLyBIIdpPgtarAPk5BtNB/Z+ZvmDWOb+ri+Yto
    NI6lzCk+zTaUh0QzSSU3R8lw2US2jvHGf8z/H1HA/bSDhEiUisiEQwFzmcTjYdWxrqqPHm
    aHF6KU2MV+2EYl4IxUHa2cSA3G64+KNP3G0l/06u0eHXFDkVWDkRvD4/pFgA
X-ME-Proxy: <xmx:C6zXag1zEDPRyOpNIjsCvs8-2Rvna5vajACf8ymDWkRZKER3CMqGJw>
    <xmx:C6zXah8mvEVwwHkmVGPOse4Ka9nrVAj5MnbOE-NwMIr3-TltgaZoxw>
    <xmx:C6zXal2WgczHDaHpo2PEzy7BKqQIY-hzK85x_S_Fucnzlp3UlXFqrQ>
    <xmx:C6zXam-d0zEpbnIHKu4l4o72FXhStjT8G1MrY5ou6Wan4ZwfHbvuxA>
    <xmx:C6zXajW7G43F9Qwdk8PW7uUWrKO6c91Bhuvl2dmWeeLRLp3BkPTMsioC>
Feedback-ID: i2aa947c3:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 20 Oct 2026 13:59:39 -0400 (EDT)
Content-Type: text/plain;
	charset=utf-8
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 2/2] doc: add new Git tutorial for beginners
From: Julia Evans <julia@jvns.ca>
In-Reply-To: <xmqqzew8wb3g.fsf@gitster.g>
Date: Tue, 20 Oct 2026 13:59:28 -0400
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <CD1E58AB-4884-4433-9AB8-460FE9A882FC@jvns.ca>
References: <pull.2248.git.1791315422.gitgitgadget@gmail.com>
 <41dca2e8e0c5fadb8ad9ed8707029356e56cc540.1791315422.git.gitgitgadget@gmail.com>
 <xmqqzew8wb3g.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Oct 20, 2026, at 1:11=E2=80=AFPM, Junio C Hamano =
<gitster@pobox.com> wrote:
>=20
> "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:
>=20
>> From: Julia Evans <julia@jvns.ca>
>>=20
>> This tutorial covers:
>>=20
>> 1. Creating an empty repo with `git init`
>> 2. Making commits with `git add`, `git commit`, `git diff`, and
>>   `git status`
>> 3. Pushing to code to a Git host on the internet, including creating =
an
>>   SSH key
>>=20
>> Signed-off-by: Julia Evans <julia@jvns.ca>
>> ---
>=20
> The goal is well described, and overall the tutorial is well-paced
> and avoids common beginner traps.  Since Ben has covered the text
> fairly well, the remainder of this message has just some leftover
> nitpicks.

Glad to hear it!

>> +Step 10: Create an SSH key (if needed)
>> +-------------------------------------
>=20
> Even though AsciiDoc implementations are somewhat lenient to allow
> difference by a char or two, but the number of hyphens there must
> match the number of chars on the previous line, so add one '-'.
>=20
>> +For Git to upload changes to another Git repository, it needs a way =
to
>> +login to that repository. One of the most popular ways to do this is
>> +with an SSH key.
>> +
>> +If you don't already have an SSH key, you'll need to create one. On =
Mac
>> +or Linux, you can check if you already have an SSH key by running:
>> +
>> +-------------------------------------------
>> +$ ls ~/.ssh/*.pub
>> +-------------------------------------------
>> +
>> +If you don't already have an SSH key, run:
>> +
>> +-------------------------------------------
>> +$ ssh-keygen
>> +-------------------------------------------
>=20
> It may depend on the system settings, but doesn't this by default
> still create id_rsa.pub?  I wonder if we want
>=20
> $ ssh-keygen -t ed25519
>=20
> so that it will match what the users will find in the next "Step 11".

I thought so too, but openssh.org says that the default is ed25519 now:
https://man.openbsd.org/ssh-keygen.1#t

=46rom the release notes it looks like ed25519 has been the default=20
since 2023: https://www.openssh.org/txt/release-9.5 .
I=E2=80=99m not sure what the default was before that, though I also =
thought
the default was still RSA so maybe it was RSA.

I=E2=80=99m inclined to suggest that people just use SSH=E2=80=99s =
default, since as we move
towards post-quantum cryptography, openssh might change its default key =
type
again, and if that happens we=E2=80=99d want folks to use the new =
default instead of
going back to ed25519.


>> +Step 11: Tell the Git host your SSH public key
>> +----------------------------------------------
>> +
>> +First, find your SSH key like this (on Mac or Linux):
>> +
>> +-------------------------------------------
>> +$ ls ~/.ssh/*.pub
>> +-------------------------------------------
>> +
>> +That will output something like
>> +
>> +-------------------------------------------
>> +/home/alice/.ssh/id_ed25519.pub
>> +-------------------------------------------
>> +
>> +Copy the contents of that file to your clipboard. It's important =
that
>> +the filename ends in `.pub` ("pub" stands for "public").
>=20
> OK.  I hope users won't paste the ls output above instead by
> mistake, but perhaps giving a command like "cat ~/.ssh/id_ed25519.pub"
> may make this step harder to make mistakes?

I=E2=80=99ve put it on my list of changes to consider

>> +Then login to your account on the Git host you chose and paste the =
SSH
>> +key into the appropriate place. Depending on the Git host, it's =
likely
>> +under "SSH keys" in your settings. If it asks you what type of SSH =
key,
>> +look for something like "Authentication Key".
>> +
>> +Once you've done this, you're done! Git will automatically use your =
SSH
>> +key to try to connect.
>=20
>> +Step 14: push your changes
>> +--------------------------
>=20
> Upcase "Push your changes" to match other steps.

Will do, thanks.=
