Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75AA92BE05E
	for <git@vger.kernel.org>; Wed, 13 Aug 2025 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755119394; cv=none; b=J0Ky6sMh5VTIWH1dOKre5jMePeOvfq+kXrCQEuLV2fIbnBSf5o2P7mnbQEnhn/irZNjVK7xBr3tcBgTnbon+Ehj8Rcl+woPlBqrructZ8Maouk9/i4IekUPGuEo9O1V0C8bmPrS/S4JqN0GXVdx73rH1AHncc/CbGD3LpL4oPIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755119394; c=relaxed/simple;
	bh=9d/m4Z7iLD+boWFqE/WGTbA9myJXmmPpYuUzI+l3Y5Y=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SWYcoTzlu1sgejkutSfXb+JBIZQU4hSj47i3kh7kbbpthsarGkrdmYnepGqxN3qOvMPJv/kpDjRRv9vDagG+PZFKCIAwzpvU/epuPd+KTjM01BvxdfpVoaj79InXklS/GZ+Q3ga18kQznflw6Lephg1F5TEwIR5UXNaaoP3eEhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPBfr7MF; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPBfr7MF"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7e87061a6d5so26912385a.2
        for <git@vger.kernel.org>; Wed, 13 Aug 2025 14:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755119392; x=1755724192; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9d/m4Z7iLD+boWFqE/WGTbA9myJXmmPpYuUzI+l3Y5Y=;
        b=OPBfr7MFIYoH2EHq+L2Nle//TRAdc253tKolHRwbR3w9SFJGgh7GP1YReJFrm7AVvT
         MuUd3Sme9fMMz9hVsbKpQ6Ear/yZDoiv+LUo21q09U8VJ/0nlBSgncX/ChHZa75nh8Ir
         bWdgT7DoM6XhvZw0RBibuumOHnAwkN03KbogplN63x7zwuTgILIYK3FsbWDBsLN3l3oz
         WhgZILjDVU48V/PFTqB6PQVw4gtgAstr+FeUj1jy16JhxkYDJmfPoLBseZU6ytHx+bjj
         ACtqvssI7yuF24ggAb8qjw+l/CwQzolVIHPPqs7/jLCYQ+2qKyyvpB36IRKxwX0MXO6G
         QV3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755119392; x=1755724192;
        h=mime-version:content-transfer-encoding:msip_labels:content-language
         :accept-language:message-id:date:thread-index:thread-topic:subject
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9d/m4Z7iLD+boWFqE/WGTbA9myJXmmPpYuUzI+l3Y5Y=;
        b=h2i5jW6rOjPE19Ygb4OpEzRCxJIsE+dzQqBlW5D+RrtNoruXqZdh2U0wNO/ABAgmPc
         9RWfvrFVcaU9EOog3v95hT1YEg1nus3qzNQLOFA86bOd7/v4JQ4ITlwRelnAa2CDdqjE
         c1hiLBcicDNhcMAGeOmPgpDj/y9ncat4mIJsMj+FExa86ijUOZ7EqD3ObMDJVfYaCiQK
         9hc0mPQ5zyOcm0XdiygbE3gi2ijRkIx8afgLOl0jcQUopkSoOG4uLj8t2q9H1gPzxPoC
         tKukN5bpN1FuyxEl3+wgRRQblibJR5IaZZOHdRcioSWaxIGiOa2zyOxzMyipi4l9P0fB
         ULUA==
X-Gm-Message-State: AOJu0YyR73MaL+SrBpKX6XIZ9j2P8jpad2quHEZZAewHRK7zQHobxHlk
	o915FO9/ShbMiAPD3t/R0GmvZnXLODLque6oWAIJ9HtOEWfd2J1j8amRs6m5lg==
X-Gm-Gg: ASbGnctbyp40K0Ty5P6BtqWihgPURgXSXrZ35tUuW1eB6P3U5VJMHUVn1Gw3Nv1B35T
	4P0QZaNumrGx0As/LWin5wGXceJx5SS9WWYTmPnFThcRaWQe3FmF9yBGCB2bwKHAWEMPtBZKnP8
	bxqMOQsvbn0N9akcSAnXsZgMQEg2Vjh4jk7iLOWcaMGwFmmV2/Ysj6dUvqmOYR+7gQYFoa0UH15
	4Qd8g/kp6hthel00xaOanSaNGnePNZOgzh/vjLL91Elu3Xq3tWwYD5QHUSO+UfF0dbuiQtlWbdV
	Z3CY0oy/X2XVCVGyy6HnKoIKVLlBm3LpYAYyY6kpxh92YGbeRRcKAllSKvu3rKnuNiFYF+a6CVi
	EkTaeNEiv93c6h6fgtjAh+q/so9FrAxfL2yEAklVJx/Lu0qpvHTR/Vf9LGbNhTVd6MjLJNl0eaM
	Edwrts2V7KeXT1sskXxVpEEgPuzkCP4qg=
X-Google-Smtp-Source: AGHT+IFmQy/u8ju5ftY97OZkxoUXiz8o+7prZjDFepyzi6VDkX5pRpVjNoyZNhiB6BCOrciLFpMr8A==
X-Received: by 2002:a05:620a:44c5:b0:7e8:c77:52cb with SMTP id af79cd13be357-7e871a44766mr22422285a.26.1755119392041;
        Wed, 13 Aug 2025 14:09:52 -0700 (PDT)
Received: from LV8P220MB2017.NAMP220.PROD.OUTLOOK.COM ([2603:1036:303:4456::5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e816a6c420sm1282940885a.83.2025.08.13.14.09.51
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 14:09:51 -0700 (PDT)
From: Ryan Johnson <rj.amdphreak@gmail.com>
To: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Implement feature to link/include other gitignore files in gitignore
Thread-Topic: Implement feature to link/include other gitignore files in
 gitignore
Thread-Index: AQHcDJaK96K/2JQC90WHIaDj3Jqa3g==
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Wed, 13 Aug 2025 21:09:50 +0000
Message-ID:
	<LV8P220MB2017EA88974F2311DCFB7665F52AA@LV8P220MB2017.NAMP220.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator:
X-MS-Exchange-Organization-RecordReviewCfmType: 0
msip_labels:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Feature request:=0A=
=0A=
Let .gitignore file link/include other gitignore files:=0A=
=0A=
```=0A=
include .gitignore.python=0A=
```=0A=
=0A=
Why would this help? https://github.com/github/gitignore/blob/main/Python.g=
itignore Look at how long that Python gitignore is. If I am developing a pr=
oject with multiple languages, imagine how long and how many duplicates wil=
l show up when I copy templates from these other languages: https://github.=
com/github/gitignore=A0. Now imagine a team of people adding new gitignore =
patterns. They will inevitably add them somewhere I don't want, like in the=
 middle of templates. I don't want people editing the templates, because it=
's too difficult to see their changes vs the template. I want the templates=
 to be linked so that we can tell people to copy updated gitignore template=
s, without having to analyze the file for lines that are custom-made.=0A=
=0A=
Respectfully, consider adding this easy effective idea.=0A=
