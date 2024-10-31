Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7626C347C7
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 19:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730402446; cv=none; b=gPdjjZUFjNgE1+27FmOG0im0pS77sWhijg/RHtuZHYmHm0K0ko5w6R9Gs6sp/ETl9+qEI7WOxV+mV89YdGzhQvafcL3QAx8jJXweYBcjr0O0esm2lME9JkkFPx7vRvGkZHMcXWdh8y+wg6eNIqwFEPwo3QYcqq9mTN3H13K6SYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730402446; c=relaxed/simple;
	bh=qsFgIqJpiejdMbYuLRrSNr0i3nQvviJV0UEtYjgJeZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCHhPOXDbSpqT54ZYteTEaGtN91bTIyXXmZGgD2MRXUIi31NAs2tIv42/5Q7Pm0Ga6E0i11sfEn0IHGnbn5Eon1LGh7+JdOmBjoiy2O/T/Su4xez1bcjJ5jV/sVWmvsTEe9g/inUFdgD80ySX+z7gdG8hGCX2VFy17842sK7+/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=QiMKI5rG; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="QiMKI5rG"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so1215096276.1
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 12:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730402443; x=1731007243; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HowC44kuD/5F5QBfZy9Psicb/eh4TXsv5yEVKk35xCk=;
        b=QiMKI5rGm7vjdPbwrs4tssZK7+FNWM+6K2GzhqKyaqx3Vok1I2xnkUZuhQE9M0+BSU
         iBzb/DTi4TAxg+EYHWyhRHXan45jHZf/4hiXtZdAH3DjWE6GR2Abh39oDwCdF0YoAko8
         t+R9WI6LhMj7tFbrHH4/erBCw2MIy+5A8E20c3k/piTeo8DoqqCScRHuYSgJLP+Cs+kU
         EWygNjm7WVfkjYpU+G9VwX0bjr8wW0eFNT5MOaBms+NfleSXui897uyksoUN/XCo1D6e
         qaK0E8r2WreFnC6ITLqhqTvLpVn4BDV2btlq3EcRwPsuCarRUcLc+7MqQ7qavcW15SqN
         qyAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730402443; x=1731007243;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HowC44kuD/5F5QBfZy9Psicb/eh4TXsv5yEVKk35xCk=;
        b=rInC/hGP9W14BpmmAAsmNkUWPr1/MGUQjNtrTgCkRP41FeQtqNJLXkZWp+dn2JpBic
         wgr50mIRiMvsSSx1m/z+6bJbzfEeuNuscaZKn0CnCOd4esKpKLHYcag4V9zRWqzQAjyW
         +1uslpdjxT/5+Gs0zvNWTKr314pSQAWMyWjLt7quXypSd5JCRNfTB2yEU6LDYh17dip3
         qaKgpW1bo8AgK8M1irtnblPw3jDRmtoE9d7cXWQdYYzX/tbE8yNsId9HMiso6jPh0K9i
         gT9oCu6TwFSIsUGYwBfoK/GoHsjj04SVnPs5fu6zI5TmvKAoX2tbI5R7KYMnhwlpYs6d
         rirA==
X-Gm-Message-State: AOJu0YyWXeaXza+O8CwXcLWWo3cASPvNbhnZbUUbp8Jz/NCJKHctmZ5z
	GTwR5UXhUO7ZSqvZ8PBFQDksREyC7NIlW5nphtjHpZPSlQbnBRz01mmzF7lbic0=
X-Google-Smtp-Source: AGHT+IHeplJfW73lxKKqCWCSeoRdjq7F3B8Qp8s7/T55a9GuL3jqtS9Lbpxpe4JF6JCKuz7GYswP5g==
X-Received: by 2002:a05:6902:2186:b0:e1d:9b03:8812 with SMTP id 3f1490d57ef6-e33026c369amr905513276.57.1730402443340;
        Thu, 31 Oct 2024 12:20:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e30e8ae8bd4sm412845276.65.2024.10.31.12.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 12:20:42 -0700 (PDT)
Date: Thu, 31 Oct 2024 15:20:41 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 0/8] Allow relative worktree linking to be configured
 by the user
Message-ID: <ZyPYiffYRDK/4LdG@nand.local>
References: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031-wt_relative_options-v3-0-3e44ccdf64e6@pm.me>

On Thu, Oct 31, 2024 at 05:05:23AM +0000, Caleb White wrote:
> Caleb White (8):
>       setup: correctly reinitialize repository version
>       worktree: add `relativeWorktrees` extension
>       worktree: refactor infer_backlink return
>       worktree: add `write_worktree_linking_files()` function
>       worktree: add relative cli/config options to `add` command
>       worktree: add relative cli/config options to `move` command
>       worktree: add relative cli/config options to `repair` command
>       worktree: refactor `repair_worktree_after_gitdir_move()`

This version of the topic, as well as the previous round, appear to
break CI:

    https://github.com/ttaylorr/git/actions/runs/11602969587

An easy reproduction locally is to run t/t5504-fetch-receive-strict.sh
when built with 'make SANITIZE=leak' and run with
'GIT_TEST_DEFAULT_REF_FORMAT=reftable'.

I'm going to kick this topic out of jch for the time being as it breaks
CI, but please do send another round once you have fixed the issue. In
the future, please verify that your series does not break CI before
sending it to the list. Thanks.

Thanks,
Taylor
