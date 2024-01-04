Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C3E28688
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 17:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="EB18+h65"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-78104f6f692so53368885a.1
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 09:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704389718; x=1704994518; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2oRm0cJwXJX6CqC1QukqT8AOYQvP+rh87Ngyu4uFJjE=;
        b=EB18+h65xwnyMahSWBkF1CX2C0BxHjWra5ONa+MIc6ItOgY1BhYjOsoS05WBzvYTHY
         hPpeJ3e7+zUKIQ8B192EnEaKbVJRX7XXsaSlspV6LqhCU0XSb3iGghdeyMqw47e/fdiP
         QLf6HxdLo+jFrq5OPFo1XmMtijP+88SaQKHuSxUGz6c1KHS1ta4E48SY2PJuIEspbwbz
         /iKJVo+u6N9iY5pUWNhcrQVPqcJlP8ZDPSizfq3T2UYDzyqBaBlmHiZNnC3rs6J7R1fd
         k0xaAiuGNqVMV2wbS02EbZtfgtdqlfwrAzTqFUDYk7HtTkK69pqhQP5n2IQB49m52tjp
         Ceyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704389718; x=1704994518;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2oRm0cJwXJX6CqC1QukqT8AOYQvP+rh87Ngyu4uFJjE=;
        b=NWCvCGxKE52mX9ltUqlEd0Ip0YqwP9lKI6o2JCpSvqoJLG6N33wNCbuyWgmUzrKGfN
         ZVsZch23wQBighafNsk250OhwnTlfO48Y9yvo9NIZ+d7e5oZZEavF2jllqVfwzLtFgUI
         Pp8XyNHSu8eYtXGZ11K8q64rbs8ySgXIPorYH2wCzFJ5OQDvecVRMPOHKPwjC0MFo8Ma
         gUIvJcGA7/qYyrjr9y1N2fbQ97fdk45ObpCY3tSiPrKIvT/bQl2pU/iRA6IMR+AX4s2n
         lxJYA9D0bwbKopDDq6H3a5BS/WMQez4uFt8urpokUumTZgsTr6rXQfGdnaUrlkZCj06x
         VE5w==
X-Gm-Message-State: AOJu0Yz12/5Qtm7tAufAdGGBL/GI2BhYncuj7yEu4G0m2PfvYpTx7/QR
	Ipw75G7vY+SwhZcjtpL8Z++WaFvom8+JdA==
X-Google-Smtp-Source: AGHT+IGf8/y47ZS5eo8le0U3hRNQ0dwsvQS9gJt+QeS8hYWhMeboxJ9pgg6FKO40DbAuLBuvVjetWg==
X-Received: by 2002:ae9:c30f:0:b0:781:a651:df40 with SMTP id n15-20020ae9c30f000000b00781a651df40mr1069181qkg.9.1704389718472;
        Thu, 04 Jan 2024 09:35:18 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id bj28-20020a05620a191c00b007830634ea18sm101742qkb.88.2024.01.04.09.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 09:35:18 -0800 (PST)
Date: Thu, 4 Jan 2024 12:35:17 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Patrick Steinhardt <ps@pks.im>,
	Chandra Pratap via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chandra Pratap <chandrapratap376@gmail.com>,
	Chandra Pratap <chandrapratap3519@gmail.com>
Subject: Re: [PATCH v2] write-or-die: make GIT_FLUSH a Boolean environment
 variable
Message-ID: <ZZbsVfFpJNQHGGEn@nand.local>
References: <pull.1628.git.1703955246308.gitgitgadget@gmail.com>
 <pull.1628.v2.git.1704268708720.gitgitgadget@gmail.com>
 <ZZUZNQqDTx3bnveJ@tanuki>
 <ZZWWLkY+ixg+OMM4@nand.local>
 <20240103184203.GA4334@tb-raspi4>
 <xmqq5y0a9qed.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5y0a9qed.fsf@gitster.g>

On Wed, Jan 03, 2024 at 11:18:50AM -0800, Junio C Hamano wrote:
> > Thanks for a nice reading - I can not imagine a better version.
>
> Yup, the flow of the logic feels very natural with this version by
> making it clear that the case that the default "-1" is returned to
> us is where we need to figure out an appropriate value ourselves.
> An added bonus is that the scope "struct stat" has is limited to the
> absolute minimum.  I like it, too.

Thanks, both.

Thanks,
Taylor
