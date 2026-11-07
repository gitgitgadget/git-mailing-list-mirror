Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.121.94.184
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794079849;
	b=EwDyMfSxKjcCXaO4O4V2PvrQ5zLjlbqc0MAqQR07dY4XQ35FBcFRZXPfVfvCah8jmx2k
	 nL1XzHr764sGKF454UOXpQ1X7oFrT2zelHT2sONBeQYazo/BuSIfQilA1C5da+P+cwrGO
	 Bsf84bn5wgjF73mFgdisyri3xqaAOpVZRIPZzu2wklslhh9PWHVgSv4GlUPyYmZlW8UJC
	 eTxj53kdX7KnjNO/E1CVazM/vEYmdBNJxiM4kYcDExB0t9v1X34BxJ4Ss/GX6oXDstwu/
	 Xi9z0mKVepv55hp08vxghrDHBhWdUx26E8zhbCQ4VoPQY8ZvquSX6HVMYFjeWneSNnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794079849;
	h=DMARC-Filter:X-KPN-MessageId:Received:DKIM-Signature:X-KPN-MID:
	 X-KPN-VerifiedSender:X-CMASSUN:X-Originating-IP:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5W1LQ4zI7R6muGFwNe5Sy9nXG4lNiram0dn54KY5Pcg=;
	b=5tYLeVkNiVSjBuPD8gIcMmrWdYBIT80EgaK2ILExbpZBTe4gUKigo8h48ggZRvlZtqnY
	 KBTgSfAHXzHKrPHnuvuheGo/iYsp+5xiSarI2iqIMioK4p35hSrBMbHV5YP2zpWLBTkbc
	 U1vVjkBqHBcZDjA1JCRBaGKfoRp0gMNcRowzQD9el6kZbbC8OpnocD9QXj+INNduyJbuk
	 y6Ldm6yKZLefPORlPOsFFkSX5SrX7oAVn57KA6qCSctZ2Rw6jeKBK4+cIazUHpUE6JRQC
	 Gb6n05q4JFAbfv/29DenTIcl5YxafWGoEIilV/EN8ELbVyaQe/iCvMKKCCE9JBdeTHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=vdwaa.nl;
	spf=fail smtp.mailfrom=vdwaa.nl;
	dkim=pass header.d=kpnmail.nl header.i=@kpnmail.nl header.a=rsa-sha256 header.s=kpnmail01 header.b=Flw7Yopw;
	arc=none smtp.remote-ip=195.121.94.184
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D61606A32C
	for <git@vger.kernel.org>; Sat,  7 Nov 2026 19:30:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78D61606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=vdwaa.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=kpnmail.nl header.i=@kpnmail.nl header.a=rsa-sha256 header.s=kpnmail01 header.b=Flw7Yopw
X-KPN-MessageId: b640664c-dae1-11f1-a3d1-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id b640664c-dae1-11f1-a3d1-005056994fde;
	Sat, 07 Nov 2026 20:30:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=mime-version:message-id:date:subject:to:from;
	bh=5W1LQ4zI7R6muGFwNe5Sy9nXG4lNiram0dn54KY5Pcg=;
	b=Flw7YopwabaEhe/oWF71v0FdMOsDMnLZDY3j21fDsPsibbQVZSKx+LCfsHORQfneDDLNaitEVTziD
	 SkfGbiDqodeAcbKWzZPdjBxhNBiC8m9ZKPUksDN7S0j2H8etBWXe8h8Cb3W7nKxHZUdC96a09UABPT
	 6UjTgn7CB2fAs7dE=
X-KPN-MID: 33|i0hgEfYjkMu/hDyIoxsIeunH4mloLlr6DqWhOI5Ue/LdbS0WHIlSE8chNxYm+iK
 LSncM/1h5vecv9lvw9n0wMQ0KH7jrKsAdcPlL5Zzf31s=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|6RYK9PeWsNSDlmADtPzZLLy3Q6r2piVGBzv/VQtInrfRWzRUm0OqguJsgxxtWFP
 qOu0FrmAnXHKvIrgIFrYT9A==
Received: from natrium (77-171-66-179.fixed.kpn.net [77.171.66.179])
	by smtp.kpnmail.nl (Halon) with ESMTPSA
	id b629920f-dae1-11f1-a6e0-00505699772e;
	Sat, 07 Nov 2026 20:30:38 +0100 (CET)
From: Jelle van der Waa <jelle@vdwaa.nl>
To: git@vger.kernel.org
Cc: Jelle van der Waa <jelle@vdwaa.nl>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Harald Nordgren <haraldnordgren@gmail.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>
Subject: [RFC PATCH 0/2] Support --verbose in git history
Date: Sat,  7 Nov 2026 20:30:17 +0100
Message-ID: <20261107193020.583215-1-jelle@vdwaa.nl>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new git history subcommands like reword do not support showing the
full git diff when editing the git commit message. This RFC adds support
for git history reword behave similiar to git commit --amend --verbose
except I choose to leave out support the "commit.verbose" configuration
option.
Other git history subcommands like split, squash and fixup could also
support --verbose under some circumstances (without --no-edit for fixup
or only with --reedit-message for fixup)

I would be happy to work start with landing support for --verbose for
git history reword, ideally with it also supporting the "commit.verbose"
configuration option. Further patches could then add support for other
subcommands where it makes sense.

Jelle van der Waa (2):
  history: drop redundant strbuf_stripspace()
  history: add --verbose option for reword

 Documentation/git-history.adoc | 11 +++-
 builtin/history.c              | 61 ++++++++++++++++++---
 t/t3451-history-reword.sh      | 97 ++++++++++++++++++++++++++++++++++
 3 files changed, 160 insertions(+), 9 deletions(-)

-- 
2.56.0

