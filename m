Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AEE30E0D5
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755626383; cv=none; b=trqz/h03j9ua7LyLFoHtR0bM8u1MeO6aM+YI/xvq+whB1AcTFWtUyWcrcrubB9ySfD0YyIUCn6ou7r4YqIqx5aWI2WPdhVjc47rkYJAcRJMiXCIEg11XGvZNouiNOmR0QkJPZf9yjtR4OYBqLNGpFWvrQSD3Q0KYaQ+z9kcN7SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755626383; c=relaxed/simple;
	bh=bFrX2l4EFbsl9E2/xSeTwtas9Tq5pXWPmZdHYjJ83qY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=mMHtTliVtPD38vpK6G4rw6dnYuvVqHzGYxhCvLDxEMaIgR6qhM7oqKox7W1ITWhhGDqsPeyC4oAAHyw5mFK/J8SEAaGy5+RQzpA9JIVbk+q+NyNWm6nLMnzGNY+t4RJfl+MQaGh7ybU+UcOUzyZfVx95p2WPvEiX4oaAdOWdVMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=donorschoose.org; spf=pass smtp.mailfrom=donorschoose.org; dkim=pass (1024-bit key) header.d=donorschoose.org header.i=@donorschoose.org header.b=nuvJF40S; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=donorschoose.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=donorschoose.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=donorschoose.org header.i=@donorschoose.org header.b="nuvJF40S"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55ce508d4d6so4426212e87.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2025 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=donorschoose.org; s=google; t=1755626379; x=1756231179; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFrX2l4EFbsl9E2/xSeTwtas9Tq5pXWPmZdHYjJ83qY=;
        b=nuvJF40S8IIOzk5ROZBeOOzxr+OM3GkLVP0R3lD5hyvLIam88sH263iVzNVrmaZISB
         DCiNpmJ15kJKueEg5Omukpc0XpSSEFt4CYR8qLK2A6S79Ekx+iZHqTd6uSZKItZ+VM2t
         9u1kA5lRN6xIXLUm/FnLWJD+ZUUj7gFHbwVgw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755626379; x=1756231179;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFrX2l4EFbsl9E2/xSeTwtas9Tq5pXWPmZdHYjJ83qY=;
        b=aEsjQqhgr6PyYCxDkyH6a5YOnR2gWnJfxGlapeUQc2qHGudLU5JGZ0VhZ0w4Kwdza+
         ZNH8/5cGWtTxVZnFtwX+i6mNVersu4XIxDmoOX3cRYVmidrXHjf5i9v5U2bozQVQlwiG
         09+I24JV/UFJ05ktdN43ezXJ6hfvTOuJosKck108sJjUVTAEe8+ukPMR55PlkfmhdmjL
         JoB7VajJxqM1ReA6SRlDiwoVqgeuwsO/7BaaniCKnwwJcUsetC9wU2b5dWLCb4nKoRPV
         gLLuulV0rDCnDyPcrGnXDNMagmjCHyRh4vHUSr0D0BzaW/9Lq//GiWGiem+wydBgwwRJ
         4erA==
X-Gm-Message-State: AOJu0YyYy3GvG7fIwxbHMmf78ZYjjBqRhdHMrk7Ga52AbwSTGO3kCdL9
	rWXUHIk1vHaHK/BvtIx5OpMw7lmBQ5gSgmy4YaZ3ayR6cfaf1noglj28ez3Nb/ysTxecATrHPGm
	oud9IHucj6y8igHVJsGGIHGlA0orTSaETaWjR1IHCIkMzh88fHEbSyQ==
X-Gm-Gg: ASbGnculmTd2xYhWNatcxPDOcBnfduHPawROz5qovQgHKOreinh3AYEqII2nldzLBSt
	ncV0eGScNr2WApZG8HKARvnHVA4BXfv8BpBBIdMw9kGZjmUT81isHJBbf9nFiOS/9majpFu2bmL
	yz3n1kGuUp79DbJgfQ18LA3tF2DkgXeMgFyuIf5g7lJhGw/GBFjHDmZahWdYqPbHt3IGOAO0PAN
	HevF2opetQhi1o5Qoo=
X-Google-Smtp-Source: AGHT+IGznNdeQSR3R8Pn+osl9rRHj2f/WpmkpXHyuavOHg2FWqh6ZVRNGaES/OvDmcpOCwSnkieqfcIBPVOe21a0jT0=
X-Received: by 2002:a05:6512:3345:b0:55c:e6c9:3499 with SMTP id
 2adb3069b0e04-55e0082c041mr1142733e87.31.1755626379564; Tue, 19 Aug 2025
 10:59:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
In-Reply-To: <CAAn3O_2n75RGpvxv1o14BE3KFdwiJW9OOKaHp6_c0rd_MqxC2Q@mail.gmail.com>
From: Chris Judkins-Fisher <chris.judkins-fisher@donorschoose.org>
Date: Tue, 19 Aug 2025 12:59:27 -0500
X-Gm-Features: Ac12FXzEwPXSZZVuDMrdNT650aWPGPilohFTIRjjSYTNYJqI_ZmkIn-6zDJ2EVM
Message-ID: <CAAn3O_1+4EUcD+5WBY6-TwPCboVTikBZzGYN-QTJYVEiSaitPQ@mail.gmail.com>
Subject: Re: git whatchanged
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Also, my initial email was blocked for being HTML. In future
deprecation messages, I think it'd be helpful to include
https://subspace.kernel.org/etiquette.html up front if the emails will
be subject to those rules. Seeing a blocked email when I'm just trying
to follow the instructions you gave me is an unpleasant experience,
and I'd imagine it dissuades some folks from giving you feedback.

Thanks for considering that,
Chris


On Tue, Aug 19, 2025 at 12:51=E2=80=AFPM Chris Judkins-Fisher
<chris.judkins-fisher@donorschoose.org> wrote:
>
> Hey,
>
> I still use git whatchanged
>
> Thanks,
> Chris
