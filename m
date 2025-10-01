Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859431531C8
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 03:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759289449; cv=none; b=ZAFC7EHJvIe+aunSD5oyPxhSC+JuCOzgWsHekWMfqerta8gF1F2KVnnUFvNbeJtliFki0EsLScw9WWiws0GDKJB/K3z7aP9E63xph5LnEJlj0LACmrjS3QxFNVzocWhd8Lx9V3sOgXIgwKs2F8d+oq5/y/16XDtHqgz5IlF+lXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759289449; c=relaxed/simple;
	bh=WFcby7g1UvMfs3CF+aci2HAfc2W13cTNCT7Gy7GPFVc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZbiUt3oPcm/sHXGiifE8tTNz5cxNo5P+oFGMii4X4xUcTzaiXBYya+aSLvBvUlaCqQXxexXBaCZscxYiBj+yS8yqfEG+QhMfkth8s9nAcRFZW6gmNhJPK1GS+mg3jnlc1ibOGqhIeOnlQBQ1d+ID0YmB46nI9hc3493oPw4xlCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VmvXhDyM; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VmvXhDyM"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7833765433cso5086837b3a.0
        for <git@vger.kernel.org>; Tue, 30 Sep 2025 20:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759289447; x=1759894247; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WFcby7g1UvMfs3CF+aci2HAfc2W13cTNCT7Gy7GPFVc=;
        b=VmvXhDyMkmSGtrbGTWUeuYGwog8Frl/vjjWCX5LyMZ7gDnvQFqRmaEZd61iBnTsBep
         r99/f2DctIGtajEdAMzR/EA7Sfh1M8aVd3q8e0vev4OcJVegL67Ez5RZmUWlmAiKFbAx
         DVLBUhMs0NmTbhzPKJDhxuc1TbgZdIr538G+lfaO1UcG50C54sck18UjDRmfIBJb2xmQ
         7m3v/DBQh+9Qf31dAi4BHIAn0qmyl2L1Gs6nIWxsJlC3YmbKmEvB3Gk2u9LlurTsqnua
         et/7Kicmwbevn2CcXJ4rbUud4lhM+Lb+hMSqxZr8Nib4qNW99u2HlSMUhFM3D6daGAey
         TDng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759289447; x=1759894247;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WFcby7g1UvMfs3CF+aci2HAfc2W13cTNCT7Gy7GPFVc=;
        b=MafV1lO3LGh9Km4lSMd67uju0F+1cVZQpQIH2S7iIFzl1lGl1mKay6VmbNTmSPqGPU
         Vwo2/hoe31WTYzZJpU5kCSRvNEApfKs+M9hBr09oWss0KkQLVfCSMvE6ueJCgjdR1npL
         Rzq8qbgpQvkURz8pitgz7RwNNXrfst7DdrDVM0g3w5hZ2GoqcC0trPlEnx2v1dg4zNOw
         BQY+yGk8LDGIs4vGnWOU+XYD1otDAtW8soBXIuwEEvbvPl/ZWxF5mERxMZvnkA63O867
         BVKNW44YaF26AEpTzo/ucvj6ivwyq3/dP8cPWlW2itR9HCIbudZpp0Afu0Ox4GBoMfjs
         r6qw==
X-Gm-Message-State: AOJu0YzswouMIORrk3gxf5VVnonxFbBncIvOUvD+kWQ8pFaAWdtQkguz
	zHhK+u51/gDfWkOD8kvOk/EI2hj8Qk5vpoRIUpLuBAGiWZcLYQy9KSill7GPnpMC
X-Gm-Gg: ASbGnctLujQYoIbqbKuXNcWZGx/E33QGLww9nFlfJWykryf6uwOVmp9iRHWpexsafWx
	+XxeljI6hWTq+PJBaxwr9pABAtmBN6yswoI+phQNcVqN9P6MvixGCybFeCtTcmRUve36OqMSgm7
	1Sc1WzGI4xPt75KgJgDmbfuudLtvfaqfdaFPGVu8RTQDb1oFVMPf39L8d08yZHOdO0bvO8Ak7ur
	nLzWlNDqaeEeD3Y/aVMGISlXXqg8jWZyuOSde/rHQXQLob7ctfDYxMmHIGDDMjEN1l2+OUlxBTw
	AJgNCdca9/wzd8XBAeZJcJ4a7cPYfLPB6S+dybLCP0M/dzfZ6fGVALXeicEJtjw7nwwUvAjYueD
	MZ5cnGM/6gYyaTHOVQkofKk5V55hUeTlLqKViYzpdEFe8Sfkr
X-Google-Smtp-Source: AGHT+IF8Jdb43wiiUWZr5aqHeVc07kgfnneN+c/F4uw2gfx9JINwa6Vm0YWUrBoNXaaVLptMLlbnxw==
X-Received: by 2002:a05:6a20:9185:b0:263:1c48:912f with SMTP id adf61e73a8af0-321cf4173e4mr2735442637.12.1759289447395;
        Tue, 30 Sep 2025 20:30:47 -0700 (PDT)
Received: from localhost ([2804:248:fd27:1700:3621:b550:5c5f:5497])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b57c53babe8sm15151854a12.6.2025.09.30.20.30.46
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 20:30:47 -0700 (PDT)
Date: Wed, 1 Oct 2025 00:30:43 -0300
From: Henrique Soares <henriquegogo@gmail.com>
To: git@vger.kernel.org
Subject: How mantainers check Git diffs and patches?
Message-ID: <aNygY8Cm7LEaBzV6@localhost>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

This is a simple question I have related to the PR diff review process.

How Git maintainers use to check diffs and review the code? I mean,
sometimes I see that there are some large PATCHES that is hard or
probably impossible to review only using e-mail client.

Do you use some syntax highlight in client e-mail; any pipeline that
automatically download e-mails and apply to a local branch; or for each
PR you save the e-mail file then "git apply" to review / test the diff?

This isn't a technical question, I'm just curious about how you do it.

-- Henrique
