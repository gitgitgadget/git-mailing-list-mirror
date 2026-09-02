Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF643803CF
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 19:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788377248; cv=pass; b=o3/q11hdRY+bttvAe2dmED4HdsGgQ3FIa548Rfx7hPyTpi3CtryOH1ShDfmejaZmG/anktbaL7zyZ7SBU/qp8yWQUEZFbjGLozEqGRYHm8dBU5yBUrQUnq08SV+0CIBvvYkHRwWzNrpfUVzA7Ih0UwvPV5O2Kwd8hrfB2exjEDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788377248; c=relaxed/simple;
	bh=a0jEpr5q2AgOUdl438IIkSEo9cEYhH8mtw27eM+3qBU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=nrZfKdgyJMK8Ze+hEZdWfDA3PaQACzEZsQ9A/RPOmZ3wHYgLSK2RFrABa0j1FFdpQmk0srCKHviQfMNhfnEpGyMGLrVY/Kw/Aidbebq9Rr0MH2hyPnKOxYWANUE82a614QadqV/5r28zTL+uR7cEpw9h4jN/xt4WR7t3OPPdS3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B0sijcSn; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B0sijcSn"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-cc1c8d4a959so1296021a12.3
        for <git@vger.kernel.org>; Wed, 02 Sep 2026 12:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788377239; cv=none;
        d=google.com; s=arc-20260327;
        b=RLE2/d14QpYY7RniRFe9Zj810Qq26yMInzocRHNrxOJf5/lK6mS8UbxykhntFu/pJC
         f5kBa4e6B3bXxI17EL+HLD/Xd+r6QgwqIdvkFlWKwode0xn//9MUWVB0z6xyiiuEwyiI
         OpwXyomsMG5kP3cp0nFH7k6MROvEkC1AoDOkPhORZXiBQiXEMHG2c49UHTR/26X9c/n4
         ippxB756dossyx8BDVm/i7hWb7scwx/Adij6Mo6Yq+EJPms8fr1sJLdhNtBB2X57mf7V
         vY8NBSOE0h6XrIjIXzP7t6RZftul9XvbmOkeCXLCUhJ/8x6q9Wc5yqYTVzhfPzABQZpD
         BLMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=5tQmSj8MkF4wLTKD07tmqy+KRdmyHXYAFL3qPzMKviM=;
        fh=nYFzfhBEk3egmZjYiXDJWWoxlIFIUnZU8sfU7GNtrQI=;
        b=rBVLKOcQD/OrvfnTfKmkHqOoPcK5QH37N2f25AJCkxxoVq2AXUrDMDgZB9jywah4mB
         s9uGcad/Rbu1EW+sVpDDt5Tseg0Q2LKGW13KJXk4UhpOuNLIU3RXrM2cYfyTqFEHZDTY
         NoNSx2WAEQqmdVzAShxlYFS4/LtjpWfCUJkBZvkzdrLIItW+U+phm9xoixppsbxvl82H
         FDviiF1aQsga5Vz14Pr3FuTTpj6IXPdU5JkCJfLNmLu7ILjUk+9lspUT4XLWPWE+iYLQ
         GQyh5VLXjo7cyKQVKH316gFvWwgVUFfxkhc1bKmtpH6yYqsJGfim7qfr4YNMDGU6lX4E
         z1aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788377239; x=1788982039; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5tQmSj8MkF4wLTKD07tmqy+KRdmyHXYAFL3qPzMKviM=;
        b=B0sijcSnWFH4drJCOoJ/RyZ4SDxAD+LAKdMIWz0Onsl1GvMsY+G3WLuyAkhVgi07fj
         WAlIlgevN+Yfwqil5j19tuUVmgbs5e+aXr/EFkVuAdZWq06anbb+l4zcWAy1a63PtRFo
         mFUN9uiwNhzcNj3+0BA5b/+/CEYzamlH6QFjuHBKCKek1c2ElzAib3wk/0QWiRn/fr0Y
         dfhIX8TCFyXOTAzQCefto3xL6/DmMyj5/Qe1XMYSyZCSdojNbcFO4xbXE5mh6k5esFm+
         fOWxcY7xUPr9qZbrwAIn3k12XY70lmZZD+chK84TKqW6GWrZ/OXPw9DWvy9PWYzImNOb
         ErXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788377239; x=1788982039;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5tQmSj8MkF4wLTKD07tmqy+KRdmyHXYAFL3qPzMKviM=;
        b=lPN36QkQ1m/aek2JqIAts30uj1sKCvTPGEoQqgo515giSkoYEEFNkBLy7/w4kJxiDO
         jG5N08+cQORqi12XoiZZtYCqJ03uH3ksSBSU2Ni3Bfmb82JSseGPgS3QM8XZxEcnD9/i
         jueOCSlPiOlOPNJ51ns0AUvlBp/tocSvLmp8+6h5eDBs/fwkJZ67c/IVFxvUiRWe+Ie0
         qSI0qr+ay+UWj5dfyhKjjO9tPqR5fw2pKZaeLah3YOz8Ouq60AxrsordSt4+yUTDyvYq
         ACGIHubwfhwB8rmp5QQcb3PhlvhNpyZPwWfa0ZPBDJF5dyXgGk3FcvMX9PbUBAmtcZLg
         j89g==
