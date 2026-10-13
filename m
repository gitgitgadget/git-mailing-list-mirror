Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182073E5A32
	for <git@vger.kernel.org>; Tue, 13 Oct 2026 20:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922308; cv=pass; b=REayik79q9V6YIYTVxqODWrTaRQjjRXipWnDEx47rPf3E0rXUJkOoun1ZN8FYexUQ3OcwGKA9/QfuoZDmmrDce9HhTA7e/NdtnfiNKqRvIenoce8/HrW/z1BhaalndCUL02MHYbq5V8hQEC/eN8QIbELLGVElMIZGrjI4hA0x6s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922308; c=relaxed/simple;
	bh=FuKgoqqk1T9ztjGdz4PUHuoLygVMCuqvPHrxWzXLLPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LSw+sl4wIZVuDxlnkwxSZGihSYqNxZ/V0uIkn2QWTo7Qdu+koyM9q5cniQOa6nsKqHmB7FDhj3ZT7CmDZAT51km7hgptf+2am0vQxy5sCyE6mfeWTo3FpH6qSiTG/xg2LBeELJ85YhxdQuD5QITi3S+fhOE2GeKVFLt3lF0Ads0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAqzOUBb; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAqzOUBb"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c3156e7705cso53806566b.1
        for <git@vger.kernel.org>; Tue, 13 Oct 2026 13:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791922305; cv=none;
        d=google.com; s=arc-20260327;
        b=VA/4LF0cyM2U9Q5ATsnGB4aEq5dpbpZJluM53iAnmsEvTd5KG0SV83rs1Xmp79vFwY
         RMDPQXEcOFfuOHqQHZMm9aktI5C58TFeF56p18EC0LCuRSGG2+TT0CGQhjJtUSW7yAQt
         UZJPfUcWsmX6KQkuGz84HkFBQCReN1JVvpTuFk6sCshP382wPfUH/9uvxYaxCksPzAlW
         7mHJfIOoSCRHyCJE00gvnnbA/ZZzLfJxKcbISWZTGU3ux6oJmWqUTJGLr15OuES1E5EX
         gcCpUHg7X9dwqHQYIAM2P63SGXQ36RdjoGQYu8nKOB494p8ssWN1+Ezcx6mtWL87vFXe
         v7lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=FuKgoqqk1T9ztjGdz4PUHuoLygVMCuqvPHrxWzXLLPE=;
        fh=SiobUyAj4DHhSNdnlWinoospsAMs5VhqwojcpsCKH0U=;
        b=FPCtwxgVaiLo45ZPZFkyF5pE/EuKILzQW2bPnzSbDqe+DQ9aZQN6SLouvrjYF9FUpB
         C8S7XgxoJb22yX4GfK6AL2C2glTsg71MvRUvTGMceKT6y3XNWnlt7V1Ijiqk3dqVB4L8
         YlfYDGjP5Ias0YNxk8Xh64dz2i+9S/Mgc7lVxjKitiGO0UXv4lQHCaac2TIh0nZCLzan
         J71siFvByUE3tsMpyI1mjUltG6JYES1B82QVBGOocI4oatNQ+kiZoWWwAJptfPz90SAY
         C+tvU8XClDDID53AZ33pXwSvSS4woPv73v25w6VYklTKX0XhpnENZd5gC7EajWVXAyCa
         W/pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791922305; x=1792527105; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FuKgoqqk1T9ztjGdz4PUHuoLygVMCuqvPHrxWzXLLPE=;
        b=JAqzOUBb/3glDEcWGeokcDtElHjfWSofJiKiQfe5+TiR6G24tKS3ennUQ/PRbSLVZg
         LmiMSTXXtnfWY7AdXhJgU1fnj9wb3GqkLcEUTaId/YTAnQN1/8OcUhnL3UvYTLPzSohs
         OaEBnm59+mEDxohKmjdXEvgVSZmZScyCeq0OBnyAghFbScB7/e/zDZZ9Scibzh6M2Vkk
         b5KDCnU2s5PJo3Qjr/08cfFWPnA26YmPl0av8nzgZPFwtU0jclLrIC5oBYq3YzPpBpJT
         X0gLFqmyWPnSJg6CPBK4rNCXYmJ7qN8OyXCyknyWtbVKv5mMYJbYq+qSYSIBdgTgeUmv
         Wo5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922305; x=1792527105;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FuKgoqqk1T9ztjGdz4PUHuoLygVMCuqvPHrxWzXLLPE=;
        b=LiChaBQy2xiivXdP+xxVuBX4ua+UcLVaWeKxFQWnR22b9lk2aFyNa8lRrKE4iqo7jC
         NYS1Bc2n1wUF64cKd2gEP/2YuYTRsaPzjUYN+DP0xNP7HBGVNS/LUMvi2GkW/kmO3Hkz
         BchU4wW7COeJWGbqVoLM8TyFsUb53h3JgdZxDSwUc27Icv1BuXLtdpbQv91BYVFCuqLO
         FTjDNamas1Fo9IB/K07YT1CDfLw3hF1L9Y3KyQqLLG0vOJzNXzwButZkhfwqrG+YI+w8
         N20eQjPV88sp8i60paIyVH7lA1/SlCSH5soe7vBPKoYozfP2DYn6B4TsZVGzsT2sDzsT
         N7sw==
