Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DCF3382C3
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774427597; cv=pass; b=IRmt1flGdc+t4qSylcQuZZ9g5bIBGvruKi5vO7mhb28AoRYhfDKrX62Y0xp+uQAX1MOp3BIBmVpoj9962cWIdOSMrUYObKVCEiccIuX6hGDN0ULcmYMe5uEg/orX2cV2tYkn/IcY2j2oyo6zgJYyIODy19VdLQW05ToLFsa4Dck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774427597; c=relaxed/simple;
	bh=kRCLkxQA8yXzw2khKJTEK8hli3fbZeENsUwI4ltynrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tz2MaHcBZJyZpXgp5+ISm9IqtFx0POm9kzjs3xw+yyybVOoq1DkKCqrSTbRilt9eg1+PAEJKEETIoZbRLzcjXaZTcHhhm4hEuGfjBCILq8aUfJX9pRw2U5wZCqOt96Eua7LMFk0hOtFk5ubOyilOoi44gnlpWWaksMBSbFabFJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fu/ZLB1p; arc=pass smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fu/ZLB1p"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-506a7bbe9d0so47174701cf.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 01:33:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774427594; cv=none;
        d=google.com; s=arc-20240605;
        b=F0bIJx4eYXHvvGfAJsXTWZ0w+BprsgoQiDVpt4BH5DH90QEgu90rUo2z3iFOy6WsOZ
         vgkiRR73sM520JlIMAYew9MIWt9VG/H63ffUXtqSJ6Roz0fMtpcU53wujDcw+oHLcH3u
         WnI+q9ZtJ1qiqr5h1hpOI9B4lMSvSL0BgNv9WPD8eFbnUeGB6S02YuP+IcxmqcpATbw4
         shm7Win1dehMM6PJMAn4giwepl3iYUl7SIMZ412XpyD0cVq+F/IUAnFLcwkPTsD2EQoi
         +vrLFNPRIrcxgTUWsCVk7s0GiuWOPI2XBCMsqLMLQW6x7Q9mYs9xriBosiIgggVus0K0
         iz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pV/eJWUNh0W7q7B1Df+a8omcrNLJ4h2wihJKDcvbkAM=;
        fh=1/3dtt18tXnIvB8syWQ2wTvDn6umrk66dlnjmb+I9bo=;
        b=Vdm+Cq6LxRCaCuaLhPJoFAy4KyjSTPxTY2iRJGgkVcneHvoip+7hf7jhp73Ck8ide2
         OcgI95yLcmOJCrUx+d0IHRYY3U/ddmfY73Bs+hY9zhwsh2QGB0gNPHlpx1UgZmIToNfq
         aYzK9UF+aWYdakgBuKbySCy+ljq12OlLfiixjMOdrn1SSGjpDjVlypVNZ1a0ZUFrV9SZ
         ydHd5Fc2ngUD+sVPqPSU6aO4jsvV231X60mIC59lyn82mQoI7RLH873MtbhQbC4Wgaye
         kAl2BZ4+k44m2W9iXLP7IVO+BoQHD6KorsYLfpl/uLJjEEu7oJQ7hpi1usDPCdurVFIy
         LYxw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774427594; x=1775032394; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pV/eJWUNh0W7q7B1Df+a8omcrNLJ4h2wihJKDcvbkAM=;
        b=fu/ZLB1pahEw550wR4u4zBnHt3xYc5fKx5JhuIlyuZf6D95wiEHLo5RACO3SRT1mr+
         mypm8WgotMPccaHyE12HxsYi8Eai/csNKfMGlAvoAPKBmDU7HZCH17zdYOSquLwrd3G4
         s94f7bazo+TxRYxim3hFGcJ2MN8IlncceCxjzOtQAE34wqtBDcfdcJ8sCt+osyhcbbVZ
         AbFKxyu2oDO6TW1Nl+gRoP2knk+jXRZmHufqMpExw/edbtEaCB+AqdcUT3u1VZ8YcaVt
         nPFuVxEjKEUcQfBOacC/pDHi2y/3eUzcDzKBUHwcYli/2u5m2tSHw0mdAYnra5XqnqUE
         wq9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774427594; x=1775032394;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pV/eJWUNh0W7q7B1Df+a8omcrNLJ4h2wihJKDcvbkAM=;
        b=S9u+YxoRoHwR9jfK3EbZ3vjaa8emUeQTf/gbW1We7B9V1pH7isViWzQEIHRoGc2fae
         VzFTiA4pbjEbyAb1+lbMlBP0tSTkfvlVb+9azmWAhZ4k99Iro5ONWkOm0cvLFxhgy8lW
         dOphmkMGFqjVsP+2svVD3yM6fvBjjl/AxtrNMh22U+ctBFcgYPdxgPl/f4W9NN2CYL5e
         Uuoai2NZx0MHlWVPQrTkTmfZfOBhmFjnxamo93aeyp+K7W30rJfqXVsWA7s+pcOFhyLA
         T0/tE2u53Em13CVYdcfYfRp924zWLcoVMAsTHSw3qzZFaWHh7ltJtuhZ9kOoggDGdoGG
         d2fw==
