Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254474E237D
	for <git@vger.kernel.org>; Wed,  7 Oct 2026 19:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791402657; cv=pass; b=IttSo7Qs5QZy83abkaww5tOQ24TwPtVc9lb5NzNO/Nc5R9ZkEMLmIYq0wdhKUEE6VrSvLSS7hOCWh/nUF7Eq19ZWaOUfD3YZgPP2oICL2e+ORGrzEn9Kw524yEIKRR/LGmbV4wIjwkysGNcm85jAzMd76Y24uYm5rotRJ9vhUVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791402657; c=relaxed/simple;
	bh=doqv7ZZJiMCDtyTld91/Bisa9W2sPfP/JDVZx0jt6Tw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KB1FoI9/v6Ow2/CsBvfX+yvXEUoYZb4aU7qT+ecp3vg2/9QK/Zqa4Q/UcKbtanfIyuCwsr6AG2SnVRVknSfewp9F/al/w4seUkE1+X+YgzrG5wkit02OerqAW2WI9HsyN+jYGRQVU/HB/Q2n6CQJzjDfEiHCiYbKzaabVaj96rU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KWll2V8o; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KWll2V8o"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cc758830601so2958852a12.2
        for <git@vger.kernel.org>; Wed, 07 Oct 2026 12:50:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791402654; cv=none;
        d=google.com; s=arc-20260327;
        b=ar12nz/H9IYqjU7QNPssd9GK6UAhHie8Et6BVuF0htF8UCE9eWvx5mpf6cu40U43bD
         SfgiC8tyx+iWfmm/wv9kNdDhdpJS3lxjGf3Y/8bEDglY7HlOdIUEDXvO+7Os2ASkFFvU
         zd0oYD6E6FfBShVNwfQ6ql7OiCm5sKzhBem/1I57iklf0oG8HmQ4nAQz+znxF7KoRHzp
         yO1EL70noLv+TupcE2yEDzCUgH9S9PyRAwF9pG7/Frif8Jx8c0OgYkUpMiAnrnyjyFjY
         t17lyH2Q/2vwF0rGESmUrweJ4sEXy2D//l+1WUoxg2W1gj042vH4lF+pUjPhvr+VK6E0
         +lUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=doqv7ZZJiMCDtyTld91/Bisa9W2sPfP/JDVZx0jt6Tw=;
        fh=/mYkHfH0vJLaChE33D7D896C0kjD0T1yFyfto5V6d0E=;
        b=d86HQqWi1gW4XfsnFJPIMbU1HmlA/i7Mr4qtRFEaYY4rQCjsUPzvJSunL6aObBt2tH
         zS5KU8sL6o7JeWq8F2spc22QByL/70bayZR54PvgWdkTikEnY3BAD2PStlpjU4txb1e2
         lKIBvt9VqJ+/BtOeltfkhculzu8SPPWRKze6LUx9CMx3thG+yf1oCNzDz5peLmmM+S7f
         KdpIHwT+xLF0+CmWWPJwxYanrYgofW74sZMaC2WmB8hq7euOzhp02yTIbtS4zb0meRQ0
         h9lILa78ds6Eq6zLMPjyhVr/yVJA7slMMHsveD1GEmp6tj71ginfkywU6xa/azNSiVc6
         eUSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791402654; x=1792007454; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=doqv7ZZJiMCDtyTld91/Bisa9W2sPfP/JDVZx0jt6Tw=;
        b=KWll2V8oH0/qe8We9WT1h8LsDBGhC4qqKzM4unu5vofy3ACptXThbvC6TdeXm+B00n
         ZTcKI1vHE/1CUGNPH7WV1VIS9XMivSJK7A8zWmLhYUfP2Iez4kDGtnrTeRt85fLSt8ji
         Tns2X0707u95fHwbZFjUww1y6XCxRwvzQzDBnPVg7ImOBXma4WLSnKXdQgEQ41jHV6og
         kgnUhxbqWa97lR7ql3pPj01ZqrQv1ZBXlT0XhAXW3YqWVaiCw1CnBd+zel3kYy8/sWrA
         mND9RjB6XbA+tpCqQEKUgRIWer5gLpr+MpE1Eq+c0CtSZKnqEdp/Hd5WxqXLgq7Zahnh
         5oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791402654; x=1792007454;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=doqv7ZZJiMCDtyTld91/Bisa9W2sPfP/JDVZx0jt6Tw=;
        b=ONdtoRN12VuvhsKI6uye3neR7YoIEJN7mdQ0Ta9fAt2AMhPH8N1k25cxROTCkwYlDK
         JwPKg1lFif9AK7aamowACrpMivs0Mxc9Cwzr4MwefTliVJHLVNSpaQQOuKlA+UtU0YND
         ZwKnGAgAHYGxhs8mlgMBZSb7LjDtyC73fOMHm/GQpJLFKCUNeJWtovO5hXI+tclFSmci
         C3+tlMqN72+TsW/9xAtrsGbQs19GOaDkU7Z51NotDKs74FWp7GPzZKp5mTDtdQZubeAb
         piL+hiyMHRetSEBskhkrekHmI4w45CMgqiBRv/1dVQIjuPZZ/jdIGHF5gQtUMbzOgg5C
         mkVw==