X-Gm-Message-State: AFq9FYKnc00lwgNaRou5++XTpZQAjBWgnI1U/0m2hW7h4sdJYnPZDLLZ
	PtHd5CI65ASmVeYYIPg+rIC6DB32mMHMUtEYLIRF6pH/X4X+5I3nsEbxLsEfCcMbPyb0kiySiYA
	7W4mN1W4d+lRo56T9PwmojFa7OEagN0N92lvf6ZA=
X-Gm-Gg: AYBFou0nxoqQs31oFfwINIPeuKt5oke8pO/R/ifZKAoSC5ypKIWUEolmhgf3CGcvV1w
	UxakB6KRHNvO5wqRwFYDve1MPRtJdf6XmR0pQAqpYWijnwxFGqH+klGMVfIlvT0DdCfjrhCOW44
	/B8O/HJBRHP9KtGl4hzy1w/D9/Sr9a+G0CW3+s+Gos4Yscx4oa0I4taz92H/QO7tua5FKiOXG46
	JIeAVlKKrg6fdBpyIW4lQAVyNrlxF/s9QE8+iLmJOhW+KVmFSylUmIcH2aQl0qoecNXbTUl8XdJ
	JSxISKndX9LDlfLFJUkLBxGJs9NmgzGqr6A4iDjGrVB7Xo70LJhJi7xh9mHekorVUVpB4iP3o38
	bl/IWuQWhSg==
X-Received: by 2002:a17:906:c141:b0:c2e:412e:5121 with SMTP id
 a640c23a62f3a-c31a9a28e3amr1517408466b.4.1791922305267; Tue, 13 Oct 2026
 13:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAF-UMxiZet0qic3-ugKkovurDMP1h4Wt6kRN1J8b120Uwe8sGA@mail.gmail.com>
In-Reply-To: <CAF-UMxiZet0qic3-ugKkovurDMP1h4Wt6kRN1J8b120Uwe8sGA@mail.gmail.com>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Tue, 13 Oct 2026 21:11:32 +0100
X-Gm-Features: AclHuK8BFvP79Ibn-eZkSHKeZaefQ7s6W_tdhvd7miATR03pks2UNxHcjPyPP7Y
Message-ID: <CAPSxiM-jZF4QswVRmNwNE9E4oM5SZqY14xyTXY_ximfnqENoSw@mail.gmail.com>
Subject: Re: [Newcomer] Microproject: Pluralization fix in builtin/describe.c
To: Antoni Borowski <antekborowski11@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> Hi everyone,
Hello Antoni,
>
> I'm Antoni, a beginner to the Git codebase. I'd like to pick up a
> microproject to fix pluralization in `builtin/describe.c` by finding
> strings with numeric placeholders (%d/%i) that represent counts and
> rewriting them using ngettext().
>
> Before I dive in, I just wanted to check quickly if anyone else is
> already working on this file and this problem.
I checked through the mailing list, I do not think anyone is working on it.
So, you can work on it.
>
> Thanks,
Thanks for your interest in the Git project.
> Antoni Borowski
Usman
>
