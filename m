Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DEE743C7DF
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 11:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788868121; cv=pass; b=mdn8zsXnkSym/ZBod5U8ceLLxCdRVznVGcf/ZoJVxb92zPUg7g/q4DRvS1eiLOpq0lAy84w7TpHh1kVmdLmd3LHbSc9VAp91UIA9LGI9XackBzlcZMY50NMl55GwyP7I1jUCPWL3UoU8qW1Ybm7y/GktZP3m2LigCH4VuVEqqyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788868121; c=relaxed/simple;
	bh=7G3sWlRkrsxzIENiDrq4PTS4k+kd4nb28XYfbDBJGls=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vEcTwk7ChI6JS6sYKa249ipjRBMH0K6kT224gCvhzNj2LQSpMxtlaKaoIytZDOmwhKLJH4TexcmsINCJFb6bdahCupoeF/jEFTE/dznryalPv0YRZ/w8H3COL2AmTzww6Qd2DA0taEINv5hH5oM9o5LMf24lJYUEaGamr5Kd8hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAQQZeLc; arc=pass smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAQQZeLc"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-97ca74bd6e0so942763241.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 04:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788868117; cv=none;
        d=google.com; s=arc-20260327;
        b=YBl2R+G0HTIzlDyzM/wp8EC2W7jJlJFKhKi2F+u5MCJl4YsLbnZqd+KTQ3nvC92Tjl
         ZQ8CnpVX4XhzpsHxT+s4MpBL5u+cyy6av5CNASRFcZ+9r4D/W1Ti3r7DZG4OUZHlaGlS
         4Vb6/meYRauaWL4OXbS33CEUgqF7EpNBfHmv7P3eNLK1OQK1oHTfXGiJIUTAIqbuuW2y
         pdc4xRR8mfH8rQktyk9mi+lzmF3LncMfpUw/2NyGFwQCtwk0aUJS15U5ozlAOdOzJyJv
         Zq00WjItpmbq70IyBtJcpBbBbydhUubFxdq5HRzYM3M0A/X55NZABkchu358gNjNeVxW
         llIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=6rZeSPPDYqxk7JCTCCs30keGl6DgyW2/glrFT4Bjab4=;
        fh=Rn9EFvid+bDsg8CskbihT0m5GvhnTPnaZZUMwd/52l4=;
        b=ETDq8LF5efYFPlLUYNxG5qx91BXKn+smOEojhXoqObDSj314t7XME4yJY3s7+Hi9lu
         BkUGVgyHkhjwRrOQ0B7Cc20ByJG3ovpFcOzNEz59Ai4I8zZuxNXb/DrKWr3+lx9EbhmL
         yinozjQGNOlONWSaZwRoHSGhhPLQTBMydzrojv159xdlDIM+1T1uUy33mvhlQnwoGIWn
         OrymF69fVjaotYuoXwXgk+NPyE5374cK8cbDvEsuaQDW4drqHocznT2HypKL4gUD9W7f
         l1kcRnLvwiXDiZJGNJfY/nMSKdLIzZd34pcsZGandUxWzQGXW0VVuPjx3dCuPwJ4jvdu
         n3fA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788868117; x=1789472917; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6rZeSPPDYqxk7JCTCCs30keGl6DgyW2/glrFT4Bjab4=;
        b=TAQQZeLcMhXtfczua2wj4DHQyB7mC/oRMYB8Ldb6smoFOCMwWTNpORG1ptkM08Ci1q
         HtIidHzGvfPMYJzqTq8aUeYXVrfcNoQyAsW5p7S6Qic4xW057ISiKcGfhmc4FrGtK/6V
         9kr/Z/m9CxgEs9O2phrCzMAkNB2pW6I1k3Ze9BqFfVWSdBlL/ws5lH+uSn7CnpGtHBXs
         wagtxga7USTXL9pLRlsQjgC+LubEVFMT0dm1yBwxIPFDIpqEhpbQYYkd651WIgBpzTzw
         Tx2dwy+8ZdgP5DvXpQf9jCJmV6dJAbg3wMEVzvFuuzH5a884Y+xAASuUzIFfdtpLWYHm
         JoVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788868117; x=1789472917;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6rZeSPPDYqxk7JCTCCs30keGl6DgyW2/glrFT4Bjab4=;
        b=kCL7T5ry0T0eTW9kyDB5XzOldAw1kR7h9s1k3AriNmh/2kDxoQTC1se0ulwj4+E33l
         4vGX26Yz7v8v6ShKx5znhTkG+guBTbMhXYx/HgUm1NQWyN578AZ1lwVQWzqmp8BtYS/J
         8S7HKDI2PCCwM0//b4Eoic22pcVsOe7l7QIKUrvywFGihFaSR1kL5ue4LmSdc02W6UeN
         Bq/ZG6SJAnyk/C1ldXIU8SyiAqJMlzGm5kVjfSpr1Eu4CRWojEgPZ6QssVO5Jd6wxtQg
         stOeYOkhZKzqUK61BA1LYvfkw+Kw0ensoeu0tBVIE62YcSC29GAxGLnkwUhwQeb3zcIH
         8fIg==
