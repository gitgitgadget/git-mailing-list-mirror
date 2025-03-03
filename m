Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7362144C9
	for <git@vger.kernel.org>; Mon,  3 Mar 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741015454; cv=none; b=GTIMXIHTNiX0mGokFsoBesXkNms7i1H+h6HmHk0h4kCZWU88sHXzZ19PjXYfY7tdN7JUlgv34pPoyyhTVdCzcS6E4GuE3y5DOffrQOG9VycRwhHuqCT3lLCP0NGiKFCSyH+xm/tKYHfsk+jqL9jDnehOQhbCsZZ7HAoyp/V+kA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741015454; c=relaxed/simple;
	bh=j0chrONuUaquUmp58t+FiT7A/umpqr2Mq7TapQnn46I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r469B0DcEzhO9BkdG23QJdZYtddMTXJo4d9HQoPB47ClALSlV53RHbo7WQd4qDRUWV88vHdcZNPntzidZFHQ+DWCoCnj/uPtQQOAco2kdsLy3jdAx4B2QHVsiJKftfj5+Zb3h34cadhDNbqZnro8uZqc8TLgP/s4rNbKNDUMe90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b+/FOes1; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b+/FOes1"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2238d965199so29513005ad.2
        for <git@vger.kernel.org>; Mon, 03 Mar 2025 07:24:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741015453; x=1741620253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=X1gIgnf+8UVkTK5SsmNkJicdXcSsyAYw4gBZJV7WjAg=;
        b=b+/FOes1P8mcEe0e07lcI4YuJcIK5O+/K+0c2xCc5BiBuI7Q6PgCsDKCPyJi43wk6A
         nzDi3ktm6HYpu3NOUgk6TADsfg3Jp/FdcjQu+a3qs5dYelstFA1R2fQFM5GiLEKPGKjT
         DiLRy3qIR4sMCMfKB9dvTLJFFMH/Xhcd/BEmsADesAAVWUL0CR890+Og6RKUo5yWum2d
         OIFQ3PeCjg+YBPpzfNL9MyOUjmGix+HcuTr9W1yqyjvjf5Eh7Ue3BcI6vS786gJPRzMj
         Yh8LYlaA0avZB3Jti1h1BDThuoRb/UyJYYfuW41m7gkMlmtQx28O5U+ntW2A4csGe58+
         Y9Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741015453; x=1741620253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X1gIgnf+8UVkTK5SsmNkJicdXcSsyAYw4gBZJV7WjAg=;
        b=a8iZeta2p1eRem6nZj+eyF84xEgAmlbtmY2l9cUT8k788NP3iSEWiEcIw2BfgQSdRd
         1+kjr0OXI3cW9acg7/ulssUJ4I9fBgDKgcoWEYzYxlINJHbUEnLDi8SgI1+u0eQM9CBA
         7Jd/8nxiJrXg2jHmjVmNVzj9kSBBBwuFqeEvVio7uoyE281PTyIWoYWL4r766wNUXJD2
         08AoQaZE1HZ4lvZB6gKuV6frXs/XSyu19AsUfZQ/FECMtajLtQHxoUDy+MrOuHor1ywG
         Zidc4TVyEnZiggY3nZxfsO7KoUfrYvLigFXnG/wvpvZ2bPFOAFSOEzWF051Hf5fkrdC3
         0Gqw==
X-Gm-Message-State: AOJu0YxMwS5d6Mb73jLPPtsgEHmjj73vWShspaTunWehu1hK2gXlPHBN
	xXXapZxQhw0T5jC7t4DKCSQVlNKM1ZnwtXGM7vnmScM9BeJnxmltVfELTg==
X-Gm-Gg: ASbGnctoZFVc43AuGohV+GslFeAh7SjSEepZDHoTDD9vOxSXyFO1dhv7E8a1nlL4Bl8
	AEGZOPK/rUgIYDSjF19EbqT3p5Hl9AHmrYLJIKXAjCCUrcqhK3+8keqlTOjA5OPG3pGVNgb0G0G
	LY0pcXwzvClVUAICHwY6z0mPw9yUJAN6bvCk+y8FtpDbiQPyaGW9hpVzvZrhcmsTminbCczOY3N
	lN588Mo4LEHatxBSrpb38I+042YFXr/xON85apD22H9D87LiMNd7f0Q89FyQeyCfuGm8Z1Tju8r
	2PCNPOhTYVDYRjuy6IbtlTXcQYMfu+6e0lXYpWBy
X-Google-Smtp-Source: AGHT+IHPCoyfkvS9yH0Hh+BKf4eFoWAXH3E0Kn4dIMGEgrsOsqET1HiYP9rT6aLYQPo+s0lkjbIVMQ==
X-Received: by 2002:a05:6a21:150a:b0:1f3:3771:d3c with SMTP id adf61e73a8af0-1f337710ebemr632507637.24.1741015452740;
        Mon, 03 Mar 2025 07:24:12 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-af233af8af3sm2531418a12.73.2025.03.03.07.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 07:24:12 -0800 (PST)
Date: Mon, 3 Mar 2025 23:24:12 +0800
From: shejialuo <shejialuo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2025, #09; Fri, 28)
Message-ID: <Z8XJnJEHZd1dFE96@ArchLinux>
References: <xmqq7c591sus.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq7c591sus.fsf@gitster.g>

On Fri, Feb 28, 2025 at 04:45:31PM -0800, Junio C Hamano wrote:

> * sj/ref-consistency-checks-more (2025-02-27) 9 commits
>  - builtin/fsck: add `git refs verify` child process
>  - packed-backend: check whether the "packed-refs" is sorted
>  - packed-backend: add "packed-refs" entry consistency check
>  - packed-backend: check whether the refname contains NUL characters
>  - packed-backend: add "packed-refs" header consistency check
>  - packed-backend: check if header starts with "# pack-refs with: "
>  - packed-backend: check whether the "packed-refs" is regular file
>  - builtin/refs: get worktrees without reading head information
>  - t0602: use subshell to ensure working directory unchanged
> 
>  "git fsck" becomes more careful when checking the refs.
> 
>  Comments?
>  source: <Z8CMx7O19PMs9sVY@ArchLinux>
> 
> 

I think I have addressed the comments from you, Patrick and Karthik.
Could we make the patch into "next"?

Thanks,
Jialuo
