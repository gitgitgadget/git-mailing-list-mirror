Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3F424466C
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 03:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775790095; cv=none; b=m3iE3nK02dHmuyUtKOPpX3QP8x88gLT2Zt3LWbeLkKWprwVYJx6If3oz187ixjWFSk8G1QRnAnJSiD+tVJvoL0WoTy+ddrc5xWstL6icv0kdlLXqT6jLPqINbGsP24LmYMBMkTJ/YMEpI1JbIIqbC57xdXKTjTeUYHFMAtl9bSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775790095; c=relaxed/simple;
	bh=iqkARBgcn/PVy7ccHyStRus4B3WxyIfFfUeDi6qRgaU=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=tbNiuU93dSE4hqjWBcIhoLkb2T6gWOBvQDK6y7UF0N4Ehxt9XM0YCBnno6fC+3WMw1Xgg+yUqwMPnk/rP3CYzOYv0eUQsFpg2Yqz33aD3+MRlahNplKq95VQkLY3TxCgN9MyA1G1sKqJVNzaDIh+grf1fkFi7o4uFZF2S3shk3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sq9nQwdU; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sq9nQwdU"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82c70e4654eso738656b3a.2
        for <git@vger.kernel.org>; Thu, 09 Apr 2026 20:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775790094; x=1776394894; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XvOMTr8wvlso60qrbYOO21hw9Rj7ObwP983Yw7Ya5MA=;
        b=Sq9nQwdUQlbKE1yqNuaEGQXmPrRWiORqrwyYAGRXiqdAc0aTNiiDxNI3E/QzRAxVpY
         6pOwPm/kAJs+P68uJoDjWyGYC7+OaXpc15dWd5QsPYkxNltAJJxXcdLDU2NnAzvTYOzS
         TlbBZfkh84EVFhRGRiX/0CW/jBwTvX0lxceWopmlxaDqTGlKROGK/LOZnvNUygLvMaBd
         +jEJ8o9QgNEsELDE9v6itcrYFjsHeHnvvxvV+G5uPpSHBDLQmy8KaoFqoB/VHhrVgPlH
         9Fg4LMsSsxNlgOC8ztMmkhtonC/RLBO8fStA67X1I2+COaaFo+c6mxybk0jyNYi+Yqu3
         WwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775790094; x=1776394894;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XvOMTr8wvlso60qrbYOO21hw9Rj7ObwP983Yw7Ya5MA=;
        b=JEZ88Gxb+5oSapGWi85NuzjK3PVug+Z+vWyXxuyAhztq3pVKgba03IUp0JzwuqRUUs
         dhyMNmgTDdW8kRzZ2Pjh5G3z3Ca/n/3JJrMFXgjK7cDdG9e+T+gmE+92uLvrczLZfDcb
         rJDjKLQFLxgULVexYlQ+eKkBJAx/HRIfXr+i+Lj6OYLcgcTcUqpWpbMRMbQHwTp/ZwIQ
         D62tMkT+Sw0gywrxMQH6KA13V39O5HZpkkl6cumi/0dAQ8DikhCjcbdkjqYP3wxTCn7g
         MrBsj8gpfK28a0BVUWvcZhpQYGtmw5LC/6d7rARZZ1z5Rv0Rl1kp0SIC21Q5VvuM81TL
         sO2g==
X-Gm-Message-State: AOJu0YzYpQ22E5bE2tHXbVmZLPt7rgbnelhlXhgsSv4Jj81NAJ4Lx7G4
	YPpwqqzdt/xihrEPrUdLtPGOtUVEg8WPqui0+ySi0HyKYAFkKYsrACMolcWG+A==
X-Gm-Gg: AeBDiesFv1cI3dmGauuIrDmhpvbsMy9ergxk8Q5aio9OVhe+7BArEaKPGb6KHlhRmfE
	2vlWpH7EMoYoIiPRusfqZE7htCJ7ZILzkPNcI1KkY7aI23epamm+ZaNxlnK8+4V3E3bTkuhDpr6
	OUS+4Z2EqZCj8dCW1nP6ZZq4fSudIp24Msho0LItcGUc5pIMHTqKRYxsRAODYBDJYKEvOuVRnz7
	ULfLvuVJTmjwbswC5wq89ZFeMXTTpOoFqNz7TMt/43n5sunvHc3MpBtBrfJIiR+3t5+Uax0c1/K
	svVHMX1tC1IqqzRSblHhN3C2h7RLcb7nsNO3HhRmRBs5HpKHya/vuT38EeVNcizHaPadctkDUi2
	S/UG49ORolJhmzTnZ/0RXh+fPdAMihR1EkavkwWxdeux8YnP5reeJ/Rvtga0UK0o/dOR/QrcRSh
	nTOcqysClCYe9WxIryCeVoyiq1+wxO9Njb4qFoSCveTYgJvIOs8yOLvoq6rPetn1xO0rv+DaEC7
	sS0AhO+wQ==
X-Received: by 2002:a05:6a00:14c7:b0:82c:6b1b:7ad4 with SMTP id d2e1a72fcca58-82f0c250a1dmr1778420b3a.3.1775790093871;
        Thu, 09 Apr 2026 20:01:33 -0700 (PDT)
Received: from ?IPV6:2401:4900:93f1:72e7:7147:28f0:d3fa:f2d1? ([2401:4900:93f1:72e7:7147:28f0:d3fa:f2d1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f0c500415sm922689b3a.51.2026.04.09.20.01.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 20:01:33 -0700 (PDT)
Message-ID: <7207a7f0-3806-4ff3-a3d2-2cdcc23f913a@gmail.com>
Date: Fri, 10 Apr 2026 08:31:22 +0530
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: git <git@vger.kernel.org>
Cc: Christian Couder <christian.couder@gmail.com>,
 karthik nayak <karthik.188@gmail.com>,
 Siddharth Asthana <siddharthasthana31@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Chandra Pratap <chandrapratap3519@gmail.com>, Patrick Steinhardt
 <ps@pks.im>, Justin Tobler <jltobler@gmail.com>,
 Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
From: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Subject: [GSoC] Call for Mentors - Help Us Welcome More Contributors to Git
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi all,

We have great news and a small challenge — and we need your help.

This year, Git received 19 GSoC proposals, which speaks to the growing 
interest in contributing to our project. We have 5 strong project ideas 
[1] and are working to select as much candidates as possible (at the 
moment we're capped at 3-4). We're constrained not by the quality of 
proposals, but by mentor availability. Right now, we have only 6 mentors 
(3 primary, 3 co-mentors), and that limits how many promising 
contributors we can take on.

That's where you come in.

If you have experience contributing to Git and can spare some time this 
summer, we'd love to have you on board as a mentor or co-mentor. 
Mentoring is one of the most direct ways to grow our community — many of 
today's long-term contributors got their start through exactly this kind 
of guidance. Karthik, Ayush and Chandra are examples of GSoC 
contributors now turned into community members contributing outside GSoC.

Even stepping up as a co-mentor makes a real difference.

We also have one self-proposed project from a candidate this year [2]. 
If anyone is willing to mentor them specifically, that would be very 
welcome.

If you're interested or have questions, please reply to this thread. 
Every additional mentor means one more contributor we can nurture into a 
long-term member of the Git community.

Thank you!

[[ References ]]

[1]: https://git.github.io/SoC-2026-Ideas/
[2]: 
https://public-inbox.org/git/CAOAgETPhYra3XrevHptFu0x-se8D9ovRtgfomwFbhq9rSTXu6A@mail.gmail.com/

--
Sivaraam

