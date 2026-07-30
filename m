Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D0E38838B
	for <git@vger.kernel.org>; Thu, 30 Jul 2026 06:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785391958; cv=pass; b=kalDHIH3gvnG0Zh3dbe/F5HxRJDOqogdHdOBXFf1ZwrNGBAh0yJBk+lf/TcNjut/uAsxGnnXe8pmO2NXbFldIOrUTzcNYFO/jth/hFpfbmJE9T5is+yGC1V0a5jiOCA1Xatx9Er4Gmcg1k6G7PVTKP4oQJssGFLbKCPgbdeA7os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785391958; c=relaxed/simple;
	bh=aWjFjfCgaKT/BFLt+z5LD6s6JrX0JFU4pVfvbnFUjSk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s2DNy/0iPX0qup8W8+ROQUNefImZccweOVwlUBiE4nAajfNTbcGucpZj9CT6Izi2xG3jm8TbFY0qZ7FOMC1Y2uI9QDcG/IsHrRDdc7111NS+dKpElN8X8Bxq+BwAm34nCbLjjnGRXOsLzX8b+HrprCZ2jC74HwKtqiB9nbbFjfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kp7ivOFu; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kp7ivOFu"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1c24ec9525so298298166b.1
        for <git@vger.kernel.org>; Wed, 29 Jul 2026 23:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785391942; cv=none;
        d=google.com; s=arc-20260327;
        b=Iuvm901Y89sGJsL+3hH3XEIFJY7+0oUDdwrCe/WQNbCmg9kD+rcTKdxTsLNHc7Xsmv
         trYER1rsC9M+isJWqHyGVrvgyjpGJnnoh7IKL4YrQ++NfBMUvjI76quTgJSQF2JXSZwQ
         9PE6At3HoDHLEIYXvSHYJbW+ZuKJH9eA1XAvbz7/jSD4WgSMrfTui+Lg/5fNmu2hurnm
         JkHDVxW0HIbHKBh3m38zLWBbAFvWtbxQIrQQd24apo9nFQPegjzaACkbUyh2sjtryyGH
         N/M8cUmWIjPFMF3GAoohnHGeUEBsiDcJupXix5GImZDWC/80j3Si0lc3BC/E3+/XVy1S
         2dFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=aWjFjfCgaKT/BFLt+z5LD6s6JrX0JFU4pVfvbnFUjSk=;
        fh=ca9VggR1vZgx8WR+2jWMeutKbt9P0l7KL0VRF2+Xd7o=;
        b=fX6u3aThSWkrpXQ/874XpuozL/4Ciz8F6Aaq5uoImzpRLL2RiZYMMinotsprS0ZDKF
         IOWnSy8grGZKBtXR8pbd7AxJRjEUgcxkMeJHqqpkK2lr5Ih5FzQrL1qGnOfAcVzZhhcn
         brArsZTd1jWIBHcg4KR7RqInT97OAshMw4wfoGVruFaLCYGu1O/XcmCe3mtX3iO8Z4wB
         EDRfqLqmxQHrZIqiT48hZp38v2Pk0ZJIz/j2QalDBp6fFxnYnpvlVBVnTMG5v8azIrPB
         uiNtukc9ondS8+w7AH6mjy9w1r1eqQdfXlBhD9nCVtpcv6Ot8eiK7b7prbNFoWJv4kTf
         ijNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785391942; x=1785996742; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aWjFjfCgaKT/BFLt+z5LD6s6JrX0JFU4pVfvbnFUjSk=;
        b=kp7ivOFu6fEzaLBSRcqxhgmAClD+1ndbUwfRH+4Z/dclsCMwWM9JVJgQYFUH3Zr1kR
         I7LnTmjVf4naxLmwWa7Ihc9W6rzavvtS2oXRiTKCQAP7StC/tVJIKWvPHio1xI4nXlMj
         xhdmvoZ63io6o7CU6cAS7uWaRH7aPvA1lK4g88tOGV2xRyzVXTtgb+kTaNnbQ5Ifv7it
         Jny0v42Hulhqmb4gaVy8bu24LyKjQeu+dN9HGgLb6xl4blWEdSTkY4BUyHBIHNC1DCvJ
         3p5iMJqMkugnwKK8YjrVbZ38M/yxZgOr9EnrG9fgZ0c5q+9X6i6p5XzEJgR13uOeybKz
         sPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785391942; x=1785996742;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aWjFjfCgaKT/BFLt+z5LD6s6JrX0JFU4pVfvbnFUjSk=;
        b=BOGC6DjJe2Si7xDxD8t06RUqQLbvvgSfZqrea+WXN1OhRBYuMIOO8f3WIn3zmcXC6I
         0KcKbYZP+byetkmoN/KckDIm6MrOIug/YxOe0HO0wmgPsjt44yg6EC8fXbx/e+wEvmfh
         JsTL6FZPTN6O/5lwrJYdDzJ8MZlcF32+Ku8kBnOiEpPo3ke0u4g/k3IZNnFbgtTdcjL/
         87SLIKfoCwNKBA5vHSTi2zfQrqgonIzQB0MySdCIBPG9hLlgI4EXaKxcqtX+RUA5J6mn
         cZMRaVcVVKj9d/7W2IqY2LXgbCGm19J379vbbvfVaBAxoHNbb+Tk14Kt3pcilrRUFozl
         i3Gg==
