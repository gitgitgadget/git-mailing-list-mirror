Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204203803CF
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774896636; cv=none; b=IHaH7cL4xP464XNSEX6nJs3L/pVr2Vqpk0k1lDQ9czCMwbR4tG/m93kCBN5NHayF0g/FpHLt+T0XGbj8pOcm6BOkTsjyBaYbaso4ueV5YS30gmu2QL67Nto5cdLud9f0JNq4yGfoVmgYy05nGTXznm/EH+NyC3HDpUILSZx+A2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774896636; c=relaxed/simple;
	bh=SAwEWRSsS27ic/kp7UNoPux8JZpmWevI3nnzRS+VMuE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fwh/P29osryCmuRzgD8EaaS9/iw6WrlHtjNTNuOJJe+6Kk89WWEfTT0pw835Kv3oMmrE73MooHA/NM87obtCMDmp+cc1RyYYQrRhSR6MwcHygMBseGzyA5kXdY2mmZj/6KRcSKq7m9pYoW8oZKClGbo8u3xgyRyThrgyWzCIOaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NzY6O1xs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NzY6O1xs"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-82a893d289bso2105461b3a.0
        for <git@vger.kernel.org>; Mon, 30 Mar 2026 11:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774896634; x=1775501434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z8HSB+VLKN2oob0y3NoJPp1lAhn1h8dxsPUMFaeSnRk=;
        b=NzY6O1xsKRNAALxjicTSfemwdtoau0eQhxpUD5L9p+4HpWl5Ae24O4+ouLEAvZrgxC
         MThd4Bv1KtaLjOJZDGR8yacj8XRX6nwKZG9RP+ZrBKK7pPaQ4xUlqc3dz29Tr/fmhX+F
         fo6GmmJIe+1lsrs4fQg4U3i5PPPuEa5o6MK8oVzVpdFk9gWRey40v0O5BnF8aQu1+c9h
         e4TurB7XLnf8xLikjzj+EnLIbvi7GQ1hl0nNhbAmdWy5qlG/2ET7Ot7Tz13fr6rZk3ca
         gBmiURT3hIu6xx7/KErR7BlkrARgN4MT4VSy29uVGsWPXZ97HcbD5A/r/NDcaB414WRr
         wDzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774896634; x=1775501434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z8HSB+VLKN2oob0y3NoJPp1lAhn1h8dxsPUMFaeSnRk=;
        b=cR+kuuPW5RrohSg7dc/TqOkmWCgopXMPbr1nOyVjOH4zzat+AMYwDQjSJNvopq983y
         ms37LqQ8cnhrjiDaFkT25Vq+ddBxydc5qamqlVOL/EDseRHC+6cbSIdDVO2W4Gxt0xS6
         xtXj3y3L/0QGImJFA9w80u3VV+Z23vXRE+PfCuhjLSYxVdz19g12/n6ikK1fhF4A1j1b
         PqVpZDDS5pOjCiCeHx5ICkwsAyBICifURDnUx+xGZxoO/SLxUX0q2VMA1mPG19nGzE7q
         x64u7AjEPyHk8YM5xnERtjoe+Atuzl1HHuT1knOjabwTUu3pWJOeIvYSudc8nNzRpjY8
         0Lgg==
X-Gm-Message-State: AOJu0YzsF47N9YHXAI7ZiIIpoUOXqZngMDQSsGFpwLJ5ZVcPBUgOHpOP
	PSDTNIuFXpoHMYvMObhD5ji0nZavfhmzDEhlg/Hgmh4BcAHTiver+jxhvSQ7fPflxBE=
X-Gm-Gg: ATEYQzz4AyKVaLsgJYjrbNZCA1pHEG3VryfxAUqoNsiD3orTTeLhq0x/T7LV298ahcq
	PK2QjULlJepUVjAq4wKT7eVVmju+5Sx8KqGRbUtFy4sMR1cANpfQkRf5TaNsAbDHf9vI3zgbc09
	e7/Y69KJVwE9cW5xMlZ7BQtfkz+alqOXkp7PkMaetNi2oswG33px4DU95PwalhhXlneSvIHzd73
	73RFzdFznZWYpEz/hYj+6yNlNpbNE1nyOgMkCnuzeHVszzITZGpzXNDDSt7XaVuPkJqBe1vsZFG
	NxKsvs+7xw3cCKfq+7c4hPWrWLHOrI15sgjaeKU6ZkGxV8+ozQzuWSMX19WI3ZbJxg+1VkhN944
	XRN81rrJtsfMMsg3rxiL2WkOWMUl7N9QrOGOAY52CHcZML1yMAhT939KmE2noqw40HMJVPnXCkV
	VcfO2FwK3p6uYjDlKAd42i/XD3gW8EGJxPbvGMpFk2ow==
X-Received: by 2002:aa7:99c4:0:b0:82c:9c5a:4c32 with SMTP id d2e1a72fcca58-82c9c5a4e54mr8898466b3a.6.1774896634372;
        Mon, 30 Mar 2026 11:50:34 -0700 (PDT)
Received: from localhost ([42.114.23.29])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca85ef0b4sm8077028b3a.42.2026.03.30.11.50.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 11:50:34 -0700 (PDT)
Date: Tue, 31 Mar 2026 01:50:29 +0700
From: Trieu Huynh <vikingtc4@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH 00/16] Microproject: avoid suppressing git's exit
 code
Message-ID: <fgbqroyrek47qqnzyeuhbijonj4y4h24kafwzs6z5om52lxflh@3on4ynvhgxf2>
References: <20260328200255.247759-1-vikingtc4@gmail.com>
 <xmqqpl4nh3b3.fsf@gitster.g>
 <ftwnrutdbvyf7phr4ad76agt2jvzgieqnxprvmoyw2vzwbhgqy@z4x2g2n3ft4r>
 <xmqqbjg5fjls.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqbjg5fjls.fsf@gitster.g>

On Mon, Mar 30, 2026 at 08:00:15AM -0700, Junio C Hamano wrote:
> Trieu Huynh <vikingtc4@gmail.com> writes:
> 
> > Ack, I missed that point. Could you clarify how many patches or
> > files changed are considered appropriate for the microproject?
> 
> The end product (i.e., a patch that could be applied to my tree) of
> a microproject is not expected to have any value to improve the
> project codebase.  The process has two objectives.  One is to help
> new people experience the end-to-end process of sending their first
> patch, getting it reviewed, engaging in a dialog with the reviewer
> and communicating with others in the community, and polishing and
> resubmitting the patch.  And the other is to help us see how well
> each candidate can work with reviewers and others in the community.
> 
> The size of a microproject submission to allow us achieve the two
> goals may ideally be one-liner change ;-) but it may be a bit too
> hard to gauge the effectiveness of the candidate with such a small
> patch, so in practice the lower bound would be a single file with a
> few hunks, with two paragraphs in the proposed log message.
> 
> And we certainly do not need 16-patch series, each doing very
> similar things and likely to be making similar mistakes at the same
> time.  Interactions with reviewers on just one patch would be
> sufficient for them to learn the community norm, and for us to gauge
> how effective the canidate is, without doing the same or similar
> exchanges for the other 15 patches.
> 
Hello, I appreciate all your kind comments. Thank you.
Drop this series here.

BRs,
