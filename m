Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A1F13AA2F
	for <git@vger.kernel.org>; Thu, 26 Jun 2025 17:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750960704; cv=none; b=W1rPRF2bfho8e/83/vRiUYDxMIa8ErDEWrB5q6tZ37eJMnZ9FkyZ/0385rTzwRWKTmB6eO3T9KLJp2FPYK0kVtfFcDl7Qz3tRgIJ8QifsnGyNzUG1p+WeyFcI1TdWcFVREcKc27jJXvPUYOBUoUVUyYP3aWZ4pWuRHQ169XiyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750960704; c=relaxed/simple;
	bh=JH7vSmPAiukhmouEQX/HrPXZz5fPcaSt0OCfPSjPY6M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=WiFKXForU8muw5nF3mv8Czp7U7XKQvZJuEPpbm+ITpj7gXNqK8P9kHwRIZiTAJXK0wwurEQIdAg+HK6JWvv69yo5TTZfdbSAYK1tf+qdkq/NhGeiyQU8OZrh5tmHONWfZpWLRHEIxoG/KQUKGpeUSX6l0uDKOXCxXB0B9wTSiSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VT75OGEX; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VT75OGEX"
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df34b727dcso11222665ab.2
        for <git@vger.kernel.org>; Thu, 26 Jun 2025 10:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750960701; x=1751565501; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MFYkxe+p3V5xBEVbzBrj3p1RURoVdE2v0G3PvryCv18=;
        b=VT75OGEXyA9cFQrcquV7TauUJr3Cb8F8Mv6p6JPSzaWs3C6vtTyw42lfrL39WbIyXr
         q+eQ8aWCOmSqM45b1HWC+l7gJrInXpp7I49b+yV2fsjgw+AuYrcka/0w/t/smmr6dqZC
         J9xs4FuwuLPybV4votVNB0Co1MafKwqHwozRBw3scuQG0LlVKX5hPIGA8x4Br3wqYkBR
         5Mow0iNBj68uOgUrZnlJQkUaBbvghghFwPpWJsdDbVKW7M6v4uU2wYR3HVPRPtnWP8vR
         DkKVEriOjSXIZ+6gjx9iJiZX53R4R1DFR67x0m1c7K2wldMDa2AP+qLxXkRhRVFGDJVK
         goIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750960701; x=1751565501;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MFYkxe+p3V5xBEVbzBrj3p1RURoVdE2v0G3PvryCv18=;
        b=fF2u59SrSHPadd3KM59OgmOF7NWvuC7FAvPwEHqfUJ5lZZE7JqCrlSrlZp5l8Zyo1h
         NEhcAYBQmZDOJjas/CmzzWRvG1QJLb35bq8gzWEsU+hX9F91LrAmbTY+DWdBQfRwAQu+
         l6M6OSNkoBzMFfQJ3he4FUMOu+Uo2gD/zwfxDobLpWHjanam/y1i0WALao3GSI5cDhDX
         TnGFJgYuKCyUYQlY4Jus9MtUZoTIgoOA1Q8++OOSrLotnmMT8b9TPuQo0YFj/XCyHRnY
         6fpHDNpjJ+8erDtq/6yrTsCRmxCis66hd3VbWcwjerna3LIYAqm7XsOOZNj5ZCP3Dqkh
         ARPw==
X-Gm-Message-State: AOJu0Yxx0y0f6oEhPhlhxO1jS62Qk1NCBWAXoiMYjyjgkaamRMeckSja
	7ftIWYWH97AynFyJDL5UKQ82fRWGSJdLchnjyM50z7TexHfniTy0Znmbwv2bqGXlPBYWxqpAwwL
	8JlB/z//tF4Anc/CKuRKI5OTu8TztYbBZzi4B
X-Gm-Gg: ASbGncvUkn2prsr72FzzG3YouFeYcTCWdiCA4AYwcC3AeP4EUnoW6BO5CnLNpXhhbdr
	YD0z4SfaVZMO1d29WEjv5LqrFddujyifM5StiLf7WOdXDxcTns8fL3AU/ZxWC0DLq04i1aORGQb
	fTaPhd9h5KdphwdPBBFh7Ok/TzAX2oecJB6Khzw6ZyXnvYz/XwtZhWblsWIiwX8HgRZuc2b9FGX
	iclhA==
X-Google-Smtp-Source: AGHT+IEVXprVBMlqpxlUOHBIPPtkpBb6PKEbKwdoWmWm9/2tQ8+8JOgk0NfX6oJ4WZQ71aIvjwmMfFgB/31RlKCvUpc=
X-Received: by 2002:a05:6e02:3f11:b0:3df:3af4:ae4c with SMTP id
 e9e14a558f8ab-3df4aacd30emr6298575ab.0.1750960701517; Thu, 26 Jun 2025
 10:58:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Brendan McDonnell <bmcdonnell.emb@gmail.com>
Date: Thu, 26 Jun 2025 13:58:11 -0400
X-Gm-Features: Ac12FXz1rVcDJxCyTtKFM68U4LVFuAFNaQtlDLiv7gkCCv_HQCoz315fl4M6Gnc
Message-ID: <CA+MGQRBjx2XfhFo6Bs+X_WzRq9kB-ucZtTuw_kAfuZCVKGVvsw@mail.gmail.com>
Subject: How to show "bisect" refs in "git log"?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I use this command
  git log --all --graph --decorate --pretty=oneline --abbrev-commit
frequently to visualize a repo's commit history.

It used to include "bisect" references in the output, until ~a couple
years ago IIRC. Is there a way I can modify this command so that it
includes them again, without excluding any references that it already
includes? (Appending "--decorate-refs=refs/*" includes the bisect
refs, but excludes some others that are there without it.)

Is this behavior change a bug, or intentional?
 - If intentional, why? And is it documented anywhere?
 - If it's a bug, should I report it somewhere (else)?

Thanks,

Brendan
