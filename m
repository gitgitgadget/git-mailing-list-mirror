Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650D3750AC
	for <git@vger.kernel.org>; Thu,  6 Aug 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786037420; cv=pass; b=ftEI+7rOKCn5zZZXnOeOyEQTqhyjKqX9MIQOathGijP9plhdk0tjz86Dzu9OeJYPDs4OKPPY8dxjy/aOAYBNNoA+hXtrSEnY3DIS+xBjyL6AjIc9duKlpxYNZBTqjOofJGn4ZGitt9mr3qAiMjX2EnXBiq4Tsjc8Sg2IbMi0sZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786037420; c=relaxed/simple;
	bh=tZPmvDlVeThfUbvYZvme8/lSM67DFB4eoFioWh5Y6q4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=bIQQKsML+KafOIsqworaLeTAPfw0BxAY6kNCOr7sDMNyy/F25mIdy8dQeB+fkfjAxtff/1uWMDmMIf9xGgNTr/IrEGZhlIT7YxKRV5XsR2EsSulbIkYjlc8Ki4cszdjHw36GYHH6zUjuJfLOQ23D5U6LCzUzh0+d1VkjBSU4PkM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a7TrTaxl; arc=pass smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a7TrTaxl"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4953de5be0aso18429535e9.0
        for <git@vger.kernel.org>; Thu, 06 Aug 2026 10:30:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786037417; cv=none;
        d=google.com; s=arc-20260327;
        b=G2m9fJ+TmklMQrYzpeGazuV74WUPo+GbQt8a4gu+bo63dKrKS+2WDY4cDgzQbg7rVw
         qYN8CAR4Kq49OQhUOH2wGOo/1rNIFYYBFO1oU6IZDUQ6X6+t8ZZ/2GKvRxO2n42Fd1/F
         DkDH37ydF8asZ0LOJhNHdkTgluhjeQZsyj6tzWY+02wlsWTXaU8h2YAq0F7OR4yfEfYg
         rhbhjqhNcBzMFuN5ofq59+d/hQByXvGKDEIsUbbsVRe6TdQifxjZbp72zjHSoqygc820
         EDVhXQmktlxEct2bzMsX7fIoYKCxJuQi3hT/L1JFRxWf372IWP4wfhwYG4eX1aqYk/AK
         PlAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=tZPmvDlVeThfUbvYZvme8/lSM67DFB4eoFioWh5Y6q4=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=bsOuEgFge6gB6iSQcEAckIP3s/4yOGsd3UOm6FceqFJNdyoMHTNgmRl5oulM3YyNLc
         iy7WPQ9deNmoUoSl8S7uvs47PZciKs3VdBucDjf2LjguELhdVHnqkzu8whPnl+0ezwCe
         YCbKMmBx6n6K5lE7JsjBqVGnWXuibSXrkHjDK6acjfb3Lrv+wTplMy8kCf/8kZBkJrT1
         UfGXGzSS3YxEFLPi0oxIRYLRj2g++pKQj7cKhGRA3nEs9beByEYmgfgTJlezQC9RNMO/
         uwspvJ14pjeJpm1dUuvKwHtQ264Sj75pia5YpupdebkHtGkV3eWytmBi0iTNyv/8Qx78
         hh+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786037417; x=1786642217; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=tZPmvDlVeThfUbvYZvme8/lSM67DFB4eoFioWh5Y6q4=;
        b=a7TrTaxl6xSaSUGjOgz8N8E2w8L8bDLEjr18/1kTUzkCdUBaim62iW6REy3QfDRpYH
         jK2bfF5aHnbTHQbaVJFq32M3CXsoCKUCJos648p+ZRuidTJJJ7yB7up0mY71ILWc0le2
         J+WnDkKRdQB6YzowSpgzTjhH5ttoRmo8U6mYpq+dQjB1n0erV3nWMetrMnBdGnlbCMM2
         Bbx59eYt6L76jL5MRT6FwybBMg/5fVN2bKRVEp+j7VjNzF68/TABUgmStyOS0EOkucAo
         baIhO3ghJZv4fKv502wuAcsOe7R7nPovZocNOCb3nRUBBkEZsdFuW3msuMsynD/k2ijf
         h/lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786037417; x=1786642217;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tZPmvDlVeThfUbvYZvme8/lSM67DFB4eoFioWh5Y6q4=;
        b=aLfMH+d+cGI2pg8nGHlj5kE5UrjpUXAcNolBtAurAeg0fLmHWh2kh9PjCaidsj1gaU
         v/544zJlmON1aDxSp2c0iibXVYhMDTsXlaBcq3M73Am8aqlcnYiTbMEuM2+y1cADmS4M
         sYMnE2QPbEVSB02491P9gfdp/DzkdF760WA+BVnrg3yeRsFRgHEmGUyGeBXsbL+dgW1F
         zbky3MSOr1Wmvhp8yqGnZ99CIHRetC/sOeH+9c7sqxfP/iw/GcaKjbQbXztahLC+HvsS
         3Pgyboxydlud2ZnJ83ihgiyzgKgX0RKhUlpLEOjFRfjKwA3lg5S5ZtbrRQk38fOGI+EN
         hJTQ==
X-Gm-Message-State: AOJu0YzGIauwiy/X5JDvmTQrP5rC0PCol+i7WMmNfoC0PlOy4GLH6N+f
	VH9t/NOG1AO4YkO21HytOtjzGAypZVljKvgzi/epuokIqMP7pupkjG8nYS0vCHeClmLFs0x0DL2
	VB0qhNCBClbvuqq/70i365579sbUFk5MYVw==
X-Gm-Gg: AR+sD12bbnzhE+IRxbrN3LK5hjEEB3h8iuKNI6MxSNGHx9YjrKQ34OIEQExxd0DAD5c
	hnaB59IwdPqpEuOl67wvPY2W7GXNwcMu2uK+msbza+50nDILd0K5h9YWll0xik1xpqPGr71qlfE
	a5w7+Gy+B4A97EH4traLoNILqhvp/tbzKnGT3EpvqXS9teGESQHhoFgpzpOk1RooeWAMA8zL2xY
	gnrbY0kC6g1VOUaGzDxclBV4J4MBOneyuR2aylOoR1Pmoov/RXmbzLOuQH/aQvrPP2CvQPz7OUI
	EYUGpKbA/R7/LoTRR899M/Fxvok5zLuLNi4CWRtiOk+ZkDbxmpDBvrs3tsXWfNdRFgOFiA==
X-Received: by 2002:a05:600c:529b:b0:493:a613:56b2 with SMTP id
 5b1f17b1804b1-4994e71d3e5mr242728825e9.8.1786037417267; Thu, 06 Aug 2026
 10:30:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Itamar Perdomo <itamarperdomo@gmail.com>
Date: Thu, 6 Aug 2026 13:30:00 -0400
X-Gm-Features: AUfX_my3dTsYB_dTfRWAEUoYFHtTwENMnZ29UsQaNrtOXUfMf0S8CifBtvbnocQ
Message-ID: <CAAqPR-3F3sKCJ6P3pfYoGpw1d4zXGmoFsTm0m_xnX5Gg+pFogg@mail.gmail.com>
Subject: i am still using whatchanged
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

I read the changes in git when used such command and i send the
respective mail to report that "i am still used this command"

See you guys
