Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA05324678F
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749759929; cv=none; b=l7k4H0hWksLgLu1kKe4wgsJyFJhBwO0VCl/aAEyjl7iv3ZOvAuffQxjCFaiZuZ0bTrz4YF9TJP1Zj0bfEWyAf0xCmoJPxqcpgKfjOZiYStjjhgD1lpD6YbB2D0djjDn8I6qQTgHQFzTgAect/07COrgPXriEX/rlBb9bCD0ab0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749759929; c=relaxed/simple;
	bh=G7TVFeLCCVPQ4YSLFuU/rsrGoVoKZ/yfDgAPxjzV1Q4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=pbt2S07VnQPOGN18AlKEsZGcZFdLpcDPUccKtO8uJhgv+MEu07l+cCECQTfTDRIhcl/MeEAXSWWegiXM5SOegLqeQlEhZ+G8NzxSGLSUjkP/zgYmDs1QfwoFdzE3LXjAbZcEBltoS02SFidM5E9V3G+Muengb7dEvf+NxhsxlqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gi66dZkY; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gi66dZkY"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-234f17910d8so15151875ad.3
        for <git@vger.kernel.org>; Thu, 12 Jun 2025 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749759927; x=1750364727; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A0QduJ0Wyw4QF1Nd2XZG2O5cluWpNjppVTVMCAPvO30=;
        b=gi66dZkYXJDye+MtHJ/DUK6Ahgw/d5KmHArPvRyT3bqVo3dbFk+t+8usubMC5t377T
         swrfPuwUc33sc/wScaH4dDLZo5QPUKWEmGWFkCxiK88BkZJfqBpnd5hKpzhTXc+X6Nfd
         I/RNmjr9obe3iWS0obUD0knrHZzJ+kT5+6cZesJVLz5fzn52fFSzafx0T86PE+vYtjCE
         JcoM4ngMR2bL9XJBqHGEeryw1yt4phqefdfsu0OmtwkuBktAqPozj478rP2WFC88RrD1
         j6FaGNsFIMgL8ssuFTOjzrthKVEiyAKhhv17yO8mam79oNq4dKaXaMah9jx8KAHPx8CQ
         lSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749759927; x=1750364727;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A0QduJ0Wyw4QF1Nd2XZG2O5cluWpNjppVTVMCAPvO30=;
        b=m7GNkpXCyjKfmixy0E8DYRp884Tt+Y93cuHehQz0TnLgPRXDUT40HjjI8NfKJe2NGH
         +i25MyI38GHVDb+4jVdojUwUBwM1SRI+jxRIWx9AVpjlINSqt3GNTTJUqzILaq7j7v+e
         RNf13N3dY6rl+xbyVKp6nY+tf4TumFM5k61Eyeno5h+aAI1Uzj4bsKK7gZqIwI+NqEyr
         /efIqZMomw6m6ntzAQAwFhmHDSNvF8uHF2mNy5XoCnfub6vsGBN8EXWjRC45yayoya1r
         2XARXqz2UVPMgsLtQFqCDd9Ju+aMhGzxj4EStQ4M/Wi8xp06JOLF3lvl09Z+Uxxu8lh7
         v5RQ==
X-Gm-Message-State: AOJu0YwhSe6HAYAnvclFwj0n1BN8INnmQ9M1gS+McVVjX5nj7Mz12H/4
	fufXi7B5WJVfSlEk0WTXvyCncVMgHjuEPPd19qYH2odiZb5jylMoc2Fc
X-Gm-Gg: ASbGncuO0Vy0h20ECqK8FHc4gqII8SoSMirIQoy2SQ81KtPvIauF1Ikn2S45m2hMApU
	whebdKDpRyED/C/Ky6OaVzevlWRhV6T+v/L6hXHhMPZo2hWz2mvjPkLAYpXGPEdebliDhuzBxCP
	JrLmoHz1MLrmSxSBl5hbu6Nx0nO3B4KlqLF+saHodhmTBclhsIrGQuaGUZCejj/v5b9YruflEZK
	PMG/2oQUJWMznzu7WWIZr9HKuWZQrBabRkHxeMbPIa4upnaZWJB3bMX/sYxZwT8t0nB3gMl/SKX
	82dhTyhU49CfCg6t3x3GWOa5ZXtymAYXWleXv9mcxYW37I4GQZNqOgvsRiNkeovOK09ef8/13jc
	50hpqEKIb/Q==
X-Google-Smtp-Source: AGHT+IFq0dWaS9sdkmdfT8zpFYjzz4UcZRnutc+IlykWzyxCEZVD6H3Sh6Fs9d9M5Ijc06W5zAOldg==
X-Received: by 2002:a17:903:2a8c:b0:234:d1f2:da31 with SMTP id d9443c01a7336-2365d8884bcmr6215475ad.2.1749759926957;
        Thu, 12 Jun 2025 13:25:26 -0700 (PDT)
Received: from smtpclient.apple ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b2fe1680420sm136001a12.38.2025.06.12.13.25.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2025 13:25:26 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [GSoC RFC PATCH 0/5] repo-info: add new command for retrieving
 repository info
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
In-Reply-To: <xmqqikl3mtx2.fsf@gitster.g>
Date: Thu, 12 Jun 2025 17:25:22 -0300
Cc: git@vger.kernel.org,
 ps@pks.im,
 karthik.188@gmail.com
Content-Transfer-Encoding: 7bit
Message-Id: <2EB72983-BA77-47C3-9331-B08760B092C4@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <xmqqikl3mtx2.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)


> OK, that's understandable, other than that handling of trailing
> commas looks somewhat inconsistent.

Ooops, it was typo. I'm using the json_writer functions

>> Or in a plaintext format, like this:
>> 
>> ~~~
>> $ git repo-info --format=plaintext
>> sha1
>> files
>> /git/dir
>> /git/common-dir
>> /git/toplevel
>> /super/working/tree
>> false
>> false
>> ~~~
> 
> This one is a bit questionable.
> 
> Is it safe to assume that we will never have to deal with payload
> controllable by the end-user that can have arbitrary byte values?

I was trying to follow the behavior of rev-parse, where we can
do this:

git rev-parse --show-toplevel --is-bare-repository

and it prints both the top level repositority and whether it is
a bare repository.

> It would be uncommon but possible for LF to be in one of these
> pathnames

I tested here and this also happened with rev-parse:

$ git init 'my
  repo'

$ cd my\nrepo/
$ git rev-parse --show-toplevel
/tmp/my
repo

And this also happens passing other flags to rev-parse...

> This one is OK.

So, after reading your review, I though about other solution:

1. The user can provide only one field or no field
2. If the user provide only one field, repo-info will return
   only its contents
3. If the user don't provide any field, the default set of
   fields will be returned
