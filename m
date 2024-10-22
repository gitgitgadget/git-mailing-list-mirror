Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B195199EBB
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 11:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729597447; cv=none; b=bdJxwAQFUH2ib6Y/sw/R8hi9Pd5IcPpHBsGFn4ChiOfkL7xRuOeuA0Ls3dwYSGsVUIUtRbCxPxPhm5tsL+YxhQ93573Xdhf7euRxZiQKJq/GjYrBp6wLsi/Wd53U8tyTr6CN2KEKpk2PmRBXW11F0EOsftlHZWhjXA+v3O2gQ2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729597447; c=relaxed/simple;
	bh=35Pk2f5wV0SU8YxfK5JpuU2EiC0hFNi0cPpA1+hccQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXkEqdVUHrjifK9XU7iGbmf1Tvb1qVSToOna5fcYPLGblJ+2vA9+85Z/QCYfIE9DXtGx2JifHBKh9r2JUPccDzTY4d3XgoT4bc+vnjgEaOxNJYYJ0KSj2/OF/nHSTqelM8dowCV1BgMLCEzzXgKf+BzbKGnMSuPcOkkUU+CsTRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WQB4l34j; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQB4l34j"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20cbca51687so55010945ad.1
        for <git@vger.kernel.org>; Tue, 22 Oct 2024 04:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729597445; x=1730202245; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wVm4sxXX22rmrbivriAyxs4EWl1lkeZwc03HSsGUCLI=;
        b=WQB4l34jJfkARLPWo5PZZMqXEB2aNwL+JUA8UTRMwSrtfcHpnNqSzlIdeFicCmQ0n1
         hT1y6M2Ua1KwWo4gDvDhmdctP1o6IWSHvHAueT3IiOOkdxG8B2jkAMy0xUUjTGHKUA2g
         pe/jXzvtGw/GZ3ZkOhU7ZZF4SLvCe+2pe16btweSv3vMYSuMsgkkUvBPuGFa4jHlFwa+
         wqH2Lgze0niQNmzzGKkGQ0dHLnuSQqNRP6xA9JgUt6HgbYE1AwWtBgOjL3Oggm7vp9SG
         5ElRrbtoux93Tn4ApkUInlgrDditkp6lZXZr1gPoeUoi4W1cXFNdckh+vTr4RA2stW8f
         Xo+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729597445; x=1730202245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wVm4sxXX22rmrbivriAyxs4EWl1lkeZwc03HSsGUCLI=;
        b=CgTUy1eA5JMWGEkf9mupdTH6xcNh9EEi2rQPVEBd/xRqjPf7I9S49FBKnha6aSWJgv
         zw55OBcIJkuCfJfCqAMn+Psuqjb+XmkP/1z/QTmyuky7TSHlFViXFVGf6AwIoEwQU97U
         8Ji3mttCqJKZEMsOEBy8RJKym0kGHyhgGYTDsRvrIILfvmdlit5EOkMx3rLqTAMZD/qo
         7yY2wiDhg/7PJzYJViDZGYzjQRyOJYKz7SkmeDo4nZ9WT5yamNgn4pvb/5ICO5tQdQEU
         aNsPtafM/gXEM27oOn1BEC8/lQJP90puTdBFxfr7dn5ayBYVTMxjijT9aHngX8hGv6Fg
         aoFQ==
X-Gm-Message-State: AOJu0YyERt1JaWTcA5HOyIPPgUG3IaPKGwUCLzLBTNwV7e3enzdDur/6
	QQIcMdnsrJ7devries99ms6NBQEeAWRW1QvZbqNNawuwPjZEah4HOtVYjMHiVVg=
X-Google-Smtp-Source: AGHT+IGnrWf4/hCYut1xxEc4yWh1r87Xyo3TWcHPBlEcoZiQnXVahS1pp4MOYCQVFjdsewMqP9Zr+w==
X-Received: by 2002:a17:903:1ca:b0:20c:8907:902 with SMTP id d9443c01a7336-20e5a923d33mr184342335ad.49.1729597444820;
        Tue, 22 Oct 2024 04:44:04 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0f6462sm41222185ad.272.2024.10.22.04.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 04:44:04 -0700 (PDT)
