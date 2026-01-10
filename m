Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC9F1C3C08
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 02:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768012818; cv=none; b=crHlQaWuYUt+jfI1hwXIHlT3cpMBNbt/LsTJAB7eh11QYq5awoeTMmVsd1nBLqWmTWZv76qkORPR6JzCRZTH9FrFGhEsrNGBvojifOr+FtyznmU0evq4eruOl7t9d2oQR7BCo7HVllaPC07neI08JaTh5cmybtgAsNJ3JE+DBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768012818; c=relaxed/simple;
	bh=LIAmuFV520e2O6NsoQKfdjp943HV8XujLOxCi089I3Y=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tOIlJCs0mXRWu7apoiVuRFzDbz3FJj/H/nVzcyVv8HeyvbfISIW6G6DCoAePCJN1yxV86KJARElLH9RgPdSUtQFS1bYm4QzdhMklsPmEnzKFjTe+BvkNAJh27lHp3Yu9RvtXJtchfIaJV1uKdUWsx8DSY1R3zfmqtuj+goZeWoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EtFw05mV; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtFw05mV"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7ce5d6627dso1033322066b.2
        for <git@vger.kernel.org>; Fri, 09 Jan 2026 18:40:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768012815; x=1768617615; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LIAmuFV520e2O6NsoQKfdjp943HV8XujLOxCi089I3Y=;
        b=EtFw05mVcKJkW6M6HOaLgiFw1tnuHTQzMsZu/bfdiOKcAoNZRzVj1NwkdWRWN5p3Nd
         tBAqEZudUC9IwfhqVnok5IF1iSpBhEzpAcQG053faDKefRHrr54H6d2Ekyzwc0CVhiXl
         a+VlkKZjPIuq6jQP/pEr35SF8VNpIXQh41UeZ2T0AxKPVZWDMGfBtsREc2j6Oz+WWSKl
         4MiJDTPeXiS/D+6iDtRFOTj3WE2nQz3Z+6uq0e2iYja4IJNcRcJ8N/aKqEPXoKbNmF3s
         hng0nXlu2ISPJsPMK4jmMRMReaDXg3S1i8mbQb88bC7L4ro9f5OiTQsfoRhckuo4vwPl
         TNKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768012815; x=1768617615;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIAmuFV520e2O6NsoQKfdjp943HV8XujLOxCi089I3Y=;
        b=Jcqb/iG5ka0ol5w6bMke0qLBEQbq92nuzZRP1O31WdwK4nB3RPvSn9H2V3vn2IYIRz
         oWjSXntwbadQwR+Ej2n70VNd9t+E9xgXAjfL0Ojtbrc5YqCkOBYdP6xYBaYGqzC7syER
         9BeaTqWBfF2iden3dsKB5sPSDX8LH9x9TiKbt4U8ao284Pg7nGYBl38mQ3Z/1oEqkVtu
         xTjkXxOqE/H8/vdyaSTkg3ijQGIOSVYiHlmwwpGhblxyWhB6rIRat8fOQTdqT/XmOhPs
         rD0+AX11olsAGkSLoimLGEXsIfVhEdUsx5hz1zMi/F0vWdh6/uNs8rlb367An5MvoVGM
         UiVg==
X-Gm-Message-State: AOJu0YwZN6yapMgBRos+SZGSqo61tBY7t6mCwyY8o7KajDPj5p/MFlOk
	eUDeHQBV3LyVQsNJdiDD7m0E3zXWjpcOavZCUSI5sbgtITvFEpntuJJaXRTyxkiD
X-Gm-Gg: AY/fxX7a7djwbv3nHxoMY8im+VDFhM4xSxhXqiOUGqUj/h1Gjr6KUF+OrLzVgSm6yKM
	YnQcPu3ipoWuCGaJoHZ9WXFp95aTStcvjigpGXY2NsPU4iIUXeQ50ydRPcM+b5uUHHchLX/Di3g
	El+92a2gVlA7IyAynR5TWq9H6Y9Nl0eUj/zfIpXs1S5NX+3Ml5k+sdjX3Lq9FFfFIBMTRhODora
	k01yfLmEpCxAIadAJjM2wkwe5Ki75SjEk/Cg/PpB5BeVR1r7b00cXxu1GkiZoTTzxFv2Ys6jGlM
	WKZxMXQoMIBUxHB4cX564X57N1GP69MyAuzDKTwUAKLPtKhTdbpNVnftnJbh0yOx6vkuVnKH0fN
	UEB5adY6mlTTsbu8Byu2amatzHPPVxOIvggpdBEif+mA2P/IWdkOXLiz4VXQdtKR04cUA/7Sd7E
	7HEprYQlMbCnEuQ6CAyh1b
X-Google-Smtp-Source: AGHT+IFJa+vngoHuCy/ZHbqNzqdD7OQQexIZXym0aoUKF+dsKmfjtuHplOQ7gGdmxcGgiKEGxSZpNw==
X-Received: by 2002:a17:907:2da6:b0:b7a:1be1:86e7 with SMTP id a640c23a62f3a-b84452414ecmr1234638666b.63.1768012815393;
        Fri, 09 Jan 2026 18:40:15 -0800 (PST)
Received: from lorenzo-VM ([84.33.162.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b842a233ef3sm1302244066b.1.2026.01.09.18.40.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 18:40:14 -0800 (PST)
Date: Sat, 10 Jan 2026 03:40:13 +0100
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: git@vger.kernel.org
Subject: [GSoC] Introduction
Message-ID: <aWG8DT3swDVJLS8m@lorenzo-VM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi everyone!

My name is Lorenzo Pegorari. I am a 23-year-old student from Italy,
currently in the final year of my BSc in Computer Science and
Engineering at Politecnico di Milano (Polytechnic University of Milan).

Last year I had the privilege of participating in GSoC'25 with the
organization BRL-CAD, where I took my first steps into the open-source
world.

This year I want to take my shot at becoming an active contributor to
the Linux ecosystem, hoping to participate in the Linux Kernel Bugfixing
LFX and the GSoC'26 with Git.

Right now I'm learning how to make my first contribution by following
the "Hacking Git" and "MyFirstContribution" pages, while also looking
for a possible microproject, #leftoverbits, and/or bug to tacke.

I hope to become a valuable member of the community.

Best regards,
Lorenzo

