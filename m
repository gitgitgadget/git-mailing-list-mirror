Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DC12C0263
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769199421; cv=pass; b=OBvHtATjBmLuU6IrnE8luEP4x/wy+ca24rl0+w/bKiLz3seEjLYurKK99Fu5tmK8G3uj/yEGXcZ9PCuqXsTfKNCiV60n0iZ9yPYk+PZGNzydOeg8NB/0rPDR461z6vF6egJmrDEXac/JUwj9vdMJEQg0WgwsSDMcrK1Z+uLvK/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769199421; c=relaxed/simple;
	bh=TUNAGiu4ezEWJm5uYRa7wQsABq7yywrxmVTJujgOr44=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Ru42iqrz4JxN43G2jTjAkI0JLoLb0M7NMHtXGz1QgbShkEs8FmOjQWZ6OfVidwlXAYntPdANPNt8hNrfElVnxQ6rqoI5pdtKQ15AnQ9MtYb8qphOHrFSD2Hfea7euKdvyTvarVEnG0uXdJEcL8l3E/Lwev7PK8axsoHPxB/y8Rk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOUXJBLm; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOUXJBLm"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fba1a1b1eso43759077b3.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 12:16:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769199418; cv=none;
        d=google.com; s=arc-20240605;
        b=QRyC9s7wSGb5ehMi0ExbziCgUNG7PMfVAH4IrUes+GbndsOlpu9cWcvbQRNBQ3R3VL
         Vmb1M0ruRjsMs7WDwzACpd6kgxQopIfeRieVayrU4Hsa9o9hFaCZ1WxRUD0l+5QR/ZsT
         S63LH+JH2VVKu7BodqZtVZzrlpcvH1sTTCI10qEHVRRgq/nxyaYc9lwSnVwuFzTkbYmQ
         wPOB9mvT558Wo9FFVr8uxnQu67XvRJqdm4ro+cKz+ambbXy/I+iKFsFUe4wadGKW8xRN
         IFa3ezqlwwujps1Mk7E3fHlGNbng9BGbiHpxEBu0S9pEH3wFYkfdWl0aGYD5xVjmqCC2
         6oZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=TUNAGiu4ezEWJm5uYRa7wQsABq7yywrxmVTJujgOr44=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=ZRj6EuHB+2P9kJ+aIkbpW/4Mo+YBTlwLGjmfqh8Zl7DbY5X9a+NKBZDfqnuqE54vQx
         Tt2km2G2QY3qeATefns618CrsHpCkOKmDc0S2v7DHtU/il62upHcQrnA0b6MyzyL6bc6
         lK5vchnyKG5vSu1b6iDGnqEZEKjNkWtP3o/4HPabvZnvBcnAXfVLYw92W/yVs6UYihmK
         GnbnKNdZwrCQGHu/ZtqFm43/7kFCVBvPPxzwpD9ON0Z5hLQKXwPqWT7QdXNpIvg92+t4
         +vpCEdrbHw4PBl5EDVY3S9bzxlVIOwEu0/bSty7mgBpx2hA84Fg58M5GYlfzLIuVdbw+
         me2g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769199418; x=1769804218; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TUNAGiu4ezEWJm5uYRa7wQsABq7yywrxmVTJujgOr44=;
        b=gOUXJBLmqlxMj5HJgWpaqseKprkgG3by9YElm31RK4t9y426bCqZ9LErDp7iXpjNkP
         FJq5A4vq2BQaBrDCqRMFRMiALDQKgjVmsFcKAsdNGqQ5dwQe1CSZgDAQ3CXNsC9o5VlC
         ZhNNMVjziWBez4LCvrDbljWj02MJ8x5q/iiDUHxhiTkXeF1r9qJXaHXPpFlRHg9q3yTV
         +a9sfgn1ZLb0RNrNPH/sCmuXceG6RpnGmA+nPrr2VR/bArGwWK5a8zJ+h3lGZv6Nl/AY
         kXien7PTje4Q5X6UoC27zm7Cx+Uu1+JaHgGKcqKfC5G3SAjSDyaqiU5wYdOkKxrtxNh1
         5RHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769199418; x=1769804218;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TUNAGiu4ezEWJm5uYRa7wQsABq7yywrxmVTJujgOr44=;
        b=KBK9TiooIHAFtLCfkUhg2WnHvxzGf8lPJW2RMBHpXCjZDCTceC/u3HloapsFnitmSI
         d5zhJnpNmVvsU/jsymn4jSmlVWHMkcmGlP2rjfxNMnKXz70EC4uCjD3uP8wPZ/fiHevJ
         no/v2Q6ITJ6audQr9eFouOVLCJNHuLfH8cXoday2JHgtPS+7TInqlTGYoaU9w9LhTkOR
         oAKBw+kAgaX1d/dmEukbK6R4ITMlRzE63ggQkJecKkt13LYHHF4atKvLbH/Xv9LdKinv
         G9+vgzNd5c4I8ZgXYOnzUU2B5444k75PRdVIZBmCt/kvaRKRXZO3UhBrDmEHHtkw+oIY
         125g==