X-Forwarded-Encrypted: i=1; AHgh+Ron3JqssXOyEJ60QcixSDUAqOQdKJkGOqbYsKoXOJmy5w8pUu3Hpkt+et06Iko4aEnWcWo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGg1GRUVcWbae8i3eNZK+5K5x9mdjeeJslIPGHXozKapc39qX8
	lgyMylhgFl6QS12T/wimiindks0oxqMpnXtJxtrUA3SxCMdX67q0dDKYzjHlOJw+atlN0q1frZm
	v2WIaVsH84WoUHXR93N0YrWbxynYuDKPVXk0ce2E=
X-Gm-Gg: AR+sD11R/AvDdLL0qJWPxkqgafTAV21A+0Pu+H3ump2uDR3SDZiYH3u7Tnd3lmTepzt
	/KbkrobZb356acvRalIwjkghF1CE5XKIVthT0j68IMXKTcW9KB2qnpWFJnnJyqs0ld1uaS/ZRiK
	bk0j6arEV2WduRCe2T0pj7ZFmz3YwtDw0Ui/M159+Wn0wd2RsHMKNtYfbSixD1BQMz+JiCRTJAX
	gHjNzsJdaMaPIA5jNDSN2xX/ZnLDtq0htlf3U09J8LGTE7apED6kkjTO1dQvHzvzPDgSiQU3VX6
	2BP4Xh5CxNIAkI/Vhldp9qPkEYMXyEjSjlYuf8Bx3/kmwbnsBTw3qeiz
X-Received: by 2002:a17:907:724f:b0:c15:f005:63fb with SMTP id
 a640c23a62f3a-c1fa554e611mr59230666b.3.1785391941853; Wed, 29 Jul 2026
 23:12:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqfr15ruw7.fsf@gitster.g> <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
In-Reply-To: <f5f7af53-df3e-4902-b350-8fcf8ccb02ad@gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Thu, 30 Jul 2026 08:11:45 +0200
X-Gm-Features: AUfX_mxLGLRAejvTmCl3Meo6QY_XFXYEuQC4mS6CuCWRpmgy3lJTKQo-GM4MWXY
Message-ID: <CAHwyqnXYi76rMOWYEgJhoh2rXaTgLbze7mKd+WGoC9BbDFHXHA@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jul 2026, #12)
To: phillip.wood@dunelm.org.uk
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Without "--reedit-message", it will happily discard "amend!" and
> "squash!" commit messages even though the user creating them is a strong
> signal that they intended to use them to reword the commit.
> "--reedit-message" is a rather verbose option name which does not make
> sense to me as we're creating a new commit with a new message so we're
> not re-editing anything. I've commented elsewhere that I strongly
> dislike reusing the rebase squash message template for this command
> where we can squash fixups into multiple different commits at the same
> time.

Should we always do "--reedit-message" then, i.e. remove the option
and have it as the default? Do we need a "--no-edit" switch then
instead? Maybe not, user will then always have the editor opened and
they can save and quit if they don't care.

I'm not sure about changing the template.


Harald
