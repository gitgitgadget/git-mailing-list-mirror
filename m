Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7E51B8EA8
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 19:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724958220; cv=none; b=tn5w3KzqVTRFEt6HKVLJCtsOum2/RiDaovaZVn4wEUdxherOTHZ8kF4jGHRERZiryQotEOrnb71/wSqQrYmhADfvP3aWha4GNAT4d7uGQ8uIpbByQ+XkPGpvb7LTd/DvLGAHpc5v4TV0tJG9oZENCJNupFWZ8LqAWDl5QWIkhfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724958220; c=relaxed/simple;
	bh=6oP4Vgp7BNr08ecPoA2NNQSKwaS1TO/HbZncv6kXaC4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nI3DG6zeBLudr5UsHixcVk2hVj/+Mh7rtsgTu/osg4HwhbDfndHs1ilLJ/uCKNyxdtE+/xcQP4V/1oj1MG+DL0udJJ5u5vOq4oQ6F5SLAg8YjQVUGd+LNc+iTUXeCbkh9HLJCMyfzbaDA8t6Sfli4IoaBbH8fDcOpAWiHyvqCi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=DyoKDjAL; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="DyoKDjAL"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e115ef5740dso1075582276.3
        for <git@vger.kernel.org>; Thu, 29 Aug 2024 12:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1724958217; x=1725563017; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6oP4Vgp7BNr08ecPoA2NNQSKwaS1TO/HbZncv6kXaC4=;
        b=DyoKDjALYEcojrDGJcMT59jAGbc8yZZtcpzVkS9/aQjwy1QM+YoaglD51zvDFdVrO6
         tjp47npdM1bquWgbCfqeV+UiDx9Zwt60c4HHgbvHv00AvGmiOq8FPR9a/AGSJRNh6QY0
         YVjrvIhOY8pdMAjYxrqz3mt60NqAwGjdw5JtZTaDhxJFZSc/NqkvyiYmznc+7ao22NPD
         hRMUN06MUQ+47oagzGCIWaomOtGIW8XaJ7KMonYDdAiup9aeq2EzGx2jsx27WnAnMOoF
         PRKI1GuXSRPvuln0dGQp2IsvIiv/W1/pGX2+WPfEo/45DQpd8tmFsZmQHuNIj56WbFpk
         oG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724958217; x=1725563017;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6oP4Vgp7BNr08ecPoA2NNQSKwaS1TO/HbZncv6kXaC4=;
        b=TxuFY6C+UpLVWs4P61qiKfyPlYFPti3Bi5ikvbFar4KEs8G1/svw5JZdKE607nNmEr
         /WzTSahciIPqKXtdGVm3yHjY9KkyRvEWtuiqF2SNKuGZ7zWifAZp8h31IvT/5XAmHwbh
         1Nyi4bFtDL4IgJA2DUszuKumEgyKePgHAYIQIR3cszKzS0j/g/sw4E9Kmi61JCLzy9rK
         bmAW0olg4w8veGISTF0ECSHep8sfZalZn6qrRIrJOD53txMXcYfnGFW3RsHeSW796wUy
         KYfYj89rQIGQbI/mX/EYAU3/SEIMqq3bgEZM6N9/C7zHRV4UIBwJX/SBjcpllFA77fgX
         EZMA==
X-Gm-Message-State: AOJu0YwnmJxo66A55eclVzrrxslT54xBqe6EJtCK9h1nJD+yNeAvhsfS
	9US231Rhq+zWXDlRYKA0PDlYcK9E+ZAQA64NiQIC1F6/7eIBZ3/p0VcaxpXkN3I=
X-Google-Smtp-Source: AGHT+IE7uvvUdV4r5plTO8pmArfD/Ra6ai4HsDo0G7DKgw7jJTJmHheL6H/d8YJMHwlZzdB90pzynw==
X-Received: by 2002:a05:6902:1504:b0:e11:6294:6012 with SMTP id 3f1490d57ef6-e1a5af15176mr4582823276.52.1724958217240;
        Thu, 29 Aug 2024 12:03:37 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e1a626f87cdsm341199276.59.2024.08.29.12.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 12:03:36 -0700 (PDT)
Date: Thu, 29 Aug 2024 15:03:35 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/8] pseudo-merge.c: do not generate empty pseudo-merge
 commits
Message-ID: <ZtDGB4otIjnAhiJ2@nand.local>
References: <cover.1723743050.git.me@ttaylorr.com>
 <c7e0ee0712034f654f018361f52c09b1043a8441.1723743050.git.me@ttaylorr.com>
 <20240817103822.GC551779@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817103822.GC551779@coredump.intra.peff.net>

On Sat, Aug 17, 2024 at 06:38:22AM -0400, Jeff King wrote:
> [...] If we really want to test them, we can probably generate a
> single example by hand (and we can probably even wait on that until we
> see something in the wild that makes it worth doing).

Yeah, I had a similar thought as you. I considered adding a test fixture
that has a .bitmap with a pseudo-merge bitmap containing zero parents,
but figured that it was probably overkill since this feature is still
considered experimental.

Thanks,
Taylor
