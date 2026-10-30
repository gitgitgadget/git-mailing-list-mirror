Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374283;
	b=U4npuToo4SMet/HEKJ9ZMoIPM1iwKdDwG0349Jt3U2oiNAIIq/slnEV8fN7v9Bmekn+7
	 uEuQ1M8Wc/YcTB3644KXvkCbq1TbASStdpXhzCLs1p3wdCMQSQXxYqeia11MUa4kSYhSA
	 +nCWXpsgbDNkuiGCGQnzp0vTcuwlF1/kW0Pui8eV069dugjwqHPeypAJsCwxxa0Y9Ca6r
	 +Vo05995rw8+N3G8kOsOWOBKYX7uJNTSHMBkO2w+WMMV9XxeJt0qTcvInmUtVv0xtG5Nf
	 5P66UiYz5phxuD32lQNpE22RLGqZxYO4DauijQYezboRgCWZn3ttzwofYo/pwafdfAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374283;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=cNOmYj79U2UP9sBLr0Dkejr1DDi3NLGrCNpra11StZ8=;
	b=c/3rQeZvTd0soTqSYhW7hCXfNJoKgDJ9yREqx2qxO+Rxh3P1qg4Uo1Z4gOYj8pQFjV10
	 uqi1BcYypcvfMOki8596Vf8iKlaRpYQQQB6Q3FK8/j6Q/RGt/vpgwru10TLpZ7SLW1S//
	 PLkVDm7zDKVrYjACz3P+Fd3NMdB9ETDDYALVaBeYCDD5BHRJpo1liPylwiwYg4UaQD0p2
	 ykgREjJJffn2TDyYORtZ6BmsI0DYaVQLiliQtm8FrRqI1MeldM4/B5i5DnaQRtVr4vd6G
	 LtD+jgIYB7lZI34d7lO2R2fTD1s5AcDDebrSAWV3Fa9bzd+YiRHGe0c0gef5UdYIlIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AgxXkju7;
	arc=none smtp.remote-ip=209.85.160.43
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183AA606A31A
	for <git@vger.kernel.org>; Fri, 30 Oct 2026 15:31:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 183AA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AgxXkju7
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-499f20c7054so475169fac.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2026 08:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374282; x=1793979082; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cNOmYj79U2UP9sBLr0Dkejr1DDi3NLGrCNpra11StZ8=;
        b=AgxXkju7dkMBMjKA9SfHn/yGzMwjH/7A81GdjvHo1yOe4YDbW3F2S9iZTF8gNlWjKi
         oP1jvJpdvITy4pf29bvNGVViQgsWhQ69rzxiTVTZSGL1fohOq13QWtv7IGpFVD0FsBVE
         R8IkJ2uQejCGhdVzVT/qYdEqAyAeWTbv/ppjlyjli7Tx5ffT7YdpWwIL+98mthTKHbbW
         tHPANy+/uDL7RkwFkiU7AlSXK38Ko4L/D+9i0mzpQKvbcT67NP+AyMtVfwZX/WQok+Re
         At3Tek57y/wATAFi8y/Yq/MlLEqPUKttcH1Fg+jB0aC0iKIbsjE62WX/G69i/JjpeZEb
         1ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374282; x=1793979082;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cNOmYj79U2UP9sBLr0Dkejr1DDi3NLGrCNpra11StZ8=;
        b=qQJYlVMcp9iryKYZlM+bL17osa2RJvxJF2RFfWlQliNdMnldnB3Z6uL2WPn8kwPEMn
         zqvkNaSzuvZwHKdPbcKtrsyppiYY7LGoFDKwLi8oyuPFfHgEkitgwVS02fHV27Og+CWR
         0tnitpYoHTi+CIq5S5mq/yZmyHaTc0t+2McUI9zggBkP8/Bcp94NpKHs00W6kigYQ5Fd
         Q2AsOZCglXK+o/noA7i9PEzCvwJTxgHlM8r+r0mGV+MFHMw0slpaUy4xgXKaPc8eIxwr
         lNgHDDoWky4+G0izY0TiW6j+l8SeaQg/om2aWdb6BnmMCVTCjvnB9XmIaLvf89kZrMsZ
         pXcg==
