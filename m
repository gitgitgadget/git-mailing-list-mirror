Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E1C1E489
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 21:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755381423; cv=none; b=Ay+rv8rwMaP50cJ1c/BS+yES0+vhewVdDswwZcLUwNefUyBtA5R5ieWWopkRe5/nzM5nKZL74FQLmeUuYSRKewQ0leyNoFT02/L4SxWLmIDUX3mLSWosVEHTPxj/2XWgUzPlmpFPu4c3cHgZzjdU4kd0yl80BqjTYYfXpicyeqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755381423; c=relaxed/simple;
	bh=9xxbEabuyYs+9tVe+iBHIKnUJQljGXo8+lxfziNzxOE=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=KvJMmN9aZJsywsy9m+Np/PbLlC6g8jsJRyGEH5GFaoQH+oDe/rJwoqLgPXeCzUkCbP8sRwxCn0QwsNBXhCYuvDOwnyCEqg9FSp/kKhjzeSIJGnkFsug7w7kTxHRQHa9+JuTFP+3eXqLHlVnLl+XXrN8jYnVTpTKlX57RaIcDbi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSwmi8AS; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSwmi8AS"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e933597bc2eso1410229276.2
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755381421; x=1755986221; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9xxbEabuyYs+9tVe+iBHIKnUJQljGXo8+lxfziNzxOE=;
        b=mSwmi8ASHKm1y6lj2EUu8noDG4b2HhsPqB+rEof4fJ+wM4x4IOfu5oheUkg0P+apGm
         YGiRTJRqxy2+r3E8Gyn7VKb+oEt+hpdN0wpf1CVyWO+2V3RAELOEqCb5gcGLaSRduvot
         Y3J8v2GUBmB7bQ+aeCzKIJRnmcknH5dYUk95L4WQZjAONn57Z43cHUMqpMQQR+QXyhOG
         5XSlsdcw5pwO2BsVqKTHfRKdw8YXYicX4ZMr4rxIsaMcluUjPQzSLV6A1MCCchxPVCTx
         PiC5D798RMnTMDkwIgF8+zheXzg/caaU1+P89Jn2OJt26cQMfwIm0V/ahM+8hTWXWOA0
         OIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755381421; x=1755986221;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9xxbEabuyYs+9tVe+iBHIKnUJQljGXo8+lxfziNzxOE=;
        b=CINcCrdrc34mrEx71Q8sDBTcQGTJ91An6roOYjtbD77BnyDceQoxHqgx5PptgJMW5P
         5qo4IBmV3owBJPqntQzyRAEOp+bC+XY1zDKna+ZFYaWiB4+pWegOx/yg3VLMftYMoQNC
         FyfTGElIFYTVACLEib50Zk97cFmQNZMzakjb5n2eSFKSP+HKSjsIF4V06XeyBcTLBvrA
         ci9Sin+53AEykBwOr50bb94BAOF0zuQ0jfQe04N5b5Rx+UVFjBgHd69x2P0zhy0iR7hf
         RjOHSOFArfJmhnTljhvjPJFlXL5c403WgCChC5gxc2uvOa1a/Nc5YVUErBCWij6Qns92
         Nlog==
X-Gm-Message-State: AOJu0YwzZ5+wz+Is+ft00FEYNwoxAQcbK4hpixK7UgfTC5zmEGtQ6+pn
	NPUfClKKKIOEDN08dzAVbEztSEZFzuLKCAZnFc/iJvSpJGnI323Oc8w7
X-Gm-Gg: ASbGncs9/ovgiN5kB87X7K7xuXfxqWqbn1Cl55oYPTThfTsXGtRiPSC3ZQsVG5MI4Sj
	NLgOPTsL2MKpaaJA99Z0NS9YD4ojYkkHkRTT8PfQMSewh+rRZXQ8rqJiytaCRaB03hY6WJtfeHS
	7oQJtHRGdo9hLiSQdzI4E3moZLme2cyR0IDrsARyBhqxq9P8rF9IAn5n2qSlv+NNIvwpBuD6MMa
	6GyxZJNJWzOG0f2wjS5VXK8pS1JFE45WALlPbkd0+doc8gyXB5Wxs6aXX2+v1Olahzj+wUcMwlK
	QRvRNxEjXTzTqK7SIwCqoIR/Kqoq3u7qRXvIf1BKWeJ+QyyUFOzNDaUXDjMfpxKHuXm1eId0Nds
	PNbOUy4R5i1yrXgHyh8L6IPg6HH02EtCglFo1oGXVPklLfmSGnllcwcI/6uwW
X-Google-Smtp-Source: AGHT+IFuLeBX3M1JYhfzjEHpEyZ8Ep57F0GXGpUraFCxTTbMbNe6Bu1r63DgGajweuCVsl88IbA9uQ==
X-Received: by 2002:a05:6902:150d:b0:e90:1488:3cf8 with SMTP id 3f1490d57ef6-e933250f708mr8256626276.37.1755381420984;
        Sat, 16 Aug 2025 14:57:00 -0700 (PDT)
Received: from smtpclient.apple ([2603:6081:3b00:54da:544:6126:ce7f:360c])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e9332499f2asm1741823276.0.2025.08.16.14.57.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 16 Aug 2025 14:57:00 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Ben Knoble <ben.knoble@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 5/9] strbuf: bring back is_rfc3986_unreserved
Date: Sat, 16 Aug 2025 17:56:49 -0400
Message-Id: <AF619536-A31E-4D5C-A553-4CDF8D05FCB0@gmail.com>
References: <20250816213642.3517822-6-adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
 Rodrigo Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>,
 Junio C Hamano <gitster@pobox.com>, Aaron Schrab <aaron@schrab.com>,
 Jonathan Nieder <jrnieder@gmail.com>, Stefan Beller <sbeller@google.com>,
 Patrick Steinhardt <ps@pks.im>
In-Reply-To: <20250816213642.3517822-6-adrian.ratiu@collabora.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
X-Mailer: iPhone Mail (21F90)


> Le 16 ao=C3=BBt 2025 =C3=A0 17:39, Adrian Ratiu <adrian.ratiu@collabora.co=
m> a =C3=A9crit :
>=20
> =EF=BB=BFCommit f89854362c ("credential-store: move related functions to..=
.")

Here and elsewhere, we refer to commits by the output of =E2=80=9Cgit show -=
s --format=3Dreference <object>=E2=80=9D

Best,
Ben=
