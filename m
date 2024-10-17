Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA8216EB42
	for <git@vger.kernel.org>; Thu, 17 Oct 2024 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189978; cv=none; b=HTah+BP5eF/DG//Ocm993nMhKI4BRVL/Xzmw+hl6cIvP0aV+NlM1JmDbqRFwOEvetaA9QcS056K8zF+3X2AqU9HGKVlaP7y7B3hYveMXmNCf2E+3r/Te1ZdQtuIxY5UARzhpEsiPR2/VeKy6AMLORLd9qgsQVEhpisrPZDjjC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189978; c=relaxed/simple;
	bh=x/jMZ6gqwoyg3Vdi9lOmFmSTykHaxj+WyX+CCxs06UE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MGQ8ZmmHnFRCfGxRHOEdGgq3d9/w634w7ayNDawZ7e2MO6iywSM2EnFjRiNbmnIT6a0kuRHrndji/B0Bqj3kDUyJrl2X/0W1/bNGUErzaHoQ0w4s7uZJ727Z4X82ImZrizpMjGWsFBKY10fvmWA8qTiY9/S7481EGjPgZaXQz0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6cbeb0c41a3so2391806d6.1
        for <git@vger.kernel.org>; Thu, 17 Oct 2024 11:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729189972; x=1729794772;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/jMZ6gqwoyg3Vdi9lOmFmSTykHaxj+WyX+CCxs06UE=;
        b=lv1aZkCN3cTHQfBAYn7WhgHipm0ohkf88ZsqGvYTRjIeRhcH8ukxhiL723xEpr4+ab
         /F1KkvU+CYb2jTA8sgakAaq4l8lHeq/itcBib6O2aeagCzH96oF5XeBicwfnEIN0Re34
         lXByozhCEjRWWxoJA6NohYC+wjlnoFLxlC2drqFCobfE7XuQh+Ybv0taVAsDjsuCIi7+
         09eHv68DYXTleQ2lWM7IPZFD/iiC6hZXxmSav//eUoVBRK+OoBRYMld5aqsgEj0cHqe/
         ZI9zCDyhxuIhmrz15zwWd3vqOfHig2SLpdeQRtveDqHSgUb4jZBXA5tGMuiLMp9zuUn0
         TuGA==
X-Gm-Message-State: AOJu0Yz1nOTllArShUNV+HUs9TaCqiRgqudE/6nqQJcmRluZMIOnncLx
	MpfnCD+nluLn/vkPpJe2vwih+RelbDHqfWE0Snj11nYjx2svOaCcJ1pwIeauLw2Bo9iUtN/2uOG
	Ryp8fk5h+jqe6ncHUT1HMqVD1pCMGdgkk
X-Google-Smtp-Source: AGHT+IE0Z7k5FOsFM0aCvC/x+nvQjWg6bpnBIwb2D2X8mcNY7tXKxUi0LJe0Ew52ZiJwhzXlY5WnpEiUV8rTYfkiLZg=
X-Received: by 2002:ad4:5c49:0:b0:6cb:6006:c98b with SMTP id
 6a1803df08f44-6cc8708db6bmr2886906d6.5.1729189971946; Thu, 17 Oct 2024
 11:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VE1PR06MB707063B6C98798EF8AD9EF00E5472@VE1PR06MB7070.eurprd06.prod.outlook.com>
In-Reply-To: <VE1PR06MB707063B6C98798EF8AD9EF00E5472@VE1PR06MB7070.eurprd06.prod.outlook.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 17 Oct 2024 14:32:40 -0400
Message-ID: <CAPig+cSzkWfC7WSrT-1Kdm78PU3EPNj25+FV4gZfERQLOc6U8w@mail.gmail.com>
Subject: Re: fetch and pull commands not working with latest git version + BitBucket
To: Dario Esposito <dario.esposito@electrolux.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 17, 2024 at 8:49=E2=80=AFAM Dario Esposito
<dario.esposito@electrolux.com> wrote:
> What did you do before the bug happened?
> I updated from git version 2.46.2 to version 2.47.0.
>
> What happened instead?
> Git fetch and pull commands get stuck and never complete.
>
> After reverting to git 2.46.2, fetch and pull commands are working again.

This sounds like the issue reported and resolved by [1].

[1]: https://lore.kernel.org/git/9d2d6e7b-9691-4c9f-9b13-f1019cd1c491@gmx.d=
e/
