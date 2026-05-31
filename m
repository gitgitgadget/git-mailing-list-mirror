Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE3228642B
	for <git@vger.kernel.org>; Sun, 31 May 2026 06:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780209491; cv=pass; b=OZrNEcKEdxsI7i3f1fA/ZMW1Lc9OWcsHKVU68sqeh6VVlHERFtRUZVYLezbp9/9Bn7q+4etqxOpThsHHhvEe7LZyzf1sFRxdg79O0aP9u53/9u96uVMf7YcaOtVbL5ojUiTcTF2ASQ7sDjPxi6mTJKANpvrUfa3h2+Tvo9kSJIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780209491; c=relaxed/simple;
	bh=IZ9RXwMybmfUv7Oa1XYO/hMnqO5FSpFyxLn+GW39tnQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PcbOvZWZXCg7Zjdu2f4WHo23c1k07tUPyL4DiQBqt2BsHNG8tIF0Cbt86Sw/zTpun42oeg6HugoKh8Ll2XrHE7Gt1Vm5ZZfirQ2fIp4q3gMgFfC67cSqCOtyGsB4xRSN4QrZL44S5IcdTzHHF/UOpTmyIpnAfODyGhogL5gnPAQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KKP1rEtY; arc=pass smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KKP1rEtY"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4903d730b1fso81447295e9.2
        for <git@vger.kernel.org>; Sat, 30 May 2026 23:38:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780209486; cv=none;
        d=google.com; s=arc-20240605;
        b=TJn6jv3s5vxmkHNxvteJnnP9zRb8jvhr7TeBiGS1IspNom3Ce348L9Glda75hEHbXN
         NewjEP/4VdM45PjpfvzDZshd9WCJc1UoKiHSFE7yT7KRu9wNpujL5Xb7zZj7LIV8TbEp
         Pu9cHgne/m3EMCfJ9XgDlXsxQAu0C8ZspPa7QazTee7bb0V/3Vn/gj9vDCos9AdBhBvD
         v0kpqrqyxmNmVmBR7GTDFbgNi67yXcYEh/6U3MRM6EzuzC9wQL9gRmGaWjkUf+12TTxZ
         F6qOO03x+srNdXa4et7lJ7CsYryBjSlvCjtfxOFUR0PA1AFCTzVYMV+92CKXMa5BTOBl
         JJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=q5cRSnqb6AEIwQHuqkmVYotwGmScpLeHDFOyj9T3r2E=;
        fh=/2GB9gZwrWBAHWgL99Dxjo/GtZB6XQlAfcSS1ab7Z90=;
        b=XOpf8au4tJYFSRQW1xdENxAfZ1krq9TH5YDaAN2q1caP2eKM7SmPz86XIM5ZP0b65o
         5eHNAorD7ISZC27AZeEOirTVEONj5Nxc0mvTWDNsaSr6Mtu2ShmcqpYo/2C8INlmXa3g
         3BU97umLYMmgvfUdtYktJSZCx9ndbnQAU2CAsI5rlOtzm07eP+VxGIgunOdL2Fprx6oc
         ukBoaerQm4L7zJc/ja5cZmYFcavaZTqP8swIJuEZfwiDqoaDtM1rKqNhBf3S73T0zdHx
         f3TbvbGQabgviyYnj76/7d5NMbiQr5wM24+Pl6fPysUh4jESVNi6W4dRwGip0RpfBSnW
         WZoA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780209486; x=1780814286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q5cRSnqb6AEIwQHuqkmVYotwGmScpLeHDFOyj9T3r2E=;
        b=KKP1rEtYECxyfSHKKkb5kCm6njRsvL1sYovFLjrwSu2jFkwenujW7CoV5qYCKUEHhG
         2mMfJgKkbmFBMlNL/hEEARw3UiGa6dUR/UmHal1ngK/5/u7UNNixF8iVy0+5BJUI826D
         L58d3TPsYAoOmXU+66Kn1e6co63FnEd6CfNwGQzFyux6r0Usvs9oC+zlmQJxIURxwJ8t
         eBRGeTJn+is9J+etfVgGNyvnlHSZ4NXVCX2rknyZd6/vQFEbopwzjrFkZ7N+jSd5d29D
         BFHlfOpLxpG/eUgFOubo15zoksJyzFd5esMOQjHbOHr7EsLauIpkj7L+6QzNnTBtxxs2
         x/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780209486; x=1780814286;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5cRSnqb6AEIwQHuqkmVYotwGmScpLeHDFOyj9T3r2E=;
        b=NOpV95UtrEukyWeMVLxesjqdElrGQ+N/38cbTqKBCWQN/8hthTymZXV2R5hvigTAsX
         eM/CK7jTGFbSnemPPgoy0FGlni/dTgt6VhcwXQ7KpJxNlnkfWHSxEwqKpMQtqYZPFvHg
         /9r/R7/bGTYK+6TAAuEy+lsFbOfpvIH7785l5rDe9sf7eLoBl8zGQG2NiT/O7cPDmz5O
         9Pfx3FUXtFa8Mf18kLogSoQh3sMWjAjo/Wr4int+NRuDSbQFnkYgU3nokTdFFllZyJli
         yoYJs4sJyuZnT30xG1QFJsjfArfmRIIHLcGTtabM1rMzTgUR1WbVmU2DvJ9drRoltAim
         hhfg==
