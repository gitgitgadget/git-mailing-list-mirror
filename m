Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7687449DBB5
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 11:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791544757; cv=pass; b=lNo/HEynMmmmNtVWPs+xKmgxapq7l0rVKwZfjw9D9hKmbODauohvLKh6Sdrvkwx9Q72FayFEgGWMALmIFTY2iPlPC3u3cX79596Wqj+oan+fRgGPOy1O29MYjRJZxLrP5Dh2ZqLyhsHt04zZKWTi0oBrmzKcypBAUvtdqax3iSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791544757; c=relaxed/simple;
	bh=4z8ww2Hlo9kC0yrDhYN/t9rHSZmopITN6+5U3juSsak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Utvh/PxyVgcXB+MeReRFI5pc4pjXceyTfxV8khE8/rfVe9YVuQY4pMZBDlyLygJGkbwEyEguOcPTntv3ow2lIDHINLyBGtQvvedmtutCF0xn/YUR2Hl05c4Fom5H2XsUoCUUpIJh3WFPgIDKUeeZalmGHm5WyXlLh7grT61rTzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XiIIPK/H; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XiIIPK/H"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso7894725a12.3
        for <git@vger.kernel.org>; Fri, 09 Oct 2026 04:19:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791544747; cv=none;
        d=google.com; s=arc-20260327;
        b=BGk2RnlY3r2yAt7lRmz4BFApK8RHg+2+5eZNTwNR6dXTHOhYuEEG3xQdBopbRZKOhC
         mmpELbNrC5RTc0YBeVjbrPJQAbCBNH38RojMzUlA1Url7s9lUXAtdMTvWhpCiZ/ZxYmq
         gz3Ytdy+jnCfC8uNGDJv5L3xPOOD1SVo72Ino+lAzeb7xhzWBGY6u8Yh4wnbcWKwHhNO
         JNHGRBCBjnOQInc865yr499vLqGlS2tEcDBF5fcLY7l/2xNHFgc2geurZv9qKJuLY1u3
         vCiZEhFCS4xN8TMnQWNZ+xa8iwzpVRnVxg4rpmN8HelgfpiU0gzKeI1UzMKU7Q2XNcxn
         caeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=4z8ww2Hlo9kC0yrDhYN/t9rHSZmopITN6+5U3juSsak=;
        fh=blw9L3wp5H8Gk5wmgs5Jpg9S3Yowxt7Ot9STxUIwl+8=;
        b=dXHS/XYQYJ3md4li30sR0EPt08OVCvFkiokKjlq5HwSgDbQqsl23O8qnlv0n4NoEfd
         e0pvYxnMePXblfYkdgUpBNMFhDhiNRuHqfC0fhWeYfid0lvQlY7jfZBcOB+uCE8/INLV
         ZYnJHPYVMPElvwGFGBa7w9vcPyBlyc4IUmkNMubq7ijlc2Lzv52ZOKhbbTSNGsX//GCo
         asqCKS+g1ngzozL0GvGbmZab8Z/8Ufrz4JfExSPokkacfcpT6muc5uF0Q6lpFFk1Q/hv
         /Jqr7G1oBeaJSN1TfkFseR5zl8apju6gcPuIG8OP8/VDvPqrpRYOuiGT1rH4anOHH30l
         UGfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791544747; x=1792149547; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4z8ww2Hlo9kC0yrDhYN/t9rHSZmopITN6+5U3juSsak=;
        b=XiIIPK/Hbe6x/Nl3PvEMPSo/TNY/cMLG5Z4fov95Asr2i/YPjR5dp2ptiss9Gtk2eu
         +mNfI3X74nN6Ny3LMLHlV5FpianzzWmaaJXZozwr7TqUH3EnUXf7wa3Zcoar1w7haNDZ
         PM0kc5loWm/0Xd7JQfnu7fSZuqCYeeYoJaz6yaqT4h6ZYhuwMvrPvm3gawnrY1FbQtYr
         plitPZdbwIs9xbT9oBgkioTHN55CSq9aaj6DbcKnJhC+zchgceIyoFho76hujSrlHHN4
         l7RD3bDxzqOzUSnPKEyjZeTsgEEL8Q7NawzWl2kbNZJRY1LlQhy8l4ZfsoMg/NGGK8S4
         KwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791544747; x=1792149547;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4z8ww2Hlo9kC0yrDhYN/t9rHSZmopITN6+5U3juSsak=;
        b=NFx27jAbWdNSlFzFcgVGcYmT8iClqP5/ctLxQFqPcL2Q64YcAbM5O/6HbZ2NWFDTgp
         rhyJjDN4TBFTIfEep4quWCYbXgrw4CqW9IwprhHk6n1Eo/MBFjYhldl2U6A8I4p0kCD3
         SlDQbz1q5oMIRVelb/Nw3siJT58wpa+sv+GFfGvr/qRrtDkgOMXUsOyk5uQKTPDSzI0M
         dHEVRFHmKjNBhWFJlNnQZwa15EVvoJ/1UJSIDaoaKVS1NqMU4+lZ/N/fAIWLv/JG7dRX
         J1czr/V04wyAVdK8wflA11Ca7YWPqE5QIHNVPlGvpuruGOy+dscN7SmfSPf5NVz/aSga
         IWCg==
