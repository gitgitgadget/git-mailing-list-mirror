Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVfjSyIC"
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68CA410C4
	for <git@vger.kernel.org>; Sat,  9 Dec 2023 08:20:46 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1da1017a09so369002166b.3
        for <git@vger.kernel.org>; Sat, 09 Dec 2023 08:20:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702138844; x=1702743644; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UF8RjLNXJrKIN/tS6NgqU/52Tft5AkBHEeMdJqwjiZA=;
        b=VVfjSyICKJ50ngVldJjtliLlp74TtFJgK4grKaJAnpiy/yYijsCLjf484hLMm+2xiq
         2DPsNegC7TkvjrVhxN/eG8WkGb3dq1uMPfFRTiaIUFopqcR4kfxAaCK+54POwZYaqtq5
         NuJ75ikNekMJpIeSeCXfEIJ3kNKVF4av5rdK2g8P9m0FxOwQ1tm+HfwpVRIyJDblMKXD
         McqGyUaqjAl4ZIcf2HySFq6Oubyi6AW24wAfJEaVpKJZfj3R3UOA/h8lvxHMYQ1L/agr
         67GjawfhfeCyVpzw2r/TNNsLuxKhIY452GnzXYW0pphoRatQlKkNZKuY3EvA9tsa9NBO
         Xukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702138844; x=1702743644;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UF8RjLNXJrKIN/tS6NgqU/52Tft5AkBHEeMdJqwjiZA=;
        b=DQ/7cTX/Si7n8v3q8dQZhP0FiiNa7N8AgUEKBeCXQZ94aI59D7V82NKqG2o+txb0Pk
         J81rX8V8N2dkvW9Fay0ZWK7Sdg+QLwW4QXm096DFV58pLfDLuy4cSXhxCjuKelF1BQe6
         50CqQIn7eNoK9RhLDi0lz8U6wiREjXGf3EGKu2l8+wnZXmJmPepGWCF2h9Gfs/7AjCc/
         xFdmihi36XqjZSZ3uMZRXbtwWHj0IzeeL0ZuyX2fhekp0m6ZrS4IgpX3ec2OxdqhCFKQ
         Q814X/aGQ5n3ljL+YNPlGiSgMgzfxYQCiYNi/pmSpiM9ZkEOIl1cGIdgeX5rxsosgLCB
         wwPQ==
X-Gm-Message-State: AOJu0YzxV9QXTrettdF08gBLOglelEXNImo8F0O1R4H9as9+enr5P3MU
	NINSYnha5g5cb5KcltyFG3nDw1se9IcfnYRAkD+y0yi93iw=
X-Google-Smtp-Source: AGHT+IFMAa2fXBmVWzYKpOpZIz4MC2OTXqQrTJl1L/YJCOAEUAenSEkKzsY/7WKD2m1IQZXjU7N3W7v9d6eR8hkUplU=
X-Received: by 2002:a17:907:7d8c:b0:9b2:cf77:a105 with SMTP id
 oz12-20020a1709077d8c00b009b2cf77a105mr1231912ejc.15.1702138843799; Sat, 09
 Dec 2023 08:20:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Sat, 9 Dec 2023 07:20:31 -0900
Message-ID: <CAC4O8c--k5ajjRMqumfE0LHnLDGYjL0jnBvJkP1oqrcWLyjL2Q@mail.gmail.com>
Subject: [BUG] description of bit bisect start wrongly mentions <paths>
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

It should be <path>... and not <paths>... in this:

     git bisect start [--term-(new|bad)=<term-new> --term-(old|good)=<term-old>]
                            [--no-checkout] [--first-parent] [<bad>
[<good>...]] [--] [<paths>...]

This is worth fixing not only for consistency but because path is
mentioned in the subsequent text and paths is not.

Britton
