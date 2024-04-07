Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7168A3BB22
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712513075; cv=none; b=arZ0dV7zQlyThENJ88Uf6xjaEbAf/Ji+D0Pr4VG0vaZygDDT9438XF1Wvu7GbBvHAibn2Wh/l2fmA8eHumXI2nSR2GWjrg8SOdkZ3l7xvYm8haUYw6tomIXYMmNEnsck0QFyQ7CYxPRkMQC3tb4LWYlsqzrCMy4Y+HZELxCIzMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712513075; c=relaxed/simple;
	bh=ayLwcerRnROPBERVhfk9kLNIn4coQqGrZQyNld02QBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhATeo4PiCLhSenahSaCyUexXolV0dyQYg8YCKOvjGOKH/loHEg+Ik0foSaMaaf4XpbOkX842Ta70+wY7EbxNfQXJNPWj4MycAvn1DPqd49j1LN03fulJcPNLo589yjrz3TUUcIwSttmXQooj+XG6mqmYH5H0MGrXWLJ8qc3dT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=BeCRedhy; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="BeCRedhy"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e6a1d24770so2180297a34.0
        for <git@vger.kernel.org>; Sun, 07 Apr 2024 11:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1712513073; x=1713117873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BUZek8RXJuezf8Zocs5Uq/6wYGlux6dAPQRKaFiV+hM=;
        b=BeCRedhyOAzuupE3BJIufimOcWMH1wfVcNV/syvnFgtDt+I+mLZJltLkCGlJkIW/Nk
         rgkiU9vbm/61vY++x8U9rFkWvdwksbfD76GYsReqE5CdG3qcl1orEbv2jYEXCg8GtQpY
         38nvZYXgT3bz6pjikin2wBMJdbp4LusrxwfGzyS0Dc4+16eIb236KvLje0pkGw8Idc00
         i0emanE+uauktJ8tVbhIH+ZSnauQBWNIE+cW8h7KFtCsQqCFYpYidbzOMbbxPuRwptLx
         mgLM28zDHFKIIVjpOQMlHAENpQlltruD+B09EoHMnL25khbezmqE8bMISzWC36rbXW9D
         3fYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712513073; x=1713117873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUZek8RXJuezf8Zocs5Uq/6wYGlux6dAPQRKaFiV+hM=;
        b=O+RzT0fZpBEr5yFuIpiJgfJomMfBcSXIM5mVdGUCIaHSzUhiyJt716BLxSjVVdopBc
         nBrOG0aJH+kz/BrOasMgyk33ECotoJiW4e5hEJ4j02TNIX5SPSXGS48crleTou+23yfz
         yy2nwneZd5lUdbcavtpuMr42r9Dr7LiPLhZhYgBevtvlYAC4vRNOXXg8B4AiPTBcDnkA
         Tkxtj/hqGLAzW4m//rMxwTSEq/JTJAwJG06TdGrPidbexiDUFJV7un6qevyx4r9wYAaC
         TDFB6lKENNkEv98LNBgfNrdk62+57dGVBS87hoHJwgqICoRMqWrLbmaNqbs3oHpFUUE7
         nWDw==
X-Gm-Message-State: AOJu0YzElg8mkmZWwdFweh4PlWlwch+M/lGXVzi4Zb6TCsxn5qAtklGj
	CTxeYEqK0GHWk4BD6ZvvUx5UMDIwWnXVgREAbUgScDRQN99F9N4uSAAKmqxmS+k=
X-Google-Smtp-Source: AGHT+IHL/7oizIjviNR6MUleR9UAlFH7PVKYk0LFxOKR9kuSkkhZRUQs2sXtgUVj/a/haHLOO5C+Qw==
X-Received: by 2002:a05:6808:23c2:b0:3c5:ecb5:4d8 with SMTP id bq2-20020a05680823c200b003c5ecb504d8mr4224309oib.23.1712513073525;
        Sun, 07 Apr 2024 11:04:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y19-20020ac85253000000b00434a9af16acsm22818qtn.6.2024.04.07.11.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 11:04:33 -0700 (PDT)
Date: Sun, 7 Apr 2024 14:04:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: blanet via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, blanet <bupt_xingxin@163.com>,
	Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] midx: disable replace objects
Message-ID: <ZhLgLhv4LRcYrm7X@nand.local>
References: <pull.1711.git.1712495507815.gitgitgadget@gmail.com>
 <ZhKqvA1NQwrVfnfE@nand.local>
 <ZhLfqU9VNUW+2mmV@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZhLfqU9VNUW+2mmV@nand.local>

On Sun, Apr 07, 2024 at 02:02:17PM -0400, Taylor Blau wrote:
> It is tempting to instead do something like:
>
> --- 8< ---
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index c6c8f94cc5..cbc543caad 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -17,6 +17,7 @@
>  #include "trace2.h"
>  #include "tree.h"
>  #include "tree-walk.h"
> +#include "replace-object.h"
>
>  struct bitmapped_commit {
>  	struct commit *commit;
> @@ -223,6 +224,8 @@ static void bitmap_builder_init(struct bitmap_builder *bb,
>  	memset(bb, 0, sizeof(*bb));
>  	init_bb_data(&bb->data);
>
> +	parsed_object_pool_clear(the_repository->parsed_objects);
> +
>  	reset_revision_walk();
>  	repo_init_revisions(writer->to_pack->repo, &revs, NULL);
>  	revs.topo_order = 1;
> --- >8 ---

Oops. I meant to attach a diff here that calls disable_replace_refs(),
not parsed_object_pool_clear().

> But by then it is too late, because the replace refs have already been
> taken into account for parsed objects.

Thanks,
Taylor
