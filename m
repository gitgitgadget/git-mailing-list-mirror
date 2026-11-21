Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795257761;
	b=DpOtnfP737JBo985/1jR/3exsaS7Da+MMlwjiEoEtPMwoNdS9q3i8pYWlxlYyXa2y09u
	 2FLd5eDe1fkiHVGxmP8AWjDIHVopuhxTEzylxtV3PfSH/tkhXv7D2arJOi6sSm5oLOOc4
	 Aey/ADP73BnId5brg/iyhS0RZoFqYu+ImWxhgp8qMudTsrucKL+Woasvnvoa6TkVW7Eac
	 xtOCxTR2EwkV7jhbs8Deu86FuzA3p/kdy8hl+01yHbD3F6ua9Ig1+u+Fj8cG967RB1yzR
	 hcRJ8qgN+nxxjCJL3PpMkPHmq7FWnd0iAuna9YTqQOEgKr5cHJUdeadg9B8jyuO9VAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795257761;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=vHFn9f8KEoWGXZRuf9xkNce44zdVi+EHJ5ELRe1T6xM=;
	b=YzItyVxxh5W6oiRb1CQW+TP6KLSFIQUbZA9aS+HnE/UHA6N0lX3vvVDednXbCTolTPt/
	 0VYZ4He0IX9OVeTIx8qld49yiARMb/qrJRWkeu4CflkExJPYeBNCdrzsXpKcHXT253h9B
	 e9E7EtHAQ0RPuflUHACt5BkFt/Axu44+P6C6SBSmtRiYfVw8s59EUDbRoHsIriXC+Otea
	 MiVW/4XaUHC0f33Qtz2tuXIwKdhkaihE8ak0l3FFm3S6M8MOcm56o1bSCUu4i+4HqZwJ/
	 WsljC0XwFShI7KdF1tttenbpNSE0hQInbkUj73I+lU4MhUYGrtTlwA7DdT0ces/SCuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cn2KrmnG;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC434606A320
	for <git@vger.kernel.org>; Sat, 21 Nov 2026 10:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC434606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cn2KrmnG
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b50a4bd2f3so2818654c88.1
        for <git@vger.kernel.org>; Sat, 21 Nov 2026 02:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795257760; x=1795862560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vHFn9f8KEoWGXZRuf9xkNce44zdVi+EHJ5ELRe1T6xM=;
        b=cn2KrmnGT/TdoQzQXSg2wev2dgIT3cz5VNKUHS8khX3gVsjGdy5mCy954SeZq5VXgh
         ZB7bFn5pNI6wJinVz70fm/zW8pOA5NZr8zVJrNtWiNgHnA8W26FAUmu2tzJ7c/7NznX4
         eoZHpHdAS2/4cocK5DDfeDU1Hloh6gJq5VtnvjFOF6cI8GzTlcSyTe3rlnKIwzQyzZoF
         YxkpWTaj+zi60XBX5A3Vn04P1Og0ZyI7BQ7/u3ni+OfZXnkNkDXDe6dskqYPtGEh+EaJ
         F/ugqLSoib9UA/gNNfy3a3FArdqoAmlaYJ18Fj4u6uNsQCJ75bhRKJDU06v+uFuGvN1u
         Wl0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795257760; x=1795862560;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vHFn9f8KEoWGXZRuf9xkNce44zdVi+EHJ5ELRe1T6xM=;
        b=2pZJ/8rKcv7rlE0BfTeQyY+dLIhl7aCyftV6WSvSZmTk1/lHrlC7opCe1w7B4cZ46s
         b9DglgGxP2rtWFl0gEgbdkZ+fuiiDNd+0TEt0c9mAwu9OLUvk1W17wl2cmaBZ9PMRlK3
         BwT5iK4Rbno2Kny9qDtR7xkzua9fKUifo+YRD1hbP2ASPHsVsr7IJtgH+6e+PhEr/br/
         HwiylLoTW31RwmnJq42GYTyLAWRDt8PFjfeQybHcdynROoV4ukeltjRGHHa0AJH/mxJJ
         VTQds7D7vfdFSQxpSdyWC1NwkR+WzVuURdewnIQW7B+ys63M55CPyFlBomoVQypTBeyt
         nDBA==
