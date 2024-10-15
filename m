Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531DD53C
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 00:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728952350; cv=none; b=I1Qm3t8TKzlatuGKKhPhFgM6driJxrgUIr2oUnx5wyRlDadURD+JfXroEOSIioEKvAP1VvX7A8LRjRvVm4tZZYKGSau+2gZ6JJYHQX9KI2RlRH8N2dfhdyBhHSILqQKItxFa+O1yA9bZVkIDR+MKP+0FyOheqp1F8HnpsgQ2jXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728952350; c=relaxed/simple;
	bh=UpzoJPJ8GZFI1SaZlEvpDK6qzvTF8W7cPeWYqtcD3eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLjtJuu+26WJNtjTonTQb+PfIB1YsmPL7kVGUeqXTIkbk6j5Nycnc1JbPBTZkI7PAeCyJkkCH1fw48OJ4LR9wtS7CVnCX0YfiWAn9wa8TMFxFfKejUYrBeEhuAndxhZroMseKxfAKPm8XXPqdc7fGSzOcWYlG0qXN5K7Y5C2XZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=y4G7uQed; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="y4G7uQed"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7b1123f8f9bso511968185a.1
        for <git@vger.kernel.org>; Mon, 14 Oct 2024 17:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1728952346; x=1729557146; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qq/NgXsulepQufunDXxsRS954GLPzcqCZ2KyGcMXrn0=;
        b=y4G7uQedM++bVsOZFIe60uyR9L1iFvQA9d+y8RqZVoZR9eQAxBPwGgCnm/aefr9kqg
         QvohOSgMxfztpgb15KSDVl2oficU7v4pyN/q3ctS2uXiEYpIL7A1Fry+aQvkI11gyYOa
         JBcG6udRoyiSHG8efFYuxB5STiJmh0DmRVqdeAgY98kbrpRUCBffi6vq3s0Lhsl97akN
         Ovl1+6EiEYrn+IPSz4oGgYyv6knBhZjFPSRszxk2+jXruwz3BeR9Hc8zpwpf9sptd/Ly
         vT12HVgMJGoaIGUICdHvsE/YjA+Y4Yw8Rb9OWjq3kLmbDkamTfAg5jISEyukez9l6JnC
         v6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728952346; x=1729557146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qq/NgXsulepQufunDXxsRS954GLPzcqCZ2KyGcMXrn0=;
        b=w5BQogLjuT35phtIPmkZHL5LLPY84a3FjpbeIDkpnhpXUO7ZzjyWinMT2L0MD3jLFI
         I1rN3Em+I3IoPeczBdro2UCJC3hWjvPvY7CmUUlveQI7ev9mk/NWq5rIq+vwUB4xbdeK
         4Po47t+f7l+LneejLRQhHuD0cVQ0Wliw7AlRvCVKcWMifpkBc1Qcb6z+8b61+i+0Ug4N
         xnNTA5JiAt2V3BVlCEwhe8gxRDpQt2vIqB/JCUcspGpyRzJvozISOd70RDOTs8FdTI/W
         bkKs0paxyInWSA4xVxOukc+JRqlmUWXq/y9uuYG+hpRV/HrQRr//IL3Q05Fl7qZaawM9
         6B9Q==
X-Gm-Message-State: AOJu0YwcxjmjPJHo+GKdQS13Y1+BYX53TMEOh+k8gVnnJMFgfuosySxM
	qvyIQphlFdnBae7JeolhxSIWkXmRrA5EYwLlX+Kv2zFpu0gWUWLiJZt3ZxgcE58AqtAqV+WR88Y
	W
X-Google-Smtp-Source: AGHT+IHzaOYXeXgMqnvXofgzXXg3WLrDvyIkj/lfyYJVtkNM2WApJS/JpleZLtNju5Nmd/YmpKqvCg==
X-Received: by 2002:a05:620a:4155:b0:7a9:a389:c13e with SMTP id af79cd13be357-7b120fb9c74mr1846803285a.18.1728952346197;
        Mon, 14 Oct 2024 17:32:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b13617154csm9243085a.44.2024.10.14.17.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 17:32:25 -0700 (PDT)
Date: Mon, 14 Oct 2024 20:32:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jordi Balcells-Smith <Jsmith@cnsonline.net>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git bug report - CNS - Shared repository permissions issues
 under RedHat 9
Message-ID: <Zw24GJnLlqTuCOsM@nand.local>
References: <AUXP273MB050333B19CCE93899FE9F26DDB442@AUXP273MB0503.AREP273.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <AUXP273MB050333B19CCE93899FE9F26DDB442@AUXP273MB0503.AREP273.PROD.OUTLOOK.COM>

On Mon, Oct 14, 2024 at 12:07:07PM +0000, Jordi Balcells-Smith wrote:
> We upgraded the operating system from RedHat Enterprise Linux 7 to 9.
> This upgrade pulled the version of Git from 1.8.3.1 to 2.43.5.

Given that 1.8.3.1 was tagged sometime in June, 2013, I'd say that is
quite the jump ;-).
>
> c:\tmp\gittest>git clone ssh://10.150.80.53/data/git/cns/repo-parent/repo.git
> Cloning into 'repo'...
> fatal: detected dubious ownership in repository at '/data/git/cns/repo-parent/repo.git'
> To add an exception for this directory, call:
>
>         git config --global --add safe.directory /data/git/cns/repo-parent/repo.git
> fatal: Could not read from remote repository.
>
> Please make sure you have the correct access rights
> and the repository exists

This is intentional. Please see the documentation in git-config(1) on
safe.directory for more information about what this check does and how
to disable it (if you desire).

Thanks,
Taylor
