Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498643D0BF3
	for <git@vger.kernel.org>; Tue,  2 Jun 2026 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780399939; cv=pass; b=BI3Oa6YM3qp622l+dgoe/e0FHypTsnNCkvCILynk6QdkQMZCL4ToSd7wjTTSLJTR0UvA4Jpm0o2sYTNAgK84xXLxyO4hnjlMxJWHJMSRbB1w0B+XM4RioMRpkQrC4JD07ate0qEjqxeFHevKEiajbaLd9pMEYzrgYX/7fVYZ324=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780399939; c=relaxed/simple;
	bh=vf4AZFvubIznLJ0+Qrm8rxZ7wYY0WxFUdTUz8YX3VJw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=eIXSY73MxgGYDytaj0wU/CDQ0N8q08Q/GsBgrSaZOJo+G2uG1l7M2xYhBinNAKPzguL4vWX/8g0zMdOsGepZfSu+9m3sYeb4S9DYhbIGtS8x9luPttFEUVjYfrQwu/84YXo1UIv2rEKmHmSbQsRL2ESddG3v+EETWfEDyOzhqf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=reftek.com; spf=pass smtp.mailfrom=reftek.com; dkim=pass (2048-bit key) header.d=reftek.com header.i=@reftek.com header.b=YCmNgRuc; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=reftek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reftek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=reftek.com header.i=@reftek.com header.b="YCmNgRuc"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39661f81eacso38638511fa.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2026 04:32:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780399935; cv=none;
        d=google.com; s=arc-20240605;
        b=TGRYAG/2VzsNXosDxlw+A/biiigO6GObzL8MLFb/kvKcfLw97OcqhQWrabrREj+0PA
         VvYYXXcm5Y5x0JrDvwQSPaT0AoPICGxY5FAyuCAEQPJCds7Pj9mCAnADlIEhSk+eL+FQ
         CIndx8TY0Opani3iHNXpBu8Ea228w4XIaei9QwKSqMYcaegXbGX06zTYrfuixs+D0awr
         jBvnC8g28jy9nYk4dbd6FmGLx52fNLYxyTm3uM3frdfPgFath9QWRdwtCEV4PsKX4F4D
         /Tt4q5Y32sDvVk4v1Q3F3qq4fFrQj0eA/bOI+FDtNHRT5r3MXuapMspcd2H674eiuhbu
         zAbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aO6SmpbcBVnqhYOK/ptThHe5BcpB309PJjVbiLxUobE=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=lNZHb4Z6iSUSf49Hd6pHZvV5E7NEFUahcbTt4efEinwf3p8kXfUwPulMeIi6ctAmxU
         EFKtC9oadQvd1HXVcGLqfp1dSrGFpBCfOb3y2L3apUFu1HXFNIPIPSkDzYd7rAbAeFGW
         Hpy93hl0ogyg2fTizzdDqKQUAGUx4QQaIZhXqZfp9/YN+McvRM+nuDneEZVZXNFxXFIq
         LynlM5CpExB9cYxMfs+8A8N7EzhlXReXJAisJMKNhEd8UmiNi2TvFsCwuzhTlKHeMmdp
         2j1Arh6AtKEc7TZzXVq6zBF//ptkhOz/THXejDy8c8AC91XiPuedBFhW9CiYKO26klUM
         VOhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reftek.com; s=google; t=1780399935; x=1781004735; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aO6SmpbcBVnqhYOK/ptThHe5BcpB309PJjVbiLxUobE=;
        b=YCmNgRucEYAhbjDnpB+68ao3AGIrw742VQFlhINaCqIZUyy/uN5PjNZFClZl3kBLAk
         jxZpQLZrsseqDncmbFMms0a4iOWgWONTOQCyKVik/qeNi0wuu0aXSQNJ3QVwnimMOEBQ
         UykE5nw1xkCKIaQOyGXC1H/5gNumRnknXVU42Ilq2C16BmbMalK8OirLCOf5ZTiu23Ni
         PB53i4SUf5sC7f4fMNSAhVNq3VfG3DnM2KQdEnC3LV0R+wDHce1E1of/YPMokZBhDruA
         6YEFeQM9Em6NUkvsWONmS3GHOhNg9zTCGyjC+TbjyHKA78DYFyih66pnMyZv8fiGe5Vt
         hpLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780399935; x=1781004735;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aO6SmpbcBVnqhYOK/ptThHe5BcpB309PJjVbiLxUobE=;
        b=C8eZz9JN2mi6i3mRHKyf7poKnJ009gnmDfEbC+l+ukOpL52GPEnt+XeZ+3uXWQxSIC
         VHBycFWSP+IAJuXsl+eMM51iBw54Wzk3qO7MrD46UUeQ9cHXJYTZLLnMYqhShmx423aa
         M93JcLvFb60zYF/IsL4k1qX26BaJ76a4MIOga6ipeJhkzVU4yiwZ0hM+Qd90yIb2bRIp
         JB+ZVM88TuDzbtX/tlUniiMooYNXzk1jcL7Xqcp7bVYHM28w5Cl0JKtCPB/oFizAHhAb
         Tf2sCiWlDfbzkaCIqoMYGAW23qLaUvW1qcfFtgYOB3ItEFoyn0t6G1qiuDORns6vLs4u
         GD2A==
