Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793586445;
	b=J/jIY82oh+9hjeI9NpOyg+QwSnNhFrYsTAe30Mzb9lVn+9yWhoujGZcvgsp1dLed14+/
	 vzKGbpzHvp0txOA4HDiRmN5SRqbfhPuWkplILQhfuyiahsQd8KTvk2VsJJqzt+jiNhJ0A
	 XQ4p8bZJsMOvO/lK3o6kSOFvaS18bCo4AKgAkCPaliu8x8eC4uPzRgJxGC7HTdJkG0+VN
	 Qp4htWqZWIpAdnvLYimBek6zh5amql9bpIIU9/A3x1II/p391uNciZJc/Yzt47h+dc3X2
	 hoYXm4NYO7Lv1gTdaM1+AQSajE1/8jupH1DbCG1RUMrkO4bySFixUQyD2IITDIWVHWQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=h6ZzEUlUPegSnBuJb7/4Kg2GPM5MbIOdR3TW7eKK6ng=;
	b=IWXUDVOWp3BwB/w8Mef4Js2MXIb3KAR6SUYVgdsNu2OVg5HdaKFL1aGYUjOtSnRAwdi+
	 0ARrI0NkW1laYq0WNR2CZLFQdmF9DK0u4JO3EJhc23lNL6IwRBzlNGDi5fYW682NfcL4M
	 VMqbdo2nDbtsUhrkaEEkBhX0Rl3JGSaa/D7723k7EU6ZQ9BpjgCHsaZ1rzcChua3ppSu7
	 bVh0tF6jYHj+E/5k7EaGqzijN119quMyjdR/w0LjnDgT/j1wqwAkE4Rpg6bHK1YhF5MDk
	 DO2Zj5j96kvOHYYDqj3j+sklWSRuHTC1axzEiAMHC58WtrgKd3TMu9HjspCu0ijmKwQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CLJU+ICM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.173
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1B7606A324
	for <git@vger.kernel.org>; Mon,  2 Nov 2026 02:27:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EB1B7606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CLJU+ICM
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4b28d9537bcso1850157b6e.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2026 18:27:24 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793586444; cv=none;
        d=google.com; s=arc-20260327;
        b=PMQzDQwWvj1jDITEH33oqQTitkP6Vvx9rwdqf/TWGqQQ6TPqUjSpNwKMLe6EIybKDW
         W6Y1KUwXCQiamN+tOrKeHoVKHtgGlykOi/IkC0CALA6cLGny0VVCTOotLJkxJQzaTgJq
         Axgh/MexaaDd0Fux1wt41Tw7WOEWWPQjBwvQV1uYwo+zRCNRGXGGs5k00afPzdddyJ9L
         M5qX+uKybJet7BaABb+d0dQSvdT2Xvpt5DCLS/rkr7ZLXyFPB+BaAy67+jwaDkFl3Rhc
         8dPkmv88TqdSJE4MQKCjxz2ZdvPdEAP+a00K67z6kp5KXTbKJkm9SURvTFSt+4eEtGt8
         7dow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=h6ZzEUlUPegSnBuJb7/4Kg2GPM5MbIOdR3TW7eKK6ng=;
        fh=hz+/nn3ggLKvx7MVMCnEfhHO7zZTcWxbS8wudRGL11s=;
        b=la7QtzXZ/pCcDeB73RIjXRcsAdPgGXQZr83Q6+9rdR/CJWVFWSmkQuOJHrQxkmeBnJ
         R72tSigK/LlWD3ff/CIoWU6Aeu3AVMAtdc2qOGQGJsbRwcyj2BS2WFl6DFvjzlk5a24t
         5RJEjUX8YF6qtMKQ5RiP+rEod4iMAfU8zWj7TTrZEpvAopgV0wwe3hKfqTnuSYHxlxn6
         JKPsgP18Crc4g8ipqvtakjG4/dWO1sO7486DG+WfdyudP5N0d5gcEWvxTIehNjATnWNu
         HIls0mBYlsY8ikiQHNxdWEgjsNPFJgV4hwXo1CCw+R+mzzITUpNEtyPljvz6z8vBvBFP
         wt9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793586444; x=1794191244; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h6ZzEUlUPegSnBuJb7/4Kg2GPM5MbIOdR3TW7eKK6ng=;
        b=CLJU+ICMc3/Zp7L8AhWoCEm2E45IYZckO1h/dnsXKK7Y2lo7Lmftfu6G5yoJ+Aknlg
         wu6x2Eh+dD8n3V58OgepA/UtR9Pf7Gg8tXR2LLHwxej51d7jSPMe6scbsrWm3bNqTP4m
         gbt+rR7gd+DvJOIoEZBTpM4D3qgBTUUyz7rpBBNc/D5AcQhRfEiXEyj0sSyEXd+udR2g
         lHCir2ihMLu2qykbse88IFqwvYDp7MhbKBpA616XkNr6PuVZRmGNIjKHpB2ajo0CD7Kf
         2BJV0kNk5Liw2DrMmIkP3DQ4bEq3kTFh5z57p6gx/q3a75RvvyLHU46JT4g5Ki9cmCmg
         Pqwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793586444; x=1794191244;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h6ZzEUlUPegSnBuJb7/4Kg2GPM5MbIOdR3TW7eKK6ng=;
        b=iVwd2+ZMKAmAm0LUBOWW5dy+gEE26/wd/P64vduzmyZCxV79ZxYNZ5Egp7ROexeizT
         x2tnKeVRoQBUj4Cr/0EIQhWvjC8mB2zL78AYwkGyFBrGBwAx2KvZxoq38TQ4g+cw0sqO
         JDxd4MXvZVkljZCDWiLD8gRFxHGdT9Vl7gGQrxgsDrIX2+RLmO8+cwu8KMN9N2DdQBCh
         vS5hkJWrjHVABr/g90Nlh7cLm1g9IWm8Hj25TIoHKb3iE5qra/M1UExMCp0/D/LMmile
         QiyOvnTAb4bLt2y4Gqq+UqC0S6MlBPW6ywPztmTXqdWmBewBj2S09gw8MC4lvZQDxOvS
         gRIA==