X-Forwarded-Encrypted: i=1; AKwUvBxhBT373e7e5MjbxfJ90oEjdyx1rq8Rbcw8tQ0A+yuVQw5buIgaujtvQfnp7M69IU5P1II=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyUTsR1buaNFQZpE6zUP1byOm7KG5cVu3iE6aTf522T13SQpO4
	31OL1SV2Ue/4BNbTEf8+i03yC0HHDJ3Tc4HHKC1s54ZpjnSfQBl62EQMHChQWqyBVLwFaySvjfl
	tDe3LtLyChqpytTlb92mt6IGjc+1fjSk=
X-Gm-Gg: AYBFou2HMnGpQBlIuqNsn8n8Ld4cI+ZgRXbp6PgQbZhg1xXPSUibKGy9TuRm+IBU36n
	o1/vu7y0idzM7y/knfVE8tHc2z/92SucmG5dqhGgpB/sdeWILPbOHOovGannRSsiNWXN2258VBK
	L8ckCv6MICfFwh/DHUaVGPGcsp0N/pszjJ/n0NTms9Ryq4gY4OHzlm5ZaZrF5Md30PugmJ2vx6E
	/sa07A1XDRN8E8Bm8b37svHBZ2/Ek4E+8w7WfsDu9VnmXvm6P4/WMwAICSewyztuixiXiagMhMm
	3rPuPUEikm8LMblGUySVL6oQTTu02mUoelzrLsObbgir5StjcOlKvHLLbq8KyWU9Jw==
X-Received: by 2002:a05:6402:2712:b0:6af:bc4e:a285 with SMTP id
 4fb4d7f45d1cf-6b17c2dd330mr1383568a12.31.1791544747303; Fri, 09 Oct 2026
 04:19:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
 <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
 <39a28064-1698-4971-a80f-4a4c4dcdd8d9@gmail.com> <CAHwyqnVoMnO_fYGJ0N29bQv=Lh5naZ0jc5uSpiS2urQMZVG5-Q@mail.gmail.com>
 <61ae371a-225c-4400-b878-8547547d1269@gmail.com> <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
In-Reply-To: <CAHwyqnWkTvicU+U99j0MzzUUXeVnUj=FJJwUDR1F7DGk1hmtrA@mail.gmail.com>
From: Harald Nordgren <haraldnordgren@gmail.com>
Date: Fri, 9 Oct 2026 13:18:30 +0200
X-Gm-Features: AclHuK9nTbrfH8ZdBvmmMR4vzarIVeBKsAZnBEHaKkR3bi8A1hnL1fDCBjG5Glo
Message-ID: <CAHwyqnWmXM0fEn2X9p7g3fpzmXhfAJAqAj9SG0=6kOpunqfVUg@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: phillip.wood@dunelm.org.uk
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Interesting to note is that merged branches inside our repo change
when Junio signs off on them. So without this functionality they are
not cleaned either.


Harald