X-Gm-Message-State: AFuF++mpWc3jZVe+P5E0gOL52p/gAVMoSeanwPZK2qkKNEi84zSn+Nll
	41q+lle1J5/utf/nKsbo6yioLRWxC5k9r4wCn2rc9IxWM4QiuQbZ6olGZLHvVYc5GP/gWFBaHPS
	HiBtSwsn4XALDkxNg/Nu0J0BWcvpUH/sqvQER
X-Gm-Gg: AYBFou3+G5oDShpF/tjNZYiNin41rjMUwxnJSEgiOEuQRQIM3ZYMOZGkfWE/EMxF5df
	M8v/WH8x8THyFBZwtzeJjAseTAsC5WdFYnbqjl9CEWXOp2MXBovddmWHlOEXj01Xi+zJF9RxG5i
	24ARlft2FawNdKpQhBISo8FxB4iHDBtqlgeSmeI8ISnKs3809YetYmH/KhlTGIyRolPKjS265eS
	u6GAkevPlq5df0XRHF5HnDEcwu+ZOZ/j2LAkyUF/RgUa4RIx94EsjG863FVp/jF2spp/MppUadt
	++34xPw+rKYoXJfwl6nRCFDdzcsoGbB290YTzSGVSlseUQ4bi0i/YZyTJhnTN+rvbMkIZiCSJAG
	GXRjK3iuv5o6CuR6ksj2c0Hd/15JestomtuX9nff5+Q9dXHYMK1rC8CPFUunmgsO35xaI0xPWcW
	/lnbjuiaWgdG1bHEaPJ4ByPCFaQN8X
X-Received: by 2002:a17:90b:560c:b0:398:9bd1:3211 with SMTP id
 98e67ed59e1d1-39aee0e3e98mr11155945a91.18.1788377238713; Wed, 02 Sep 2026
 12:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Christian Couder <christian.couder@gmail.com>
Date: Wed, 2 Sep 2026 21:27:05 +0200
X-Gm-Features: AcwNN1WeLY5Fza4A-4mb5VXtx7aYeIyx1Yx_F3z3WMF4RGXPnBTeB3Evi-Hbq4w
Message-ID: <CAP8UFD1LKsxiR6BCHxj_GdAVC35=dyGNMi3rPQo6uYhfkgUnRw@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 138
To: git <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jakub Narebski <jnareb@gmail.com>, 
	Markus Jansen <mja@jansen-preisler.de>, Kaartic Sivaraam <kaartic.sivaraam@gmail.com>, 
	=?UTF-8?B?xaB0xJtww6FuIE7Em21lYw==?= <stepnem@gmail.com>, 
	Taylor Blau <me@ttaylorr.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>, 
	Kristofer Karlsson <krka@spotify.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, 
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	"D. Ben Knoble" <ben.knoble@gmail.com>, Tuomas Ahola <taahol@utu.fi>, lwn@lwn.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi everyone,

The 138th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2026/08/31/edition-138/

Thanks a lot to Simone Arpe, =C5=A0t=C4=9Bp=C3=A1n N=C4=9Bmec, D. Ben Knobl=
e and Tuomas
Ahola who helped this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

  https://github.com/git/git.github.io/issues/860
