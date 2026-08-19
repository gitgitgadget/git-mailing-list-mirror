Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCA518DB35
	for <git@vger.kernel.org>; Wed, 19 Aug 2026 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171152; cv=none; b=X40OfJXK1L6gQ1WETGqtpv5bH907dnctCfWeigNSrCLshetw0LJZYWf37aLg50zKPSqn8jjhoWpO3cSNQZiXLe2f60vy3RUqwDEfBSvjUjzHbWrHgk/MSWTi/i4JRSNiilDcRyx5Ep8PC4PfFCNt2qrU1XpInkiUVjWjO/ipvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171152; c=relaxed/simple;
	bh=eg2OW9omDyLaV+5Hb4zq3QcIUQ2FJ/FGR8l10wiTr4M=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S6B3d1Uen4IJB2LB4zQ6+srZBLmZVuG+7GFzemMDJs/kLgqFQJVxtUlf5M2QWFQqojIc7p7IuBbNfnqktPJaHT3rjurX5dnQoxzcaNnA05aMFmGvvqPm/hlaqivhsHKd8qqR4Ind6sFwepdO1p38+Ga/SinTJH2XOm2GZtWLeQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBfcGTr5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBfcGTr5"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-47f611b3af9so153456f8f.3
        for <git@vger.kernel.org>; Wed, 19 Aug 2026 13:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787171149; x=1787775949; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uerkz+INBd4jZst5wJxeOVpzdYwH1gzB3TJMDFEDJ4I=;
        b=bBfcGTr5eIVXCj9jHZV9tgW8Vb4O2eibBm/50qo4BDozm/NrncqavvIapiviBqVW4W
         1OFfMIzPhNOselQWWCPAZ0STlvInPYKXPtgm/KphO+uWuiSc/8W/vqst/pcaCqR6HdkA
         OWd3c3IJxHqWl4ivJQ0O05/pOBAyoze9nFxilD+DRqFc1tXRjZau0mukltbsiEEKGt2a
         yBVbL3OzY+Cz6943BvfyTLDL2DEUyGgZsvlbfbhzWapMKa6+i04+46KDrJzp89+iuNfN
         u0cm1hwV4gwvAGuiytikGFW5ThifhrsKl9nWqXvSYnDVGC1Ot+PqoSFNeWSV+67xNMwk
         fJ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787171149; x=1787775949;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uerkz+INBd4jZst5wJxeOVpzdYwH1gzB3TJMDFEDJ4I=;
        b=DEc4IcB4/vbvqAvqPZYWyZpx1t/wt8krRhGthDyL2R9Q6FQab+Vl/FgxPf/Z5JmYhZ
         gMXO7o0DauDsRs/+GZ3TsI0v91/Nj26JHbCHwc2G5NBVYn0B3N/MY6gmRu8kba7D1GmU
         gQswo+d6BcK9iqyQfxsTedZ4W74PUDVGKwaG8J15N1fZTmgZ7ayMLcwhhieO+6VzMdsi
         ivl9CKmZ880nMKunvBcyJ2HcRnuJ1ag3TnMnhAdNIUnE4putvhd5V15K5a+/OdR4e5pb
         R8QVlFeWvRe8Nmmrp14W72cAOPDELcPPfnIsXz8Agv1+tBwwK8624Dd+GIbgG1TzN8Ui
         QX5g==
X-Gm-Message-State: AFuF++n7BfEiVCUBl3aejFqfsmRPWUVTwQTEBnB/VDJ2wiFJKBOc74eh
	3XJiYtFw2/NrRMzC6vEPwIGOHAJWw3ddruwKoidzIHAVrNqa1hyMQiHyAYorT1eE+50=
X-Gm-Gg: AR+sD112ciFroCsgOSZqrnDmy2HiTSrONf1YC0VqB7Xw228RGsKZ1IK8hf0cwy94LID
	Pr529eBfY/LkJMbyPr8T1y0thIA2S4SpV5Jd8ePloeXIx9tx95kDdqZUPNYgSjHGKuKHXjsj+Lq
	23l2BUPe6ij32pFKxznLbUExESeyX7hEn7eulmtn6iSI70Q6UmGxNzk/HJkk6kUzjli5W5hNZnm
	iHExnDubBSbaE7SejfNvuobSmVf/Ad54jz9IdVDD9t6XogWUssLqEDelGw+tdSAXJHnk9uJT4K6
	UFgc6bGWeLXGTCkrNpq+eCgw6TunbsjuztUxaY5xioqYDM1sYmSBAypVDRUO8HdkCgNdTJtvAqK
	jpcfn63x5kDnw3zzL/q7ZIOuCKkFynGCIK84aJA5sMSXoXG419ohPssi+gnw+HyIrcwnxXEUDcU
	E6MCIdI9fOMetPrDZQ275VPSOl+zWDuLvPglfpKnkxAorVIPrpC9dq182rvOVo6mqS
X-Received: by 2002:a05:6000:41fe:b0:47f:959f:d5e with SMTP id ffacd0b85a97d-482b1e0a2f0mr6408628f8f.0.1787171149111;
        Wed, 19 Aug 2026 13:25:49 -0700 (PDT)
Received: from desktop ([194.127.199.68])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b14415ecsm7365509f8f.7.2026.08.19.13.25.48
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:25:48 -0700 (PDT)
Date: Wed, 19 Aug 2026 21:25:46 +0100
From: Matthew Hughes <matthewhughes934@gmail.com>
To: git@vger.kernel.org
Subject: Re: Bash completion very slow in large repo
Message-ID: <aoYQ9CCzPM3qKVfZ@desktop>
References: <an9iXOqOOvFfyN4A@desktop>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an9iXOqOOvFfyN4A@desktop>

On Fri, Aug 14, 2026 at 07:55:36PM +0100, Matthew Hughes wrote:
> I'm not sure about potential fixes. Hacking around on it the best I could come
> up with was a workaround: add an env var to skip index completion during bash
> completion, so the completion falls back to the default Bash file completion
> (i.e. complete any time), here that is (just for demonstration):

My final workaround (read: filthy hack) was to re-define
`__git_complete_index_file` just after sourcing the completion script like:

    # copy __git_complete_index_file to __orig__git_complete_index_file
    eval "__orig$(declare -f __git_complete_index_file)"

    __git_complete_index_file () {
        # options that require 'git' to inspect all files on disk
        local slow_opts_re="(^|[[:space:]])(--others|--modified|--deleted|--ignored|--killed)($|[[:space:]])"    
        if [[ "$1" =~ $slow_opts_re ]]
        then
            return
        fi

        __orig__git_complete_index_file "$@"
    }
