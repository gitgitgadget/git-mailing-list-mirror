Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794164892;
	b=k3gG4wiXi+Ny7ScXB9QZ2wjzTTyisBN/UVokCFVPyu6DoA18R/UmN8syxKT9oahCXpnF
	 h0t1p3XOdnhSN7o+g87y5nl2u7huziOqYGdwUiNyhDj9LnJc0ONJwaoc58S6k+8p3iNZ8
	 4O7HeL7iA32ezUExjXqcOG/oKF4HCSmQj5rBTYB/wdYDLj0LIHgk18d88nVmjqCf6ogo3
	 3je1loSbKbt7Qei7cTc9Rc+xGhob+JX8yZxl/ck8iOWMDrOH16di4jBINHHUhWB6S+dnY
	 kukpKnXiYdI1fnHwkMlE1rvutdrQbbHCIIHZcYkz/LkUH/uUk0HQ0O+HayQm2aaRSIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794164892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Jm33vG1oz0qQTpyDP+MU6mgKo78MjVoQGHFQqY94tCE=;
	b=yQqNBUxvTHnrkWEzYFziFB0li8XcrOrAc556rvbu8W5LNS0FQ6USyQwQdCHEgagiD0k0
	 w21iZuzwnIvrJ2p7m6dJAaf72Ws0xWs9RkpEMBQHrJ7qWmQIS1eq5pcBHrzKOMyV+lOW0
	 St3/+YmerjBgf8is9BFTAtnF2uwCwq5TtHdCN+Yohu6l+rlVa+hi8N2PXKlDGtY1HlJe9
	 xIRBJzYM9auR1DFAJzhZqgHCI08r+84kfXP4xMNc2tuk9dmHkd/+Adp8GwsfI/woX4nsb
	 kA5BvlWdeNmtfJx9GDz5j7Dmb7ERlP9cebLm8HsiYEjIm5sSciFqzqjFpSrOPkWpAaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kFm6n61I;
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E562606A31C
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 19:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E562606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kFm6n61I
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1b1ce85287aso184069c88.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2026 11:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794164891; x=1794769691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jm33vG1oz0qQTpyDP+MU6mgKo78MjVoQGHFQqY94tCE=;
        b=kFm6n61IQPN29VaKp4RG3U+DUTh/hJ2qiyCNGqtW/tcRWKQQZbVDUtRTKbib5W5T/D
         mM9+IOkFGtHS2IZ0g7RmhFbosLYo991UT6L3tUJhySyAVw8ENds1BOFMwcpR0p9K0s6I
         533hm/EYQp1RA8rQ6Jm1xoyatd+TCMBfNddcZp4G2DlPWAF0F9mnEMAzkkmnziRGPlwl
         7817FV34+ECzxjWLTXXLzWHpBu0CkGzV0iislmxKXkr5eBP4ftMDExy/Iy/asQZwqZrd
         dzLHs3OJBFq0h2UHGjb1MCoEqGFhNnK8nsfoBXp11WwFE7KNH6gstTSebtKKDptyRFD6
         L3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794164891; x=1794769691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jm33vG1oz0qQTpyDP+MU6mgKo78MjVoQGHFQqY94tCE=;
        b=tpQd/GXKGFTMb759sQ4CTvhqQGHBOnv6F8A8nZ+szMaAlYrOzl58XhKkBkMPXxrEpk
         j8hlcC6zoOVOogkRnrDdWcdbFjp3P3pCa4mRkSr4X2bxc2DtQ/lIYeQEAPInhQjbMUjh
         juRXD0EmIrERa4K4jNdK3WoBW+7WuQVF8sN9DJhHvChWgGqOLSUjiualWN+sh1yrrYzo
         DXlUk3hluf/Y1mBY78IaNowzhOoHa3pgZ/h8sbuQx0X5LUklJKhjNbT9WDSx3sro/pRc
         7S9UeVQ0BaroEwgIhNydIQvSE/IMlCuP8xkYUMhGQKWiGfVE9QdAbpOINYdj2C7IzVPV
         dIig==
X-Gm-Message-State: APuU4Z951DyFCdiRPVOasG8+q3NBXaSBsXlxjeHCr4laSWhFz8ofQ2Mr
	P617USP10rA9+bhZVL+YnJ3MoIi9uikuQs0kKRPPQv1gWOwK8HqVs9Hk
X-Gm-Gg: AYBFou15oFIkIpjhknA1jKAc5AautzOa+4Q6Vyf3woyuUxsSUUEqspCkptsO5CeD7E9
	ReW6l5rfaHpeFZbmPopOpf7UYfcfd3W79C7o3M01BcXSgr7Uqo+3mSLhDyAkpm4AMWN8UB6z4B2
	Cd2HunLgHE+RPYf7WEN+Ze7FEhtrrWJrxCz7cKSGXOM4nSNwt9gnPPWkzAqMYovIp7e/jNv8iXf
	uc3hCSR29lMhOMwoAyDfsQ5BsvEHxIq+IwNjLtmSnu7gbIIcgm9aIgbidiIgYCXubIqa6Hdj/sG
	ucOIjxcDICpPCoD7WDyh/BRCHPVSWDqRzwHEG6BABGATZPzBT4raX6h5QNjUwPa5nkGLcImx3Qe
	DTXfHK4WNaVipmoh2cnmJyEKV5bIHKoRDUzNBuM2tJxtwrAGavz3iQm/Ko1rAB5p1z+e7sUq1/I
	27A/CiUawrg46xvOniWJHf1Q8qWbsvA4KJNzLE4sWXOoRThtZks/gLNkJQsa4tb+kKb9EGWHscl
	YyZy/rSbxBRFaypYb50+ktMlRPL8ok0FD5qgO8G4spW/T0b/VrSyP6oVlx9+sFQfnbt2nuZTeYc
	5s3F4fMVX3E/0anyfA6acU645h3FmFdf5lA41UQgixREXB5elwM=
X-Received: by 2002:a05:701a:815a:10b0:1b3:ac34:bd59 with SMTP id a92af1059eb24-1b3ac34bd9amr318597c88.45.1794164891350;
        Sun, 08 Nov 2026 11:08:11 -0800 (PST)
Received: from Anonymous.localdomain ([223.181.58.0])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3757214cbsm6733722c88.13.2026.11.08.11.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 11:08:10 -0800 (PST)
From: Hussain Sitamouwala <husainsitamuwala21@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	christian.couder@gmail.com
Subject: Re: [PATCH v2] doc: describe promisor remote fetch order
Date: Sun,  8 Nov 2026 19:07:43 +0000
Message-ID: <20261108190743.508-1-husainsitamuwala21@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <xmqqy0b32mcl.fsf@gitster.g>
References: <xmqqy0b32mcl.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Junio,

Thanks for the review.

> Please thread your patches correctly.

Sorry about that. I will send later iterations as replies to the
previous one using --in-reply-to.

> it is not considered good manners to send a new iteration before
> first finishing the discussion on the reviews you received on your
> previous iteration.

Understood, and sorry for sending v2 early. I will reply to the
remaining review comments on v1 first, and only send a new version
once we have agreed on the changes.

Thanks,
Hussain
