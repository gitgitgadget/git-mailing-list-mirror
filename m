Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728D8BA3F
	for <git@vger.kernel.org>; Mon, 12 May 2025 04:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747022719; cv=none; b=kRDNZJTG3wOo9xei/jaiT9Tigv/5dSSxY8eGVfOyabIpgQpiP2fhpnLofZanT2AqVwf4EZ65ZiO55OsUWKPNdibkVtGb3+FNfHISXL2hHO+YZYGnGJZEPW/qumqG6FW7U5gaQW/jRVLiSy/9TaKJQKHNV9GgCAcXeyiCuCb9FhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747022719; c=relaxed/simple;
	bh=ruK207ayBPgZQpdkptfWGERFbUwBDEgdlJ85jmY1zxo=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=OaEM8Gbyvbn3eSYqRzTmvndPpvwRLx/L5+KFT730A4wh74okhHcOCAawDnFWoavRgyPv7TN5s29Q9Oad+8sVqr/V827l2M8VyMRfgb1sLWq++EkRqZufl+NlA+aDhDV+kHpDhm0zZZZ5XzeKGzM6XxTHh9Hc0sUzupy7fBknrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a8JRgIcm; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a8JRgIcm"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-30ab344a1d8so3785825a91.3
        for <git@vger.kernel.org>; Sun, 11 May 2025 21:05:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747022716; x=1747627516; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ruK207ayBPgZQpdkptfWGERFbUwBDEgdlJ85jmY1zxo=;
        b=a8JRgIcm56LbwOUO2jp4u4RmwrjR2IoP/P6DKjwqlV109yFKl/jwgNQmsbetGZ9u90
         WXLkPcG8VIL5x4bPbdlp/e7Rnny54bIg6m5Nd+svZ8LGbz8np4AZqJK8mukfre3LcerT
         BQnKxGbxy7sBelyqo3yLAoyrUouan6ZbTn+nHbj7W0n25S6GE3hI9tygjQ4GoMLX5PlM
         OL/oxtENuUgFW7yfDfGVweVTsCYyD+SLORzeO1w3oIySTWAJR/499nwDBaBqwk5B34SI
         2hC+xDtORPsqzCz6XGhZB//uSHDE6BAiv9QBnx/i/j61/EaTduvFY4ZqeAfJDLu5feOv
         tpDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747022716; x=1747627516;
        h=mime-version:user-agent:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ruK207ayBPgZQpdkptfWGERFbUwBDEgdlJ85jmY1zxo=;
        b=Yn+Dws+JhNGlG55AV2mDuzu2chLrFavDl3QSROR1/7hI3PmTD9RihQp80igUpofBkh
         sYW2Tx+HoLm1Cxp4v/Sa10tZhZjoIZlpUpCJKAg2I1daMwXg+Ijg2lxE0A73L7524VHx
         sR2XL63qmapE3xLkKjcN7r8tlYal+1NkggOeIFdA8SNxrXw0DR8O8X39pYg8QcsmhS8c
         RYC+am9m/FOl6TRMi6iPa1IsPQ0KTdJUmjoCNz7jxLHG575hQzfDDagPkN/FEg2+gm11
         BwDLWuZKlQvaNK4Trc9sT4NpeSwm/7uSXv/YEghZjrMOWMCbFwI43td2hSzw/duY2exX
         D52A==
X-Gm-Message-State: AOJu0YzdiCKcCZJ2ly/61TFc44ch5r1MTOTnqx61mILGelcrBPbFT/TL
	AiJkoM0Y1CRlXhEWYMvybkt4PaQIDufn3pq1CN8VReq759EsfpM+KOs28Q==
X-Gm-Gg: ASbGncugM7GRW8AOEUD66zpXjGk9FTSkKM0AVKAca1TE7XHyg5OHyLNj/wB2BHCR43V
	CG0F3p5B9yo5kbu5/1K7OKJ893K2mJophfwuzXh5zTCBzET+SNz7ANNUR8wWH/UK8lk+ZxKyXWf
	8R+yFaOuZ8QORrlcY8sIUVMO2LAXmLYdwJleuwwz904WBrMhmsV3HzCjWEiY4tA55uesaZHTc4M
	V3YfjbVAicfxbcMv8/NICLKq6lc7Gcr6KD8vHvLZZWCSSRXx9iUzotuKLIC7t6VeAOUo4oSiKq6
	gFTzNATyEPCiKMC2tqV7yioEHnfUQdle2ajltSSCaPlBNhI2ELrXTjjZSBzQi0WN/JxlAKFC5Ae
	zj7/hQ0+o4qENN/b1ilOn
X-Google-Smtp-Source: AGHT+IG9d0JUIJb5pEjTPnY6baqKMlixKTMRxTcmT0f8OEBTfEdIE94r5wDIUvrEj0JRUoPwou8zqA==
X-Received: by 2002:a17:90b:4e85:b0:2ff:58e1:2bb4 with SMTP id 98e67ed59e1d1-30c3d646602mr16291080a91.22.1747022716371;
        Sun, 11 May 2025 21:05:16 -0700 (PDT)
Received: from fedora (static-23-234-94-191.cust.tzulo.com. [23.234.94.191])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad483f438sm7837098a91.10.2025.05.11.21.05.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 May 2025 21:05:16 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Matthieu Moy <git@matthieu-moy.fr>,
 Eric Sunshine <sunshine@sunshineco.com>, Todd Zullinger <tmz@pobox.com>
Subject: Re: [PATCH v2 04/11] contrib: remove "thunderbird-patch-inline"
In-Reply-To: <20250509-pks-contrib-spring-cleanup-v2-0-14e20d95ec68@pks.im>
Date: Sun, 11 May 2025 21:05:14 -0700
Message-ID: <87jz6mo4n9.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi,

You said:

> The "thunderbird-patch-inline" directory in "contrib/" contains a script
> to send patch files via Thunderbird. This script depends on the
> ExternalEditor extension [1], which seems to be effectively unmaintained
> with the last update being in 2008. While the extension has eventually
> been maintained in [2], that fork hasn't received any updates since
> 2020, either.
>
> In addition, the script itself hasn't really seen a lot of maintenance
> outside of a couple of global cleanups. It is quite unlikely that this
> setup still works, and if it did it's even less likely that somebody
> uses this script.

FWIW, in case it helps any Thunderbird users, there is External Editor
Revived which seems to work pretty well when I used Thunderbird [1].

I think this script would be irrelevant with that extension though.

Collin

[1] https://github.com/Frederick888/external-editor-revived
