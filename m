Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FDA155A59
	for <git@vger.kernel.org>; Fri, 29 Nov 2024 12:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732881676; cv=none; b=uF4KbkqMubLQf8WrPlTNUHsliW1mAqdxvtljFbDBS2M96I2f48jxGn+s984SjNVO5JQ6F5WI47/Jakr7mLVINHJ/t15Vc1OhL3eMTpzwL5viuwdAdIYPzAdPgNQEFNO4lafCwEBWjVRpGDlQw3opbZvGZLLBVSWMMPdmBl8crtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732881676; c=relaxed/simple;
	bh=AYxqqoFqxZuWPZWT8C/LXIKScChrkfUPZjjrheEdc2s=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UCFRrnLS7EXC63RHUVj5GyirHxhmiGYutZwDnFm9n+63dMcnMH7jD9Q0G0hyd7uNv6szQ5TM9SKPt3f3fD89d2Ic6gKvRL4+IW6fu75uLM0EOzlr6vUE8VPo1+TFJKvP3MfvWp07hIL0Kbc1jdGX23jyPaqKMf/R5lcQMikPcf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U+gFPk6x; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U+gFPk6x"
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-51544e9a0abso1436392e0c.1
        for <git@vger.kernel.org>; Fri, 29 Nov 2024 04:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732881674; x=1733486474; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=AYxqqoFqxZuWPZWT8C/LXIKScChrkfUPZjjrheEdc2s=;
        b=U+gFPk6xQpGZ6wcHwcy7qXBiy/HBNHIdO+lvi7ziU4F7kIhAHOHn0n48SWO4ivB3If
         MgjeiPdTIXqNqj2M9JKwoEGU6C8tn75QlKZAK9XDlHeb1HKe1o6Do3umjKxtpuYchmSH
         LIIrvbBK8vReJV3be5A3Mirrk/6vmnJgpzuGNqBu0SVo6MRWHCIVJ7jJPGPZ49TTW5Gi
         FLY7v4ODUp6EyWxLJ475IkIPelzqGtf2YmHv1CaHX2jomv6uJHfE2fQUsd2JDThyjHe1
         uvL4FI2nveBr8chQ4ZI+LQ1z62dZIqBot4IGMGsy3eZQ9tlurtEwmuk9vMqawVg77wiR
         hDPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732881674; x=1733486474;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AYxqqoFqxZuWPZWT8C/LXIKScChrkfUPZjjrheEdc2s=;
        b=aCKP/xiE7cUgBOqm1op10yso1YDNA9AL9bpVgsJ6wNxrvDHWy8gAfvoNUvAxLIaGp9
         UGuoXPV2icZ0IAlgMxYEulcrpauwG1mePMfDJ9EAfdE9v5DbJZaLSJXa5++D0+GsheTl
         J1qZWWklFOcv1g9D1SUSI4tHLHB8a7NKeGuUxwklaXCM4HZ1e92dTFD9myV8o3WI7IA5
         grvjl+p1z6ol/6kH+4H/cWQaaKasPxDQlxWuEiSta95GCwzxPcwkk3CLew8NQyxf5J/Z
         eidY/ACJgpV9JKpKSm0+defkojnjMnidKLEGu8yKIt7WWEbgCM3CTttQkz+1uqSKNIFZ
         QtEg==
X-Gm-Message-State: AOJu0YyVN+q5g9esRhYSImPW1uawjUGQqgRVzYeZhTxLCuS0utJPUddW
	I3s3/Jmh2ZixBSw3mm9is30hSIA05NTs9w3yrI4wBpGlf/8jZItVOEhpCQWGIPKYldswiRzjpks
	G6yMaEvm0o4svzQxTk9xnY7cOe1pLwSZE7DM=
X-Gm-Gg: ASbGncvYaCuegEFetAXViyRQdpgSFRS0PAmLKcRgKdcwS7vQdxcaoC41hhXZj2u9EWC
	g1wvyCciBY1lCcjCVh/ESLuit/RKgNxI=
X-Google-Smtp-Source: AGHT+IErSztqdZM383m/qGd8hF5jbxIwluRN6Cgs52ZVTY+mXNuEc7PdzezrcRbKRvM8b8o6ZdjRDY02dqqPuHjnPnI=
X-Received: by 2002:a05:6122:620d:20b0:515:1fde:1cb1 with SMTP id
 71dfb90a1353d-5156a8e0b02mr6132438e0c.3.1732881674094; Fri, 29 Nov 2024
 04:01:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Fri, 29 Nov 2024 17:31:03 +0530
Message-ID: <CAPSxiM_V1X7HtAAX+dJLH7c-ScVCnLxvazgJL=BGeC+kuEAHWQ@mail.gmail.com>
Subject: [Outreachy] Git Internship - "Finish adding a 'os-version' capability
 to Git protocol v2"
To: git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Dear Git Community,

I am writing with great happiness to have been selected as an
Outreachy intern for the 2024-2025 period. I am really honored to be
part of one of the most impactful OpenSource projects and also working
alongside the best engineers in the world. I hope to learn a lot and
contribute a lot also.

I appreciate everyone who guided me during the contribution stage. I
really learnt a lot from all of you.

I will be working on "Finish adding a 'os-version' capability to Git
protocol v2" projects in the coming weeks and days. I also hope to
keep contributing and being part of the Git community after my
internship.

Thank you once again.

Usman Akinyemi.