X-Gm-Message-State: AOJu0Ywvc4FJIvf7CJzG4gwDBCtdGRhuPxWnGaR7ly/NIBiIO9f9Zbkl
	D5hkTqmjoAR//fV7k25e9pQKJOYUktBPyLsqD+4YV5iLX+xFPro3ztEkbbcC6NCmqSmp3tan37t
	9qRx6EuwPayI/Rad/KeDSKYRkm3v95afTmMjY
X-Gm-Gg: ATEYQzzX41R3dYo0q1qwn6wJpqXGbhNN7mXcMz1Zq47Wx9Qsdpj9PgZ2VGXLzLOsZ25
	NnNfxafRZaRvFLlrydDYkU6QReSduQOBRkjsGN93mnpmVt4k/oXZ8EgiWlkIYOA8n0Of48uvirF
	QCv+Bf0y3BSiYW4DQ7YzZkdf92dPSA931kaM59sr9lqCgGCJeeZLiDI+TFUsO0Wu2S6xxRnc8xj
	7EZFdIoj4411DwmbfPnMYvlqa3GUHMgj0yYnP7Mti9LsvHFybob82V+56TCCV741tIDyfIcKlkH
	RTgFb8Cwug/+Ns+5ezLoGPRj6U16eU6dBs2QDsVTfA==
X-Received: by 2002:ac8:5946:0:b0:509:4b11:6d07 with SMTP id
 d75a77b69052e-50b80d43e50mr38366611cf.27.1774427593758; Wed, 25 Mar 2026
 01:33:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldfgy1ye.fsf@gitster.g>
In-Reply-To: <xmqqldfgy1ye.fsf@gitster.g>
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Date: Wed, 25 Mar 2026 14:03:02 +0530
X-Gm-Features: AaiRm51D8aA_YfneaTQZAJpbng97FrZLWkRDhQ-vdwgaakXGa61O9L4HJouH1O0
Message-ID: <CAPYXD65-LwXrZSAtGmbj-O4nW7WMcrJ_D8HtNtW5WZY2fLbGqQ@mail.gmail.com>
Subject: Re: What's cooking in git.git (Mar 2026, #10)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> * sp/add-patch-with-fewer-the-repository (2026-03-17) 1 commit
>  - add-patch: use repository instance from add_i_state instead of the_repository
>
>  Reduce dependency on `the_repository` in add-patch.c file.
>
>  Needs review.
>  source: <20260317155230.619378-1-shreyanshpaliwalcmsmn@gmail.com>

I think this was considered ready in the previous 'What's cooking in git.git',
so the status can be changed now.

Thanks,
Shreyansh