Date: Tue, 22 Oct 2024 19:44:09 +0800
From: shejialuo <shejialuo@gmail.com>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 4/9] ref: support multiple worktrees check for refs
Message-ID: <ZxeQCW6iP0x1P1o4@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYcPwLB5oLTFUo@ArchLinux>
 <CAOLa=ZSGuBsLxUaA_gvXrYzR=Abzno5PEMZZD+dAs_smcyoqLg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZSGuBsLxUaA_gvXrYzR=Abzno5PEMZZD+dAs_smcyoqLg@mail.gmail.com>

On Mon, Oct 21, 2024 at 10:56:30AM -0500, karthik nayak wrote:
> shejialuo <shejialuo@gmail.com> writes:
> 
> [snip]
> 
> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index 0aee377439..6eb1385c50 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -105,4 +105,63 @@ test_expect_success 'ref name check should be adapted into fsck messages' '
> >  	test_must_be_empty err
> >  '
> >
> > +test_expect_success 'ref name check should work for multiple worktrees' '
> > +	test_when_finished "rm -rf repo" &&
> > +	git init repo &&
> > +
> > +	cd repo &&
> > +	test_commit initial &&
> > +	git checkout -b branch-1 &&
> > +	test_commit second &&
> > +	git checkout -b branch-2 &&
> > +	test_commit third &&
> > +	git checkout -b branch-3 &&
> > +	git worktree add ./worktree-1 branch-1 &&
> > +	git worktree add ./worktree-2 branch-2 &&
> > +	worktree1_refdir_prefix=.git/worktrees/worktree-1/refs/worktree &&
> > +	worktree2_refdir_prefix=.git/worktrees/worktree-2/refs/worktree &&
> > +
> > +	(
> > +		cd worktree-1 &&
> > +		git update-ref refs/worktree/branch-4 refs/heads/branch-3
> > +	) &&
> > +	(
> > +		cd worktree-2 &&
> > +		git update-ref refs/worktree/branch-4 refs/heads/branch-3
> > +	) &&
> > +
> > +	cp $worktree1_refdir_prefix/branch-4 $worktree1_refdir_prefix/'\'' branch-5'\'' &&
> > +	cp $worktree2_refdir_prefix/branch-4 $worktree2_refdir_prefix/'\''~branch-6'\'' &&
> > +
> > +	test_must_fail git refs verify 2>err &&
> > +	cat >expect <<-EOF &&
> > +	error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
> > +	error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
> > +	EOF
> > +	sort err >sorted_err &&
> > +	test_cmp expect sorted_err &&
> > +
> > +	(
> > +		cd worktree-1 &&
> > +		test_must_fail git refs verify 2>err &&
> > +		cat >expect <<-EOF &&
> > +		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
> > +		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
> > +		EOF
> > +		sort err >sorted_err &&
> > +		test_cmp expect sorted_err
> > +	) &&
> > +
> > +	(
> > +		cd worktree-2 &&
> > +		test_must_fail git refs verify 2>err &&
> > +		cat >expect <<-EOF &&
> > +		error: worktrees/worktree-1/refs/worktree/ branch-5: badRefName: invalid refname format
> > +		error: worktrees/worktree-2/refs/worktree/~branch-6: badRefName: invalid refname format
> > +		EOF
> > +		sort err >sorted_err &&
> > +		test_cmp expect sorted_err
> > +	)
> 
> These last three loops are the same, couldn't we loop?
> 
> for dir in "." "worktree-1" "worktree-2"
> do
>     ...
> done
> 

Actually, I guess all the tests could be written with that way. I need
to refactor in the next version to make the tests cleaner.

Thanks,
Jialuo
