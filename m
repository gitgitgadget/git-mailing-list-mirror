Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648E482866
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 04:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770524441; cv=pass; b=hqRth01SW158SQR7l3RGWrbTYkF52BLncKFqhfyYWO0KYqxEs6hunJXwiuiNR8j9OxeMxRwwB/+F8FNQtNd9LGFeJPz2+Lmf5pZsfEs6k6c/cewp8dhD1KsVP6b3VHR0EVyv79uoThajx43cwOiVlo9NgQsdbeFqMut6pQaWKM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770524441; c=relaxed/simple;
	bh=jR8td+fQnU42KBxRU3VawQjxizEk/QiUh2k/sdqj+54=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=FfsXQV1KmkiP9gjnKG3YHtpc0eTs9To3aJfFi1EI0c83D/qcyPxhHtvNTYMV7OCP6YG7U5jnA8HTEUfYuf+5BcR1PoD5LeOIrelrzb5JKeAV2e9bs7JMfh3C1SDnDQIdKXH+HjsaH9cxfvkaqFO6VaZlAATxI89QQ0kjr0NSHZA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HIiDuXx1; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIiDuXx1"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b88593aa4dcso454952566b.3
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 20:20:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770524439; cv=none;
        d=google.com; s=arc-20240605;
        b=BWBRwgBeEYX/g09IcS3IWq9EonWQTjTIUgQB1se1GOlJydOxz7RJPRPN4CapiyVgnJ
         J9HfqrU5POcoL1y6Wn68Ic+uO/coLmLi4zytfzkoIdOAKI5/vGcnY+aHkUkVlpQtKvKu
         ZyzvFo4I71a2zXDT/qxvYXwoCa7eCx8BitqDEE0Hw7G0jAj1amYTP73k1B4+gPLKu10i
         ZrxDyoYxDhyF4eNyk6LPODguwOOrkLcIIEVx0rWP+m2VCesP5G51J3ujr+puJ4CrWAFw
         CpQ6b+kqNG6Vx+Iej06xRcledR01NoC9RuHn1klGpyfo8pCjgfzw6a7QDsnyv9VPVSZL
         qswQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=jR8td+fQnU42KBxRU3VawQjxizEk/QiUh2k/sdqj+54=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=au3xq3prqZXEpn+8IPmlPVytpjDAyReiSKcADV4/QJD+6IMoaKrvB2zGItjJrD3RAE
         jlwp6IioQ5kGMIY48+jNdW2vRluhj+CyzagkxR2lhNv7xQY/aKwaAcp2LEOmQnRVefhN
         lWIKFPs7rCw1sphDWkwCpHnYj0iK+EG96whW27Rz8z3Lm1AIbTu8ydoyh/gng5FuT2bJ
         SEcUIvOBcJBaF1Fmh6AJ+pGaI2m5A9yYpgnWa/caMftmBk2wrbSZSHIGakIz1MGWJNX5
         nR89ertRrNsKpVqvE3+xST50JFx51N1jCFcWkB180djHS4A0cmMILoBiXZM70YyQbvwv
         OSZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770524439; x=1771129239; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jR8td+fQnU42KBxRU3VawQjxizEk/QiUh2k/sdqj+54=;
        b=HIiDuXx17cfH548o1iV/QzH8sA3SzUqHDyV7a4Dviuj7qVpbM31yZLufKmlDdKEmoq
         tLBoomNwmJWTANK454uHdLXKgrjLCYTbXXy1/S8OKBEl4HA1ZPxGPU7QAuxPS3dPzPKM
         kw/nSMj8kgzPG/+J1ho2/RhR0qWm43ldbW5HRSrli9eJpWAw8IDrpVt2KWo/5Zokc408
         LmnqfVpYB3UlZBegtyrbV4RITia+itjHYtd8tjPbBk8Eh2MykdwAJeH0ngCdzdALBTZn
         cDuRVpVH/tZo1uC9eG2se2MOzamnc1D/AZXJ5c5Ii0kDdaSRn9aT8gouOC2BfMu3Eo0B
         C1ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770524439; x=1771129239;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jR8td+fQnU42KBxRU3VawQjxizEk/QiUh2k/sdqj+54=;
        b=eT8a82wR4EoAtbYx121GIH5o11pECNsGRFQN7GbGn3nZ3M80p/0A+aYaXbLuH+28sa
         05vVMYc8SjbgXkNRm8tHNT7FziDhcnA/nyrDqg5WWB7KUj1HefRzZKfKKMBXCBjSTKW6
         4aPQByLVeYAgr1W5xZliDUg2UH7ytDFsHVnOVyymx7bxitLlyuaMn2iG7Emuzhh4fYpX
         h+O4Xk3o0SWqxqE6Zb4YNGJd7JsaQZsv00paSIOYN7NMUPsYE2thyr1WYgSoWalDuX8E
         cbxKnMsNyoLEIhJh4jUgU+KvlP8GRf8MWdBX9rdZkxpOg802D9dG9jPfEu8w7mKptYm+
         k58Q==
X-Gm-Message-State: AOJu0YzUBsGXuNE78YGe0OqlY47uOwRbszeDI4rSfhZ/9mPDHW94M1yf
	cUS0wvPuhWXXP/EB0sPTnrsmxZhOo3v/6ig8AbEx4L9C09ud+WQemIsZNchY6iNAJgvxKXsysfr
	YYh9ups3fzyQCjc/LKUoJWcaIK9EQG4pNDlnO
X-Gm-Gg: AZuq6aI3CkUCWVpSbIO9GUI3zDlSQX+RgC0gOCpr8I3SPpYZPX1086ESJEJlMgyY6d2
	FpQpO2Y4SXNRB23JHrfuaJXSy+VPmo9jBo6ieYrpbVFMheI+Ly2VOxCekbHNlFWjEobOx/7p6Km
	f7MmnmoVhv29EDUyigUtuzSsF8TpdIJY/mkUM+dzN5rgK4ZWBTh9YLeznJamxkrAK4XmEYt/Tea
	P8QgEhrG8NQ8NMovKoxGDrAFumpsEo/+kBnLYK600QC/+bBu/Ze82TYS090ogbBFpM5JmPRxQVn
	lfHR/epW9MpcSQn27IfeWqU9oWZeQX7Ycdzob0b1q8OM2b7wXtIgHEmNDmUpkpGXOLDvv950P84
	JhlCjtfksiJUqCQ==
X-Received: by 2002:a17:906:2081:b0:b8e:fdc1:5ef5 with SMTP id
 a640c23a62f3a-b8efdc17a31mr155253666b.18.1770524439162; Sat, 07 Feb 2026
 20:20:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: soutrik das <valusoutrik@gmail.com>
Date: Sun, 8 Feb 2026 09:50:27 +0530
X-Gm-Features: AZwV_QjPnT6WvK17tI-tj9LGrKh6cvDxx8702tr7vfQ4yxIHsxjFNUytE1DYwCU
Message-ID: <CAPHqhPmiMYLE_v03i-CzsBmonsNiY2PeeaGgP_AUthKhK=NoCA@mail.gmail.com>
Subject: [GSOC] Is adding 'dart' to userdiff.c a valid microproject?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone, I have been trying to find a
microproject idea and I saw that the 'dart'
language was not present in userdiff.c 's list of
languages.

Can anyone clarify if this is a viable GSOC
microproject ? And if there are any hidden
difficulties or anything like that?

Thanks,
Soutrik
