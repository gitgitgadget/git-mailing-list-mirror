Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00614C6C
	for <git@vger.kernel.org>; Mon, 30 Jun 2025 21:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751318618; cv=none; b=EaR/tv182SMYC26Vpp7I60wWZ2IANQ/LXg5udHaaNYTKgjFODzJykl17IzvpwnjvlJ9pJV3gUP215X8lZS8OhGHDWpjdQSjEWTfTGHDkzZJcclg6cVLrc+aGt1pPRK0TDTt438aRx7M8QDgn/TSBqJmMDhjFmi8vfXl4yFlpa6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751318618; c=relaxed/simple;
	bh=+bjZseXqB+0YHw7mX863KjWUYKmwEaX7M2VgHSQgm4Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OgIJiJIBfzOzJUoM5SdkDXt9r/cgJFkbWqxWsUUC5Vwqu3FOATVUR6yzlXas49nTAGKlQMScvRBsbG+d8f1vzh9Idgs7ZMuZ4AYeLiDVn58mHyq60KdLwTbGVxNDLsC/ze+jTEAYJb1TtkVuXQMfLIbqECBLI3YlNBf4rlphn3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EXF3tMB1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXF3tMB1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2350fc2591dso45721725ad.1
        for <git@vger.kernel.org>; Mon, 30 Jun 2025 14:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751318616; x=1751923416; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E3WZZ/PRut5pYB6HdpP4W8TAv5VIFmhWyjRfwKuynLM=;
        b=EXF3tMB1+8A4cNWr9Ly/jAalFFJSKLm6bMnrqQ0aYjLuC5XlBlAU6tSdDGpYvFIxuY
         nHRB/WmrevG0ifGdYvZpUcXwKsp0xS1G95/0/GvzH3ZKXKsQnFHSqbVs+1DLMspN3EK8
         UtCayyf5WhoiE5Ui8/QO5rxNpXa4uPoH9af1PpRpascPR76yuLHPsV1BKkJYL8OLXF49
         wrgVV8vcBLKOGT2NrwBSiq+w/ToA0O4lzYADZK2e//8Mlyrdt+jx/hUoRl14Vxwf1C1E
         dkHVw1IlqJ0jyWRAidHgC9cwJGqaBYv/tEhY3z/ssWGZicuzAZJJivpGObfHuGZ1XYfT
         SP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751318616; x=1751923416;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E3WZZ/PRut5pYB6HdpP4W8TAv5VIFmhWyjRfwKuynLM=;
        b=uQsazSQttr+QNtOyvL76C8QpXOtnVKylZ8RuWcKykmvfUjKWN2ViH1FJgxSxy3kWOM
         1SggIftsVSn559xw+ERhKwO4vJUyJ8nxsOsDSj7mzGv+aE9PkjeMT+/4zKIsuq8xBYBo
         zw1HG2dIhOwO/qFV/NndWJBH9unG/zp2srGc+lPzIe+rp5I44WdyQtOrcDSH9l/u1yiu
         71lndx7m/k6QmfhLexIGKWBdFPouHZIqBAwVtlE+gT+vJ27f0ttmCpSepzUIwbgIKJJ5
         SatdICesjP8FaEP7Q5pWFhqwgnH8oXwPVlr2auKjCfslZBXqom+N0hAciJBC0TyUuPE+
         NY8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXl9UqAXTCqZwpHeMTXpuAEzLjIrtGmF6jSiZzEvcenZr924676uVIwi4HFh0FHnu8PQVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxExcHmrRjjwv6rIPrZa6likExq8d3O5chov7cVVxGjVF0c8Jjq
	tuTmlKGSvbeLri7ursrLZpcfucAOkggWi6jJr/otMn6lmpX6sCrX1Kwk
X-Gm-Gg: ASbGnctOw2z/8dMZ9UEFKUqu3LndFwWn25BlhiFC5ooHQAsaUm7yqgI/TBWMLcBKX9b
	ehvSC57i9GQd3mbxsR/qNw95EjYZURI31ITu4KKbe7BcjcDU9bWoUuVbf10t0BLxJma1c2KezGP
	9MLNVgUOX6FjIkiy15ioZAQOzTWKznoN6i3m6I8hd/N/FADy69bWmsmJrGHfRnaEakRWEdwubr6
	sIAFQXTGgM/n49gIg/0M+OZDryfSgm1GEmeUOQlw59iMUHvgdSV9MJN5cq2XuG9Xkeb/5+jBbn/
	PrmnbCgrnBSDJ7h9rxtO6YXRpGbBL7P2T0tTGmilIRI=
X-Google-Smtp-Source: AGHT+IFJ2q/WflTQn73A8nIrpmnIapzkluVvFOTj8ZZPSgLEKCYgC+q7L8aWF05mW8QAfi29VAV53w==
X-Received: by 2002:a17:902:f706:b0:235:278c:7d06 with SMTP id d9443c01a7336-23b354b9932mr15061905ad.8.1751318616202;
        Mon, 30 Jun 2025 14:23:36 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::18c7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23acb39bcd2sm93679085ad.131.2025.06.30.14.23.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jun 2025 14:23:35 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Junio C Hamano <gitster@pobox.com>,  git@vger.kernel.org,  Git PLC
 <git@sfconservancy.org>
Subject: Re: [RFC/PATCH] SubmittingPatches: forbid use of genAI to generate
 changes
In-Reply-To: <aGL8hubqY35UAaGh@fruit.crustytoothpaste.net>
References: <xmqqcyalm0mh.fsf@gitster.g>
	<aGL8hubqY35UAaGh@fruit.crustytoothpaste.net>
Date: Mon, 30 Jun 2025 14:23:34 -0700
Message-ID: <87ms9oore1.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi all,

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> I think this seems prudent given the fact that there are 181 signatories
> to the Berne Convention and even if the courts rule that the use of
> generative AI is acceptable in one country (say, the United States), it
> isn't clear that that will mean anything in other countries (such as
> Canada).  Considering that there's ongoing litigation and quite a bit of
> legal uncertainty, as well as substantial pushback on generative AI from
> the open source community, this approach seems like it's in the best
> interests of the project at the moment[0].  We can always reconsider in
> the future if need be.

I agree. It feels unsafe given the lack of legislation and lack of case
law.

One thing, though:

>> +Hence, the project asks that contributors refrain from using AI content
>> +generators on changes that are submitted to the project.
>> +Contributions in which use of AI is either known or suspected may not
>> +be accepted.

This feels more like a suggestion than a requirement. Shouldn't we
explicitly prohibit it? If we truly are worried about the
copyright-ability of its output.

Collin
