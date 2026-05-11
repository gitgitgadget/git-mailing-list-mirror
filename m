Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412AC2D5922
	for <git@vger.kernel.org>; Mon, 11 May 2026 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778482577; cv=none; b=A7FH2CQz6L28vrDp+Pb4axM05OsEIoWbjS6Y/zU1aXdwkx4Rg9Iebj/pd8tXINcpKu06EOly0tc6sPGlOsGiK3u4DYpjf1+8igflyrxuw/LTMptSg4Ssooack2nOZaEtMACS3KWCb2HXfkbAVBCO7s8+3fvGKMviTOlDrZHjfEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778482577; c=relaxed/simple;
	bh=ysuSHtlznS6zwg7QQJc1I23BfVlQfmPNbQq1cUibHOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WQvY6Xl3O7HQ4NjY2wiJN5yRYSZffdeF0EKV/9ERVNLi3sR30UPnOpbATeDvJVUoeH5SlQrnIKymxI/h7wS+rHG38kEBvqBFbhFelJMWpwdXCM3KhCN3MozwSoXKFR6uAYx1U1Ei+yh/rLuVpR9jeFYXAVgA6BsQReHioo+Yt2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmtSpW3o; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmtSpW3o"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-393c40246afso39806281fa.1
        for <git@vger.kernel.org>; Sun, 10 May 2026 23:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778482574; x=1779087374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MH+lF33lYyiCpNvzXZrfN4DDTKzxjXvu0UwsfCRLDVU=;
        b=XmtSpW3oKYRbKpMGGGPEnZSGTFV3BJUd5XaB8BuyMdVctkXF25qxGKVoQW21fO6JYO
         RMbDm/KNMA+6ezwpTCZ5bQWYYEENVxtmXjBh0/ZAsE0O8mr0NcrWw5MvMJJ4ftRkw4oe
         w1mnIrna1E9cuJoOwOV+A7RxVE7xP1JGuYe/IPK2Z/Wu+fq68mgQPIRE+jXE2oFGwVVu
         +62NhXWenmtCgjBPIrUYtRUsKfUoWnCH5r3hkWGjI21T2wojIIQdB4y3m6yiVfTwF+Ue
         F4brPv2uD9EQ6w3ypbUQ9LFMaZKb5Og/uJW6NZEl44ZAw9R7tiaZSCbKK3Q5YBxVs3v9
         tFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778482574; x=1779087374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MH+lF33lYyiCpNvzXZrfN4DDTKzxjXvu0UwsfCRLDVU=;
        b=IgGvIEcP1sNwMNBhfaTzwi3T/b2wPBMLPb2Ed6ujotBOVihIeykOBmT12P42xn2N6/
         VWoWr7rmThLeQPgo+z/KemrVOSwr5YQUP6dQtURSM3CmXybfV2pJMhCgbt8Ijj7WaR7c
         FEBdPR9YR9osZ94/F/Rp8Nl9lu0XzpuVfLuwaRwl0x4CnVTJHZ3JAHubAAEMP6VUscoW
         zplcKm+TxBYRQb6GPjA60JJGUIQOway7SIjIduh40IlBv8tXkI5LbfHO/MblqSzYwJxo
         DtT1Sb1pP88dJbqREmnlX/pQJ0TdjOlKLSw4i/QPlUiOh7jPjEh660LdjGp6ztCeP+8P
         2FCA==
X-Gm-Message-State: AOJu0YyKOLRaXoL8N/zpVeljZldhi9Amy6PwAdsbkVC+u6FBji7e0+CF
	EmSlX/2foecNDfbx3QjHRPEpe1irX9r8xKm8jLCvZ0Qrb6bBaEefR6XS
X-Gm-Gg: Acq92OEySRwyn6nCRHePK00ma7ARVn2Ga2lkNVRYfRYb+qCBF2Fjvb/ZsuLHu553fys
	ECxPuA/icGkXuPdTNRMinSugKgHpl8Zc2yzzAA7eMpkvZy1KxOme4PknLn5IOEmV9i2ReR0+quJ
	vE68hgpuNbMP2fqK1fQo7c5i8pIaA0rooR7l9f6oFs+mZ8Nbc2zGXQc5wGMrXb7QhXz8KdV2PBN
	ibEe0bMbxLnSb4XiBQkjO/52hQNLGRqXfr2Fvz4Xe7yn4Io1U3psgEjTRfcwMDL/fAOP5Vba+Zp
	U/uNy2+1zW89QgzAzcmbur8952Up90ot6a7w2potiqpWyLp/otFKSBZ8L/yonB5jOxb9c/ZIt49
	Huhq36XIUlO2z0FsCBKf9DW/HnJM4FTFMNIA6IhsVVgDWiGkzzRx2dgz8SuufZcJNK+xx5wRxbS
	yiiAnUnxfxVkhU+wqRazAIiFxzdThyLlsEq2P3X2Tpth3/uwSkoEc9efq7RHT/dOj0wGMoj0/ll
	KB7XgWszH7B5SIKgA1W4O2tqC/cQvER
X-Received: by 2002:a2e:8e6f:0:b0:38d:e744:8663 with SMTP id 38308e7fff4ca-393c4210887mr47504051fa.26.1778482573999;
        Sun, 10 May 2026 23:56:13 -0700 (PDT)
Received: from localhost.localdomain (h-98-128-149-74.NA.cust.bahnhof.se. [98.128.149.74])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393fa029671sm22884131fa.36.2026.05.10.23.56.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 10 May 2026 23:56:13 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	j6t@kdbg.org,
	kristofferhaugsbakk@fastmail.com
Subject: [PATCH] fetch: add fetch.pruneLocalBranches config
Date: Mon, 11 May 2026 08:56:12 +0200
Message-ID: <20260511065612.43515-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.454.g697bab966a
In-Reply-To: <xmqqh5oetzw3.fsf@gitster.g>
References: <xmqqh5oetzw3.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>> I have some sympathy for the desire to clean up unnecessary local
>>> branches, but I don't like the concept that `git fetch` modifies local
>>> branches, not even as an opt-in. Deleting local branches should be `git
>>> branch`'s task exclusively (at the porcelain level).
>>
>> Yeah, maybe that's a good point.
>
> I think the latest iteration was sent after the above exchange, yet
> it seems to have changes to builtin/fetch.c to cause `git fetch` to
> modify local branches still.  Will we have another update that is
> hopefully final to excise that part, or are we OK to allow `fetch`
> to modify the local state as an opt-in now?

Done! (I didn't know if we wanted to do this yet, or we still just
discussion it, but now I deleted it.)


Harald