X-Gm-Message-State: AFq9FYLF+ZgjrdOR8pW0d3OAGp2AJ7l4HKc2E0h9/d/bzn905a9odfHu
	iAfH7lIecSkUgt+pAkH1L0sk9V0lBhcvIMWgeGJe6aw0YE+qoAdPGc/Gw9xRTHK50AS8Dd5ecq1
	0hRhBsK697LqqFY9HReUMUa6W8zxZlHk=
X-Gm-Gg: AYBFou2NAGLwjcaXoAhjsoOR52poHlJHRVI0uXNJyB9fuFNNQzj3cuFWcJoPSjEZsmk
	SEiQII30vbrFDy1n5D39Lhj198adxSWwtUW8Pb7m9VsC/WzN1fLS1HFDlLwWgZT16P6xzI4aPEq
	+dgqZad6xLgT50wPr7SmjcSOJWpBhbvEwxpx9t6ZzYoAZ67LsZvjTWGEGh7qNXXKH+r9umA2YnQ
	1kCK4QBTVSrTtsRJdC8l9ae138H4FdEaB/jWyLhoF5qXKgYKoi812JtGO5mfI7zhcMTjGkyUrS7
	UY76l0sfiotXsPpDAIKc2oxPLWEaC6cjYPF7QZX1LGkIBFKrch1OOut0hZ3ngb8gcRFYIe/quv9
	OD9fuNJlLwhkAm2ajGIlW3bX0tjzwoAzejCTB455d7udAqIPVA0oP3IJmXIERxaKK42M5ps/3ii
	ExebOsekJmqVqw71JMCMcSpkaQxALtrXjE90jTyaBZ3dR43d7lNkXoJy0=
X-Received: by 2002:a05:6808:1585:b0:4d6:9133:cfe2 with SMTP id
 5614622812f47-563efbae72cmr5892014b6e.39.1793586443696; Sun, 01 Nov 2026
 18:27:23 -0800 (PST)
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029012616.139783-1-tangajoris@gmail.com> <20261029231621.48958-1-tangajoris@gmail.com>
 <20261029231621.48958-2-tangajoris@gmail.com> <d026d6a0-5b1b-4bbf-bd1f-5f41c9c2a4e4@gmail.com>
In-Reply-To: <d026d6a0-5b1b-4bbf-bd1f-5f41c9c2a4e4@gmail.com>
From: Tanga Joris <tangajoris@gmail.com>
Date: Mon, 2 Nov 2026 05:26:47 +0300
X-Gm-Features: AclHuK_VxMtsG09pazPCC3IN37T4-e4b6Nj8FrlK0IHrO27aDk-4PKGTTTl9OR4
Message-ID: <CAKrRMNogw6rUsZzDsEPLmLAmjB6fvcH4njga+_qBz554x8oEwg@mail.gmail.com>
Subject: Re: [Outreachy PATCH v3 2/2] git.c: drop NO_PARSEOPT from builtins
 that use parse-options
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: git@vger.kernel.org, l.s.r@web.de, gitster@pobox.com, 
	christian.couder@gmail.com, siddharthasthana31@gmail.com, 
	usmanakinyemi202@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello Kaartic,

Thanks for reviewing my patch 2/2, and for writing the test sketch.

On Fri, 30 Oct 2026 at 13:21, Kaartic Sivaraam
<kaartic.sivaraam@gmail.com> wrote:
> This looks good to me. I was wondering if it would be valuable to also
> add a test so that any future commands that start using parse_options()
> could be caught if the corresponding change does not also remove
> NO_PARSEOPT from the command?

I also think the test is a good idea. It would definitely catch future commands
that switch to parse-options but forget to remove NO_PARSEOPT.

I tried your sketch on top of this series. Without 2/2, it fails for
diff-pairs, fast-import and patch-id, so it catches the bug this
patch fixes. With patch 2/2, it passes. I had to remove the
'false &&' line to make it run, which I think was left over from testing.

It does not catch var, though, because var only has short options
(like -l), and the test looks for lines starting with '--'.

Currently, I am not sure how to make the test catch commands with only short
options, because the helper only lists those with long options. Do you
have an idea on how we could do this?

Would you like the test inside 2/2, or as a separate patch 3/3?

Thanks,
Tanga
