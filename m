Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE9F83E44ED
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 04:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790655838; cv=pass; b=q4QuJGuFtbOECsGnnMdfJ7txh0lgt38WA/P8c3CDTA3d6eaA7GU0VE2jhlpxJ8tvD2db/C7+Hwa7OG8oq2NJ/TfxUi8KpSmp3HSHuFKyGEOBIhlZNiqXU7YB8qsekMxkMotANw2rwCqK78hOJeZXdsXYUeRBP0UIzmWGkKj0PHs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790655838; c=relaxed/simple;
	bh=ImvwQDpKhGKdiXb/EZmN2u+hnM7CMYzRNoY4MzGFsA4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=SvHniWKh0uYoppLBZHlolYDoDiXNoZ3l7mEZPIeMALIgvB2lTXjXaSjMf7E37UXilTUbgvhDgwIQzvp5N7sr3bpPighF/nyYkJNn4i17/xOt0rGMjQOlQJDFr67HM+WNf9AlAGjw0zO/WvQqCgUCmzg2U+xbUStw3j/l7tlSdiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V+3S8053; arc=pass smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V+3S8053"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2df698f77cso37637166b.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 21:23:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790655835; cv=none;
        d=google.com; s=arc-20260327;
        b=GHP43xmhsI6IRIax8xuaSWCk35yvx5F2IIDCFnHlzujUk7MowB+2H2cGpte/s8klyd
         Y7vUIc5aVtXCvf258Ax6Ysbicz7mQCcAOLxQrCAv1mvkjKHm4Lil+1S87IGNkpMavzBI
         bVqbbdMCEI5lUNJ57IACa9zOZ96yqj48nETYvWYiiWusCKVizzy/GkCS3Jo+THsTcmmX
         BQE6EyhO7N0ppuu9BFo6syOGEV8hhaxspsYhckh9Y/yNc7OQXe1B0FzJgMN3tmvFAu9s
         17D2ab962W8RMWfMED+515XmksurxUpTF5fQ2+jmHdmMqMnv47TaVqB+d5gl5WDQoUYp
         5iQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=ImvwQDpKhGKdiXb/EZmN2u+hnM7CMYzRNoY4MzGFsA4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=V1EQm2ap0inAN4cRgYKTnbbFdsaNwdnUE3kMdzLxf+p69CuEEZGRdK5fjzMMSwR6pf
         8R7bP1g4dEwr9aFbJgvO03g6u5RWkjMDE6jCfVkW6c8GZZJs7r+HnYmT5aYwMQHfUdaW
         2p6oXXoYtapjb+HP+VsdiO1NemcYwL7d3uZB+ODRLMX6AjXO+1VZkVrziIYrlCrYGeJk
         l3yGyB1AtuFarks/Hh6gT0iCKg8rtRJAIrz0Kv2YYfQOBe39ao0jX2NXHZV7bVvp57oU
         Q3PsTUQBkoLVvYeVY3sALh5T+XD5VDfnY3QHpm98Qbzo/zk3+Xq4tlrJ7OQ2++8Yi8vL
         9dgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790655835; x=1791260635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ImvwQDpKhGKdiXb/EZmN2u+hnM7CMYzRNoY4MzGFsA4=;
        b=V+3S8053DdxyPt5gQJ4w/FqdlwNpo9tBLfzbske/kOhKojnKTSC6bgHEbcwxI9Jk9A
         G6SYtibBGBRqwTX6JNB8/dRfujX1ZQzIDd0BYWi18PEkwOOR7QCTWW8tvgMGN7MtIPcU
         F4DsJCVBAppoSvpnp0s9gaIS7BqHY/iOnDgySkY0zywCYDyQl4k375Cqu7vy9fyEpCEb
         21w+4h+3LlwbyglObAkp7zB2DAq6W5s3U6lqq1ZHKaArIcruHxoiKqzM3wlVB5xaP8TR
         vwy46kdwat/1TselSMPpwyWtGK66LR7+sFyrb9RyWRyT86ymZPOWrrOd6pfQTM7SrY4t
         w8gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790655835; x=1791260635;
        h=content-transfer-encoding:content-type:to:subject:message-id:date
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ImvwQDpKhGKdiXb/EZmN2u+hnM7CMYzRNoY4MzGFsA4=;
        b=LOj5UthYpziUPBfFfdELWWiEwRu4N3WGecMF6zAmlyNB20mkCGJ+AcmjHxrmgScv4H
         UFe3bwObe6L7lPF/Vrsqbfj++dQ/m25wxqBuDwGRiwnTk0a694nK40WYLEEbBygdEkXh
         6p4E8SScWh3vA3U816g7ZF+EzjPfbCoFUY0ZO0qZgzgkS/hEEBKtfps1HCjc1eaJ6TiJ
         ypNtY8B4BjHJMGPWFVG2GcqtJNV3X4jBvwx09QuAsX6XZpK84GP2CJx3liLxVKEo349+
         xXzjHOl/ThYZI7dAI7/gZDFllGSgOFFoblTh72TF/37Y7EhZJ7Gt7U9j84uPAkfP81Al
         XKrA==