X-Gm-Message-State: AOJu0YwZbKnLWOSCLWb8y11LR+ZTEBJdaQaqnP0J/SZtTFpvF+obBlh/
	dBiqNujkklKqewhsuwKWNRRBYVLtpQtp6ETQqlIP6Nsof5pQv025eTI/f7ptFnPzfmd+F6xBxBb
	/8E6HHxNHwuax/ibALd+1bogJ0cDGo8vKjkO6OvI9MytmrNWjUE6sMA==
X-Gm-Gg: Acq92OFR/Wbu2cGXnDUl8fPoxUAnvrbCj/aooCwK4AXRtSCQd3ywa7byLLMtEPn/GxK
	Xv1Z+0VTOnAvsTR9oJBarMBxnytSl39Q2S0J6S+p+Odf9K5/j2RtgqG9KRhtRmNYhuvFPxxqwfW
	z3gfziksae+9JqaPj41hifrDBoxC1n3jMBrKLIpzbd1A+sc1B4AZ97guGz6IYXGuFevOmcs8Pg+
	Y0vFecmbn9Ck4kiPoaZFysXN0khYUy/dZuA2uPmLwR8VzPe6VN9CHXWL2kIvfsnImBWMtGkPx9x
	2GoPXpnkufGxVbaqQyu1+maRdX9Rz8DiLzvl35V3ynU1ZCw3kRxC1CI/lAIrDQEgH3tQetZskkQ
	CNsjq2YH0Y5m6L1I=
X-Received: by 2002:a05:651c:3041:b0:396:a4a2:beb9 with SMTP id
 38308e7fff4ca-396a4a2cee8mr5579741fa.3.1780399935335; Tue, 02 Jun 2026
 04:32:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dylan Carlyle <dylan@reftek.com>
Date: Tue, 2 Jun 2026 08:31:56 -0300
X-Gm-Features: AVHnY4LAjszfsSS3jsNPyiRjCf7womXFC3_1NxP3XwfH6Vdj020xR8HtBMKS3uk
Message-ID: <CAJKusd6WJUUVhbyN_-XHkGWVYeNe_=K2U3tZoezPWFG3+OG_zw@mail.gmail.com>
Subject: Git for Windows Failing to Clone
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Thank you for filling out a Git bug report!
Please answer the following questions to help us understand your issue.

What did you do before the bug happened? (Steps to reproduce your issue):

Ran git clone user@ip_addres:repo

What did you expect to happen? (Expected behavior):

The repo to be cloned

What happened instead? (Actual behavior):

remote: Enumerating objects: 57873, done.
remote: Counting objects: 100% (57873/57873), done.
remote: Compressing objects: 100% (32002/32002), done.
fatal: pack has bad object at offset 460179591: inflate returned 1
fatal: fetch-pack: invalid index-pack output

What's different between what you expected and what actually happened?

The clone never finishes on Windows.

Anything else you want to add:

Git version on the remote server is 2.47.3
This works fine from Linux but fails on Windows.

[System Info]
git version:
git version 2.54.0.windows.1
cpu: x86_64
built from commit: 2b8a3ab140826ac423c2845ef81d4c6ac4f7bf3c
sizeof-long: 4
sizeof-size_t: 8
shell-path: D:/git-sdk-64-build-installers/usr/bin/sh
rust: disabled
feature: fsmonitor--daemon

-- 
Kind Regards,

Dylan Carlyle
REFTEK Systems, Inc.
Systems Administrator
