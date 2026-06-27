Received: from sendmail.purelymail.com (sendmail.purelymail.com [34.202.193.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EB034A76F
	for <git@vger.kernel.org>; Sat, 27 Jun 2026 15:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=34.202.193.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782575562; cv=none; b=bPY0+OLiMICdBDj2OKIRaFH+hwjJhyD8qPaGnnfQLNIw+ULorbZjyLgKW0FlBlsFYjduylyBUu9Vy6SpKbRGzOfh7vYDMoudQ6lsPZHii6+EhFnuZWA3pxrhMZ7XOsAzKCSLGSSX0DZOMESrvrdOjup/BbuhedYyhBWUs5AOavI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782575562; c=relaxed/simple;
	bh=U6qnhtYKAY2CLR4PqBgKJCSxCUkC4xs8s3krNWHYVY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Czme3E7OuzbpwEIj8ZDodv5c7iD7ft0d37jYE8vik7X2RakhNNz7fMeWTjdnhS4DhBuSjYmBTxYfuaEOhOpj+Crr4KvL5vYi4lmaTr0lPUFIJB/BATLe4Vgn5M/1XYytGJSnESZHxT68QkKmasAR25gmGtYOf1KoO4+rk8ESodQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev; spf=pass smtp.mailfrom=malon.dev; dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b=nvt1We4U; dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b=PAVYeQz1; arc=none smtp.client-ip=34.202.193.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=malon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=malon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=malon.dev header.i=@malon.dev header.b="nvt1We4U";
	dkim=pass (2048-bit key) header.d=purelymail.com header.i=@purelymail.com header.b="PAVYeQz1"
Authentication-Results: purelymail.com; auth=pass
DKIM-Signature: a=rsa-sha256; b=nvt1We4Uep/2ygOpjsU8PzCOOPbgM0Uj5iLyqVmAhLvOAsWJWF8l0gGLdVHCt+tO/Z3XRn9oDDx4N6CQa/dSUqQxI5057ZGXH43bGvbguU7UHm9noFmpGccBTNnUITyYfhIOVmgZwUv0x34dYmdDZrISrTlxhGg8vnrfIddrKbVoeXWTtQ1K2hzkfuHQIwoxEfF4D4EVtTfT1u40gdIQvmUSLEvznJAOgP0WDMb7axmFz96UuSYSFAVyEOuJ8IEqiHP5aRK+R4PqwgE80Ql76Df5U0gKnVP2kAsBp+SxBEDOT06qA5ky/0ZmLNxEMVA9l0QlaSBw+5v45Y+feRzg0g==; s=purelymail2; d=malon.dev; v=1; bh=U6qnhtYKAY2CLR4PqBgKJCSxCUkC4xs8s3krNWHYVY0=; h=Received:Date:Subject:To:From;
DKIM-Signature: a=rsa-sha256; b=PAVYeQz1f0NrMZGlkfCMMCxZESwLncH1B3be5P6Us5a4bYQxsEz+nV25rkqnhMkVAGCydkwzQ25pSaaGUiC8ync+hVYYNZutBBPykGMaLgmihLIxB672Uk5M3QMcshpQtOMndM2mNkeQtqoHq2hcD3ug7NNtGxCWYuHdk/duryBGdE1vUc8iisM04La73/R6m7H+wlKrrf/w5FO7BlwVrcZEyq21g4p76ZdapB5o80tuz10WjUEtcaq83tMQ1SLkSJ8Ek36xnp3p+MsbFJmDj2ySGUq4683nTeOQ3Elrt/skl5Kzq6dieTV6dLt65NQa03+xgA789wrVN/0mOKOIig==; s=purelymail2; d=purelymail.com; v=1; bh=U6qnhtYKAY2CLR4PqBgKJCSxCUkC4xs8s3krNWHYVY0=; h=Feedback-ID:Received:Date:Subject:To:From;
Feedback-ID: 599969:32685:null:purelymail
X-Pm-Original-To: git@vger.kernel.org
Received: by smtp.purelymail.com (Purelymail SMTP) with ESMTPSA id 1902517477;
          (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
          Sat, 27 Jun 2026 15:52:38 +0000 (UTC)
Message-ID: <832fee0a-f61d-413a-9562-78eccf8b5eb0@malon.dev>
Date: Sat, 27 Jun 2026 23:52:30 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/1] move excludes_file into repo_config_values
Content-Language: en-US
To: git@vger.kernel.org
Cc: cirnovskyv@gmail.com,
 "szeder . dev @ gmail . com--in-reply-to="
 <20260626075037.532164-1-cat@malon.dev>,
 Christian Couder <christian.couder@gmail.com>,
 Ayush Chandekar <ayu.chandekar@gmail.com>,
 Olamide Caleb Bello <belkid98@gmail.com>
References: <20260627154514.1073154-1-cat@malon.dev>
From: Tian Yuchen <cat@malon.dev>
In-Reply-To: <20260627154514.1073154-1-cat@malon.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/27/26 23:45, Tian Yuchen wrote:
> This patch continues the libification effort by migrating the global
> string variable 'excludes_file' into 'struct repo_config_values'. Since
> this is a dynamically allocated variable, the migration requires proper
> heap memory management.
> 
> This patch mainly does three things:
> 
>   - Abstract the XDG fallback lazy-loading logic out of dir.c into a proper
>   getter.
> 
>   - Move the variables into the struct repo_config_values.
> 
>   - Introduce the memory destructor 'repo_config_values_clear()'.
> 
> 
> Changes since V2:
> 
>   - Squash together the previous two commits into one.
> 
>   - The 'repo->initialized' check is used in both the getter and destructor.
>   This eliminates redundant checks and follows the fail-fast principle. This
>   is consistent with the previous global variable removal patches [1][2][3].
> 
> Thanks!
> 
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Ayush Chandekar <ayu.chandekar@gmail.com>
> Mentored-by: Olamide Caleb Bello <belkid98@gmail.com>
> Signed-off-by: Tian Yuchen <cat@malon.dev>
> 
> [1] https://lore.kernel.org/git/20260610093635.139719-1-cat@malon.dev/T/#m856253610936d052a798259bfc06d598561e53c4
> [2] https://lore.kernel.org/git/20260606143412.15443-1-cat@malon.dev/
> [3] https://lore.kernel.org/git/20260617154929.564498-2-cat@malon.dev/T/#m8843984a6175a1a4c7e00877085c77b0c72f5803
> 
> Tian Yuchen (1):
>    environment: move excludes_file into repo_config_values
> 
>   dir.c         |  4 ++--
>   environment.c | 30 +++++++++++++++++++++++++++---
>   environment.h | 13 ++++++++++++-
>   repository.c  |  1 +
>   4 files changed, 42 insertions(+), 6 deletions(-)
> 

What happened...? I used in-reply-to this time, but I probably typed too 
fast and didn't notice where I made a mistake. Anyway...

https://lore.kernel.org/git/20260626075037.532164-1-cat@malon.dev/#t

This is the link to the previous patch. Hopefully it will be helpful...

Apology, yuchen
