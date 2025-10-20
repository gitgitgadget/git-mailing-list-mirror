Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BD313297
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970248; cv=none; b=O1vdgHFch3mdQOL13u7PGcftAcNt/1b2taUMpeoHX9mcjizXpQTPT/+Lz/8z/uaEvjFFdrx9DwDrOc4dkjg4hrGI/t8ObPo56WChj6qkTMyQsVHDpXQvhVbPa/CdByw7oYReW9qBGZrxXyuk6WDP0sXyM7iQT5SYzCS4BtcQvhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970248; c=relaxed/simple;
	bh=RcT/IG9s8RbkS1izs8cj69eUWVtV2mwFQIVGUtbD35E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MltbAgOOp4bkfx4vcmzibIMQI9qq+Y1Jajoy4YllFZMmOexlCxCp70k654twAhT9w7yfKtJGbGvQqnKlTFc+nsgo8m9e7TlpDVLxlzI3FAi3uDegAZfHF/n4LKtERygyeY+8ZPurb16upXRsw05kbPkRXRHFvlmcR0gh18pBSpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ip252tSm; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ip252tSm"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-892d1443e48so412800385a.0
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 07:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760970245; x=1761575045; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35KsAGiMzNLXsikMG/cT7hjbhqwx6HQPlFeeqPyOjRw=;
        b=ip252tSmtN6jBT+N7tQ5yW9LxDe5nXvHQPXz9Qkeqj5LJoh23Q6R3GAD0nrW2rKlM4
         S0I7uHvHDRFCGzM2xi4YnvMJZ7VgZ44cIAqtvIMZqEZ41kmuyZ+T5iF/VbhGD8sUGZGv
         eLKmYpMMTya/gJXiymuVTdQ+akJvFjHJ0i8idYB7TpJbd+yCN4xPHgUJTsg8CNahcDll
         hUvso3NUpiuSIV+SZq4FtaC6KpjneZ3VSqytdHBCdw1H7/17bLW+X6Hm+TPX57be3Y6n
         Oh6niGfVRnMmaO/06mZar5hQ4FRGcmDBmap6W+1qP1ENXNESJwye/8l8SjaYcKTEpjCr
         KhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760970245; x=1761575045;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35KsAGiMzNLXsikMG/cT7hjbhqwx6HQPlFeeqPyOjRw=;
        b=oSlgbGpvrBG/5FCDBn2pX0hd5j1o8yDovkw75XxW0TyOcjEu+0O92T1DzfNAY9kXlU
         H0ic4oQJOx4pODtrRiQ2CAR36hYOpcoWCE/PdtHc0jlWouJl8mhLodw3IK7Kz/SYVyzj
         EZzhBkw45YQ8Mmoibm5S1Bdzm6ZlwY9hUBMTXkk0ZGaIvMeIwSmzZT82Z2333FNMr2bP
         GpkJ7UA0bq9NXDFLXSXmdV8rJPZ1YoWQKvqdfDHuQ5SlnULCt14I0xRxZY6Jv4BPqcsr
         Z0RBPlWwj9xbCZ6nQGkMwB/fvStUC1Fzydn1D/OgOmevv3OiqDwAj39X0wPbdR8DLhXN
         H5TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWubxIenjl2hWOyPBR/FEwrSpwlG2dvJ0oC/yJTLBjcJodIJM0E8PnD0tkDrIG2zSK/LCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsCLwq6FmY3XcseTImoewDz1PcJtrlOTo32ZtfUCZ2JKEqT5o0
	FUINOv0yCUzSHxW74Kx4CihYxYdnOfJrjs4RKyn6W8F8TkRhmDgH0/htSSaT0FQL
