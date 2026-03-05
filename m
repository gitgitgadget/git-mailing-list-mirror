Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73D2DC35C
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772741277; cv=pass; b=aDIma9Cq4+QwffQf8URoVxRb+TIwayHwir4FKf+yvQ0sFRdo7sJYydHcGCLgQecdLi6eU6H8NCp5BwqTq9LmFY5AYV/vpE5R5uXybHhrEUsY0uMxTd/IXfI18CkoL7f9RRkwh5bGuWK0/aKMXWh/U9liJz0LYsfuuGc3zNFsRg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772741277; c=relaxed/simple;
	bh=a7Ah5AuF0gMumTvjlQ1Vp0RX9JhSYU60X8cBoHXMtgs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=p7vkyst0bLxoP3NjBau9n6AU6SSMvBktlmJIaSkDjRR0EA+K0ivvKdHgiowh+JyMv7VtQobtcnccF2vuPOKsDrmjZlrjL84E+3bRUSUduy/6aa9guUS0Xg7ZqPXnAlH6tPbsJXupW0JhOIawJGgNOuHUWTVSzSErU8VKD+3QiP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K+AmG2wc; arc=pass smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K+AmG2wc"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-6786b13984fso6061373eaf.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 12:07:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772741275; cv=none;
        d=google.com; s=arc-20240605;
        b=L0OY4pqAzKnE74vClwvjN9IGZu1RtxBp0tRK0p9yaCeUiL6xmUlHnOCh9XWZ/74QRY
         EAmULtEvIo18yLQ9oWQF7riesfxMpgujb0gaPB4Lwr0cKuvhUQXQ6/9pXF363S9cmdhi
         9/mQ/yOm6KEskfYEipCSxC1SQK5ITQQW6H9lFLXeyMsnxj+Lgb6soRBjtlxMy/P0jt1O
         hxhBdZdMIjTGp6eJI4W7RaatYwcc5E5dZc8hT4AClZOgiwWGOhjUBTOgrIyK5Ism3gdz
         rRYQidex1HMIzgeWT6ZJYIJkrjmuLwhBBDhreKVcXwgXmoQqCxTJFfyfcn9ajaZEdrXj
         JZ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=a7Ah5AuF0gMumTvjlQ1Vp0RX9JhSYU60X8cBoHXMtgs=;
        fh=AdLvfp5rDLFEqEXBqPWoMWgsTSDK6pd8NZNu0VEubK4=;
        b=EXJrgXVhLf5yjZfjJfsjO//2wNriyXj1dXishw4uJSbcGwWHAmV/fnsRcg2y9/qhnm
         W5r+ezpC94899WTgsl23niBrMUjMBgBBvAej2/0twE+zQqQ0h//9uoKRM5MVRCBXSqVu
         2nt5yAjdqM0Wt9woep0QABR+CR7saez+JgqxTeCKoT/+cewefMkmy37CU4jZy1kMoht8
         qkPSG9Evzfi8XLoz0ob84mr5XQSw0+Nxxz73advNFNt5hPM9gfIQYgTIo3gtWHf7ZWHu
         Lrtnc0mQB+9VLPy980of+EK7BWaaFKgeG6BlNvEzT9UecqaQGGWOrgpff4r8HQ9KmRKb
         Q/QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772741275; x=1773346075; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=a7Ah5AuF0gMumTvjlQ1Vp0RX9JhSYU60X8cBoHXMtgs=;
        b=K+AmG2wcYEkfNeCZbdWidwAg54VYKK2ntLE93X0OdeYabnXh7l0F/eE2pb5BIGwrzY
         XjgD0cFfCNFOvkpfgZtAE8W6hnOP5in3GMXsiiOEaETV2QMc2ie7+rVAh2KzGVX+pjSI
         EBzqXBAA/bPRMumpLqKTQdDSz5AiXuc/hpplZqLkPcDLNfPh3Sp32Mt5OrOr0EtGh7rW
         Eom5dBn/J5SWp9JJxgKmGEevNy4fHLn0Szgt5U55mCLvM71j9ePHWLZxfwOceBuCs0QT
         EXMiDP44MP0W6ddT9jUdsHuMt/jpDyLSyumlrY6FkSsRCj11X3cNSM6XoIOhE1hpCaI6
         Tf9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772741275; x=1773346075;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a7Ah5AuF0gMumTvjlQ1Vp0RX9JhSYU60X8cBoHXMtgs=;
        b=d3iTUpaCMtve3Ib0CSucQny5kq1PQjHZh6GJk37ApDkqgLCANf8/qhqFoxf0FvIgcC
         xLoczsE6rSbPFhNJB3bz45i8uMNwtrh/HnspCzURSe6m7yXuR2JyMaRoiLDxYgRL396L
         DJYtqtCkzkg8fTXLklYxMtjxY0Vo3GmWjIE9jAc996MyrKUwcvTjurk7oofc0cFlexGK
         71PRzn+DWM17A1Ej62Tb/VIJlQbHBFSR2m4jmlsKcB5tfdL3Ks/zfhHwBpDFecJM+m08
         4V9xrz2AQZV+Lr7tvZnr8cOc4uIWmbEg3EuDjN4E3rWcih9AGVq7q+VgZpGS7qDaMkt/
         /NLg==
X-Gm-Message-State: AOJu0Yz2DnRbACsews8oAP3vErsD+rLDsdjJjwBqLgVgXqPqG+wbNsXK
	SV6hknDjQXO0F68fppLnjzmGbRYiIJxYCXmyDUZuvvkIywFPNUYUomc1vy8IHRt+HuLwp3l1gtG
	BKkMdfMPrueSmlF1/PYoC2qztA33qMTrKsQ==
X-Gm-Gg: ATEYQzxdMkm16evV4Ggt66ysZdSG9wcwUHw+UbGQThXM8BzMQYTfvp5b4LCHASwxcSs
	tVjwdsHsXy/yVJrehXrxkGI01vwoMBzbDWvWxQsOMEuZtU79MnjqdJzsO6IzzYTIpKDOat/yOBB
	aIFgSOSInRXNYTOg9ETQRzuiCYsWWmQXXbubxHINdmVEHSRDWjwNhgfR8sHxxNOAsPkUjmKeF+j
	aFbpqxxDTiOHRNd6Ga8FeE+vpxJb4JF4tZNjx4oLWHQo21qUek+LB39IOVJX/LZcAwqWIUQbXZJ
	cCOgPczJ
X-Received: by 2002:a05:6820:1ca4:b0:679:e68b:f95d with SMTP id
 006d021491bc7-67b1776bde5mr4103747eaf.53.1772741275074; Thu, 05 Mar 2026
 12:07:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Aron Sigfridsson <aron.sigfridsson@gmail.com>
Date: Thu, 5 Mar 2026 21:07:28 +0100
X-Gm-Features: AaiRm53jsDaczIPgcD3OkZsWUPssT9UFdTRKhFIdizvAWCKWahDImUYiJrnu_K0
Message-ID: <CAB0c_PjtTs8dWJCoUnQfCUM_YOaK3e3FcZfCgWjTOLcNWj-6nA@mail.gmail.com>
Subject: Git reference git stash
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi!

In the reference for git stash there is a section that specifies the
use of the pathspec option. It refers you to the gitglossary section
about pathspec for further information. In the glossary it states:
"See the documentation of each command for whether paths are relative
to the current directory or toplevel"

In the documentation for git stash I can't find any information about
whether it is top level or relative to current directory. Am I missing
something, or is the information not there?

Thank you for your work!

Aron
