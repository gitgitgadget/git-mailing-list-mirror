Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6542CA7
	for <git@vger.kernel.org>; Fri, 19 Jan 2024 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705625852; cv=none; b=iIZvbo02HugASEDCpPIroLKSfLsD5sbjO8csw3cmBIJbzaUqqZNjsKNqYZ/jhpY5GMU2MeuC36RnwevjnX0PXltODuV48SNm8geouQ7oUO5PID6bg9ljs0I9OpssrfvyLjRQKOeMrkedauXGn8Xm8vY9Sn4Yp4BHSVapo+E3KjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705625852; c=relaxed/simple;
	bh=bzWkMD8A4ODRlPVdluYgZ4Gn0XaPy2oSxrBx0E8/7fE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=RZJL7d+33S4rykjxgmTi+7ZXxxpSLEQUhtkUjMssAVaXy2P2ZBR/Zxi29707qd4aYsO5zmCbe27kTppNCPR3UUL8dz/Uc5W/M6jPuy6JGCBe4bJOV8rk8widf8d8G9EgEwrVOoMUBL7XpbZvI+3mSDBkwAKXnplwiL/glJAGc1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NyrXvD52; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NyrXvD52"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d70c150632so1942785ad.0
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 16:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705625850; x=1706230650; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWpI70PMb0D6Q1dgGUqxLDm0iK1RF6oPIervxLjPfx8=;
        b=NyrXvD52yjH1jtKQDUepDey92fN4Ti4ISNV17vwDv4h9Ipk6e1++z6gHlELugS4z/5
         wLmmRaZIWre2apsIhBWPw+NWbQUgeZ1ZxDlMJVp8t7QiaGyHQ0PsPePD4mjbBoyjGeti
         jMTA1jz/j18Zg+WTalyECElKbcl2E+g3X+k3WdZbyrxE5f+96oDj4LfcaAgDrb2NrBPJ
         L7g4PQ9V66h8l4OZcZ9+pYg373gBaIhO9C+6khy0Po1vny8aQw1bKaePlyEQpyGAwsNn
         dXNHBvnE0NIZ91J0oNykCSFLl2/aLG7/jPK3Mjel/tPJF29JjwNrlBdnn2Jf5ShkKuHy
         zdbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705625850; x=1706230650;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GWpI70PMb0D6Q1dgGUqxLDm0iK1RF6oPIervxLjPfx8=;
        b=euzChMHxtGIWSIbfZw5k8OqrpkBYhFnHgN38O96Vyer4Jazcp1HT41Yj18E8pFG7/X
         I3SYZgRSDPdBhuSzmTO//7I0REwoGZWGh14Ed6sZ0HJVEe1P/tSTrOzy8Mr7qY1J/roa
         Lctl1Gz5dG9Ro0eG0gjH2Bzp/0yNnv+h2TspEOdu/jipGU6ckTu4C2BIVRwRRtJAzslv
         1E6dXzbnmDntA8pI1qACbS1hH8L93RqBA0fxInUI4Mf1CmhCfWo+aB64ql9cW86COhBa
         xhTA/zVqIZPuc7C9ktniTB6pwshwX53905DFyPXusSMGVDDtXLH7a/orEROwZbmwFEKq
         Jqkg==
X-Gm-Message-State: AOJu0YzVdyPUyxRSyE/7Jj0a6z+NwifSn7zSEe4AWQaJSHP9182Lj4Lw
	50xrkwGbF7TBtYF8l/ox7x6DCsTQcvR9utE1qcVEmMztV2NQYpyw
X-Google-Smtp-Source: AGHT+IHufrCdSyMEJo1rZCVaG5mlLH6tBwLtTGQlhXgZtzpdbw+DfQnoTGW0m/xlpdDCNxpiZ7tlUA==
X-Received: by 2002:a17:903:608:b0:1d5:8ce6:e4b1 with SMTP id kg8-20020a170903060800b001d58ce6e4b1mr1674426plb.43.1705625850613;
        Thu, 18 Jan 2024 16:57:30 -0800 (PST)
Received: from localhost ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id s21-20020a17090330d500b001d6edfe948asm1950053plc.76.2024.01.18.16.57.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jan 2024 16:57:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 19 Jan 2024 06:27:27 +0530
Message-Id: <CYI9WH7UZ58F.GO37VZJHL7QD@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] t0024: refactor to have single command per line
From: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
To: "Junio C Hamano" <gitster@pobox.com>
X-Mailer: aerc 0.15.2
References: <20240118215407.8609-1-shyamthakkar001@gmail.com>
 <20240118215407.8609-2-shyamthakkar001@gmail.com>
 <xmqqfryunsd1.fsf@gitster.g>
In-Reply-To: <xmqqfryunsd1.fsf@gitster.g>

On Fri Jan 19, 2024 at 4:48 AM IST, Junio C Hamano wrote:
> > -	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
> > +	mkdir untarred &&
> > +	(
> > +		cd untarred &&
> > +		"$TAR" -xf ../test.tar
> > +	) &&
>
> I think we assume "$TAR" is modern enough to know about the "C"
> option (see t/t5004-archive-corner-cases.sh), so
>
> 	mkdir untarred &&
> 	"$TAR" Cxf untarred test.tar
>
> without even a subshell may be sufficient.

Will update it in v2.
>
> > @@ -30,7 +34,11 @@ test_expect_success UNZIP 'zip archive' '
> > =20
> >  	git archive --format=3Dzip HEAD >test.zip &&
> > =20
> > -	( mkdir unzipped && cd unzipped && "$GIT_UNZIP" ../test.zip ) &&
> > +	mkdir unzipped &&
> > +	(
> > +		cd unzipped &&
> > +		"$GIT_UNZIP" ../test.zip
> > +	) &&
>
> I do not think we assume "$GIT_UNZIP" to always know about the
> equivalent of "C" (is that "-d exdir"?), so what you wrote is the
> best we can do.

Yeah, "-d exdir" would be the equivalent, but there's no mention of it
in the testcases in t5003 or t5004. So, keeping it as is in v2.

Thanks.
