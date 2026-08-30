Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C735F215075
	for <git@vger.kernel.org>; Sun, 30 Aug 2026 16:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788107015; cv=pass; b=cT+uLFOJ1vxyUjp5osgtWjzpOzv4uN8IVhuHYJYlZOwbRYuxh13TUoEV8o9GQhl0ddGW7tOBYccJcdLwF28bYuiRrYmz2R2/z8MOUr3qAflpeHU87KM2AcGIfa07V10Hm4k5yRg3ujWcSgWdJoNhlTWYSwH84aCnvq3tYF7ZujU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788107015; c=relaxed/simple;
	bh=okfQBgZLwgaqwF+iI1d1M0oVjtgL9//thIIFpNq55Tk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a2w+w/X6HstRPPA4+IElpQpbAUCk8yzFDq6gkAyS7GHUcATitmmggzbEYLYM13h0ICa0+iCE8T/jmlOOMTcY4LMoTuJbZ//m/fbuA8Fo4i4rZVseDiieTDwr9sQ6m+1qZDc81GiwfjZXgF2uDghe8/ps2m6M/8MyKZcdgP6ZGuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kL45DL6I; arc=pass smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kL45DL6I"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7f4e596e393so2586689a34.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2026 09:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788107013; cv=none;
        d=google.com; s=arc-20260327;
        b=hrEjn69aLzxXl3U0YmEK9KoIR1U1PwS1oBGqOuP5r+bOLsne+s5pMG/01tJvNY3kKP
         EDBFmKHR9wUhJnDKB/PNhR7oPzhN5qyeDx3rL5GAEDzgeVIxGcQmV15D4RGadSn8PazL
         HC/QvlP/d5CvIzpgmC8iWe8KnORWI01Pxuesbpfh5eT0goKK8hmI4B/Uo4vKNASdWeW1
         BUPlO6bAw0QnHCYAZscVPv+2Yps4CK84omYuEZ5ZW5Y7QVfVKKE52op706CRigCmxIsf
         J0HwD9yGQ3SJg9UxQHG8OJKkjAYCZmtrBbWio9iwNDyuXKlVBqMc4UzZMOAmQpTuGtYz
         HjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OWr+AxWqwR2uvKpY8DuHh+sTHLjVrzKRuRCCi8XIwmI=;
        fh=7ClKhNOZ18GaCvN4f7ErSfD3lrs6iTyRhVUawLEOtiI=;
        b=F/NeektCbiQ5hfM44tipK0+NVW2TeJZybBCYP7jSw4x5cih0IC/0YagL8Fi7YUgb6V
         m2zYNpitabc4je6VxJdUoAdxO+25lWFG8zmtDRdNzD4u80Wi/dr7X4vZ/K7zJ2uqnUgc
         8uuldI5cCw1HFNGdY5Sc7Nx9ytG5rKkSj5bsXK1OzAg31JYnfYI7GYpi8Nr6ZWhAAWAP
         2L/sp1DqoJ5TZFDPvw1yTQfcBcC+SGqHhf94yNL2J/BFJPzf9lYj9F+icF1OqVrfZn9L
         gGguQ1UZKgYqkbTm9FSUVkzQr7eKySxQpGnEahV1Uimo6oWvv2tS3ZiArigCG3p0SigB
         SoHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788107013; x=1788711813; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OWr+AxWqwR2uvKpY8DuHh+sTHLjVrzKRuRCCi8XIwmI=;
        b=kL45DL6Irsg8FlTegLTPFiXbQwAuREK+9H/5MtKoAvneKD5e4rjMF6+iJF7Z5hCuyG
         7oZP0byxE9WxqKroBmn8Rbhe5X/e6KfHik2zkvkG2Ts9T4zE7qpXWkf7geGD9X/CJICS
         Orhis/Xn0F3SQBu+ZJGii1mVlwlc/Vxua6XniNxMfmcJjllptLThic7upqxGYPb5P2W8
         l/iKaZz+4bQlGBja50w/7bUE5AskvvEfpSh1Co7/vOunQZ9r39pTV0FZAUTiMaMTU4ov
         7V99BfxMeJQzpIjmyGMtTs6z3VFBVw4hPdbp7oI2ZecKNbi8A1d31zZ13Zyh151aoz3q
         lkSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788107013; x=1788711813;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OWr+AxWqwR2uvKpY8DuHh+sTHLjVrzKRuRCCi8XIwmI=;
        b=lKzttWgwnYNRLnDIsjDv4auvKwwKoBcFhUIwNxxD1+Sxfez3Eql6cL5OSx5Kty0is9
         7tmrtTw9vA3k5sKeMIl/asdW+/ECJkGa7Bhvbsql8ybp1X5Eh+eD6pcsagk9uKs/bi3A
         v/JgDW8+c7+2bDTsnYuTuPv0qbIBcjEmLfWe4UeOYZX8jy40A/ZsrKmQ8E0giptDGuJq
         e1wXXIfswfffdv4gzetoyz49DXTxehs8Po+QU4law1gYC+NQ7Z6jIXHQpal+tjJ073oV
         8BGYDbRkY82pX+sUOpafWxAgRz0Xq4akWM+Dnj3cAB2H8kegg0Ig/WZf2aze4HFZyhPt
         sfzA==
