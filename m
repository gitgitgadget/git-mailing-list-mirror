Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C50F3793B6
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772732573; cv=none; b=oj+kIhSQT/XKBO4i3EfaU9GeEmLtEcELQoS0tFlpBtztv8eA4fG/BWEWn0KDx6/iCALfzBAjMRe4yXezQ6ztW0st93jqkVIvvL0zqAtcLmaki4Ktjy1GdA50F/OUHCNclJ4PbMFNKnJFKPOBLzqPW29G2yNRAYHeYJavzX0xDMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772732573; c=relaxed/simple;
	bh=5gUNg1sGffvkBaY/qmgj5XHZzww+0Mz3hqj84o9NAKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DZOOlpnbNIgwiMHAG39wIAvDWxEtZgRoUnoxG1pqTumsjE8tVSA1o/qIRRX19Gl1CiFCIZydhdmigvhgQVlMZqnMJzdQDGRgYGVFjLsBDhgA+GFstiA20+X2xAOEIHzEiplxaqbZ6TmIYGAV9hcKCuyO8HC/U76da/e92JW5gZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d3doSPjS; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d3doSPjS"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d4bc9e48bbso3856481a34.2
        for <git@vger.kernel.org>; Thu, 05 Mar 2026 09:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772732571; x=1773337371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZgEk4YGY2HxlR2ENZWWttVVuz5ciVYlqx6cU1lDiujc=;
        b=d3doSPjSeiFcnwzmcfsHd3Bc/ibIRNqa/NHB2D+gLy8tkr+NAtkv2hbH6khD0Zrc4F
         F1HUQB71C2B+dW6lbsAxjpMI15PcXvqh7s9ffY6/6wAB2o0bVvt3ch34cIyBt9bJeYys
         bKgYh2sa5Kirari5cKbrSmr1cHRTVsIBX30QDkskH624z/1nKyW81fb9CGoM4X8xSFnn
         Q6GRNYknJgfyLF5Twyg89EJucRvXQwtDKsTnwXudJR7Tibpv4rkl+bRotFqROOjb6ecr
         PKnfs1OsfO6y4ZgiPIYeRFqDJGTYAd+SE1I+UwQo2awLGj9NJ5s5ax5wckV7JLrU+eaD
         13qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772732571; x=1773337371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZgEk4YGY2HxlR2ENZWWttVVuz5ciVYlqx6cU1lDiujc=;
        b=E++lOeunkyJkKYgckI3WoN+BfV0eCT1Zl9S6qVWzEisTApzRhuy60euKeZqpUqjVhT
         8xfbQh/CWPwo5z5+lLfIqQqGdsDSg6ndykMILJi5umQINurHbf4Ae/drWDhgwEmMh3Rz
         Lxyw9KrMryjiXMUNfaBMQRwWeWVO2TUmm5BxY6iyGYt2dGcW1/Yd3qz/AG3q6/YxBz58
         ZdyNk3rm8fWsbE06g9gS27cPNu/D7WnJJIJuygGG2/F06h/vI/Rr4h1GN0bmbWHMij2x
         Bheshuc8ZkM601tk4jx1Sm7k9QZGx36hYfAPpEh2x5Y1eCBz4nEjjdHycfqKTQUpBNjd
         /NbQ==
X-Gm-Message-State: AOJu0YwFS+yRY3poPQjjO8THoefe5kX3l201OKbg8d/VFIJDskR8jhZX
	Bom3nZCQ6cMWx6bvxH1y5R85lHxRsuKL0mGcwwcPSqyy8Z8e4pfMQKwF
X-Gm-Gg: ATEYQzzJAVkzUGzz1XMEBdRauAw64vkAyhfvge10I5snM2EbX3c3SijLVxfPje8ql23
	holbXPVZUpoVLAr/Ko7TJrIEnCwa6Q0X9T1O5Q7+DxGHSNYf4gab1mF9N0weL0nQZe47OEkzFFb
	CslVIjmOugM9olayjlaNv2Jc/Zv8ftzeA5c0TefaCmBWaMiPhKAeX4Ey93jLc/hdTqXOZlo/bBB
	gRr+ckCmP+md5Ob1tFmNvvGI4wjH0tlfPVT0yQA89N+htFa32moENRcA55fB6G2wTtXdi9i4Jr5
	KgLuMbtMWfxgwMnuMJ9hW2gQ/gzdTgpih2XCr27Aw1FFfTF1Kv/KglsuEUhg5Jy8wQabu1u8hEF
	FaAt+nO/D0deVH/leVgHv/BcgVMaQ9b5RXC6cJLXjo9BX4xb2beOCQ7bKBI2U5SyxorOIQMLeNx
	krdbeWzoppjtVk8FYS
X-Received: by 2002:a05:6830:6a88:b0:7cf:cb09:b7e8 with SMTP id 46e09a7af769-7d6da227b25mr3564096a34.36.1772732571527;
        Thu, 05 Mar 2026 09:42:51 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d58666ea95sm18043359a34.28.2026.03.05.09.42.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 09:42:51 -0800 (PST)
Date: Thu, 5 Mar 2026 11:42:48 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 00/17] odb: make object database sources pluggable
Message-ID: <aam6fRWqKMqpwoLD@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260305-b4-pks-odb-source-pluggable-v2-0-3290bfd1f444@pks.im>

On 26/03/05 03:19PM, Patrick Steinhardt wrote:
> Changes in v2:
>   - Fix mismerge in the base of this patch series.
>   - Adjust several comments and improve commit messages a bit.
>   - Link to v1: https://lore.kernel.org/r/20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im

The changes in this version addressed my previous comments. This version
looks good to me. Thanks.

-Justin
