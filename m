Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907762FF645
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 12:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757333450; cv=none; b=FFJjTEcbVWjRmNKddGXsx7dlQpw3zDdBtUGpXBMoMo+1+Nqu5fG7IzTb4pBSqJLuaWGKO9o7JtW3UhZdS//G9JwzFOWJa68ESmM5wj2ITUm6LygJhnM25mr3/SQKa2HT7XHCPePJHlPPA3NH1tDPUxeCkefazRhDarM8rVhBYaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757333450; c=relaxed/simple;
	bh=XZmEg1EedgiHXJIFsGejwHgzcyOWzE3VXC5ccL6BWbI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=F3FCHsHIHIxYibPUIDflLG0TCfPe1YB50XCoU5wlsaDxZtVa/68riBNygop09K6t3HtVOlrbAqwvxT8pnJXdMPjDlXg0micHLtUQcalNGsvA3/xmmMNwd+Huj8U6vH0YtioxuXwT0LtsRbLppLd3FMpH2XAKgrIdkJF77IxIxRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lSlYuipu; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lSlYuipu"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-ea059954d52so799717276.1
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757333446; x=1757938246; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=u2WjekutghDao99RBLahXWEGdPf7+QbTXcWh7dztnCw=;
        b=lSlYuipuy44Wr+qnOQssiJ7M8ckgV2Pn4jEs+85ysKdm2+1D+H46lzoGdgx9K2lvBo
         QrnUn15fcjKACKRJ3ZPTXE8xACvXHyiEnkv8e56aPdexblrv1nBpfrhURSZaPPDRTuvR
         YSmre7gpktC5irG/yVYwtmog1QsDSjVxdaQA6KXWSY1WIHNMWk1RhxFYexMMe3Qnfe2O
         vXYedgt6r11MBakbamAlhzoIe1ovdPHE+/jH3gnzCWkCOukfFLKuhasZBzexuvfZvA2j
         7lvO6sWSnfoE+bJCCGInm9sHHJNUgk9kMy10LjRg3bRN/jMFk4jt1TVq2oh7rNKMxABs
         bPWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757333446; x=1757938246;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u2WjekutghDao99RBLahXWEGdPf7+QbTXcWh7dztnCw=;
        b=hD6IJmUh98PfeyfN9B7KibPQHI6XROeDKWpr51Nd3S0C1OL++auGMIRMJfgzy87fz8
         vJcMkV6eL01ihnmu9NbMkU8HW6hggdSLvSz3VtXpu2XLd8DEOtCq6rMCkd0oH4CkgHFX
         Foj2y1m4K77adgc/7uCTVoPvsNFUtnMphOcVU5rxZUDdsk3DxA8qQvYzVNwlH0bgjewG
         t5boc3lnJjK0m8yERNJC7EI64FpOKJkmB8p+Y0t3LJfF2eqegcWsqKbQyarNUUtlvCbX
         DlUnhWzp6SQTaShoxEOyMiROzmKg6W+OLNloD8Bo7wZRan/kTRwWRKU9lOTC8xCTuXm7
         fbCw==
X-Gm-Message-State: AOJu0YyjZD3MAvhj4jxFV4Tw3iC65oF0zojUPUZ90CIzylm6ey/TbIu3
	344Uueqn8a4xxplLhlfRBTL5kXzoE0QkeZd9YxCky9Ux+KV9RpMCZh9ay2hecNPH1IqS4x8IBmz
	YPTOzi4wYX8+11WtMTuDbp9gB1m1YNsWnbtxJYyk=
X-Gm-Gg: ASbGncufzDQa8/9/YqPcJSq131HU/D7G7Z9cRcIfTPvSw80TxbN6gqwmP9AWeeaVj4d
	GOCLwPE6rQF0z3Iz1KHdOP3/jlmQNVDiBJS+uFcXvrCejVSTPWPaY0ZEJ4JQZ3bjGWuls9dnl7O
	iwnOeILHTUZRlFjCLhAc+bUlFiDvxikFU517gQdmTk5wWezpTJv43Ugc/su2MN2rTcYw54dJVQb
	dP8qw==
X-Google-Smtp-Source: AGHT+IHYSBwa9SVxQskWLkngIfw0RX55Xr/AkFQJLeJ7WKA5cyCVo6O1eEdY6XNEvQqUk1OVni9F1a6P52R2WWdrbbE=
X-Received: by 2002:a05:6902:20c4:b0:e97:53f:6688 with SMTP id
 3f1490d57ef6-e9f657464d6mr5840529276.7.1757333446217; Mon, 08 Sep 2025
 05:10:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Milan Hauth <milahu@gmail.com>
Date: Mon, 8 Sep 2025 14:10:34 +0200
X-Gm-Features: AS18NWDcMcE4EoikTSfCUUY8lPINhsasUVIDplXb8AuQaDnzZEShPXgaFYdSdaw
Message-ID: <CAGiEHCv7kXSB5v8Pi6gDYaC2O3m5qEM8dYW3vKvNm6sXQ_Vuhw@mail.gmail.com>
Subject: Git dumb HTTP protocol should use WebDAV PROPFIND method
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

i am serving git repos over http with webdav extensions

read operations like git ls-remote, git fetch, git pull
should work with such an http remote
but currently (with git 2.49.0) this fails with

$ git ls-remote http://localhost/src/somerepo/
fatal: repository 'http://localhost/src/somerepo/' not found

$ git ls-remote http://localhost/src/somerepo/.git/
fatal: repository 'http://localhost/src/somerepo/.git/' not found



http server: nginx

nginx webdav module:
https://github.com/mid1221213/nginx-dav-ext-module

nginx config:

> http {
>   server {
>     listen 0.0.0.0:80;
>     root /var/www/nginx/htdocs;
>     location /src/ {
>       # PROPFIND allows directory listing
>       dav_ext_methods PROPFIND OPTIONS;
>       dav_access user:r group:r all:r;
>       autoindex on;
>       # disable index.html
>       index this_file_should_never_exist_DsMSIsKgBk;
>     }
>   }
> }

available methods can be fetched with the OPTIONS method

curl -s -i -X OPTIONS http://localhost/src/somerepo/ | grep -i ^allow:

directory listings can be fetched with the PROPFIND method

curl -s -X PROPFIND -H "Depth: 1"  http://localhost/src/somerepo/ |
grep -F 'D:displayname' | sed -E 's|.*>(.*)<.*|\1|' | LANG=C sort



workaround:

pushd /path/to/repo/.git/
git --bare update-server-info
mv hooks/post-update.sample hooks/post-update
popd
git ls-remote http://localhost/src/somerepo/.git/



continue:

Git dumb HTTP protocol should work without update-server-info
https://lore.kernel.org/git/CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com/

> reading directories is only possible with WebDAV since
> HTTP doesn't offer native directory listing.  However, we don't use
> WebDAV for fetches and other read operations and not all web servers
> support it.  We get better web server support in many cases by requiring
> that the server side do the work of updating the lists of packs and
> refs.
