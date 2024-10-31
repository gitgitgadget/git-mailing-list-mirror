Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8631313B592
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730406654; cv=none; b=sUpHBZNz+Cr1O+5P7Ga4//7OjFzMIPzhd2LHsV2BkXTCh+2NwQF2jOqEwKyuVobrqm7Mj6zErBeGDD6xJOZDL3gMDdUM7cTV5XtT8A470dJDaKcOkbxO0GIZpOYo5U9URhNykB7BWQ+6gKZuA2sU3h8kTNCcBIIZFDq+TF7QAPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730406654; c=relaxed/simple;
	bh=qnLFLOw1VOIptwcs/iUoCS+rxdNNcykV8RnYScZnsmY=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=kc8DfrlaUrEdolIjKxh957agH/hSRSziFZ2DUXoAVblb4JcbSkox0yhNSypXHdDICD9hOTwvbJUz93ZpA0x/ryqtuMk8HO8VKuAoJvvAG8Y1hIPiD/+ei8GRtO3G0QMAqsY/w4cG401Tnk0y/F3O7EhaXlrsGy+Rgc3O37J+7rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ya/Q/dVN; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ya/Q/dVN"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43152b79d25so11847295e9.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 13:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730406651; x=1731011451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DLHLN+h9VOFSHubzxV4YHY4wH27+lPn0IkGBDjOdxpk=;
        b=Ya/Q/dVNpevk0I16QOpIjrV3E+ya1RTAFp2IgbzpIHduyIt7q+46PdXvFoLQJpFT82
         v1W/RMDCQ8K/2bKi1tGLiI0+bCwTcck8MtfBeuQrxwcIHk/PM56dJGJ5mYxHzEk4TUln
         AUthqqV/Www1SG58CxjIMu+hB1ariCLXMZ84JBPTDnGVPn9ZgRX1i4IN+Z1RlugF7YAo
         K+vZ35wXkWt2NFRezSUnavUbY5t7hAAmnzsGueIsjLZ78YbaxUnKEaexqR9cq6pMUARd
         qY/m3Ghf29YdvyItnOqXu8CGKrNgPzNvMrEAl2XgBF09i7W36d59t1V2pAEYz8gaUkIu
         9dSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730406651; x=1731011451;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DLHLN+h9VOFSHubzxV4YHY4wH27+lPn0IkGBDjOdxpk=;
        b=Mk0L3YqaCd2B0XDk2Zdd3YVhn8ofREmy3mmxY2ykNEpFptwqDsjH15Jxfpi68dvjZK
         xWpp4EXCwXRwiiZOwheMOhAaLNlZgZ1HgSMCIhWclpCzvJOS37x0U9PB3hNzGYTYqqjW
         JxqoTu1N9jmmncMD0d6VBx4OCrJtjZFz9yj3+ntKvN5SHARu4OuGCIm3DCSeLoTQr9Mk
         CODPmUOU087jl+OniEVG1MIJk+WNq+Ob2rUkIsWA6aixHBATWlwKbHCau/SMXVRPxspe
         7cXMZkG3K1azCdy8S5/66m7oPzDWgcNkpdQ5e5ce1FBtisOmo5uaubocfa+2bfjk65Ww
         8QeQ==
X-Gm-Message-State: AOJu0YzmlffHU/sZm+vOrSlgxqj4eZQzPsaGftkWUUoOeNxUaWXRffX8
	8kRsB4bnuRvPqe6+13v/IVDG7YnX9EgvSWoVBqlroSGHsZwDVv+v
X-Google-Smtp-Source: AGHT+IFuG0k+ziNMvVUGbRxsP6thyqXnmQ6xhhnMvUNdjUwfYYmnzz8iyhONQs4BBuf9Za7gug/gFQ==
X-Received: by 2002:a05:600c:683:b0:431:594b:8e2b with SMTP id 5b1f17b1804b1-4327b6f9530mr41373085e9.12.1730406650437;
        Thu, 31 Oct 2024 13:30:50 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a? ([2a0a:ef40:6ac:1101:589c:aac1:dc59:c13a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1167f20sm3064182f8f.90.2024.10.31.13.30.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2024 13:30:49 -0700 (PDT)
Message-ID: <cfa466b8-a87d-4b5d-b330-6c660897de48@gmail.com>
Date: Thu, 31 Oct 2024 20:30:48 +0000
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: phillip.wood123@gmail.com
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: comment checked-out branch properly
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>, Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>
References: <5267b9a9c8cc5cc66979117dc4c1e4d7329e2a03.1729704370.git.code@khaugsbakk.name>
 <ZxlEJ+44M8z03VOj@nand.local>
 <20cca28c-cc0f-4bfa-bc1c-6a3dd6bc25a8@app.fastmail.com>
 <14993bd1-034b-40ac-a991-cc3eabc956be@gmail.com>
 <be0a2b2e-ed22-4536-aa98-caafda13c145@app.fastmail.com>
Content-Language: en-US
In-Reply-To: <be0a2b2e-ed22-4536-aa98-caafda13c145@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kristoffer

On 31/10/2024 17:25, Kristoffer Haugsbakk wrote:
> On Thu, Oct 31, 2024, at 17:30, Phillip Wood wrote:
>> The diff below shows a fix and a new test that fails without the
>> sequencer changes. The fix is based on master, so it might need
>> updating to go on top of Junio's series. The test could probably
>> be improved to use the existing setup.
> 
> Thank you!  That those lines apparently worked had kind of been
> bothering me.  It’s nice to get some clarity on the issue.
> 
> But shouldn’t there be a signoff somewhere if I am to incorporate that
> diff into the series?  Or is the signoff implied?

Here's a nicer test case, the key is that we need a conflicting
"fixup -C" after a "fixup" otherwise we just end up using the
fixup message file which only ever contains a single commit message.
Here's my signoff for this and the sequencer changes in my previous mail

Signed-off-by: Phillip.Wood <phillip.wood@dunelm.org.uk>

Best Wishes

Phillip

---- >8 ----
diff --git a/t/t3437-rebase-fixup-options.sh b/t/t3437-rebase-fixup-options.sh
index 7929e2e2e3a..a4b90e881e3 100755
--- a/t/t3437-rebase-fixup-options.sh
+++ b/t/t3437-rebase-fixup-options.sh
@@ -127,6 +127,21 @@ test_expect_success 'fixup -C with conflicts gives correct message' '
          test_cmp expected-author actual-author
  '
  
+test_expect_success 'conflicting fixup -C after fixup with custom comment string' '
+        test_config core.commentString COMMENT &&
+        test_when_finished "test_might_fail git rebase --abort" &&
+        git checkout --detach A3 &&
+        test_must_fail env FAKE_LINES="1 fixup 2 fixup_-C 4" git rebase -i A &&
+        echo resolved >A &&
+        git add A &&
+        FAKE_COMMIT_AMEND=edited git rebase --continue &&
+        test_commit_message HEAD <<-\EOF
+        A3
+
+        edited
+        EOF
+'
+
  test_expect_success 'skipping fixup -C after fixup gives correct message' '
          test_when_finished "test_might_fail git rebase --abort" &&
          git checkout --detach A3 &&


