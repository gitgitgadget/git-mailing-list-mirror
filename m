Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986056;
	b=buFV2A9i6oPPVA206rN+f721na8UO3qmcj32gEug4Z/4UiQ7eed/HLgP5ibyznvgihQY
	 nhujIhJJrDhwRsSHnrZDXtEok5Z0puscCd340vz/g1HfW3YTF/p6izi+zPDAkqq7qlXKh
	 Vcp147n7SBZGsGi6rIXj9Rkfk24k27tvXDPExzq5yhf3YLWXRCwWm8q1QmT2PAqWW1e7U
	 EU5I7LckODJ5FBT2o5ZJxQrbZVEmWjwjET0SnfksvJ9FlTbzv1UNfcDijTAVmJudsli5j
	 e2mnjIbwXFkWYPDEdJp6ocvN6wlS+3TrmK+2uNSENe058oEMZs0uy5Md4Ls60agXqNA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986056;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=PWyRvsWoxC5/mxqAHhehH8N+DRARZCHpS4VXq5ZK6dA=;
	b=dHVFp23SChADHwEf2NV1osv2pFFvdop8NGORWQ9S3Y/+7DUN37NqL7qT4qzceHNJ3JAC
	 qi9ukVQAi8tp3BxA1zaq0KXlbTaE5EtO0DKGSHXcHWIYPzKGL3Z6UGLeMAApbcDpB00EV
	 fE7G6SJOztlUalzJLABJgstL8DKQsQWEzd9pHCizw3V6ZeF79pyxPnf58HYjLAFbhS44t
	 7HouDuJfo0TrOYm61+Q8Xaeajs+p9hp8nJPfSU5DIPwgbBMS+I4vY4eWL2V2/ZjCtcy1w
	 ZWl+/v2XgtkxfgrvknohV6xGQWborJCnQ58exDasaBzOnPbnHwk5lkEpmuram7R2YhA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lHJGXIw4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA096606A336
	for <git@vger.kernel.org>; Fri,  6 Nov 2026 17:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BA096606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lHJGXIw4
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c246c0c60so382540d50.0
        for <git@vger.kernel.org>; Fri, 06 Nov 2026 09:27:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793986055; cv=none;
        d=google.com; s=arc-20260327;
        b=PeRTFRnokhalTz+14yY2Hn9knrhFouacbwi5sstASw78/KKcZJ4Fr4h+JpWENVU/vu
         XcN0PmEUyRmumGkSi9t5tsiDKquqFsclPxm7cAwJnmk3YpqZ8RZIfsTROsbyPPraNVQV
         C/EUx/It7nFrr4TY+F3GfEZI1uIHHiZqLR64ahpqnk2oybCdGpL73BnmgMM0rn7jkQ67
         MDW4HVfDBz/J58pD04TOIwxCKBdYf7M5EdZYhVXNZdTnv4TvP4DxBKK3LsVQQ40eu5OF
         1taZimRP/7bsayBoRS/1hohD40b8XyGMiCIAJF4goi028wJ7jvodIH4qY74l+JRylpuH
         b5hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=PWyRvsWoxC5/mxqAHhehH8N+DRARZCHpS4VXq5ZK6dA=;
        fh=fGSJMDFrkkEDNS6+QfBczVJpie+hBE0ZP2ZqquOXZKM=;
        b=Iozuw2ZOzVybNlSxVVf6g7Xn+Dfe7+VPJN8miAc2Yp2/flZEDgiyW043ksTpY2OSkL
         i930dNbWLcZi1Zd8Q752SEGyqT4Nr9qcAmBahOvy4to/5NsgAdM7CLBSuUI/81rUrAbi
         kyPnH3Qta1bJCaIXbsG4DpiB2jfwU4/XbvsLN7Z4EhbJLfsSshA8pNiB9mF+xRDq7WYz
         kjuYZmngFDbl+Yuv4uZRDrA/gqYhHib5h+kfyj91fIhD1bPHYiszF/6nEwpoAjXP8h+h
         ln1n29gIRx6glraNMgOyD9Hvzgu/esfMGM+HAi4i9t5k8MIgWw0PHBte7qT6/b2zTtfy
         gbrg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793986055; x=1794590855; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PWyRvsWoxC5/mxqAHhehH8N+DRARZCHpS4VXq5ZK6dA=;
        b=lHJGXIw483yCmaDe/SHEm3UXR5n4C6EZLct7ww3KhUFTMscS1VdfgSy12pFYmPmvHl
         tEvnhhZJlZp41wTbjvQsTnpywiAhoWbpBgRLrC0vIAxs928Yiv/IRp+R3TjNreRg0X2x
         Px8BV1YEFtu6NtkADa3IoFQLBSF8nrLSQFQbjntgAiFrUnTmP/3ypQSqKpPcnPtpqmaC
         aWwBHh+xdNpCD/X1Z9H1g+uHcpUc8Ry/OfXpbjlEeRWvaRQ6ZrCutLB+lr0+XxFOJM4Z
         OF4MFw3rFYxxwIyNhrO/jiyIYLe4QILYfKihtHK0UCNezYuqaveXtFJE8UrPFCxTJXqJ
         sO9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793986055; x=1794590855;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PWyRvsWoxC5/mxqAHhehH8N+DRARZCHpS4VXq5ZK6dA=;
        b=JOrBgb5kU8ws/2K8blYFCQT82oMamgSROQS817eBaHdZPSFmbPvKqVplh6A+7bPjcq
         dbT20uypmtRYGCv3xj+U/Woj6jopThrVtTH+cCiwXw4tPZGCAgHSRm9558ovv4jIO0p7
         R1L3QTkhWAFMS763EImaPt6bob7p54WMDqUq6DuHKdi0Oe8Z/qTnW5s37R+ZlUygSDtC
         dHgX8/eNODpZazRGdWoVV4qi6WPkNrBvh5pv5nbbWZ6Gv7vD1V5VRXjB+qbjtT+YbvPE
         A5caqiLYCHwnq/kKVkRMUSxPaL60taWWylHrsaKlE6GQTcJrixTVCp89jwXS5BxxCO8g
         adtQ==