X-Gm-Message-State: AFq9FYJo9FRsv3wZoRHWzu2By3fbZkGXJBJsC+/YOJck/kPvq1hF/OHH
	GmWpBv4cHIuXGDXq+w3WCDmPYpawZqYn9AdT4XC5x6zDTtSa4MhXWSg8
X-Gm-Gg: AYBFou0U3Pa5CPHEw2djYi49UvugEkccQz/pSHj52/O4B/sbsS3rp7kZA8mWyJHfC3v
	kvD7pPyrzJg7zrrBCloKKhL899OX+hxHxFnuKabcoEXoYbj8RtjdRNKKbCHDuiznizrLUFiHsMG
	cjOGKTuDh7MTI4Vx9ri0O7U+Gf21WUI/ttQiXp1ATrdF7TfPs0/G+rtxB4kdRwicJcsAO73NrYw
	jMHPYuFNKx4UBZSD6Ss6mXzFQnV4gbmNQdxxjg709lAGP+6KWrx87iX077ceosFrfdY/J8+aoch
	tOP1r9gl6Dn8i7SnLwwMGO0GzRLPBNfZu042xUBurryEeiU95jouRo+mNoO2SvwIb1Kqr97Alnl
	0NeYoX3I5/CCxt0sFrf5zgESRE8puGAm3OS7gGLRYtf+BLmtanq7pLG1U1MHTTw/wm19PxEYvwK
	1E3PRpim2WQ1sPsEDi2X2jjUzC+SDZCb2970hzfDXrq85fEGG05EaS9AoA1WkdzvNlC6aZj3g5f
	AlvgB5/QyWYqaoc1ou04RLzaRizOt/IF6QoY2opNaqSD5+970a2arTAKiy3eD6ohLF3waFOpeOF
	wqNQjM1l63vfGp821OFihcboGILCVr996QfjnigYAf5IimQYH8sECg==
X-Received: by 2002:a05:6870:d626:b0:494:93aa:9212 with SMTP id 586e51a60fabf-4a9078421b7mr1784021fac.51.1793374281748;
        Fri, 30 Oct 2026 08:31:21 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a921997d50sm213370fac.10.2026.10.30.08.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:31:20 -0700 (PDT)
Date: Fri, 30 Oct 2026 10:31:17 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v3 2/4] loose: lift loose object index parsing logic into
 helper
Message-ID: <auS3XTwBDP004Gc9@denethor>
References: <20261029002413.3291184-1-jltobler@gmail.com>
 <20261029232220.1245827-1-jltobler@gmail.com>
 <20261029232220.1245827-3-jltobler@gmail.com>
 <CAOLa=ZTNCcRCFDvUunqEqQCmDPE_2iu=rC4FwNmKAQujegC1Yg@mail.gmail.com>
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
In-Reply-To: <CAOLa=ZTNCcRCFDvUunqEqQCmDPE_2iu=rC4FwNmKAQujegC1Yg@mail.gmail.com>

On 26/10/30 07:50PM, Karthik Nayak wrote:
> Justin Tobler <jltobler@gmail.com> writes:
> 
> > diff --git a/loose.c b/loose.c
> > index c6f4ee0ec6..5f72c644f9 100644
> > --- a/loose.c
> > +++ b/loose.c
> > @@ -48,67 +48,88 @@ static int insert_oid_pair(kh_oid_map_t *map, const struct object_id *key, const
> >  	return 1;
> >  }
> >
> > -static int insert_loose_map(struct odb_source_loose *loose,
> > +static int insert_loose_map(struct loose_object_map *map,
> > +			    struct oidtree *cache,
> >  			    const struct object_id *oid,
> >  			    const struct object_id *compat_oid)
> 
> Nit: with the introduction of `loose_object_map_read()`, perhaps makes
> sense to keep naming consistent and rename this to
> `loose_object_map_insert()`?

I don't feel too strongly either way and am not sure this by itself it
worth a reroll. I'll keep it as-is for now.

-Justin
