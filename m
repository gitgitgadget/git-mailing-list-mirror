Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566473;
	b=IJfG9igH8kOTqoe5r2Nb4CknI7kfy6DxiX9FcPHwXR4gx4wjq8iI1vZODgZJ+0sZ1LJJ
	 Dhs+L8JD/T9v7QPj52qw5e+o5xLYGOBjBFXIWJZFGCrod+IqMrC4A9d/qtJ5GV7a9u2jQ
	 btaPGvL5BekF0Jkm5VXK123HBCV5eOg5P3Qtw+LwwIvEPyXOKh0oPBvAxkOl//lTTlhEs
	 YBGdzqyVFw5pSReGMbBNs4KanwDjwDmWfHW7tYzfwqmQO1Txz7KA8t41vnDFu8tbDj7K7
	 q/2eJm2gPXpmKzpk9YYVRBCwGQJYCJGWIedYXixg4KuF5X6U8KJuMHIobajfE3yy5dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566473;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-Id:In-Reply-To:
	 References:From:Date:Subject:Fcc:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:To:Cc;
	bh=49uA2F2F/DuxHlliR4TTmWO406yX/zucnfHj7MZYanE=;
	b=q+uaGxGt6YZbT94517dt1MbRCS2LtkzMRhCoMkhuv7m864W3J6tI7pp8q6v2rupCHtku
	 C+D8PmYndAEjBj/5kG16DpX+SVEQHBfF2IUGND/SOl8HRXonJPgZtWSr5BM+cMV6GzyoJ
	 +SprZi6fBmj8xd8i0efgiCE2bNlxoBU7U1H4FSVnyx1a6ZMuBRxe+7sOg0z7Y+b7vTec8
	 NK2JxCSL1Bzjq5JtUKTrI6nnd7u+Md1Pix6rKZx6QKYH00ogwAqZUVe7pQaydMcuc97KK
	 7+3AOKrD9brP5XuUbvfwiBHn5MYt/fdWBckhQrn1UR/gNAmJpUF3Auwv/3ScuZZ2ZvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b="fwHgk/Mn";
	arc=none smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69123606A319
	for <git@vger.kernel.org>; Wed, 21 Oct 2026 07:07:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69123606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fwHgk/Mn
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-4a71d0c4233so184473fac.0
        for <git@vger.kernel.org>; Wed, 21 Oct 2026 00:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792566472; x=1793171272; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=49uA2F2F/DuxHlliR4TTmWO406yX/zucnfHj7MZYanE=;
        b=fwHgk/MnUq53OCU6PMnskcMrnZLMa0JsU1CGRtF0Y3QB7uiSnAtVVIEg+mWBcipOsc
         7onK3SPrSPYIFZNM1CRgwQZdWn83+Gsdg7G2xZ8Bb2hgwguXora+q6cJCxCrLYccsQMd
         2lsFUgSIj7+T8/2klJmYiC4Tm6dPMyuhn6+8f3c+Il0mxzf8rSjFTGx7U2aBv4s81Xtf
         NIGtKCDiflqUhPdHLc0MiuiNzaMa6ECdCq2hLgkZH3smR0G/ssxeebl5VHIfy35D2seQ
         nawgDq3KT3PJf5CpK+i4oN8dDTTcTD/PJWnNGjN/OdGrCFHWeGL/LTNR+kXDImf1zPSv
         ZB2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792566472; x=1793171272;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=49uA2F2F/DuxHlliR4TTmWO406yX/zucnfHj7MZYanE=;
        b=W/I26OANYWFL3F8xgl2YefdhFoJDXjVCMyPSqP+4Z9+m0i9jfL2dPgmTrX6EGIWf3r
         5r6d7YWUvSeH52rkKqKVpkhFxg3pfqzPFwTa1mD0ySw/N4/4r5Hae3yk6zy7pNHXM1rs
         lW3FUT5O54meUT0klyLtG6//fHhlGNj0v093/LbWfoTUalvInj8VeHBGNJSyZD19C5RT
         C6sU40nVvXqPi282ETgL44Sq3WLe29CwQhupugoXbuurEF1kjI/u3yW1gLsHX0RT134U
         QBjrct8oS9UzaqQuoWfbuOX+urz9GuIDY9EJEK65RhhJRjZuKyw/AmlCXb61FYp87LUb
         o0vg==
