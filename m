Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86193BB32
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 03:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725940177; cv=none; b=nMMDrdpf/y+f7jg05VD5eeXxDe39vlVnDMJWpDq10ZE9uce0pXYP9XhUhnLEZPmlEHL4Ht+toBgzlKrWoYiaTycctxyAKkMBx1T4xJXTRnjQTe5yXnIZlmKdbsk6lf92HO9xkjdkOC1JAscE9yoUUgmCPYkPPsZB7B2AtNP6H8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725940177; c=relaxed/simple;
	bh=Rf7nGfzQ76zMtdLXJpRUWuIIsQODHTSZYKiVBAmbPFI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pCCLnisibE82b799yugJSiVcLp/mkAp+QfmaLEuOh4gMTawlGfZx57wskjlYMsLCp071+h/hw+2iuHgEGeFqEVENzhu73AQ6r9N0cdBOVRbFwsswN02c/lEjV09++e9Rsyyz2hBeLrcOr7VpnEON7D/Z0OdarXpSCfTgKtSuoOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Any7jDv4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Any7jDv4"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-205909af9b5so39474955ad.3
        for <git@vger.kernel.org>; Mon, 09 Sep 2024 20:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725940175; x=1726544975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=T/z0giFhBUmqotZK7xVDYmhFeFM2w01EFj1etyluhMo=;
        b=Any7jDv4cji+qm4P6fvdcgQaG4sBFitLFR29VItM1AW6gLGssMghHjqH3gDdx4koga
         jL25Q+6FQ9lzLVhagNowAzE1UVtqNM2GIH9YPZoeecfJcxnfCM7X8yvs8Qpx/6j+fbB1
         n3c7sjzTyLGYPDJl9nB3kQ+RWsrZY/JRChmQGdp7ds/MLthH5eROmfZ/TBVaK+mfbEjr
         M8mUjtEFv14HtLLiPKRVIrT/chJkmE/IPwB18psUr+hrCiSoQ9F09gS++/MZGY6NeRKa
         PZcD54wc1p+inMlfYskBwWphA7v/Asf+AvklJSJOH7jpA0iEIRoZvrq6/wWWvFpGrRAB
         qdow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725940175; x=1726544975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/z0giFhBUmqotZK7xVDYmhFeFM2w01EFj1etyluhMo=;
        b=tSBlhZ9Hs0LSghjYrwr4XkyTKNFk4lpiTxPTrFIAZV5Fd2oYnl8UoVyiBvRnVN287v
         9rSdjy5cH6xX+TIK+PtTyHQOKKDWJYXClMSdGoKQzrzHUGXN1NDiOM25QZRi8btAubhH
         hBmxC+tcMQPAkr2HkaETEF0Ktv6KZ6+uQO1FQwG7uO6A+icOauGK2ECsKe6PoZOtxiF8
         SCnhmYcBp2CJRcCaipm1dkuEsDM08swtd83Pp85wrgGnHqC2vd0JpAH8ZVpW3kgsU0hv
         +OPqO4vTyL5BYIW7R6Y7AvJM77HgxKhto/dxEBJuM92wFBGfQ2Dyrac2Vw0DsEU29bbh
         hhNg==
X-Gm-Message-State: AOJu0YwtkKfcESIaGRU6sXuom8Grl2uFKMbfQmFMRXaH0Z+5Cmz4ytTw
	rtp0aVYksCP4e5M0g+PekhnXGHnUp5y401IwAKnWeJOcBeLg9iu7wzUk5g==
X-Google-Smtp-Source: AGHT+IFlJkLIqiXek3xVaPv+rXZxxALzELQOJsP5P0U3kKMOb+VMp2sY7x1jE2MuT1Bs6COeUxxz4Q==
X-Received: by 2002:a17:902:e841:b0:203:a051:a29b with SMTP id d9443c01a7336-206f04aa335mr217188065ad.7.1725940174887;
        Mon, 09 Sep 2024 20:49:34 -0700 (PDT)
Received: from thunderbird.smith.home (ip70-162-122-51.ph.ph.cox.net. [70.162.122.51])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7d8256da131sm4782438a12.70.2024.09.09.20.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Sep 2024 20:49:34 -0700 (PDT)
Received: from thunderbird.localnet (localhost [127.0.0.1])
	by thunderbird.smith.home (Postfix) with ESMTPS id D3423196016E;
	Mon,  9 Sep 2024 20:49:33 -0700 (MST)
From: Stephen Smith <ishchis2@gmail.com>
To: git@vger.kernel.org, Stephen Smith <ishchis2@gmail.com>
Subject: SyntaxWarning for   '\S'
Date: Mon, 09 Sep 2024 20:49:33 -0700
Message-ID: <2214912.irdbgypaU6@thunderbird>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

When compiling Git from source on my Ubuntu machine I've lately been getting
some warnings when the docs are built.
 
An example of is:

ASCIIDOC git-sh-i18n--envsubst.html
<unknown>:1: SyntaxWarning: invalid escape sequence '\S'
<unknown>:1: SyntaxWarning: invalid escape sequence '\S'

This syntax warning shows up for nearly every man page or html file.

Is there are current documented solution?   If there isn't a documented
solution, where do I start looking and I will craft a patch and submit it.

Thanks




