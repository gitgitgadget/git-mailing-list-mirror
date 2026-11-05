Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793840157;
	b=4dTj+5NpgzsWhHVl3b4f4IfNN+JziW8x8wUTyH9qgeXIv9iAoW31iqC+cUMKl/lXsa/7
	 8G8BaTDuLRbgfPmPTv1/Zsug5oLKHjfd0CCB69CJt8AyH2ZaRKpFXnWimAgMXRqEnAosM
	 WfZvwvuiy/1ICp33386efTafDtV7V/AdGatf03xgbZWzOZChfBi118qZAeQ2kamCvfedY
	 1KxCmsqk7cc0RDkOU2CpD2nYa8emF5crXzPNVu5xE6TvMurJKt7lbHnLt0WoyMkpEJCoK
	 NI+aO6o3yYtMB97Id2nbMtuFWy9AZwypD56ICYJeXMnk8N4c7BD9nqd4TrN7kYc6ujw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793840157;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2N4tXSYyNJhVoPBUtEUwnL5pVlC7LD9ihuXv5+EzHCw=;
	b=sxP2bcIUVpran8z9LsekJtMtzUMS0EywEze0obBYf26WKCFJ7FeTY2Ay2OE7K4LWxaC5
	 jGV4uTYhZ/BDiF6rteX6bdJj+WtYMTeb9Jvr7erlqMtbMfzpiPxbIQImPS9J0QLNRDcWu
	 YXFz3Gl4Cd2x7mkkX1gMIm05r7BTEybeutvuO6dYl4D4YSgEEBEzJ6zEkRR+tjjo0kAFO
	 uBqwg39jxmGsN1r50wES1S7MVL4W2SbIFSK2xE77xy6lAsdP9MKq23swH4oCz1QqHblAQ
	 Yzvqr+raPS+QJ+j2Sd1fvFV27ar9pq1agg9eO6lgpN+B8qtZJLH02qYVGuGjayPL3Rg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCL+ntyj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.48
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90E6606A331
	for <git@vger.kernel.org>; Thu,  5 Nov 2026 00:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D90E6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XCL+ntyj
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c4550d8ab15so207390666b.2
        for <git@vger.kernel.org>; Wed, 04 Nov 2026 16:55:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793840155; cv=none;
        d=google.com; s=arc-20260327;
        b=LgLWtq+tWDtPGzBIHWDtuHDdxZmTFAA4eP4vb9WJ/WSq8MiaLuAnCVaGCNK9zv493V
         LeIFqrbE6lLhcYvFJDrGP5ypFussLIKVeQvURnTcgZHeIUSSKdlWKmjPkP5/eBWHRkHJ
         923qhp0G4clZkARCag80kqV0X4lgDvKX59R1x5rnYwNqzp9+nnG332X/W3dgqoqiNYx3
         cZ42QTiGaU+a0ogSvX03aBQLSY4l3X1vXHMpoCHVAfmnFxkl40d3/c5TKOcgMn/uBcs+
         HmTPRQr509ctjgBDO1Zf/Mg1xIH/PMHtJfu4TIkrnuurIbpYwc5fzxAxEgWNWJ/7+DEH
         srQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2N4tXSYyNJhVoPBUtEUwnL5pVlC7LD9ihuXv5+EzHCw=;
        fh=xct+iGG4b1LwuXoxK5VB4+y71YE7hTgcJFCPJmdmGL8=;
        b=UcBjEuC09Y2JzdEYbEN7v6huDfMu4Rtx/nDHBYAUuqrSITJ/J9sOONBDJ+NhdVlfIq
         F5Hvd1JQO4GrHAr6pGy6BkFw5LrdQlYyMedvcad5RoL01sPAlxh1KV9eejTYnRoq0rJU
         9dsmI1w2U+CLWyl3iZwbj6jUz4ORlTmh+Pwf5lNz3WWYyDs24Ts6sJ/GBPMZaHfO01pY
         l9667WKuoW6tNGVbIE8ILpXyDLwgt4+VGLF8ByS74l5GF9fHR1kVX+wiD5PI7COv+dwM
         mqPzf2/hzaZHzV80bqtIkmO9jqoDgjZ54rU84f+ehYYuTR1DOB8N1hfi3mo6lpduCniP
         SdAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793840155; x=1794444955; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2N4tXSYyNJhVoPBUtEUwnL5pVlC7LD9ihuXv5+EzHCw=;
        b=XCL+ntyjKeDXr/pNiElXMinUY3SBGLpcQYgUWBb13M1Xjuw4MqVxzv5Jc/R3soFqRw
         XMvlpnC6mFCQS+ui7xJQk9Uo8i52mgM8KvAnQaSGIS1271kE2xmIYeWaNIM0D3CpwDbZ
         ZNvI0mQfnZrBU9PEidKvIFxs/s03KspxgbJAENggEMRdy2DIhcLXiuk9auaLHpwzvDzv
         WWBfIyreMv/9N+fw7ApgfgVQ8erq8IDz6OmuWJMrJxdQbHVliQPTj8rY+Xtqketyn/X/
         tNL2e85KmZYsH+UQURhNux6RSo4c2fSZ4Fr/cOgolkUN5xpDhET21UccNJT+KNRM3aJZ
         9A8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793840155; x=1794444955;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2N4tXSYyNJhVoPBUtEUwnL5pVlC7LD9ihuXv5+EzHCw=;
        b=dn92OEf+Su2doRWkk/RyatspPlJLKes4+5VFlJf1DxS8nMADj/QfynmCKITsav9GyY
         I/bAFLVHLNYTWdjF4WpkerJY5O5flxlYc0EfgiX7/4QaUgTo23Tt2dyrkhfNVgTwE3Jd
         0cM97VRJape8N7xfFxfm1peQ9ugOJaGRcFAskrLzKx/HMlK0Bgly5LKjSXAYCWBncbyq
         jUW4BQM90Nbul7QSythKbpyUSEQa3LkA3jZ8hPzVz7I7+Zmvlx0hcNJV4I8ZJlE/KM3w
         3CwRDN2zY9azqKwJqsKvZ20dlrT3c5LELhhsv6Q9amx0J5WgATNd0TZNXBNxS1W1nqVX
         TqYg==