X-Gm-Message-State: AOJu0YxXbSUxfJPYc9MdiT+4nJM5yu9ALZKHQ3BK3vul31dI+aHR7Qqn
	KFHJvhm195fWAXCN/ThAIhiL9/8/O47ANv4hlHk94T+6PLYExJvBevkp02k2dwCruqWbD5GSTHT
	CgGx/q9xklqraL+jOXLCHblxhde7QPwlDXycQ
X-Gm-Gg: AZuq6aK3A7uj8RITjga2gsvfEvwtTnk8R4zvBNE1lwoJDE2ZtiyMImbugLcdmRl13zX
	UMGJd9O6bcycenXOPBobWvvlPX0IOu/IzYLkhlYCmJhK+LB8CJJACflaE07HdynGoEQqqjOQSX2
	iKuyc+YJJc29IQKs0RX5e0st2SS+Z43lUasseHN8xR1s13fk4HqfAmaaWY1VJ+z53tsrjfrYW2o
	Ai6pxZJ9VLsysuCHejj/eNUXgaXSDfXk/VfZAs/RsecNi9fS5e+cSq6KaEP637gvlOeBmz4GUZh
	qWHk
X-Received: by 2002:a05:690c:22c4:b0:78f:fcfa:c966 with SMTP id
 00721157ae682-7942a8a6fcdmr62957807b3.30.1769199418021; Fri, 23 Jan 2026
 12:16:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Klaus Sembritzki <klausem@gmail.com>
Date: Fri, 23 Jan 2026 21:16:46 +0100
X-Gm-Features: AZwV_QgZjshu6CbxF7aPfTmW0Bk1HZZIsRnKwBwOt4rufvw4pG9lMTM_QtP2i0c
Message-ID: <CADMnYXDDbVBwZgETsFhwkOyn8cM8QU4+YQs2rRfTac6ec49-5A@mail.gmail.com>
Subject: The SHA256 of "xy\n" (ASCII, no CRLF) contains 1337, ACBAD in za, and
 I am 1aa
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Dear all,

see for yourself:

$ # xy: 1337
$ echo xy | sha256sum
$ 3b2fc206fd92be3e70843a6d6d466b1f400383418b3c16f2f0af89981f1337f3

$ # za: acbad
$ echo za | sha256sum
$ 28832ea947ea9588ff3acbad546b27fd001a875215beccf0e5e4eee51cc81a2e

$ # My initials (ks): 1aa
$ echo ks | sha256sum
$ 1aa44e718d5bc9b7ff2003dbbb6f154e16636d5c2128ffce4751af5124b65337

$ # 50566750337
$ echo thinking | sha256sum
$ 50566750337beb9e98e553fd9196d10576f9eb0cbc6b66e2586b9d73af4f352f

Less strange results, but I still wonder if this is random, as
expected after reading this: https://crypto.stackexchange.com/a/12840

$ # It was bad AF BC:
$ # bc, badfaf
$ echo bc | sha256sum
$ bc18cd878fc136926875bcb4bddc7f3badfaf4298f5dd1a9fd4c1b9692b624fc

$ # 439247560, 1532557
$ echo vw | sha256sum
$ 439247560f158e6c80ea9b43c3345b4468ccf6fb1532557b1bab8908ad8b075a

I do not need my name attached to these examples, even though I am 1aa.

Cheers,
Klaus Sembritzki
