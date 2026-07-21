Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582C0471268
	for <git@vger.kernel.org>; Tue, 21 Jul 2026 20:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664661; cv=pass; b=ZCL13G68/7px1+9+5wXxa9yvYGqZbdyfUQqwXpunObgknZlLdReqPyzUnriRi47UyYA+7gkGHRET0+aJSRS3ELprzcmValEIzkIVSaCvrcsPOFk2dlWYppX7/D4V9w9FmwarIZKOm5ofDp/JPGM2WUuMMQfbW+7hdwGVlL6EgBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664661; c=relaxed/simple;
	bh=jOKK7wSYea2wd69PfGFTl4o7C2O772oVcnaDibnqnrc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUWU+Y+knkNTalQCUoEHVSIFtrcbn8+PUWKCZDWo5oxeMhoeWjcl1r70hPVqxTgjyyhdzOFsOz3QR2M6ZyabYyEDkMjXBKxH6fPnFp15GwgmJLrg3ueZ6IlLh6g02KotoYG3E4GXDBkdx2+pl9nPjNp47mnJ2yB+tt6sUibOR7s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RQj3RaDB; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQj3RaDB"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69f2c67650aso1103333a12.2
        for <git@vger.kernel.org>; Tue, 21 Jul 2026 13:10:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784664658; cv=none;
        d=google.com; s=arc-20260327;
        b=ipzzfAPs9HtH2uaK72sSU12zRhllf0d+xMCTT5vyhHg433YYcu4SgOj/Snp5SyEpj9
         /bLqVqRcdyVnAa/n72hCj/th+SrOcrXwE99+2syE/anK8bLwPPAcpPdHfQF6bXt9nHoc
         i95pei6vPToxlfEQ2ZUm8ekJUDvaT5E6p8eQ6YZJN0GHp+4354ZSJpF1vxneI0Cnhor3
         hexJIW3uhjKicwNBwsR4bJHIis/PYtvbf/xr8T15n78ZXueCLlHmjxykhybqRMNjXKmF
         ZIgWMKSnNqBcVZ5646+x983eB03wynJQkoXQIqS6MiUti1ZEGXsWG906gA3KCrXi+DA2
         YGoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=jOKK7wSYea2wd69PfGFTl4o7C2O772oVcnaDibnqnrc=;
        fh=3x6yWb72KaNCWRBhhH/U8I9a3sDG++DMdiHuM8NDQeQ=;
        b=sEiq93WZsOFUsfqTAANSUxN3IUGjJTpZiKMJGkS6+aBl+x6AeE2J3j16LDj+pGtTqo
         0Ump9DuADrpV/cH1Fa79pZ6/YALlIl7PjpeLTR7P0mqebgbpAuFU9cz2xA9cpvsRUEHo
         Qg8LqOt11PrIL88JusE2cAHki6PHnpUGm5yQapxyPzFG8PnLy4VVknKgXqSriQm/dSH1
         ZGMYDySn+PJfOQ1WTp3Mbf5JhzrEz+nPtcXE9ryGi5eNqNgp75RsAr4BOOGW/h4WYkar
         z2THff+C/MmkOtq2fEpHxOLOP7d3Z4n8frF/CljlGxr9xSJ6eGX2dtSiDQs+vyEsb54u
         u2yQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784664658; x=1785269458; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOKK7wSYea2wd69PfGFTl4o7C2O772oVcnaDibnqnrc=;
        b=RQj3RaDBK2yhtGRkQaCItqZSSYuAA+Jmt68ZoMum7cK4MOWF6HOYvqQfqlGH277qic
         aQzGiosOjM95RgdMQ4ORTDjzkdYa8AWPMlumy8yRmIGhxi+mwC65+Bgvo5Nu0mhRpgrL
         X1QjW9oBy48AL2djlk9VFbzEI+hr5d+91o/7PiitY42cEeAUZmZJRR4jMUAgjHKuUeZ+
         dDjorg2xJksHZJ8pkcyOA2yLb5/ecYasI0LGLYg7LG6MxbTcuX9FuzFCOYWUHBlKXpqi
         tATjmJNoMf2ldJWW8ZP9zVRoCJKwJ2FSGI7uqJrIlea9davyrQVbRoitaQaE/UFD2zVN
         KYrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784664658; x=1785269458;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jOKK7wSYea2wd69PfGFTl4o7C2O772oVcnaDibnqnrc=;
        b=U0QormLw8IeWswHpapdHRelICNEELi/H90n45Ww5Y0VLdwwqeZueXEIQcdQu2+83jI
         7VIS35XO6XVvDTqP4V6dT4hvLzihoo7LKZOhXQvKmPIh2pH2LJvMoxYQcH/GBfHZVPLo
         WDf0T3hCK9MeQPu+2ctgODbdZ34kDhd+uMlo00ZNzyIyxGGXrLZFtSouBVUhg20ELLCk
         dc9GtYnOfbGWpwjkifH2Dk3cUN9pu310r0/OgbkCX4gTEbcb01T9tgR5yDvySEWKbJs0
         cBGHci5mnS1H3ag8jdv+BV+kz0qjh8xZxjkYStqXCKgxNOLbI1H1LhI0zhM0mhNOU+zr
         Dopg==
X-Forwarded-Encrypted: i=1; AHgh+RoPMaRpNe80e8NGfLgVYNZxofMJdCnCPHuy0XvrbA8O+YSj3uGV031vyNr/WX7HQtfSMIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/jCC+tyYci64Ck4EubbFctJSBSKhSmk/29556kN2YC21Vf38f
	ZaOor+jcynFB8BlgMjlMfdsJP3TRhlkmBRnihyerpSt/6oQkS3Ah0PJPXsD4JAk2CNNza7M+mAp
	HLws0gLbDCExswrsb1Ql7FClbbF110R/J/kQ4
X-Gm-Gg: AR+sD11RYpc7qLQxLiG2rAWY6g+kZyLFqP4UEaUrkoJ8hRhfHC0D6FVrfV0FqzZN23v
	AeVw3yo2AtFyZH62fBIpUMcxgyUGEajQ2UceNotcW23aGQrE1rJAueW6NSXZZFUS8TR36lVwat9
	HuES/Lxuakc68GK0thYm2NsCkfrafoc+dPg+muf3EAs+8WwpwX8s9PKHWNvmN5H/E1+YiU9GZ/E
	I/T6qSjdXrQHrHCAl04V6ueu1v2TwkZGN75JLRb6ra6CNlxb29OLKE52+yRKg==
X-Received: by 2002:a05:6402:4555:b0:69c:811f:8f5 with SMTP id
 4fb4d7f45d1cf-69e65228fbbmr5986849a12.6.1784664658028; Tue, 21 Jul 2026
 13:10:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2358.git.git.1784538618.gitgitgadget@gmail.com>
 <pull.2358.v2.git.git.1784624306.gitgitgadget@gmail.com> <CALnO6CAY2x-adAxSXW1f_+OHjV_tVhLmkN7D+wE39rj3wc8LEQ@mail.gmail.com>
In-Reply-To: <CALnO6CAY2x-adAxSXW1f_+OHjV_tVhLmkN7D+wE39rj3wc8LEQ@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Tue, 21 Jul 2026 22:10:21 +0200
X-Gm-Features: AUfX_myzi6r5hut697PpfjeWhjfufoqdetPJ76yvb0vukB0I_EFrrmethXsUQeo
Message-ID: <CAHwyqnVu5vmJMcXFRXHG27MZtL=eoX6LjhYJ6_SZffhn3JqUWQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] remote: renamed remote push tracking
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It's very valid and I need to explain it better if you are confused.



Harald
