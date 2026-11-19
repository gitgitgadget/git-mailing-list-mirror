Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067704;
	b=AX/1IS0yOs417bzpnC2xiKBIkCuhLLKUGfyyCR8jNUJFwqxHwsbzdPVRbm62+iajsFfr
	 i7huEp+4x9hyFd0d0kMOFKybA5k0Az/yd84QA/Q3d0MKTOn+AugciQ0sWz10Q7YeJ/UFR
	 izVdu6RTcUOFAlfu7diwz2oFWIEBbbDC66xZxXi6Gf5muvmK1hHWY40e8m/47J6pe1APq
	 E/sqATa3SQxXwr/U6MkD0WHXW/l6L1GwfRtd4a4V7/w3AvmbMTkeu/sTkN9wZD3sMHSWi
	 VT/ezffAcY0+RmEIpRvZ977qSlSDsLjknOMdWdauNiC2XZCuENE6YYNyEVCegQcFHvQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067704;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=GVrD/puzAFCaIov/byTWKS9l7++jMgpSN37/6gVb0IQ=;
	b=YmsohqwP0+u/RewFphtPMvlPppNEDNloZZx6BXSNX8iadrDZvaPUk0G/OI9GA2NoCz48
	 DnQ6nvFhY9z+gcLouZzFSKcwmYhLa9HgqEGn2UozGFA2wOpW4PeKKWLwFpTFE8ZpEn16G
	 /ysY7hdQ5UhAbmlJZAe70uB2Jg5vAEBC4a7+M9GLrQch54PH7rdmcwO+Jvx8I7BmCRRNW
	 XNW3cnK/Ibiun0r1f36pUOFw1KfH0CyFn8Qz0u+n4rQdtAKa+RQwuwEkedLJP1WESLuJe
	 qws9lJ8S1wrwEqpt+63rHfF8uszor227ISzt/xWQp8ZXuwwTOxpP0kQtIv8tiZfbNug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZFofScFe;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033E2606A320
	for <git@vger.kernel.org>; Thu, 19 Nov 2026 05:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 033E2606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZFofScFe
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6ddef424972so1567087eaf.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2026 21:55:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067703; cv=none;
        d=google.com; s=arc-20260327;
        b=oPEWpS2k10k26DeK7qKY48DAeW4ozoC2J0OFqCtbn9eN53twkeiE2vRBuR7xzcRjor
         /r4+pTHh7H7bVg8MIpIAdLsx6WsVCti1LqtbWqOr+O+c5vWF6w3pv4RkOveedrXZqXtO
         UmW/mjECm1+7Dr8lM6+jUJbysZR4JHNEIrviynl69jqk3/6/MFk2CfgHluCmP37OpKFR
         E6cuRXVs4wETniGj7D7IfOl0cGRz0npEx0NubwS2ZVNF6fUQ2NBwp2DkiKKjcU6BLlvs
         m4HvFffKmls/NgQ4Vl0KDS1K7+3v8PoL9vao3bbGdj8uiUPRrvNLc01FJQDaiaML/r3w
         PY9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=GVrD/puzAFCaIov/byTWKS9l7++jMgpSN37/6gVb0IQ=;
        fh=azt8TgWTl01NptQZMw9NPhZWceF2SXJbJqFTBR6uZLs=;
        b=PrO5OQmrzUd0qhXky47wRovgMWwdvZft8eY4f8+sFEdRU5k8JFJ1l8rezLfNFOnPRc
         3jhHw712EUT54bEX9wABvfK9xO51OvsDYP9PGFUBILhpJxq9HUsRlYzFhw6JhujOrQ/v
         SBGL5JysKXBabh36DxYsg3dDOQjMllvkk3rUXKDeGhpx/gx+TCTpL5Lyp6SCldw1kA6S
         DuqsAYNZa1Tg6cEBkDN0c+qYofGvX1fpGWgswVp4+Qz+IpZykFg6hnY/YQvtY7RYUIeK
         pSBkr6FkXblKlkqPhWRTGUlxGdh5P/aAOOa6a2qwOZsHIy72XfKBI2eNR1ZdPLYQNQtp
         sQMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067703; x=1795672503; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GVrD/puzAFCaIov/byTWKS9l7++jMgpSN37/6gVb0IQ=;
        b=ZFofScFektoxhniuPqhzlWPp0oED8j3Q5gDC0byrKmbuOPGmSfzttsNTz7br1XPf8q
         CbW/FKLakVtd3ogA89s28MF1R3YQB68TEeTfmeqK1HQ3rZYhpQQS+iy+EoJrUyyWz4kH
         UBwUULwI8dFSGXzjxP6XglXHLYrwbmIcpK/HxqPSQP5CpWyQGQ6iXnltXEF55qzt29Ms
         j1TbHM0aY3xZZnPuKZPgXh5mJSvuKMQf7ADKjkbKzUU1FE7FysSzvEqW/luu306ntzhf
         c/hvRtewGTkoi7GmoJG6kWtHb9moTFx2E8/cyr+6I06C5SsjvvDxfKzEw4UQ2BHS7nVk
         XvuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067703; x=1795672503;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=GVrD/puzAFCaIov/byTWKS9l7++jMgpSN37/6gVb0IQ=;
        b=JAd88WCpStZeyxQ0deYnsCP1xw3kQMq6HtRxKVlVz0XpWApL8XoXpFUcBPRFIaklJ3
         ndiH5dx96lpXbm3CxT/2k9l7pBlwvNXM6hD5NCEPbCWiU3ysHvVMafrKjssfrEJP1bk5
         39Bar38cfldIXpGtxJgyz1a3DAdnV4L8SKFqxCfDPi2ofEejybbR50b3R3javkwt1YP+
         3dHsIHMomp04nihWxrUtq6rdgDVmR7Itk+xoypqNXTfpZ0uh0T+1OALJa19gwBids7lF
         2aJC485dUj+2bwrMPvtSaHf7CsE+Y2OoGp4hgJTS3SxPcO4iZo7N4kLXltS/Cr9wrY7Y
         7cMA==
