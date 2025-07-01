Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C051885B8
	for <git@vger.kernel.org>; Tue,  1 Jul 2025 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751384293; cv=none; b=EAYADVp5S3LRB7U7bErT1XbMakxnIPgl0cUcnycxG2OGNm7vVRoQWqhGRpvl4T/PpCSbr6+19+IhfDsemSvnzb7rUzlUlvUCZ0uuAj3IdwUBFp9oUzTrLSsa6WnsJwGeQ3BKuNsv8S5XugkvHnGtFLGF637M20hnFz+qKoyTNOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751384293; c=relaxed/simple;
	bh=iT+kKPB0VFPk11VqB8OWQs5JxcDkc+Z5d0SgSjgk8Ss=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fw+Zxugnl1/LOB+p48iOkh1DVQ5J2gLElDViXuEzlNBROW/8EHwVQLEDDfnhJpzQB+qBrcXXfc8ZN1rc7D316EIvDvUbJR48T7abZ11iFFCOBiABmelj6ZvE6iW4gDcG+VcnpmlzMZPye6/INt12vLC8OiATCPGBqDcETECg0Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=im6ZFYaa; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="im6ZFYaa"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-748fe69a7baso5638951b3a.3
        for <git@vger.kernel.org>; Tue, 01 Jul 2025 08:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751384291; x=1751989091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=A3CVO4KILI3NOiNBgcJrHooZ8xoEm3sMq1BvXTS6iYE=;
        b=im6ZFYaaHbJsK+o6QOYy0h6ly9LFXOhLbfeGsYvn8G/1kFl3LDgZBsHP1zVz4aXUXB
         IPgYedgv6PSKu7p/UCvUYD9A9Q7tb332zscQMTXZgwSFlRA3pnB8hn3tNO2DHeej9JBq
         RGmpdVhBrZ7z/8Ak6iqh0sml+KDkPDkW9Ej08/vXR3UxI9JkN3WwX/aiG3euyh/GkxAH
         wi7dA7i6QG9t4AYxwh+eN2M2VCLskMGsDyGGoRkbMyij0lSGmZQsbgH6KA4DeuaDQBqi
         5ceyY2R0IncL2CAMWRtcAnuAY44k9rmtXhjgZBL6KV1ZULizd+COdJABEX6rD0kBL27k
         fF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751384291; x=1751989091;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:in-reply-to:subject:cc:to:from:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3CVO4KILI3NOiNBgcJrHooZ8xoEm3sMq1BvXTS6iYE=;
        b=AtalxZlwX+iz5hA9sVIHOionlWiGzUWtT8JDYHdEPXglpISTqYudIu/CYd2ykMjtyX
         yzu+1XxBQxgy25awDuLdIF805rgFN1TP0PauovqR6c/FRNDsY8+pSmh6/bthaBhEHO7p
         S6pmapDLXMB6fK6LYMAVnUUUyG71uyH5CjiK2yZ7paGmJqVQAxCw366utwLln/vx7BEa
         kbuCFOIlY/ksHJbpDdrZQ5ku6RN2ozOMwXck3rJ2ng+e5yUVtfdD3Fw8ZtQJJj+HwBid
         DN04GkcO+7xoXG1I2KGSZSBgf+mvQTIRR8Io0EPXfVS21nrX4bztppVmdMLK8PaGN7DT
         olsQ==
X-Forwarded-Encrypted: i=1; AJvYcCUO3PUeJQwrgQWiCPONatkOfeE2XEWrB45SbgWofBCiEFSGrRxyQ65z/Zt90hPYlpHeVBI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAOkgRm19Qf5I1cTJSUWxrDgkObZEih4dGtUzIwLVi2Db7tFQJ
	VJOHgTvVIAE5+tiPfCy7NGlQLGWeNKvOSCdRj0SqfoRGJR22gbvdcTDT
X-Gm-Gg: ASbGncsq9/ZIaQ8/N2Bhr1aZuMlTmgB38sbVuFXQwl5JqwXsDnCuRbr64XLTYaYZX8u
	bpdJT0anWIjLIhGP5U13wOFNzLA/6cehH08JFf6I6CVIef3MhEnxSa66QLT0Zu2r3SDKB/mAWWO
	Wm3nHsw7zP7440lkv2eJ4ahQ5O0Q9cGpoM3laWER9E4xhELb72kbn7ue83u5a/bFW6HtVLN1cdM
	bez8/qXTGgIxf0BIKk1idxG6VTCVghXeRnvL/dnIshh2Sz3m08Xn9uBjuIWyE6g0jScBsliVd1m
	1yX6xxqp6H4ux4IQpFUTc4w2Qr38UQSS4d8eLgQFPOaRp8xW2AU32Ywpro/EMxMlH/mPlFnTw4K
	+MaCwWAoLP8xlRfdycA5o/KQG9kI=
X-Google-Smtp-Source: AGHT+IFtHXS7MlQkc88EnhZkD65ojxG2xUhxvM6jpk5/lcGr4+z5RVxfK4alwjhchzeju/zISqsl/g==
X-Received: by 2002:a05:6a00:4b16:b0:748:f1ba:9aff with SMTP id d2e1a72fcca58-74af6e6350cmr23250056b3a.5.1751384291195;
        Tue, 01 Jul 2025 08:38:11 -0700 (PDT)
Received: from localhost (209.255.125.34.bc.googleusercontent.com. [34.125.255.209])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74af56e8b00sm12175384b3a.143.2025.07.01.08.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 08:38:10 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From: Junio C Hamano <gitster@pobox.com>
To: Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  git@vger.kernel.org
Subject: Re: Failing to push to a repository erases authentication helper
 credentials
In-Reply-To: <aGOGMpibpUM2JJuV@kitsune.suse.cz> ("Michal =?utf-8?Q?Such?=
 =?utf-8?Q?=C3=A1nek=22's?= message
	of "Tue, 1 Jul 2025 08:54:42 +0200")
References: <aGKU-o9eXB1VHuN9@kitsune.suse.cz>
	<aGKfs5VRdmnw6Pqc@fruit.crustytoothpaste.net>
	<aGKokqPJPh5fQ3fc@kitsune.suse.cz>
	<aGLXmiYuM2C_xfWJ@fruit.crustytoothpaste.net>
	<aGOGMpibpUM2JJuV@kitsune.suse.cz>
Date: Tue, 01 Jul 2025 08:38:09 -0700
Message-ID: <xmqqjz4rly5a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Michal Suchánek <msuchanek@suse.de> writes:

> Is there any way to see what the server is returning?

If this is going over http(s)://, then

    export GIT_TRACE_CURL=true

(or the absolute path name of the file you want to store the trace
data in, in place for true that tells it to dump to the standard
error stream), perhaps?
