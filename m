Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE17C1531C6
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 08:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724227847; cv=none; b=pLcuEqH4RfTbdkaOT37Z3stgIXGMMbTthYHYb1HQPBhBD1T3y0Kz12WfeoAQuqPkXkenNL9zIbdp7oXEVTkIINzRNYKV+vmvKQWLiGdG3SX2B2vMge/uI8TdUL4d1lzWGuDG/9TBF3mcn/wwI0fLm47saXwnJXVU25AVoe6iWA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724227847; c=relaxed/simple;
	bh=cbs5dLi65MKs9pEnh2QJtEiX+ueQSDy/qu80f5osBy0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=N5wlLVjuOh16/icCs/OLsZhOd2KPRc2jhvioK1xDWco7jSU6ZKacIevNXeZymUSGLdb6xj93mJz6JoLOq9OIa1SZbQ1M7bbmUcduR4ZAt/oTNRXhhc4CDROLqJDmlLrTjtv8XR8+eBqt7gjMPQ8dEHkfNdjHQ1WIVWDnsLPEdxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JI4dV2+u; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JI4dV2+u"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-44fe58fcf29so35623751cf.2
        for <git@vger.kernel.org>; Wed, 21 Aug 2024 01:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724227845; x=1724832645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cbs5dLi65MKs9pEnh2QJtEiX+ueQSDy/qu80f5osBy0=;
        b=JI4dV2+uYYKGYDrD5dJ4qTPQwSRrAze8G9v6vmvZmoimAXprrHF0EO8NnvJ7P2zT5X
         2B22OEoF5U4CpzcIH85DvlMT7fu3En2B5Fug1wYrNu4ryA4WaPF63iJjgj9B7baMcKTh
         CBVd8CYyW4Lyp9MtuKuO5k3IyU+EVkeJsEBMyq4y9NsmyUAS89ogNER2PpI9xHP0hbBq
         Xb5vZ+Qhaarsu18RsccoyfFkdsKQ/USoF6nCT9KUvbGVa1Zq9z+T64+C45q4mN4zTV6D
         rMXRCHq9pWB6uyZcIznib33vCOB+9F/6M8+3JnRcNmyumlWdr+b0X1GpLPPAJZfSyXEu
         X2mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724227845; x=1724832645;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cbs5dLi65MKs9pEnh2QJtEiX+ueQSDy/qu80f5osBy0=;
        b=VpKm6bjqYL4I3d3vYkOogHad6+qFxSqiXXFAOjUBFO9C/0zDzV2GZY4FPNGfb4iAEr
         KNqhJFCmI3sLQFLGjpvDtzjnIF6eGuMxI5cVqWbdsQ+/jC+6X0oHytkRoiNJiW1u8ejn
         b6aFKltpairvGsiyS7mhn3clNqAlMG8s90HHfNgKwHl/VCcXAVJF+pzVlFVmv6ZZ3oGf
         PzvhXwyNDE6MdYCwOCP82pNRRdsithQKnsQlsDyrdiRUktfcRSH37NIOmE+0hPLBCxeK
         fJTCiBxhTTEDJd7Qiv/Pf2anlWd6og9GP/cwxrButP6MdwEjzFJN3ZTjzLuOTK39/736
         2+Hg==
X-Gm-Message-State: AOJu0YyrPj0t4NPkmrSA7q/kDAyHlUfgkiEm6S1/4KSE+AWnUlRDqCkx
	xOH0TNhVJBX7MZWDjFn3IlXJTDMObcbxLWewMbmtXKc1BQp9AEaetfwsnMCh3A49aW5n3Usef4Q
	Ju4JiQbWpc1WfOOyxjoOzZkzAvA4pEt3+
X-Google-Smtp-Source: AGHT+IFSri32bxwCa/RFNDPqq+QNxMU+Uc4/XrtNlUJkBMDWLZJs4pDIkLJ9V4hS8EVsQ9dBlPookAhiObFS461NH0Q=
X-Received: by 2002:a05:622a:251b:b0:44f:f6f0:7d2b with SMTP id
 d75a77b69052e-454f268675cmr15473821cf.53.1724227844473; Wed, 21 Aug 2024
 01:10:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yukai Chou <muzimuzhi@gmail.com>
Date: Wed, 21 Aug 2024 16:10:33 +0800
Message-ID: <CAEg0tHTWzgD5bw3oK7-Rtv9oTymqyhvZz3bcJ7yNRhF8wXMLGA@mail.gmail.com>
Subject: builtin/config: --name-only doesn't imply --show-names in "git config get"
To: git@vger.kernel.org
Cc: ps@pks.im
Content-Type: text/plain; charset="UTF-8"

The v2.46.0 doc of git-config(1) says

> --name-only
> Output only the names of config variables for `list` or `get`.
https://git-scm.com/docs/git-config#Documentation/git-config.txt---name-only

But the behavior of --name-only is more like "disable non-name outputs
and leave the output state of names as-is". Thus using --name-only
alone, one gets totally empty lines (which might be weird); only using
--name-only and --show-names together, can one get output of just
names.

# get empty line(s)
git config get --all --name-only remote.origin.fetch
# get lines of name(s)
git config get --all --show-names --name-only remote.origin.fetch

Either the doc or the behavior of --name-only needs some adjustment.

Yukai Chou
