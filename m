Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE36C37883D
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 17:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786640994; cv=none; b=EHOLzteg62Nqw22QFtLq7iUUfyPY8USLO28AbpT5X/eMni0O+zZI1An/wwfFqNRv6CzTRHvJQtskGvDxCyqlnwv7Lp8rFwJFNi6bx9GWSF1iH3bhKJTpIkKqhnl13hp9WzdlDMHKLThx6EEyM2DmvgygeXA6y0zc9mTjKaCznG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786640994; c=relaxed/simple;
	bh=OEReaA4c/x+/+qgtoiasVGitrOxFv9n9urIWBzGy8e8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SslJN4uXFAXfKXi0sqiNTVWPhv1oJdcMyE7Yd6biu4CJL4kjjVFfzKp45VYgix/WpXMWgu0MvvjVkXS2IHPVDMnGp1AIvLpJHKnWdYXKTFf7hP6JhFsdEX6hn76YJXKZjj9S6JLMdD2vD+Y2Bnf4FR8Jww8VyQbTNowAdKrQxCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAm7ZXgy; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAm7ZXgy"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-6ae3faeb9c3so100113eaf.1
        for <git@vger.kernel.org>; Thu, 13 Aug 2026 10:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786640991; x=1787245791; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nIi3EfGBb/x98Nl3owT/WarmWO7YGf/RtUpMXmmGIBc=;
        b=nAm7ZXgy7HKVZOTGiGO1uVQA2So+fwl0Ys+tBIGSA9azRzKF7chOw80Xv4nBMOCNcC
         tu1KGC5nzbTf1aVXbI3Ey/Na1MjugWh3tAVFUHMEeFWjIz7ESlhCvSkqosvsfjc5w69M
         O1XaCMZfoJdp4PlyZUO88tgRqXrzcLhQ2eEmSou0RzUZ+hiGDXTTqznqdDrO3UzPmhsO
         digZrzZupL7kIf7vyWAd+Xxk3ZsYoEXIId376bXjaIQZPMlRJZkH8BxNHYmoIRlYxflJ
         TyHaBGlXzeWlYCQsgHa89kUnweRkhKYZJ3hww07Zl+y7Q4b3tnJPR2ZEedQPLGXkxedf
         q1iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786640991; x=1787245791;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nIi3EfGBb/x98Nl3owT/WarmWO7YGf/RtUpMXmmGIBc=;
        b=ed0AQcYcI/UoCdJ+anQfX7WCb5sYa9qobOZvAFNatZXQJwl/6i4zUiuY0oqfn2Nbq0
         mxQSSMUEJNT/o9hHXFpUlszLeZzJHLMSDsXknxWf+xaRvZp5w0sUyYxh7lzOUmcaVj4J
         YhL4qDPiUcCfeBdIUrGPm93RIXAe0+SJ8gOvQ/YN4ahnlSpDUWR8xzgey+5R+I6YD1R+
         mvmc0T+BrkPf072JXyU1r+b2bgsSZacvZyB2ZTWJjv86nE+w/tUbYpMykuwiA7XgI2v2
         cFRjXFIJFJ9edjM1kWrPpCPCbKsYfmH+lJdtZ5m6l57BSsB1cciTnsIgFPt/qcDWx73+
         n3gg==
X-Gm-Message-State: AOJu0YwIaGciWCn50QLP42QJWeD3ukI5qX+uD6yOJYvFWuiWbTLNwF/a
	SK3wG/2/Nqvogms3fjS4pifN/101+0dn8A5G1MijUguetHQG+EPt+B7acNLBzw==
X-Gm-Gg: AR+sD13Ht1YeIyzU+u9qPI9ZKzAHTlz1gcWDH9gjappgR050Glq7NBc0MLxlXPStwmr
	LjKgF0RzEe4UtzaDehPQRnzUJLrenbzeUcHm/BXyJKafmW12lIfmy0q9RC7CXpjP+/h6vYQ7wUu
	YihS7dy/aWwnXJVafYj6BIv1JP6Aa/eFdhhQJf9vayiz+X7ITvCjUNMFBD4MmaLuUSHafluhPS8
	J1EfDl1rFHqsmnWu5cF/fSU1FwxAnClxhbCkg8VlgZfC+JzIigJqV3rQ/Tze+chbdhCrzg0hdEr
	PPCfezKSzfLno/ZdGxMi5kQF+BQfaUlDipCAO4f3cDXYABqBDEq35yjbNUi4bjAF/nyKu/prJW1
	IK1/8PGn87kzuurD7vH3wSvWVO53yl4mViz95bpa/p88yvdRQVHkiapaGmuTFEAY2rwxkqtKBN9
	G0CGXkGmSLEVeHd/XPVIpEvABfxfHG/TUVKcTzzr3gooivCHQRHxmCvQ==
X-Received: by 2002:a05:6820:2216:b0:6ae:941b:521c with SMTP id 006d021491bc7-6b0c4348c78mr5869084eaf.18.1786640991475;
        Thu, 13 Aug 2026 10:09:51 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b0c46ebf8fsm2750617eaf.10.2026.08.13.10.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 10:09:51 -0700 (PDT)
Date: Thu, 13 Aug 2026 12:09:50 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] odb: eagerly load alternates
Message-ID: <an36BA_Nw7eLAKYC@denethor>
References: <20260810-pks-odb-eagerly-prepare-alternates-v1-0-f0fa4a4004e1@pks.im>
 <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260812-pks-odb-eagerly-prepare-alternates-v2-0-522b9a5bc1ea@pks.im>

On 26/08/12 11:13AM, Patrick Steinhardt wrote:
> Changes in v2:
>   - Add a missing word to a commit message.
>   - Explain why we don't have to handle GIT_ALTERNATE_OBJECT_DIRECTORIES
>     when re-preparing the object database.

Per the range-diff, the changes to the log messages in this version
address my previous comments/questions. This version looks good to me.
Thanks.

-Justin
