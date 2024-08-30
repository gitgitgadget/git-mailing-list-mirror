Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA834683
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 00:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724978655; cv=none; b=RP9ZXYVfQU/f3jDly+dWr625GEUiCtHMIXHAVaZ674KUsr6HOQchG811fNr0HMyqdqFGGDfJMfTXdWO5ky6VQQEB6PcAAFX6WpFXUwaW3dZ2SFJL+JgeDKHBJFrS5vGRXaL8L1KB5QbAdL59w71P66Z3AFYFIOxs9PUyp6qNIT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724978655; c=relaxed/simple;
	bh=HSMo4RKBSfkUglX/4j3zBnJYnFHm3HEKXOtiyb4clPA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=OGQb+3tkgUEI0GUFyfyKtHG5w/Myk1tyldmNEjHI/HSki4ZuKD2AL8kJt0rKRLCCwhskRgnbFtsSmblhlNgXKUsFD8bjWPotfMq8EHrJACMDR5eIcit/uFO8q/81NXimX3gEanW6LE0Gi0irKt/g072iuFqmY604KVo7G6ByM1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UycB1aLo; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UycB1aLo"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-846bc787b3dso62845241.2
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 17:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724978652; x=1725583452; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=muSSVAzj6jdocEYy/S+S+NPSNi6yjtKPBoVOBLIARXE=;
        b=UycB1aLo6CIiEP/VKWPDp06Qdk0Qv9ipcOT4MIVDuj48lVNZ6GTkd0f6Pv5m4cwBqt
         Mb0UBAuDMhKdf/9mwsfpqZEgLyzeMVXyi7QRTtzCZpAHHQHHoNf5vzlDIR5wD+WTdmrZ
         YO7awRwBtGynS4bQmp2TgB+ALQ6lc0O+N5ENa5DYH9DLw8Yf8NRRk6aZUJgHu0Ii5e2A
         ihEx3/r/hEklqfAlV1S34Em2T6YIUXHVJb+UxiNXbkjAOHB85DQimMRL9LVEpMhFjbQk
         RS/QbtfMV7FVOZfb/YrGsRYa762p8smSLNrRfhWj6BcXoBxUnOqDLPXnTwC+wVL3GvOz
         XODA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724978652; x=1725583452;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=muSSVAzj6jdocEYy/S+S+NPSNi6yjtKPBoVOBLIARXE=;
        b=ACMIHbqXKefmQ9g7N6ox7DwsUi/nZkid6kRd70VvTOkhoN8MQPkFMS9Ua2SBIe2e6t
         OS3PjiQOThOcq6nF5IqkweV8nw4d/dzejIMr7fWOsAT+2yx9eVEO3bHJ+Bjf7aAIbLOf
         YrDoFaEm98QhKGEP4J3i1RcfqlQMynLuXT6EqVD5FUOLxw3Z+rIzArgi8VgOrRAthubs
         qG+H0F5ruKO9ENB42Sk5O3kJG9P0tNL0xBOEkgMZbjsPEHlMP/09aZlaOXXlBamijcIA
         asShlK7wfD1s15OSaGvGJONPVdA3pM14KUIg7FzXfRWuR7Ddl5bFRqiGMsP/JV4oU9Jj
         UqMA==
X-Gm-Message-State: AOJu0YzAF3uEH0j2GX1QpSFZ4bLrA+RZHUrbmzSzpGRjfkR+r6yr7Fcn
	kM+o+eHD4fDHZWO3QapWXDkZSFEvnL5kxqI2YguSB0adkstoO9D1a8yK9M4U6cFKOGkzzRy7qtI
	rOFfOtZwjVl+13wKO6sWfGcXYRwYBni/C
X-Google-Smtp-Source: AGHT+IF6rDGw/NUnfOLifVSX6VDYBchBYMB5MeBDJ/Fh7bn6kKSSf01zLVrYKJlT2S9tVzUpbhDjAm+Jc7wRau9Lx6A=
X-Received: by 2002:a05:6122:3c88:b0:4f5:21fb:5e49 with SMTP id
 71dfb90a1353d-4fff16c288dmr5450971e0c.14.1724978652452; Thu, 29 Aug 2024
 17:44:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adam Laughlin <adam.laughlin@gmail.com>
Date: Thu, 29 Aug 2024 18:43:46 -0600
Message-ID: <CALDEA19kJtPi+LAryAcdZSGevfGUYw2e7DXOEWySQubYoBoG4Q@mail.gmail.com>
Subject: git-show multiple files delimiter?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi, git-show allows multiple input paths but concatenates the output
without a delimiter to distinguish between them.  That seems
improbable, but I can't find a way to add a delimiter in docs at
https://git-scm.com/docs/git-show or code at
https://github.com/git/git. Is there one I'm missing?

Thanks!

Adam

P.S., The discord community invite appears to have expired.
