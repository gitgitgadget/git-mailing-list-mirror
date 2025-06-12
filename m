Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66020153BD9
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749768746; cv=none; b=sM0XMp8JsZcqzAgKdAsmUW1cGMaqXSIgTzmqbxgstBD66iJhoHh/60zzoO9laPI0RnE76EDHsd40/r/OubaRqxP9j768/+8lLsRKwKNVkkwtp+OQTyebny0psA1tusBj7lPwGp+faitcF7pWDG1NAddojl9F85cg+ROnpqbADI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749768746; c=relaxed/simple;
	bh=LkuDIXZnfkByIE3apstHLTfzt8aeT5/6Zs4omN4FDG0=;
	h=Content-Type:From:Mime-Version:Subject:Message-Id:Date:Cc:To; b=X14Ak/TaYbX698IXeG06qq1//GnSqeMsnBZNFMMm8E0toOsSfRDqJ6OdzeSAR6yMhRckoHJqrrVLEWLCIiyWgPTKWtCykhjyDYowVXeedKp91FYgAvKuaOPVY4AU7Rr/eyDp7/fHos/0ZM69e8qACFNnTL2tC2H4v8yIuKpdgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a5WXPpGU; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5WXPpGU"
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-e812ed38d02so1330286276.0
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 15:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749768743; x=1750373543; darn=vger.kernel.org;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/lbN1XwLcsC8TyMNbd7I+nGdKYYLinvLwHCxpneWNus=;
        b=a5WXPpGUzY9JdyDgDNAze+ZvMmmKVYuHjR6uByzvzpb6HdNCMjTADzRrWhK2hfrTpY
         yrd9O1mC/xUHT61i5S1jbQGKAAuj/OP81Ivj4+8QgN1wvynLu7H904sGdUx6DI5ScR/I
         rmRUSiqWS75ynTOyQ0e4Y2KBa4Gkb5fL20byRvG3yD5acWByW5kj81fJlebg0tNL6bTq
         nqwCTi0Ao4LeC2lVpRBGNweXcPe5JqmsQmSZ6tlNtzF6sW4znu8Xmn2V2q+7T+WJywIc
         fU00Bg0sQECxBL7/fugJ9ZxIsq+9ghQnjUHrvwEJ9i4LMcf9GOODpPLUYK30Otsq05z4
         3G2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749768743; x=1750373543;
        h=to:cc:date:message-id:subject:mime-version:from
         :content-transfer-encoding:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/lbN1XwLcsC8TyMNbd7I+nGdKYYLinvLwHCxpneWNus=;
        b=v9M/1CmHGLAdoQ+5ELSOkj1Djfht7iMAO+h3zyDOFAjd6KdCwSE68WKP3pJrhDwhQN
         R25oIwdyWblLDW8Rmx40RYVCoU9HxLdfO4GnPGJZYqZa1IoZLCgoEGwP+hociGG9yqWj
         U0goaM3YKn5WfESjJ5eCfFGpLQiOJb2zoCMRdBIjdkMMpdN5rZP5I8VJBwrHj+fyu8Gp
         5BQz2HfsOxVcQ/kRPJnz1yt/A9gqnB4TsHFE5ClhuBcfvdO3EGKSO4oay3WlOjRqHuEb
         CDo9kTcyzzH0udDul+wFXNdbWBI1PATrFnQl6juShjn+s8+jY8ibiMgZaAYDRnFIIjnj
         b3ug==
X-Gm-Message-State: AOJu0YwMo6tJfAK8Xttk1NXOYmz6wcLJUajdpyG/vniQtBu04wXJ95QC
	tRV9Z7CkJmXrj6UZGHNfKCGE58QoFC8bpu7NoQC4fHGqMVfBpcdkfg+ugqBgFlMU
X-Gm-Gg: ASbGnct52LhcwBBk6dHw75GuqxY7VNBKWtuKNG7Icek9pXmKlbzcCRuZ4apdmeQgrP1
	pCW56w6+8xGx+dNHB8VC/fkj+j/4tI2WdJPBrBsx8I5QaP1Z42AZ0DuUYq9Sn4Gnh0yeHRCGUW9
	p0z2Tm9st7xXQaprVspg8xSC4Xc0RhRWQAF01/eDgtO9ozAR0Ry7Otx+EMF6sd41O6x9u6J9QCV
	lT15k+51cOt6hqmWrFrtGwVPVH55itRSUYp2rC+folYODENnYqOw3oyqPk6xBVL1/R9NVQZWtiF
	hWVb4bksH6ihSqz0i9NVQz79/savRHwT4QUeN97jSRp2T1j5BgyYiJcjCyHhRthnW1BC+PJe1+5
	HIzNrCvbxLGoTGFJfNeew
X-Google-Smtp-Source: AGHT+IFBAYHu5UJq1zDEfWZKSp5e8QiY3kS3R1k2MUJ1mAWtolnCHw0UXh+2ExVB6r+9+zQxwwp6WA==
X-Received: by 2002:a05:6902:1029:b0:e81:2ae3:e41d with SMTP id 3f1490d57ef6-e821c1ea939mr1263034276.27.1749768743539;
        Thu, 12 Jun 2025 15:52:23 -0700 (PDT)
Received: from smtpclient.apple ([2605:a601:90a6:1600:acc9:95be:dcc7:a4d3])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e820e04016fsm731511276.11.2025.06.12.15.52.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 15:52:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: Solaris sed
Message-Id: <CAA388EA-9C6A-439F-BF67-ED40DE97F532@gmail.com>
Date: Thu, 12 Jun 2025 18:52:12 -0400
Cc: git@vger.kernel.org
To: paul@mad-scientist.net
X-Mailer: iPhone Mail (21F90)

=EF=BB=BF
> Le 12 juin 2025 =C3=A0 09:42, Paul Smith <paul@mad-scientist.net> a =C3=A9=
crit :
>=20
> =EF=BB=BFOn Thu, 2025-06-12 at 01:50 -0400, Eric Sunshine wrote:
>> Had it used the simpler:
>>    echo "$foo"
>> this sort of problem (forgetting the "\n") would never have occurred.
>=20
> Just be aware that echo is not well-standardized: many versions of echo
> accept extra options or treat certain chars specially.  So, printf
> (which IS well-standardized) is always safer unless you are 100% sure
> that the text on the echo command line is simple: cannot start with a
> "-", doesn't contain special chars like backslash, etc.
>=20
> For portability I (personally) always prefer printf unless I know
> exactly what the text contains (like showing a static string).

For exactly this reason, I attempted to write echo(1) to the standards I cou=
ld find freely available; POSIX mentioned 4, IIRC.

https://github.com/benknoble/echocho=