X-Gm-Message-State: AFuF++msciY3BhrA0twYjrbzPxHK5oIfNHxcyKZ8O3xmvpFAXfPfs0Yv
	3hOhfzNGGpNczt6sGvKVtCNekQeLtyeu4UAuJwgCtORFKqGUDFxj5XAceb5/AmHgIiLo2aSLzXT
	+FhavfkWwgG1J0Z6iqW8ndyTi9wPEW3Sx9g==
X-Gm-Gg: AYBFou1+rORvDyztqS+cB/NlaIr9dn8tsvW80VRaGTJ63OvhxqOXiLoDVS2xiuu11Th
	jatGL0/vGoVGMeH587Uvw16wd/yAn6a0u5Vl2nS/KeWLvnrwVDyJl+DZ8dRTRoIeIO7MjYqdHTU
	Ufhycy7E3t6SjmeEiACHQUbvQ4BKeGjg55S8Xrqk1hAEVlh6Sq8M20cn9RkDdkOlhclV5UUn15w
	OPYPhP4F8/A5eU18zP8LGSAxZEVkPb6ycygC0RUIeaIOro+TCYkveO2zJeFWRtmDiIMDzlk5D8D
	Jyo5WQn2Gx/u2VX3hJACsZc7P9oy/b1Sku9wRaDr7uLsdmsNK9GoV2d2UtxXAKFCNlQvW0DwclD
	BxpfNerAYKDgY9Qeq0HVvPWVkMuKAzAUUIppT9GPfJWvGdg5gLjUYI39beSX5Y3HhYaVjUMgHrR
	wkf8nDUdlINsxMLc+OBZPd51/CGCmUmi4FnwMjzxvw
X-Received: by 2002:a05:6a20:d090:b0:3de:dff:4276 with SMTP id
 adf61e73a8af0-3e13410e3d5mr2827277637.65.1791402654462; Wed, 07 Oct 2026
 12:50:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e30c5b13-5ca3-43d1-a87a-d807b71bad7b@app.fastmail.com>
 <CALnO6CCTbWLn2rO9ASr+5K07vqkaWCx+H8NsCxaAMgHUYR=z5g@mail.gmail.com> <d6dc70f6-f155-4a5a-b647-ac24b2b1ed37@app.fastmail.com>
In-Reply-To: <d6dc70f6-f155-4a5a-b647-ac24b2b1ed37@app.fastmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Wed, 7 Oct 2026 15:50:43 -0400
X-Gm-Features: AclHuK_PQU5EO3jrKcEvvAqiQvyP8cp5ux8Vf5krW5YBswgZpAysKPBJsY6qanc
Message-ID: <CALnO6CA5tY5Ebw5JyA8c-e00PqLcXMAijA5VF6DrPJNDCX=raA@mail.gmail.com>
Subject: Re: git non-intrusive clone
To: Luca Di Carlo <luca@dicarlo.email>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 7, 2026 at 3:20=E2=80=AFPM Luca Di Carlo <luca@dicarlo.email> w=
rote:
>
> Hey,
> You are right, I've re-read the article that I had in mind, he downloads =
it as zip before, not as clone.
> `.git` is not cloned.
> Sorry for that.
> Thanks

[we bottom-post here ;)]

No worries! I think in the past Git has said "that's not really part
of our security model", but I don't have any authoritative references.

Still, definitely worth having the conversation, and I'm glad we
figured it out together. I'm still somewhat interested in what we can
do besides "try to tell folks not to blindly trust downloaded files"=E2=80=
=A6
but that's never going to stop being bad advice :)

--=20
D. Ben Knoble