X-Gm-Message-State: APuU4Z/igid2YsoX6ZDgCuDJ6R7JKfVPQ4tmAIApkpcigHTphTrC1HE4
	iZfs9CbXaI9oM4jnyD21qD3Ze1/T1lLu2fchiKOha6BXVzPIqkRd3oF/cSkrt+3eJIOlkkWjZuB
	iPnVku9A3Bk8kQnNQkcFjfXH72kwfkug=
X-Gm-Gg: AYBFou14ElHA+clhqa+Cb7rc+SW6L7dhq+mTtRaJSIvHoivY9FIMXZS+LG3zwM028MZ
	TDOJ78j5qDn0jqhCXUSLebzp3LlSDb+Xz+IkFH8keI54mibYT4Y48DBcgkpZ/YntfGNHK4lEIeQ
	msBwb7m3gmFddCPBlT2kH3lJ/7hViR+hE1BdYbGSMzxkMTkXB1fjhNliBkiBnRGAMaJNU7DjZkv
	kjfAGc38zt+tRdWjomXwdtvsJyfUDPIcEstpxIK3HT/z2dYUiIYchrNjw5wmceL6pQ6tSZHYzVi
	YLrIaJNCwWQy+fRhMvyD1qiKBqo7YiaQpcWAXDWrcarVbhG7urJ1wI9efRiCdxBaErIx/jBrdMA
	p1VN083350gxxnlnBBf5SyWVgfGSHL6aFx5YWaA==
X-Received: by 2002:a17:907:e849:b0:c35:d50a:1352 with SMTP id
 a640c23a62f3a-c4ca7a55635mr1462893466b.11.1793840154962; Wed, 04 Nov 2026
 16:55:54 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101210623.622-1-herroyalpriestess@gmail.com>
 <20261104025340.7799-1-herroyalpriestess@gmail.com> <CAPSxiM8E3LrJeba_f1gj3mxRVUYapp-nSgj+++pcgJEUJpxeLQ@mail.gmail.com>
In-Reply-To: <CAPSxiM8E3LrJeba_f1gj3mxRVUYapp-nSgj+++pcgJEUJpxeLQ@mail.gmail.com>
From: Priestess <herroyalpriestess@gmail.com>
Date: Thu, 5 Nov 2026 01:55:44 +0100
X-Gm-Features: AclHuK9GYkbvC2H4csAIiflfuZUVdvWKUybUuK8-ehP5DxEuTEXZzKwLKz0RtFI
Message-ID: <CAOcE0w+5jVvq9ZJW+3ZjJ3WGAnSHTj5wpNvbx7ZC2a0_aEtyxA@mail.gmail.com>
Subject: Re: [Outreachy] Proposal draft v2: Improve how command arguments and
 options are scanned and parsed
To: Usman Akinyemi <usmanakinyemi202@gmail.com>
Cc: git@vger.kernel.org, christian.couder@gmail.com, 
	siddharthasthana31@gmail.com, kaartic.sivaraam@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:08=E2=80=AFAM Usman Akinyemi
<usmanakinyemi202@gmail.com> wrote:
>
> Hello,
Hi, Usman

> Thanks for your proposal.
>
> Do not forget to submit the application on the Outreachy page.

Will do. Thank you for reading and reviewing!