X-Forwarded-Encrypted: i=1; AFNElJ8k0eKWzq5yjY6nAiwQbW7nSfhTP9Ja/SbrPwInGGw17fJkDlVS25zot3zkKmxvO/2Z31o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB6Q138OyK8289HyCMEOGMWvqGS02mqHa2O/dLWj1DqN8xddta
	fJoXaye4UjE7lElBYdtOS0i7n/h+5knYXh+oMOxhiT8l3APk22iRMfOlyCGEc7mr6jKbQe/BDrX
	urK1dMwJFsZ784FGL63L2pKIPMkh5Cy0=
X-Gm-Gg: Acq92OFlsb02Rb3oB8rhxGTdnrOw4CEXMXT8wuDUSNF+qSExwY/hqg3R+kNwLJsT8Ta
	PARKZbbvV2ySPAv2VMYEWm9A2MXcf0mwKiz84WDZv9Aatol0FZL484I/HC8/mdAAYnEdka2ya6S
	fSpXWrMCrwOFixgZniLAIpLIyLxnN4ym1al5O6/7FSbIU47OBzr7vzhBvxv6L+kSmsGWeQHSaUA
	e71XTazIehJrOlbY+JFxe0RZz9ADl4Gn9ilPStSEA5WyKkLuIfjCoEY52FSwxuxR8UYRpxxnSVy
	tV18bOcFZBozDI2i9WKgnUuPgXqBD3NfXkAYxYvNPWyhk4pMsKAr
X-Received: by 2002:a05:600d:8498:10b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-490a29299acmr83195995e9.15.1780209485465; Sat, 30 May 2026
 23:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2315.git.git.1780019726297.gitgitgadget@gmail.com> <xmqqo6hyiz9g.fsf@gitster.g>
In-Reply-To: <xmqqo6hyiz9g.fsf@gitster.g>
From: Brandon <brandondong96@gmail.com>
Date: Sat, 30 May 2026 23:37:53 -0700
X-Gm-Features: AVHnY4KbYfPdjyoQFY9hqkvlZfs4Hr-1TlKw8cxsUV5H53PztXnrlK6VRNmMSfY
Message-ID: <CABe-Dmb3-AeT+utpstLWJRGrrEcbXSDYDqnWgMHOwAv85-7eDg@mail.gmail.com>
Subject: Re: [PATCH] doc: add missing --message long option to merge docs
To: Junio C Hamano <gitster@pobox.com>
Cc: Brandon Dong via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Hmph.  This is still not consistent with "git merge -h" output has,
> which seems to accept --[no-]message as well.
>
> It is not exactly your fault, but there are a few options other than
> this one that support optional [no-] and they are not documented as
> such, even though they appear in "git merge -h".  "git merge -m foo
> --no-message other" behaves as if "GIT_EDITOR=: git merge other" was
> run, it seems.

Looking at the code, I believe this might be intentional or maybe a
stylistic choice to document this way?

The overwhelming majority of long name flags have a [no-] variant as
it comes for free when defining a new option and otherwise requires
an explicit opt out (via PARSE_OPT_NONEG).

The -h output auto-generates the inclusion of [no-] but for the
handwritten docs, most examples I see where it's included are for
cases where the [no-] variant has some behavior nuance that needs to
be explained or it's for a bool-like flag. Most string-valued options
do not include mention of the [no-] variant and they share the
default behavior where passing the [no-] variant unsets the option.

For -m/--message in particular, none of the
git-commit/git-notes/git-svn/git-tag docs mention the --no variant
either and I think merge should be consistent with them.
