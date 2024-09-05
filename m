Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61A279DC
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 18:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725560660; cv=none; b=Q1bYaIo5vjE0iNG7y7ZzXQOuq+Y4z9TYSuDjw+Aw0tLzthq5DeHKiDfqXAlcdSbO28qhpESHpVbZ5/8bKi0OkfXqlwoxo8wqkMuOUp/FiqeMd+/xuIRmPxKbD1xt5UJP+kO5u6JhDdGuQ3TJ0Q/tc4yBPEb7C3gtl2Fg621gtCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725560660; c=relaxed/simple;
	bh=RyxHveo8VQ7zUH2OP4Tsot6AtyHEzwkicz1OdGt5IcE=;
	h=MIME-Version:From:To:In-Reply-To:Subject:Message-ID:Date:
	 Content-Type; b=cJuyZ26NL8zHiqQk7D7c1YAZ8sgNQr1Gq/UKjZG0rI3sUVyj9HTyLDbXbzodWc7Zke0SftmMM/ufrmdlro0VxK7E5Li0KJaPYYLaveebLN+F9+SGpI+zq2/C9fT75YE6WETdDva18ylfr8ZQ4I9Ee3mzhxpwjSu/e/Wr4/hE69o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FlxsgJhs; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlxsgJhs"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7a7f86026a0so74683185a.3
        for <git@vger.kernel.org>; Thu, 05 Sep 2024 11:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725560657; x=1726165457; darn=vger.kernel.org;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QnypwhupjVcyq4B1POoVu62+xuFqqZ4LwGeNh007jsU=;
        b=FlxsgJhs3UplTIGxtKPSGc//52SCWQnhnVapE4uFx7OWVCniKbioWRwpD/yvgC12T6
         ql5S4dVGCkoEbGO71a9FZiro+vSwJvH93Fcnf4Y7PfJ614boL1wORMzw3u2m47kWwy+Z
         exoPfJjKiqlhf/0dYpTP3Vj3Q51tHy4SdvzqLsgaj6vFH17yP/Tl9RKjvdZxpi9YGXVU
         vX/uFfvNXMvPBgGJsFzV2xPz2XufaSwwIuOzyvTv204Qz+BgzPB1nxJwHvvlzDAjZUPZ
         eBotSKR2N3lerfOcf9ZNsUW8XDdo1dIlY7225PcjVyCdMXnR8vIfwVaBIOz7kz1chniS
         oGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725560657; x=1726165457;
        h=content-transfer-encoding:date:message-id:subject:in-reply-to:to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QnypwhupjVcyq4B1POoVu62+xuFqqZ4LwGeNh007jsU=;
        b=XYRAJc3UvAcX8DMTBHXQko8JyTIFZ7zR03JSyHDQgkAVHnl+ZW6RQpLuA3/85a9Xp+
         JtnwqL+cMtdJasUbENGglLxkFGLSjay7orwiErVMwoOwcvPVYmNfOLMA6M7WzU4Qy9rT
         yOvh7LTxxsnPofEONcesB1V8RyCr97Cd/3jWlS92jWyIxr4cLqjZGP/gIu+bKU6HkUCb
         kICelom343bmMViACCby0jm/1DFcPNTlky7+LmTTemVowVBdoTytWtf+PBUXmjz9Dein
         a/v43NXGdAALPvFkpT/ukrbE45Qq6T84QZpsSk918kR+BPqE0VPws9KmUFXbaSq/6Ufx
         nI/Q==
X-Gm-Message-State: AOJu0YySGJgsLIwicf/yg4he9Yp72V4K1VdLv8c+UP5Ed02QBoH6Z8Ib
	+7GEkts6PPtpIT9SjMD4wiVMrdMbasYwO6ZDDB621Mej8BtYzrP9rROibQ==
X-Google-Smtp-Source: AGHT+IHGnN4OlETxqWQQ2NzD+wZu2mcBlwmApLgKTLv1tboye56wcI0OGpTMvoHm/vqt+3DOvuANWA==
X-Received: by 2002:a05:620a:46a8:b0:79f:4b5:3697 with SMTP id af79cd13be357-7a89ac43532mr2014268085a.63.1725560657333;
        Thu, 05 Sep 2024 11:24:17 -0700 (PDT)
Received: from epic110867 (pat-verona-i.epic.com. [199.204.56.214])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a98f00fe15sm96228885a.108.2024.09.05.11.24.16
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:24:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Brian Lyles" <brianmlyles@gmail.com>
To: <git@vger.kernel.org>
In-Reply-To: <20240905173445.1677704-1-brianmlyles@gmail.com>
Subject: Re: [PATCH] interpret-trailers: handle message without trailing newline
Message-ID: <17f26c45e0877048.9cb17c440a994cc2.6350cf4ad3b0703a@epic110867>
Date: Thu, 5 Sep 2024 18:24:14 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


On 05/09/2024 12:34, Brian Lyles wrote:
> +	/*
> +	 * True if the last character before the location pointed to be
> +	 * trailer_block_start is a newline character.
> +	 */
> +	int message_without_trailing_newline_before_trailer;

I just noticed that this comment is incorrect, reflecting an older
local version of this patch. In v2 this will be:

    True if there is a message before the trailer block and it does not
	end with a trailing newline character.


> +/*
> + * Return 1 if the trailer block had a newline character
> + */
> +int message_without_trailing_newline_before_trailer_block(struct trailer_=
info *);

Same thing here. In v2 this will be:

	Return true if there is a message before the trailer block and it
	does not end with a trailing newline character.

I will wait to send out a v2 until later tonight to avoid spamming
folks, and give others a chance to provide feedback.

--=20
Thank you,
Brian Lyles
