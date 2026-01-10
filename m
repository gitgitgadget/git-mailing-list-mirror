Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FE923D294
	for <git@vger.kernel.org>; Sat, 10 Jan 2026 12:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768048485; cv=none; b=VootPFF3hLobFoR6yUKxC3qG0il48q118oxnU+W8yM9+qp0iTu1SJ5ui22qU+D93AGxUQtKF01LBCzU79ivb+bnIKYlcBgJNVgU6oQiWoBfgZbDYCHUU49X3uMys7b844UZS/cH9x7B7n8UcGAQUt+QqEBkOT7tnlagLM23DA4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768048485; c=relaxed/simple;
	bh=jdOm6rpwbGqUog5P0zZC/UWdVvPhN1tMYJdQWsqTUuk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gu5vP1ziser9NHRq2PVLr266nfKnHCRayurUXUlDbiwExaETkEcTkrcFlrnbHfYOUVSI9OVqE0kwNfrfBcgGzFWSbI3LOsZs064odm6tPZRNR+5ju0FszUk6uxwzRQykDxek7ywmx0eTQkCt1bfjko/btbSOVrqeaPqC5+JjaLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPGuLQ8h; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPGuLQ8h"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2b04a410f42so4257047eec.0
        for <git@vger.kernel.org>; Sat, 10 Jan 2026 04:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768048483; x=1768653283; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xAGIsgXDQk9aFZnxS0ztu9iUJZfpMDfQEm6BIcj02zs=;
        b=BPGuLQ8hpVMVrPIqQ5SkTEafklk/XKLKRXHvv7bDPEsf/tGAsuszXzDuORHjzAgSZA
         krdjGMY1xhB6OM0gxQK/osNgc66mzvbWre1WzznZChypctRZW07etPMDZoLza4MDLChn
         yWBOR+z9ro+VgHNwMHtAPXbS78RIS3HweQRw2eb+56dbzxyBoEq+J1HFDIYTNtCesf8D
         Nkqtm0TcMNJ3GnYRsMNE34m4TUpPMh++3KteKAg/FR1ZxyX24WteXpJu9pNx71OpkMsM
         ZmuYjbPwQ/24svbLGik55axQTA1Zq6joUtbbyD2nkWZLa6kdmoxFj7LZJZeFE6aCMmf2
         jKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768048483; x=1768653283;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xAGIsgXDQk9aFZnxS0ztu9iUJZfpMDfQEm6BIcj02zs=;
        b=LF3IaJ3La6fm+3F5vunMM0BkZNfuL/QX7rdNGaHYM5ucwy8rBFrMcJXDZfs09QZs0G
         q62VpoHmwyK42Tjy9K1fFHicmG9ouOaHrJnpPKUCpmU9spn4AKlK86jik7ikiQ3Un2Fp
         n00cBpA6arSSOpik6HHWWdWWQspsPEH9hFGdLbB+J5xhCivfMlSLVwvWpnZKFcu5Pr8H
         R08dVhhsuBE542GLd+q8Xi5XW9SmT6SCaCKix2Mgd2SSaP+xjxZz9KHpFXSZap+Nob6I
         JLmKgVjYOCTRGsIXjNBkzo8eUgz33EKKsiJpxAGck3+oSs8IanhZwzyuwJNBWydGJFOB
         EASw==
X-Gm-Message-State: AOJu0YzBUzDMqhzJn8G0Aw5muBsHtQAaxl0/jaV/FM7+zxLJ+4fQl/En
	KpGtuv6Oc7z+wuW3BtdX8sRazvt3HZnZbr4RMuDAklM1+HmUWl826Cg8
X-Gm-Gg: AY/fxX6LH8LP1sR44GZObSN/mTwn0nGnYfmqwzXPegPNp0PKZ6n9nLO1Cx9K53t/gdW
	YFs/W1VXiXYDnHH26j1lOOcq/ENrFljVTTGS6s+GnBMAWXRmKo9Axfj75/qGqFA7QuM6pIaD/JK
	b/XLX+gVBd7l/FtAtDG6Pmjr88/anv0P1MLhYv/dEL+NAIGloeBT7LcbDqxTzFC35vM9IoPl2zB
	OclePfKJiPYUBWxlKkbvMrshKuB8zDLXd7yuodF4xj5UnuAnRfYZxT0A/uXPRzqwmk38tPVSTgw
	mFjX4t8SC+MxzNwz999lD61VE6svYPOFZFO32vimHDFdF8Mqa8dJMSfOnjCFxutoEqx4FH6hM17
	uCDdMV/555hVf8c90Ztbo0qhK91vApx6L53mZb2OhuR6ccqO3eOadC+aTStpGb5ynJVtC1CU4T+
	bqtkVJzw==
X-Google-Smtp-Source: AGHT+IF6cnFc5PcWP9ny9t1aqAn/eBCKwbHw1vEaYbtRF0TqjCj/mmkhs/VXAt2gYWHM5QuYWMsvtA==
X-Received: by 2002:a05:7301:4301:b0:2ab:ca55:89ab with SMTP id 5a478bee46e88-2b17d357488mr9085757eec.42.1768048482935;
        Sat, 10 Jan 2026 04:34:42 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53f0sm12628972eec.10.2026.01.10.04.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jan 2026 04:34:42 -0800 (PST)
Date: Sat, 10 Jan 2026 20:34:39 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 06/17] refs/files: improve error handling when verifying
 symrefs
Message-ID: <aWJHX2te19crFKF4@ArchLinux>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
 <20260109-pks-refs-verify-fixes-v1-6-3587dba18294@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-6-3587dba18294@pks.im>

On Fri, Jan 09, 2026 at 01:39:35PM +0100, Patrick Steinhardt wrote:
> The error handling when verifying symbolic refs is a bit on the wild
> side:
> 
>   - `fsck_report_ref()` can be told to ignore specific errors. If an
>     error has been ignored and a previous check raised an unignored
>     error, then assigning `ret = fsck_report_ref()` will cause us to
>     swallow the previous error.
> 

Make sense, I think I haven't thought about this carefully when I wrote
the code. I totally ignored the case. Thanks for catching this.