X-Gm-Message-State: AFq9FYKQE6HKBpzCxNJF31zSMOgnxzorezq2QKSaTde2zOxoDJmFx+uL
	TOfUlU4F6H9aplW/8rMMNqjMV6OFZtl+aIdBmHtU6zU5N0puDiJANgZ9mQjQmA==
X-Gm-Gg: AYBFou1aB410w0Rp5bY/hzU6wxusvphhttDRoSEAgiUqGSBTivDdvGguHtEiFPCz/JO
	r9pOdBPcKglYeAndDg4XKyB0TVFtv6pNIBzO/IqkNdlEQeUTp9I2/7R1N72dB2EiHpI84MermN8
	uR/IS+i4N6bGpXTm2QCa6XbS6SdrJVrCiHEIrGE+1l2gcT1Kh/tVM1S2LfyCWOIOkaEjhaUeb44
	aD8zk/sw8I3mrLtxLlr7eEQchI+BglCNVl1RpvBuc7uKPgM1jBLFAhziWTPXvc25zMTNcbMKurl
	NAQDJUqWAOpspTnwgIAoZ1YFrOPrnjnFFut5DKpeCfp+O+sUQDz+nJskYtXmRB4MnpbwRyWlv2q
	+YHw5M4ijDkaYThajSiGIP3V/+/dw8uuc9LQPEEc5DIjj2jx1iIENwNX+gVDBPrkmBy9X84SGLQ
	OGurgt2a4bkBEgPZ9fJoGX66k064hLybPpcCqV+ju6lIsFoPxLKpiyXKBfoK3EMSocYUtpOLWxe
	ub9qJeTF4lFla3XTOUUiVW70QLXpjIjpEJ2ugOu486B+QI2ZwLlGVfp3JY=
X-Received: by 2002:a05:6870:318b:b0:49d:c9b9:7509 with SMTP id 586e51a60fabf-4a7dc1b087amr593360fac.13.1792566472265;
        Wed, 21 Oct 2026 00:07:52 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.200.81])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a7d611b409sm1465442fac.4.2026.10.21.00.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 00:07:50 -0700 (PDT)
Message-Id: <pull.2456.v2.git.git.1792566469.gitgitgadget@gmail.com>
In-Reply-To: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
References: <pull.2456.git.git.1792437558.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 21 Oct 2026 07:07:47 +0000
Subject: [PATCH v2 0/2] Fix imap-send with reordered message headers
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

git imap-send rejected patches sent with git send-email, such as ones
fetched from lore with b4, because it expected Date before Subject.

Changes in v2:

 * Case insensitive header match according to RFC 822/2822/5322.

Harald Nordgren (2):
  imap-send: avoid leaking the tunnel command
  imap-send: accept messages with Subject before Date

 imap-send.c           | 38 ++++++++++++++++++--------------------
 t/t9001-send-email.sh | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 20 deletions(-)


base-commit: 47fdf2208c5b94c8cc01c106b8f7c85efb91c926
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2456%2FHaraldNordgren%2Ffix%2Fimap-send-header-order-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2456/HaraldNordgren/fix/imap-send-header-order-v2
Pull-Request: https://github.com/git/git/pull/2456

Range-diff vs v1:

 1:  0784c16134 = 1:  b170b1f6d3 imap-send: avoid leaking the tunnel command
 2:  94129fb718 ! 2:  c42827a122 imap-send: accept messages with Subject before Date
     @@ Commit message
          and git send-email writes Subject before Date.
      
          Accept the three headers in any order within the header block of each
     -    message. The copy that git send-email --imap-sent-folder pipes to
     +    message, and match their names case insensitively as RFC 5322
     +    specifies. The copy that git send-email --imap-sent-folder pipes to
          imap-send then passes the same check, so the special case added for it
          in 04133f5bc4 (send-email: add ability to send a copy of sent emails to
          an IMAP folder, 2025-08-12) is no longer needed.
     @@ imap-send.c: static void wrap_in_html(struct strbuf *msg)
      +	bool from = false, date = false, subject = false;
      +
      +	while ((line = strchr(line, '\n')) && *++line != '\n') {
     -+		if (starts_with(line, "From: "))
     ++		if (istarts_with(line, "From: "))
      +			from = true;
     -+		else if (starts_with(line, "Date: "))
     ++		else if (istarts_with(line, "Date: "))
      +			date = true;
     -+		else if (starts_with(line, "Subject: "))
     ++		else if (istarts_with(line, "Subject: "))
      +			subject = true;
      +	}
      +	return from && date && subject;

-- 
gitgitgadget
