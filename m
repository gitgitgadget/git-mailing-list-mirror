Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156D63E8C7B
	for <git@vger.kernel.org>; Wed, 11 Mar 2026 18:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773254067; cv=none; b=Ny9ImuG4vKJYFvMgAfJBqyXvQVZWKNjYjESi0j3PzAQ79ibHYBhGQmLCYv4IWCHWWoiFkaWUe8GAoSLzahukm0QPc4OYUr9ZIhXzeqPhXQukBQt8juAtGbac5QzySJvdlutpYDOccjBghg68rzCiJT9OEqJl63bPIQS0JnBrR6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773254067; c=relaxed/simple;
	bh=VMkDSmkawHDqMKiUGZzE3i48lXhkkeZW2Fk4XOg5YFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I2kDryhi4zzppTn3MGQtxqO0Z545zzcGBKc6r6SPSXN+ZDBrxGIO4UPu6S4nL56a+z7m8QJzj/zEpbZ3pvz/EihchMwYSpUDpI5LasA5KRT/XRmXI+izQwESbriOicK8ElWVCoDNavzhsUNIA+syQNaDqF3iDig0b5Cq2jp0IDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAmQm2Jg; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAmQm2Jg"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-48534b59cf3so1361715e9.2
        for <git@vger.kernel.org>; Wed, 11 Mar 2026 11:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773254062; x=1773858862; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMkDSmkawHDqMKiUGZzE3i48lXhkkeZW2Fk4XOg5YFQ=;
        b=gAmQm2Jg1BXQdcD5OpGuSk4sjGsTgFd3ZHQ3YU+e8Jg9O4YmNuU27jZZIZU4ivJsQU
         qMtNiJJs4d+H4+YOcFPSBgjSEDE+5N8W7RhYwjXG+qzzeINmetBpvmbsg9daEVas8HyL
         VVI2nYRzXgSIRXAGX6M5bBTVdnbDEOSn0NPjHknHZvzonvAseTM1uk9sjoFwAchCJBrr
         f6FRUkBU9BFey8FH8uKhZMe33Y3qyNqv7IJAlTlogNJfI2GwueW75Ccb5hjYq5EitnVr
         Nth4QvW83DRftIafH5YjIRfl4Nb/vi2I69HmN5466s3EeSS8PuNdQwhIBEG8wipCKO4w
         nhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773254062; x=1773858862;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMkDSmkawHDqMKiUGZzE3i48lXhkkeZW2Fk4XOg5YFQ=;
        b=bvRx4bCLxanhmeHUzqomIUPeUHjmnBffSCi+z1tXd+/Ug8Ags6XwLyeELNVFJJcLjG
         rt7nhV+tjM3P1JK5Z8ARh/awxS56lBRbS6Qsnjb0zvwoELCnD7J5EwBDAluOuWX50Egz
         DRrz+1RwA1YEr69xAKhZsqhij2dgXvhJJKR0WVnMlj8gFNiprTdkMs1kLGm7O7E4CkUF
         WWHVqtbv/l3HCHVcC6Q3vIkB2DeGW16tFyX3VzlX1cDKJnWRCsTt3eMpHHnZE/PnsB2o
         aUdouSH9Nl1igpB9Cpf8aRGDS0dq4g1R2QeI6uoZ0+Udwx/w+qZUe5oNdTUBvirrEGBn
         XrRw==
X-Gm-Message-State: AOJu0YxfmP4POwd2u0tEp7VaEY794rOl+u7fuEwI/OW8fEtGSA+BMFhD
	No9PZS9q7B1Yqfurzu3hAPbQOAdwbWWF301vWdOPAkRUMmHOQg4SiqyZ
X-Gm-Gg: ATEYQzxcN3OQeJh2wn5LBdtzhbrkT8h8DUGMtB46lz59bMFyvgEyUWJPxANzAkTjJUB
	4P+/z5ilMjYnUVEDami3yx8WtpkxN1x0WCxuX+VObZXa2sIU1qloAa4nCwPmdu1u82FCuOoAEyx
	3FAojfQCB/36H+5wL3AvmufpLrswhC2O4M2y+MQXGS4xAUooHg/qnJ20Cw1uwFKCFh5thpZxZ6V
	/iTEWIGz3QhgF+uoh4dSF05TtlG8CDpLLc0/voLbjqDGCDzlr80XmjlJKR5qIEqyw4Q3ti8x/uP
	R/zQmcguieNyiuMUlwtIRq8OYeMACwnJx3+h6l3TD7PM4q1StOKRRfCdLhpDNPEM/0p69CoNeOR
	3QykwXvtcu9M9PcosWxd90+tWJBuZH1OO35hJpjN80bjkJ1DAE2sgqX5Iw8rsc5SREFaIZ38hR7
	tOTPOtAV11i+ANGp1JBok=
X-Received: by 2002:a05:600c:3114:b0:485:4526:ee06 with SMTP id 5b1f17b1804b1-4854b0bb7dbmr60236365e9.11.1773254062006;
        Wed, 11 Mar 2026 11:34:22 -0700 (PDT)
Received: from gmail.com ([159.146.43.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fdf09abesm1273338f8f.0.2026.03.11.11.34.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 11:34:21 -0700 (PDT)
Date: Wed, 11 Mar 2026 21:34:14 +0300
From: Burak Kaan =?utf-8?Q?Kara=C3=A7ay?= <bkkaracay@gmail.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org, karthik.188@gmail.com, jltobler@gmail.com, 
	ayu.chandekar@gmail.com, siddharthasthana31@gmail.com
Subject: Re: [GSoC Draft Proposal] Refactoring in order to reduce Git's
 global state
Message-ID: <abGhquQz_mxK_Ow8@gmail.com>
References: <aa1cn0_ATfh-uRE4@gmail.com>
 <CAP8UFD391QPtk3Mtt5z17ivdVMk9EEWZuKhVtt7X9Twm7WTpRg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAP8UFD391QPtk3Mtt5z17ivdVMk9EEWZuKhVtt7X9Twm7WTpRg@mail.gmail.com>

On Mon, Mar 09, 2026 at 04:17:20PM +0100, Christian Couder wrote:
>I didn't talk about it earlier, but I am not sure using 'enum
>git_error_code' all over the codebase would be a good idea. Perhaps a
>few functions would benefit from that, but then the enum could be
>specific for these functions.

I understand your point. I have also noticed the use of
function-specific enums for error returns in the codebase, which makes a
lot of sense. Because of this, I plan to remove the part about
introducing a global git_error_code from the proposal. Thanks for
pointing this out.

I have also noted your other suggestions regarding Olamide's work and
the commit hashes. I will apply them in the next version of the
proposal.

Thanks for your time and guidance, it is really helpful.