X-Gm-Message-State: AFq9FYIyX/0McytVaNqliQNeJ7v63eNVZdk7XOJGbIXsW0b/Cvhm7eOU
	PRkB06jW5tLwBOTX+bIHryMPgqoGmtaFzgP1lJg4jqT/iBlPbCdxmQm4cuQqRY7X+WwOe7m91Wd
	p70MshQbyuCBrB9wmTRZrgusfdtzAU0LAPf3KOlo=
X-Gm-Gg: AYBFou0DvLNnFGfhkLako4MIN/t0p+eF2SC0OQIDivucDRQmslwdZLrqzGfLKZfLURa
	wnetqO8QNyK7ROHWdqQHO3RBBgCFWWIVYtDCI/MK7nkNGvGCHowEOTQubNeOefhlgrasEjm6QzM
	9g7r6dDsy+Xcz6wsybN1qn+fwm+rudOkIl7O11gWakpL2slBtCJn7nlT767Zy/RWTqnZAGZGHN/
	tY9hmvZZD8Hmn5vksE774LQ34t2xdtUC/EiRM+lOluDQuz7mGTUFa8tokqC+eUzGDMDKt98vlF5
	VfFXNZxrO0goFf5nzM9DYByfam+IrbEeYUbJHhgDmpSQwP/c7D9KQjE=
X-Received: by 2002:a17:907:da1:b0:c2d:bc33:7be3 with SMTP id
 a640c23a62f3a-c2dbc33c16dmr603037466b.47.1790655835147; Mon, 28 Sep 2026
 21:23:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dmytro Lymarenko <dmytro.lymarenko@gmail.com>
Date: Tue, 29 Sep 2026 07:23:43 +0300
X-Gm-Features: AclHuK_Bx9ltiromYVkuoSZnYfugbyaaXzuOpL0UEsFqSqzBiMlFw6JVas8kXYM
Message-ID: <CAF1QGTmK=WY_AODsfETOtzOSuwpZ_4KV5SiNPoRv0SAYeJ7T5A@mail.gmail.com>
Subject: [RFC] Optional per-repository consent before running local hooks
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I=E2=80=99d like to propose an optional safety setting for Git hooks. When
enabled, Git would check for an active hook before running it in a
repository that the user has not approved. It would show the hook=E2=80=99s
path and ask whether to run it once, trust the current hooks for this
repository, or decline.
This would help when a tool or setup step installs hooks from files
supplied by a project. The check should happen immediately before
execution, so it also covers hooks installed after a repository was
cloned. For scripts inside the working tree, Git should ask again if
the approved script changes.
The default behavior could remain unchanged, with this protection
enabled by an explicit user setting.
