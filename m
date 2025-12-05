Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684A83D3B3
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 23:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764976477; cv=none; b=M2bNNq+/O4aCDZovECfJ93ag4o4Uu5xrx8R3rTAH6iKdjGl1UsIRhAPmLO57NtmNokwQ9us8JBWLoCS+u8qIwVGW7xx/J9LJQIRbb1SKsRdjQqdx8uTkcAbHmeZLubRto7r2yt554R1MtdrEo1+sualRQ+V+8HRUkiMN9vERqqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764976477; c=relaxed/simple;
	bh=t3y3tFrkgYvMrwG47ZywpZdbTlul4HrdTc/3riIkSK4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kd7D9lc8OiFz08W3UDPZeGnBMBszxAjPYTYYzsLMlKccapJZHc5z4wp4zRKiVTUTRVMioH/wlQgZhDfmlPHUE8t9vnWVJbfVHj19gkBJEnQ+yw5QiRdjlkTY715IXVqwps21vJ8IjPFt56dVc9+NhJ4gKnv6oteMAVzbiWVTAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4ede6ca6f65so4233391cf.0
        for <git@vger.kernel.org>; Fri, 05 Dec 2025 15:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764976474; x=1765581274;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t3y3tFrkgYvMrwG47ZywpZdbTlul4HrdTc/3riIkSK4=;
        b=eVBdvE7GnxewG26H6d128NJLw0sMHfg1awiDoMRHg+DysUAXpu1xSLIhruVGJa8VaP
         kH7UZHLn25STlytFhmlPukYENTQvDrqFMV4LJl6AXry2QqG2xRQBw8kynz91nqvOv4RW
         SPJMZrhUMOUwfpBliQjHa/L6jy4TxLys8pGADx1wQJnkc3OW/Brpp02H/NT+CmciXk66
         50bhGROQwHhipgBRnyJ9wARSBArcz689m5KqwtG4Hl92auI1C0wmefmDg2cBfBALunCX
         7IWfnohyXQF7SB2oBDDD8XP/DGDhmRh4UP9AXkuDswKdaA81CJWMoJGxKkI03y0nceiq
         3mcA==
X-Gm-Message-State: AOJu0Yw7UDM11Fz8wj4qZAsuIOEQlzHtoRelsAhtT7ERMEwJAOFITVzT
	O6D319sRuz3cazH64hWqCya3RHG8KUO9oudoOCYgpREjBWECpB4jgq6XBhyi6fs58dDcyzWXVwp
	iLgpG4CLr2t6I1buoDzXz9gd+dPWLtw2aAg==
X-Gm-Gg: ASbGnctH3hPK0eJTOyp5uZd/A/DGJkPv0HEY6pubOXB8kMvZ4H5uquP7R9CuvnLy/D5
	KlDRjdg/nxDfXOELWGxz0HDLmKcnERk6+PrT3un7qSv01v2XKy/XSVM/5UtldC1vuOs+9BR+9SA
	JBfmEntdCI1kN3JqoUCGLyKAKaPCiWSOe5f0se7cAva1fRkL0XDKDbx+BPibKlhbiS3iDf6/FJa
	HjNjaX11qexJSH5cBuaP8T2T4Ytcnk8q2EtbtU+pTZnlh1mLbOWrvhDrMxUBPwqM5N2kDw=
X-Google-Smtp-Source: AGHT+IFkrYa3ySrQQk2PjnBeXHa2ZlG+ptWgGZI6xk0f1yr2VaqB4EEjoFKDWRgdbO+4uBDYWAviVSmG7ViP0IetK9A=
X-Received: by 2002:a05:6214:daa:b0:87c:19b6:398e with SMTP id
 6a1803df08f44-8883dac48c3mr10169776d6.2.1764976474291; Fri, 05 Dec 2025
 15:14:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205-odb-related-fixes-v1-0-ef4250abb584@pks.im> <20251205-odb-related-fixes-v1-3-ef4250abb584@pks.im>
In-Reply-To: <20251205-odb-related-fixes-v1-3-ef4250abb584@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 5 Dec 2025 18:14:22 -0500
X-Gm-Features: AQt7F2oYaqLtuyqV8Yfrn8mwLkGh2CAkg3jTPwy3SdpMLCu02LgxHid-wYLvYQ0
Message-ID: <CAPig+cRW6tXFTqqnhH1Be33TgzT2dsdzNLFii3Now7+DNiTTvw@mail.gmail.com>
Subject: Re: [PATCH 3/3] odb: properly close sources before freeing them
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 5, 2025 at 6:36=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrote=
:
> In the next commit we are about to move the packfile store into the ODB
> source so that we have one store per source. This will lead to a memory
> leak in the following commit when reading data from a submodule via
> git-grep(1):
> [...]
> Signed-off-by: Patrick Steinhardt <ps@pks.im>

Considering that this is patch [3/3], to what does "In the next
commit..." refer?
