Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C250C1E7C2E
	for <git@vger.kernel.org>; Wed, 10 Dec 2025 20:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765396843; cv=none; b=RuK417GjZJ3tsiFhwjM219CK3oWmWtxDrQYrCZf8aCBtggtxC6BhWGafRr9uzUuayOCvnnQh0swyL81T53llLyyF4yGK1eZBHhgAc9bkE8HdWZpGYpc5BQTgXrdzS/Y5OWYMsXGlU4PLxe0tHFucdQl9fzY0hoQHLtPn4gDhj8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765396843; c=relaxed/simple;
	bh=/jo759h76K6hHJIp2ifWyayoHgcX9u6J+x69pgNm9pY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HcmQ1ZSwV6tqs2uvEqAVSpI0AqQqjUT5tyaV6kKivl43YodE2TNJuV+F3xm0p/8l4QJVIA961lUj5GtCjJ1v3eZTcCrlTOk8SrjyUNMec6Gh2G9ju07T2ILaZqn6TvBXAD4ZpW7G7NjDPqqSq/U7aCNKTEAOFBwZgsVzSlGCmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7cpjVNJ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7cpjVNJ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7c71cca8fc2so185078a34.1
        for <git@vger.kernel.org>; Wed, 10 Dec 2025 12:00:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765396841; x=1766001641; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mq1MlzfmLYjohuhOoEDWznTFeFY51nCEiYWwpRRRFk0=;
        b=H7cpjVNJUD1km1bt8kn77IOEvFZk0qWZPq4bOs6pBL4MBWT/n1NocBuIJBcZdFVkxq
         0urYI0K4EjeVv5zOd+HEdEQlURseTFHUPEbF4yaFeutjpXkQp18Iv99pNjfTf8JonamZ
         FpVNmwhD4HiELVQUZe5wO8jN+5pHdXLPOPShcaVURDeRsoM5SewnDzYPQRkEOIPyza42
         YuVnUaLVzbZqWCYSlGwwQVl7t6tHyBN9IczFpyc1sHanC7hn9bzur30kawTw2hVgcg2R
         A8B388/6DV2KTrEej3KvJlxloO9QByVe3NIFSUmMZbgIA71b0Zu5XZkcJ5W05vLFaKtn
         WIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765396841; x=1766001641;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mq1MlzfmLYjohuhOoEDWznTFeFY51nCEiYWwpRRRFk0=;
        b=ltIzoQoO2VxiWYJLG8lFbohzLv5EQsfC5VyeY85pNccewkeqioBb9SKW2URTmpnWeX
         mciKHiO2nfNjheWdWQaP3eFORkxInCfrBmfU/JwVQ0FRRX7xJVHox28ltUt4i7eNcHX+
         /F4+y92HEnxrzIDtWwU0hAPo/PnX3lrYUuo9rekze9YCqgWplX4/3tC1+8fBF+IjNXdw
         TWUqvK95Itr8pCbcHn4JuV6F+fCMuzuKZEIGJpfQNVgXBQA9FR8SqotVsnJ5vaE6Lxiu
         GQ7mYEJZi1/DNI/byixcgMC9Nu5fcrEsdGorGH3HXKYUCn7HWpnQ6nYUy76kl2TV/nbe
         CidQ==
X-Gm-Message-State: AOJu0Yw5JC4VSDZTCq3+T89ySmxSdrzpgCAEIT/FjGqfpzwhIQB47xhy
	LCX8iL4rtisEkLl5tOwzFP67y02ahYjVEn/qnrAyjMpiwQ155lR/l5WBcTu9Yg==
X-Gm-Gg: ASbGncufkzOA765wnV1CZcW7LVHwLHFp+LGkj6WL+7nYjau0BGsKsGRVfNvx3g2q5ck
	3WLSdh9iJ3+KpXleztfbaJAHJewiMDaUt6WM0+t1Xmh0Ndp/rbN4XZKfMN27femlGGNtF9rme1q
	sOD2aE4q0+8q47JnQCLQYfu1uvPGPhx2NJ53mHSCtSLxK237tkwiq/oGOaDjU1FGHRgaR7dUUOE
	u8FRNZZ0WYYRHxvUmjO+RP/AagEv5r9BLVwesrVPDcptERvfGTMceqeiHuLe0VScHcOQfHSNPeD
	7FKAd1GD9rN5X7ZZ09M1yzOhSTv6AiAzI4LDioIQ31xpP0sJAVBGW6c7hzfidJSvKaVmYYtTzxm
	xM2eNGIxeR/MoBu6q4dtXcwmskDMQK4N5jXz1uep4GvhmHQC9+yaM7S9cj0CMQG7TTNylOpts7o
	Pir8I9
X-Google-Smtp-Source: AGHT+IFKg/LbsrHejgSE0dwZs6KKHgTQ1b+Ce+5+aRjgBSaduJ5Ti/PrdnFz9q/66tPjUgb03VmtKw==
X-Received: by 2002:a05:6830:6301:b0:7c7:6219:6852 with SMTP id 46e09a7af769-7cacec46f74mr2082792a34.28.1765396840749;
        Wed, 10 Dec 2025 12:00:40 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cad924cc54sm336222a34.27.2025.12.10.12.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 12:00:40 -0800 (PST)
Date: Wed, 10 Dec 2025 14:00:39 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/8] Refactor handling of alternates to work via
 sources
Message-ID: <5kulb5uk4uzn7gl4yhvnc4cnmqxzm2ngtezn5b5kkv33pgexmw@klqedekkink7>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251210-b4-pks-odb-alternates-via-source-v2-0-eb336815f9ab@pks.im>

On 25/12/10 04:32PM, Patrick Steinhardt wrote:
> Changes in v2:
>   - Rename `odb_add_source()` to `odb_add_alternates_recursive()` to
>     highlight that this function is recursive.
>   - Link to v1: https://lore.kernel.org/r/20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im

Thanks the changes in the version look good to me.

-Justin