X-Gm-Message-State: APuU4Z9AG2E167d1bmEyF8MRg+mD6rwEGmlHsyMr6lPeR4sJB5DycitA
	f63FC7fL5VWS6LT4HxT1EXmHkZeGo3u9X6TkYgEm1FWBxSy9GyA1vl+z0gP6W4s71ordg5fGX9r
	w1IQPNkPzzTRpReqiSL/Xke+h61EmyqRwCcSH
X-Gm-Gg: AYBFou0d1fpTi5taCxhsgHS76XTVhDXk5BW3WJLtqgddrdtBsoudQ7PdoR/jh/0vusQ
	fwdeGih5i7CxRY0bRe2XDnqra6VvWRdOzqTwCZoeK9+yPCaHlftoWqnWPn1TsfCHRw2MXJabtqw
	7QvuujU7Jik8E+iuHVbBs3r2lwtI8gAQ3jPZ4zPYLbr9pbDk0xTwBdzlkmZ9fksjXbK3o7TH7Q2
	17k6DmSeMPMD9zrNGtC4g2RoPy0qO0vFrjhikU+67wVIvmcQkYg66zeTodIjqnzcGM80V7GC9Ee
	72jJgNihanmq3fE7Z3XB6QKXxrgQ3tDLPx9VfOio9d3kxNmzmW79UhgXE22wA/ow2vDbaNloexN
	IcqZSpW/4pce0ZxjPGRCBlB6pJ1Hmlj5cYtQ=
X-Received: by 2002:a05:6820:820:b0:70d:9be9:5351 with SMTP id
 006d021491bc7-71b185a9e15mr3769986eaf.36.1795067702931; Wed, 18 Nov 2026
 21:55:02 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261118-master-v2-0-3f2aaec15d31@gouders.net> <20261118-master-v2-1-3f2aaec15d31@gouders.net>
In-Reply-To: <20261118-master-v2-1-3f2aaec15d31@gouders.net>
From: Andy Koppe <andy.koppe@gmail.com>
Date: Thu, 19 Nov 2026 05:54:50 +0000
X-Gm-Features: AclHuK_5BsJAPJjyshTYFbCGvwbNZVWDTnCbhIQ7XLVIivafm98MOd-Cyc3eBSA
Message-ID: <CAHWeT-aWx1VwUjM+hZ--jjSAbcMenz5Mw11y9ouFavGndUMrSA@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] utf8: add display_mode_esc_sequence_len_counted()
To: Dirk Gouders <dirk@gouders.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"

Dirk Gouders wrote:
> +/* Same as above, but for a NUL-terminated string "s". */
> +size_t display_mode_esc_sequence_len(const char *s)
> +{
> +       return display_mode_esc_sequence_len_counted(s, strlen(s));
> +}

This is a performance regression compared to the original function.
Calls that previously returned immediately because *s != '\033', or
after a few bytes of scanning, now scan the entire string with strlen.
It turns scanning a whole string for SGRs with repeated calls to the
function from linear to quadratic.

Therefore I think that if the original implementation isn't going to be
kept, it would be better not to provide the wrapper, and thereby make
callers think about what they want to pass as the length.

Uses on strbufs can of course compute it with `sb.buf + sb.len - s`,
but they don't actually need this safety net, because strbufs are
guaranteed to be NUL-terminated and the function stops at NULs.
And the length calculation itself adds a source of errors.