X-Gm-Message-State: APuU4Z8HKBS8VraOgJfg8S9RcGiJ/Hk9eb1u04nnLUhDHzEraKJ+5w7v
	s7jQ9phwcqDfmUGKOeMW9tIaaiNcOnhsz1TBmAdaIGpkS3gdAMaDUG3GV9n9R87zHx8mwdi2+ow
	R3Y+s8GXrZ4iUdSdPx+/cI6IcFfWS/laiW6o=
X-Gm-Gg: AYBFou3lM9W5X2VOOo6F8xhHsXpDNmxMYpvENR5ZaLMxjfhTfw6BNmhyeExRxqzuiCs
	9DzSSLv/9cQHvMW3bnMMWfspt76jgdn1G4xRG9JdxJxk1vMhihc3swn2C0VU0EnjUmRD9/l2qQf
	fLwTPMUK/wE1Z7OoO2HpcWLn8QjNRjii6WZ4apKeVMprfHt7jkvtIvwiZsLQZIuL4br9p7IuW/Q
	g+sCY/VU0JkCy41uFc/d/rALx6eVB0oBSI4qz0ChCl8ZazEYCogzCve1Ys0jh/2ASxsfDGrT9tT
	YV0vkYLLQUVaxa2mioSR5VRapJ8A/tUG17gg2TBtC0aejfXbrByGQa74XBMswk2NxOT4en/ieuV
	af82O9A801CrmzzN3UphlgsiHJ9tCtvHXMg==
X-Received: by 2002:a53:d44b:0:b0:677:c21a:ea51 with SMTP id
 956f58d0204a3-67c143def8amr1192896d50.27.1793986054598; Fri, 06 Nov 2026
 09:27:34 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Fien Dora <fiendora5@gmail.com>
Date: Fri, 6 Nov 2026 18:26:48 +0100
X-Gm-Features: AclHuK_CDvYFpv9JuF-zdE3RIr1SD3MUDxqInWsH7huHG2-IZ7KScm633lI5fn0
Message-ID: <CACWAS-X1EGU+esDOeym+HnLAUqyBO3nBsboPU0RTV-RF1HKDfA@mail.gmail.com>
Subject: [Outreachy] column: propose using early_scan_options() for --command
To: git@vger.kernel.org
Cc: christian.couder@gmail.com, 
	Siddharth Asthana <siddharthasthana31@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Christian, Siddharth, and the Git community,

Following my earlier contribution, t1402: test --no-allow-onelevel
option precedence, I have been exploring possible follow-up work
related to Git's argument-scanning and parsing improvements.

I have been studying the new early_scan_options() API, particularly
its implementation in parse-options.c and its use in fast-import.

I noticed that builtin/column.c still performs a manual early check
for --command=3D before invoking parse_options():

if (argc > 1 && starts_with(argv[1], "--command=3D"))

This is necessary because git column uses the option's value to load
configuration before normal option parsing. However, the early check
recognizes only the exact --command=3D<name> form, whereas
parse_options() also recognizes separate-value and unambiguous
abbreviated forms.

I tested the current implementation and observed that
=E2=80=A2=E2=81=A0  =E2=81=A0--command=3Dbranch is accepted.
=E2=80=A2=E2=81=A0  =E2=81=A0--command branch and --comm=3Dbranch are rejec=
ted.
=E2=80=A2=E2=81=A0  =E2=81=A0--command=3Dbranch is rejected when preceded b=
y another option.
=E2=80=A2=E2=81=A0  =E2=81=A0Repeated identical --command values are accept=
ed, while
conflicting values are rejected.
I would like to propose a focused follow-up patch that replaces the
manual early check with early_scan_options(), mark --command with
PARSE_OPT_EARLY, and add regression tests for the relevant
argument-handling behavior.

I would appreciate guidance on whether the existing first-position and
attached-value restrictions should be preserved or whether the
conversion should accept additional forms recognized by
parse_options().

I also noticed that Cynthia Uche mentioned git column as a possible
conversion target in her internship proposal. I would like to
acknowledge her proposal to prevent any potential overlap before
starting any implementation.

Would this be a suitable independent follow-up contribution to
undertake now, or would you recommend a different target?

Thank you for your time and guidance.