X-Gm-Message-State: APuU4Z8WYLZKHxUcEU87sMQdzyoGlDhD0oUWQqgkGkV65UC73cavDVEi
	Yc1gLduLh3IIhUm4oSS7tJWXtcMOf/YPA8Fihfyi8MlRT/ylIFYAft5nzEOwT7y4Kn0=
X-Gm-Gg: AZFdTZcy55e2bCnnjxRxGRw401rDA9DW3bSqMz44SeXEl/1kQRLLseaOA4HelK9KJY4
	ythRk36usEhEbUigbyvlGZVixUGVx94duMAZ4ifjz7WtBnSczJUi6eJnBfpbjlwpLr+zZs27JK1
	hkmcj6Bbjv8K/tQNe6rw9roYl+ctBGStsIqEdP5DY92h7VxVv9IA1Gd3lFFCsj/DX5RngKMpOih
	8WdcBd//QmLIccfwQRLTfQtniaAaKqu6fhuEkIbsE8Ks9T+fg118cbNxBMS+3az3Ed8D5X7SYSk
	uC7g9QUloRdysQfUc55h1PW50S185A2rhyNgGEs5+swfJUwY/4vgHuJLA2Tr8hAGrT5kTWhQUQe
	qPQHls+xoDCoAET9Y47VmedQTzDrWvp4Y0aFVXHfphK2GKixhP3x8J0NuJ1HtWmWuDA/ZLzi97M
	aEs2GSnsbAm+aEw3rUjH39wvAWrqp7ROnjMSMYbfF5FWvmB8iQXrYsAwsYOZUf+5gnL2MwHVjv1
	exeZseDu47M0jfadPq5eIB/hyoVP551FMxPUjslZsJgjzdx3V5xYnp/8U52qbtkSDvmhg3gFUwi
	LGdBT8Ac00OeFHKtX240wyJBw0jhtSKgFkaKuteLo3e1uMticaR/HoMgylJ1462UPY3Su8Q55ZB
	fD7CR9wIDsPzgcEzvKYyZ
X-Received: by 2002:a05:701b:204e:20b0:1b5:2717:61df with SMTP id a92af1059eb24-1b556913aadmr6160509c88.41.1795257759626;
        Sat, 21 Nov 2026 02:42:39 -0800 (PST)
Received: from localhost.localdomain ([223.190.83.65])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5568592adsm13290463c88.15.2026.11.21.02.42.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 21 Nov 2026 02:42:39 -0800 (PST)
From: Aniket Gupta <aniketgupta3001@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Sami Jawhar <sami@theorem.dev>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/2] combine-diff: fix patches for more than 32 parents
Date: Sat, 21 Nov 2026 16:12:32 +0530
Message-ID: <20261121104234.98386-1-aniketgupta3001@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This series fixes a bug that Sami Jawhar reported [1]: the combined
diff of a merge with more than 32 parents puts lines in the wrong
columns, and with 64 parents it shows no hunks at all.

Patch 1 is the actual fix. The shift that sets the bit of a parent in
the mask of a lost line was an int shift, so the 33rd parent and later
got the bit of another parent.

Patch 2 is for merges that are still too big for the masks which is more
than 62 parents where long has 64 bits. Instead of printing wrong
output, it now prints an error and skips the patch. I made it carry on
and not die. Now "git log --cc" will not stop halfway on a big octopus
merge. I am happy to change this if people prefer. On Windows, long has
32 bits, so the limit is 30 and the tests for more parents are skipped.

This is based on maint since the bug is old. The test suite passes and
CI on my fork is fine on Windows, macOS and Linux.

[1] https://lore.kernel.org/git/CAOJ8FdczW9KxFknceHodV0jmhyEB24OMtqQUmhkP3E2vfsmgag@mail.gmail.com/

Aniket Gupta (2):
  combine-diff: fix the shift for the 33rd parent and later
  combine-diff: do not show a patch for too many parents

 combine-diff.c           | 18 ++++++++++--
 t/t4038-diff-combined.sh | 60 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)

-- 
2.54.0 (Apple Git-157)