X-Gm-Message-State: AFuF++mlFocfzwqfKQaozX3RBLWx5DeVSR7ujvO7nn/8u42ERly/q/LC
	YklMtqT96NJNUY1mvIRwwQcL/gPMik8tEQvKegVFCXxB1oXuJtXd1zKTBpl3kd3lJbvGyrWMvWv
	I+T2ErXPQUA/0JyFt+nc3hMo4n716cmN40LYv
X-Gm-Gg: AYBFou2uNaTKN9GkijSGOzHjgFa+ZIm+dDbjQ6/SPmaQ3mUgwJsgwCuzylbbrSbOIw7
	bVaBKAAC3+T99Tx/HuHtG8K9df0Eba8Em/t5d7hXjMZcrMKGBu6Bs9uGIV+8XvfnHgwXPpmpu0l
	kvxn5YVkM1VAPAEsNAWzhhhxPmtHcwWMO1aRNFc3Ijweoeli4mAKStyGUBGzwNz9ish16m+Z9UL
	/HoO4HHZU4UD0sIBJq0j46oqmujMb9oBtp+hOor+pxMlWsMWY/snvYYwT/ekND9Uoy0G/w7xgig
	OGIL/74ceYDzgzlM9JgIhXO2vFf9via+hdIfDnHOC7XuqxWlUMFYMUTeeQhzRXeGJbf78tM74gk
	YeG+0rstRt4M2+GNZ2RRcpHM1ohshI2qzZar/a/TdLLrL+g==
X-Received: by 2002:a05:6102:441b:b0:784:d83f:2a59 with SMTP id
 ada2fe7eead31-78a4aa99295mr9227938137.9.1788868116923; Tue, 08 Sep 2026
 04:48:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 07:48:36 -0400
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 8 Sep 2026 07:48:36 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <ap5Ud5OW2NXRuDoO@pks.im>
References: <20260818-758-introduce-hook-v1-1-8a8d89e65838@gmail.com>
 <20260904-758-introduce-hook-v7-0-6c66f0a3a572@gmail.com> <ap5Ud5OW2NXRuDoO@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 8 Sep 2026 07:48:36 -0400
X-Gm-Features: AcwNN1VaDA_DbFWjaE__wVOyEm4Q5IhyscBY9e1Z8h19IRr2VbPrWuRFVGfVe-I
Message-ID: <CAOLa=ZRg2nH8xmjSKEs-hMKcKXPOgo+tqF1VrJx5_APkWeW0dw@mail.gmail.com>
Subject: Re: [PATCH v7 0/4] hook: introduce the receive-report hook
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, 
	kristofferhaugsbakk@fastmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: multipart/mixed; boundary="000000000000a8e495065af750b1"

--000000000000a8e495065af750b1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Sep 04, 2026 at 11:28:48PM +0200, Karthik Nayak wrote:
>> Changes in v7:
>> - Removed report_v2() since it is the same as report() with the new
>>   changes.
>> - Used a switch statement instead of an if/else for the enum.
>> - Removed an unnecessary curly brace.
>> - Also rebased on top of latest master (3cb9185f65 (The 22nd batch,
>>   2026-09-02) as there were conflicts.
>> - Link to v6: https://patch.msgid.link/20260903-758-introduce-hook-v6-0-6283b1fb9b1c@gmail.com
>
> Thanks, I'm happy with this version.
>
> Patrick

Thanks for the review!

--000000000000a8e495065af750b1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b922903d8e5d7357_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xZjloSVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMWdtQy80a3d5eklDSG1wTkV0eFFWTlgzSURVTU13aAp4ckQ5Z3dCM2VF
cnREYzZwSGdXMDNZQ21iYjNobE5qbTlCYk45SzU2TStYb0laUklrZE1YNitLNWNNVE1Id3pSCkcz
dUsrZTBBaFNOSnNLNk4wd1NqVHdSK2h5UkFVSmpaVVNLeGtGcS9KOW12UzNrMFR0QXE5dnpiWkhX
Z1d3bmMKY25yeDZ0bzdIc2RFb016QjBHcFU2a1YrazFLbkdUeWxscHdERy9RTzFIWVhlNGsra0dO
eFV1MnZ0ZW5hTjl0cQpMM09sT2dMR21XRWhCL1BjdVJ2YkRJNU9Dd25GVUVFakJtTmI4Q1pSK3R2
VlNDTmZQZzdLYjhjT1N0bHdzWDJqCm5TeXpOdTdBSC9QNUxhN2c0a2IyMm01bjJMMkY1NXRRZzJX
YmJTb1FOZEhLYStNU1hPRWFtYTduS1dOZ1R2ZU0KbVRBb0gvYUVuTXd5dkMzcHBybmRoRTlzK0FO
aFk0S2NFN29SN2cyeFZ4V0FzeG0ybFhrWnplNlFRcUFsUnFpago0OXNRRm9vbEs0RjdFQ2FvaU1L
bS9URXArTk9vaDJvWmdCWklUalZNQ0tRaEZzRUMzK2djQzc2WDVsVUdNVjdvCm9TYlpQeDl0NWhQ
WnlDQTNDYklnRWV0ZXFOd3hkVFl3N2VsMjcwUT0KPVM4NDgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000a8e495065af750b1--