X-Gm-Gg: ASbGncuNjBZnP2ObVUzebsSsJ8gvW310cJ3ouH0QTsdgMcuvNjYnMOY4u2FEooUiu0o
	uSwH+yRgxyMRNR9yoOXdlHLKNu7hUOcTF4bMfynWeA6fFE/cE4xA5ZE888TFa2+4UJmSBJtyi69
	CLqy0Pj9g3WueM+Xst9aAsCOmtCHKlUeKwSvuRpIsucz0KJY3RX+CtzLbR4hg/lwFtx/AqwLc2M
	UV9pbv/TML4Xvquf1owk/HyRHDn+KYCkFhuCSozFb4k36awsysuYvkw3GXY15FksKqWVmEIK6vj
	74uMk/F+2O2DIb0dlbCNfc5gOTfRbqZfEu1grvgUuoWFbtndRsm0wu6qeFFcplpKmlu4eNCD0GQ
	oPPSMwpM6RFZWFgxiWnE4f0V5Gq3PB7wDzrf5DK9QjekydimkZ56KVDc7rtRwJLVmYMUnb4Evd9
	MkNqe31xqb3IfpUJJh0trrltlitFVDOHnhyOhl4F/8x6SGPa1IDZMpdBUKHgIiRY1tOFisBLFL4
	o9MFvkf4MBctNZsfEijHd4=
X-Google-Smtp-Source: AGHT+IEDrTsp7QfrXud8KBBpifz+66oIUsMAAgnUaRTpiRBP0vYIl9nSkQBejD0RkmvkICrXeXsKDg==
X-Received: by 2002:ac8:7fc7:0:b0:4e8:8725:c7f1 with SMTP id d75a77b69052e-4e89d218d9cmr216339001cf.18.1760970245512;
        Mon, 20 Oct 2025 07:24:05 -0700 (PDT)
Received: from ?IPV6:2605:a601:a6b1:2f00:3d56:be00:69bd:1efd? ([2605:a601:a6b1:2f00:3d56:be00:69bd:1efd])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e8ab0ee857sm55161121cf.31.2025.10.20.07.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 07:24:05 -0700 (PDT)
Message-ID: <a34cc559-5823-4e68-8f3f-07c182f7299b@gmail.com>
Date: Mon, 20 Oct 2025 10:24:04 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 8/8] sparse-index: improve advice message instructions
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: gitster@pobox.com, newren@gmail.com, Patrick Steinhardt <ps@pks.im>
References: <pull.1941.v2.git.1752716054.gitgitgadget@gmail.com>
 <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <pull.1941.v3.git.1757673011.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

 From 0ee829fea73d495dd32deda4553ea00f9299c701 Mon Sep 17 00:00:00 2001
From: Derrick Stolee <stolee@gmail.com>
Date: Mon, 20 Oct 2025 10:19:22 -0400
Subject: [PATCH 8/8] sparse-index: improve advice message instructions

When an on-disk sparse index is expanded to a full one, this could be due to
some worktree state that requires looking at file entries hidden within
sparse tree entries. These can be avoided if the worktree is cleaned up and
some other issues related to the index state. Expand the advice message to
include all of these cases, since 'git sparse-checkout clean' is not
currently capable of handling all cases.

In the future, we may improve the behavior of 'git sparse-checkout clean' to
handle all of the cases.

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---

Here is an add-on patch to add to this series to hopefully satisfy
Elijah's feedback. Sorry it took so long to be able to get back to
this!

-Stolee


  sparse-index.c | 5 +++--
  1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 5d14795063b..76f90da5f5f 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -32,8 +32,9 @@ int give_advice_on_expansion = 1;
  	"Your working directory likely has contents that are outside of\n"     \
  	"your sparse-checkout patterns. Use 'git sparse-checkout list' to\n"   \
  	"see your sparse-checkout definition and compare it to your working\n" \
-	"directory contents. Running 'git sparse-checkout clean' may assist\n" \
-	"in this cleanup."
+	"directory contents. Cleaning up any merge conflicts or staged\n"      \
+	"changes before running 'git sparse-checkout clean' or 'git\n"         \
+	"sparse-checkout reapply' may assist in this cleanup."

  struct modify_index_context {
  	struct index_state *write;
-- 
2.47.0.vfs.0.3