X-Gm-Message-State: AFuF++nrU8Das1qktxBKeHNYczEExhLGlOLKo26bXx3COSW4GMDo9qNF
	vm0qydkaMIoGdgMh+Zpn0mO84eNXYMhGuHPeWWrMCJLWHNVfq3/s05i30H0gi3mipWuckTR7UHx
	O7IY6bjIK+WvyHQfX0I0jzcpULEeNf3u6Wg==
X-Gm-Gg: AR+sD12hP6fuS30E9S9DLhlVfDCa9P5n/iWCjNyr6XWTmv58ISkAgSbAHpsqN3Tm+XA
	RmdtYHjSY3+pG56oa+PJuny0QNDhCpNUIu4pxgii0KVih69qJEPnpDiXyG7MJQfxc9vispapFfR
	tSRO1lmNg5Q/M+0YEt0a+YUGWlvkinUJXci4LwSlA6bASYBuYHFvZYIJw4VV327q6h3T0HmBETK
	nwrfaatIS4F3qlUq7+YADxko0cM+N0GEd6zGoWaW/5VIPaomMYK3tX1rvxAX/8na7G9W0SeDsXo
	P6jEeUp5OSS60Mwl0dsuAQET+7CPN912yc81OUszRBYD21poWjQR5cpXbyVe+QyuJgQi4QTQB7H
	6HQ1Kgxath+RIy2q/tnxfmy+ejhoOTZtBjIV3gzInO9EJT6FTqoglirxL4XNDYWI=
X-Received: by 2002:a05:6830:411b:b0:7f4:effa:a5c4 with SMTP id
 46e09a7af769-7f4f2237021mr23082501a34.1.1788107012637; Sun, 30 Aug 2026
 09:23:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-typo-v1-1-d397c8dfb301@gmail.com>
In-Reply-To: <20260830-typo-v1-1-d397c8dfb301@gmail.com>
From: Michael Montalbo <mmontalbo@gmail.com>
Date: Sun, 30 Aug 2026 09:23:21 -0700
X-Gm-Features: AcwNN1WKqwtizblURiYmCBjulQQEipLibHyTrGaow0IWA6L_ZGtKdm3Nw0pvBpE
Message-ID: <CAC2QwmK1CR9177=eD_rqGrCULPkXTDDcQn=NHqoGGBzdeYEYCQ@mail.gmail.com>
Subject: Re: [PATCH] typofix: fix spelling mistakes in comments and test description
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 6:42=E2=80=AFAM Hardik Kumar <hardikxk@gmail.com> w=
rote:
>
> Fix spelling errors in the following places:
>
> versioncmp.c:           "fractionnal" -> "fractional"
> git-gui/git-gui.sh:     "occurence"   -> "occurrence"
> t/t0022-crlf-rename.sh: "similiarity" -> "similarity"
>
> Signed-off-by: Hardik Kumar <hardikxk@gmail.com>

These changes LGTM.
