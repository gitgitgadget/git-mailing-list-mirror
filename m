Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A8335E1B6
	for <git@vger.kernel.org>; Mon, 22 Jun 2026 08:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782117717; cv=pass; b=bnEeTmSz4pj3HG3B20urq2VJMpAjwvoDFDm50qvliCW5HQbzwq9j8L6uQ0it1TD0lUeNktlqXURPwIUhkl89pXbps772iePcY7fzJnOhZuggGIly8ci+EWtyaT49ECeipK33nsiBouD0VLPSu6uNJ9QTBxcG4bD68k4Yh7CmGug=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782117717; c=relaxed/simple;
	bh=iZR+2ju7++NRcGM1MWJX2pjIN+qrKg6jd7TopyaTJw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C4bTauypbkFeKyAohd/2H4LOrctnM8ED5fDhtY4bGqjq2dShhcLhqTweOGq/YkL4DtbgSv4R+t4UxxheQqqtBU6uUTYHG91s+S1E4TX4KeNNy0rdVofIcXm4MJv5/1p5nx7Nr3K+2cd2rkb1oe4rocmGe5jLxgTK3GQfFRj70vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0DrvT4U; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0DrvT4U"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-697bd21fdc2so784125a12.1
        for <git@vger.kernel.org>; Mon, 22 Jun 2026 01:41:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782117715; cv=none;
        d=google.com; s=arc-20240605;
        b=MlvC9c2Ewn65TvHt6Jsp+qIPdXERuZa1aEo3CAhqxn9UD2okDpGjx9/oDgNvlntv7W
         FbQ6ccd9a8X/tudWVfE5Zr2/Jk7gchcIsB1XdssRnbnI9Wa0A+eJmnAO3G/FDInKx8ep
         3LMP0D3dhGYz3yF6H/jmjBpjLqMskjdqLtLnFZYkJf8I+xwKS3k38XA7hzQp3bGIhSKp
         cL3GyZbgk3La/PgVkOnkN3iTuqt2kBl3FFIEUpkzCwZsOgOx/EZOZzN2FzWJapIyEzPU
         0QUDMtN7MD1eQjkDlS+OmPh66z5LRz3s0GtC6pD7cVEBU2Yp+UIow6TISGYZ0gXEKBT7
         2e8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=iZR+2ju7++NRcGM1MWJX2pjIN+qrKg6jd7TopyaTJw8=;
        fh=4taht92dzazhQDOjq8CsAaKR4Bsqe7vCuOP5jjEO90Y=;
        b=c9TZmyl9WsOzIUqYRR2/mqyD+172283K9mYCkBDvp2aXuKctGCVq2iP7eXvlvML6gI
         FeHUoLscLeOsFTs4zwoAHlTVKDDSKVA0BKrKwnMdzGsvDnuNzZeazZF9jci4QFR1s+8K
         XJnnzPSjTKvv82wjI60rxci/8thXplXgpUiTWCkcETLZR5xb5l4LoRt7aUpSuO8K6xHD
         emaR3Dh68lkYoucaDFoTazQvzvhczhXxDIxliRNZYZrWZnQUpcGx+CwvfhVdtSP37KPx
         h1zrBEgN4ZXqiirke77ppgiJXCikvfHeJFXxKc9rglBh7nn54MuzyheQ4PXxUmKuS/dq
         Xi6w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782117715; x=1782722515; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iZR+2ju7++NRcGM1MWJX2pjIN+qrKg6jd7TopyaTJw8=;
        b=D0DrvT4Uu3MRGRh5L+k1/btHYL/TjTHiRtKgyiPSot0Y9wUAOD2gXdEGWbPkejNvIj
         emQ+i2uF7lAuRap3PxlIbxXXYtjG0PJalkJbuV6AN1U5xluoLkpXOE3FPhq1F3v+bOvt
         jA04Fgp08ffyYirO/QkcgTcM4qLGiBYnkFaN11wlU+nJsSo3g8SZ0mWd07dldlLMCXHm
         05hUr1rhL7JlnYhfpeJzqvia02AzfVlAW6IAupXXnWPI6SUbJHiG09SNzUwrnZa1Qore
         zfKeQ11IY2AskbG/wIo1Yczacv9X2y310TvOZbfv8YMNHIRfD17netMwjTgyerDvvMXX
         iVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782117715; x=1782722515;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZR+2ju7++NRcGM1MWJX2pjIN+qrKg6jd7TopyaTJw8=;
        b=O5pzEtVFXI9N57KvOfxYPTfbS9kcOm4uHBGIvSk0EjPj+/A8oTI/dCfg8B1DwTyaRG
         Qdv+uZjxui2BUPLbr8AkDqXOtxO+ya5cT1kJM83cDttVApTk2vBE9GyHWfW9YX33BHUs
         ZXEbN9mGagugA1labNXCvDuuveB+BFGJl+KAsi9psCWgRdSsLV+5QbK6QgwhFtKeT9hH
         gBTSIiPAIht0sbpDH6nIPIzFO308VJ2hF7Mpv41Y3sZf0RpOCoDVAN17J2tNGgOJekCI
         e7vdZuWTZeVKgQy3u8XtXWlkRkCGeRJvUvTtS0gr13WnsPaU6i60G15PFzHizKJ2x4FD
         oeLQ==
X-Gm-Message-State: AOJu0YzXIkIwE6OfQ/KFlmFY/56F8IuD9U2FoZg8OdtOKIFWGUhd43eQ
	61wh/x+2PP7Q+XHhYRZsk8rtxqyTdraq8I+dPFP5eaycWDGHmG0Up20EfwKe1DMf61bX5cibjZf
	PPEQTL+8DGytX34LO0nNGLw+jk8gq268VRr47S68=
X-Gm-Gg: AfdE7clJyZ3tQQ4A9GUe39zA6dIpDAFQyDypvuSUjDoEiSMR1YyOSinqq2nOccRNfAh
	5S5SRetdRmpDmgd6FHe9K8hw0g1RGuO5a/+PLZMGLXnzngFInVpd9j59wL0Ulwr0clJI5UG5B72
	ROm31mofKLAdl/O02JIkBw3gZcBx3q9IJhEu/VbsRIQ+yUaCuI1GnUequ8Y10o+I7z7mYKjA9mL
	T9MB/IcKUL6aS8gUHxlyA4oehoDsuWWcO+xUyWeYYuyhu/JmVKxLsYz3MfR2sTKiuzXlU1b
X-Received: by 2002:a17:907:e102:b0:c0c:bc4d:77e1 with SMTP id
 a640c23a62f3a-c0cbc4d7a08mr149068266b.37.1782117714648; Mon, 22 Jun 2026
 01:41:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
In-Reply-To: <pull.2331.git.git.1781262619.gitgitgadget@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Mon, 22 Jun 2026 10:41:18 +0200
X-Gm-Features: AVVi8Cc7KKVTWfA0-nWExZYCdHiJzWi13WOkByTQjrXlq7EKD6coUBNy_6UhmRo
Message-ID: <CAHwyqnUNb-P7F3EREbTtdTmpx=M7bSw3idrKdm-tK3wTKnePZA@mail.gmail.com>
Subject: Re: [PATCH 0/2] branch/push: suggest intended form when remote/branch
 slip given
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Would be nice to get some feedback here.

This is maybe not the most pressing issue, but I remember being quite
dumbfounded when I was a new Git user; not understanding why some
commands required one format "origin/main" and other required "origin
main". It would be better if we could actually solve it, but I suspect
it's hard without breaking backward compatibility, so maybe this is a
good middle road?


Harald
