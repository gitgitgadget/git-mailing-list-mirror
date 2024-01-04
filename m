Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766A428E1B
	for <git@vger.kernel.org>; Thu,  4 Jan 2024 18:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="PHogGAuX"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-427e69f70afso12958131cf.0
        for <git@vger.kernel.org>; Thu, 04 Jan 2024 10:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1704392870; x=1704997670; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=F/i8Lys7H8rjk+Bc1vdCJ0luaHdcB8W/a62TZxeCEoA=;
        b=PHogGAuX7uGeGTc3+ESbf469vyGbt1tUbAPWpCoKWVn+Jg6yWime4bOrlfwDGGlMQy
         8sw6mVVw2Q8zHQ5fBZEdPR5jKb5h0VUIdAOV23BHv29Fhp41s0KioFtSZCWFjASuHbxG
         ep1FG8UQfPfWEYuBxL588q9ZpHwAoBvX+H4HxssaQlWYyVYEWGZVr0XABWOv0TpR/ASy
         oN9HyboSGhUEyX0rJ6oVn8SKku6YU/GwgdBhXlic+NEAS2+XFwp2UdDtQQI75HjU5GOW
         n7RWLvvHHtJCKXp1hYadSkUsPgpK4uEf2XUTGgl1rYD6bQAxfwV1SQqT2wbSb4mQAxYc
         ZwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704392870; x=1704997670;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/i8Lys7H8rjk+Bc1vdCJ0luaHdcB8W/a62TZxeCEoA=;
        b=WBAo2J0ZKMT5R54jl4zLWpop1ti9HvaAtZGjkw6DDVFosd3cZl9Q4QlYgPV19PoVxE
         BsfLwjYwepKC+yF6Ox5IEhPstnVpSAC92ki0nivT8n6sdtm8EQtEB+DUap9FmCHvdnYH
         fmsWOcsx42kFrk0NmGDslFQJSpe1tgYcrcD4r0pmTQcpg1Yb/iqGRM/bSyNbWXlidEG4
         vba2ON01qsGTrBOZlAEHzG6vvBDO6LBldmvB+2oKiJnca1n6ZJ+ZIRMgyQbqAddLjwFh
         WIPSeONaPbsJaMV6/rmT9sZ6z09hH5++921hAja34rQw9tI6zrGe+nVaJ5NiWi95B+0w
         eG0w==
X-Gm-Message-State: AOJu0YwoWwrGJ3gkRcIDuC3quVVG7ECskQIjLUBPtbseHoh5ZODaETWw
	rBi/+EeDvmflCI0DEc0pUZeju2Rwp+PQnw==
X-Google-Smtp-Source: AGHT+IGj+sVr3237r+YFb0lVslmn1wWBIFB7fFyw21szl1hFaZzCYUce3nQwkIga5wV0k7MAdPK+jw==
X-Received: by 2002:ac8:7d42:0:b0:425:7334:2fa7 with SMTP id h2-20020ac87d42000000b0042573342fa7mr1055481qtb.52.1704392870268;
        Thu, 04 Jan 2024 10:27:50 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id fc24-20020a05622a489800b00428346b88bfsm12558qtb.65.2024.01.04.10.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 10:27:49 -0800 (PST)
Date: Thu, 4 Jan 2024 13:27:48 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>,
	Chen Xuewei via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Chen Xuewei <316403398@qq.com>
Subject: Re: [PATCH] fix: platform accordance while calculating murmur3
Message-ID: <ZZb4pN/zR12m93L4@nand.local>
References: <pull.1636.git.git.1704376606625.gitgitgadget@gmail.com>
 <xmqq7ckp7ysl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7ckp7ysl.fsf@gitster.g>

On Thu, Jan 04, 2024 at 10:12:42AM -0800, Junio C Hamano wrote:
> Jonathan and Taylor, isn't this what you two were working together
> on?  How would we want to proceed?

They are indeed similar. I think that Jonathan and my series would
supersede this effort.

But I would appreciate if Chen took a look at the approach in that
series to make sure that we're all on the same page and that Jonathan
and I aren't missing anything.

Thanks,
Taylor
