Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478113A2E25
	for <git@vger.kernel.org>; Tue, 22 Sep 2026 07:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062707; cv=pass; b=GaoGHvvtAjWibv8CSwF0UBek7fRRS3wF/FsXBsZkreHQj1ybcPrCAI5BMUdvAc/lEDp76wpZzlyHCQsxy2+8Mh9FMN4AUFFu+6Ix1rTXlABWI3O3GPwoh2g9P2B/SPDECKmTAl0zAh+WcPQKbp5tcNxmSIRbDBBVyCXLvXgyrrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062707; c=relaxed/simple;
	bh=2OvPf7G0mxZW8f1XoxxjE1mgpudNfFCaTlJLyRllMB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCcc6bMlE2o88+hFZXKuPY8BfZzzmY9y3ogG7Yc0/d0s2LQDceuj5xr/bkOi5sqKu6wuW7I2PwbJ8ZEyfvzgJYTOo3OAm1qfz6Kk8bU9gzeI/ySsosUhs6Jld7iDHfiFmHlCgpMZ4CvAWiSi+0/gQGNbM6g/ANmZ3bbGTfLHL8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com; spf=pass smtp.mailfrom=thomasbachem.com; dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b=qGa/2y4o; arc=pass smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thomasbachem.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thomasbachem.com header.i=@thomasbachem.com header.b="qGa/2y4o"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-8716a5baf64so35406517b3.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2026 00:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790062703; cv=none;
        d=google.com; s=arc-20260327;
        b=CBeBCJfDU5bcrTb9IVbhAEdh3NLwBCt4xH4pcQBe+ErK6RnJdZ+n1lkUfKeI9Mj6O9
         ansJvVlSD06UH1nPTO0CfMJ8Zgac7NcK/PANkyi7LWo8aKaRWgNeQuY01LLdF1Fb+dzG
         zg49TN9FxbN01fRmbC/tdTDC1tc+d0dZvpfOPlQhjS+OzQIIWXuMPqW/tp1zCSsXuGru
         nBEcbpgpoxD8TBXjsdUajEC4ego8VCjmXPH0J3fOn4z9bjawzu6AHtRHv/T+SqoGpsJH
         upPrTWNLcZDIMe6jlxj+VMcdx9bl4VccH70GU0NZ390GwqrlwTf0VD31/gehlIYVSfW+
         +CSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=2OvPf7G0mxZW8f1XoxxjE1mgpudNfFCaTlJLyRllMB4=;
        fh=0futRCsuuruNF0YpbT0htzurjoYfr03ulKCYVbMNkHc=;
        b=jrAHXUIPTkxc9z+pUYi/A51hAJCD15DmRWKXH2DiADztqoXpH5dDhiZzJtSghumEXK
         vEHPg4hu4u/RQZRob1x0bdzt9I1uDCT757PvxTviVmmFak4c+H709hJwo05J1fKdjRJB
         tRBKyqqjyIfJEuoYtKhWZOyNDoGXkoKKqDNXyL0YB1BYXfysJ46K80amb0TKykjdzMSY
         v0BwZf2/0E2ARyIc8zwrgm9reZRK/+Hu+70nIE7R72pz62e1JuO7+FwNqV2EnU8LuywQ
         a3u8eF20/H9nhqPSYBXAW/MOab0dSR6o1ONLqYnDHyZhXaqCRA99wFcWeS1jg2T0xlLK
         PlPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thomasbachem.com; s=google; t=1790062703; x=1790667503; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2OvPf7G0mxZW8f1XoxxjE1mgpudNfFCaTlJLyRllMB4=;
        b=qGa/2y4oCjo+Bio2hPIcfdi1+evtqHMF2kVtlrjKCIv9UGSaDG8oQEqHNVi5qEByeg
         O7oQzrfbgQkpyQPSea0VlA7hxuisZRRvQzOR+7dyX622wCDbFhaPYSx+49FjMSnZyjAC
         hBmvQIXQ4c/mTElpOxjHHPXJufiFht3yrhXG9FTUjGHHzdbJT8zjYG69KwWBKmNZPEQm
         4bVOpfLLIGs+7H2uYXYzAxjuKlXOK4Hdg7xghktviYEC9eN0uf/xWKShwAFJMmoifAN1
         8+TwtlgtoWRqu23jAicLfSuTrREwFi2+h2uAzUjG+4K6qquI04lOzEFuWSCENbXFcGlq
         MLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062703; x=1790667503;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2OvPf7G0mxZW8f1XoxxjE1mgpudNfFCaTlJLyRllMB4=;
        b=dZTzsS37FjT1Cl4JLLstmWNedt5myy9a7yoDNXRaBAJfHxIg4GL/56RgFQ2pNmFuMA
         tMz7Y1bEw4kuCPs5u8AoongUZWXqb/kDS8eslVjqmiISAxXRM/bsCbgohSf4xUYydZ4e
         bOtaaPqw4505fBLm1dh3ahtUHZuo8dy695FoukvfqhhsEhirf9QFfeddoWyyjSYqYGDD
         QJU4Z0gcrYTAsxdvj5uE7RRnuOUwH/T6wf18S51sPZk18GA8qNnwD6RbPdowDtQWddKr
         wHJByLVv16VED9s1XZ2aspqQZEaQLaRxg8SW+HwnN8c+7OKZUbXse5KYjWEDLxEXOov5
         Cqww==
X-Gm-Message-State: AFuF++lFowXcDc3B+A5ac9cW/VsAdwW2fUxmwFOKg9pvSRwDTxBK5WZ4
	TzYQYBPVfi14EyZAvnb57s/JkosRAmRQMRd5kB5Y14PtMByyf8OLr50EdG8oNs7jvZsqT8spOJq
	L9tjghk7m5yrz6dXjJVWQl3Pi5mWH+TCvRjmS1TI/wA==
X-Gm-Gg: AYBFou3bVKAsPWIWxgJ1WNH56AC7GGAXA5obMIrzweTvpncWVvtRTRdPgPzQwhBr5qS
	s6JNvE4AKy8s7SkQ6Vez1g59rRkE5m7KrDNzu2vd2E+21pCWDN1/nubXorlpUWd4kevUs7rNxE5
	+XuYmTlmtjYNaD6HVEKfO1o4igJ3Sq8ZGbFpVDTriR6VGofKCx+vu/Ql7JxSHjI5YnH/hrpM9AG
	floH30s2eRRSOQLfb+TYvd29yVQLX4o+9xGibZdTOUQ3Cum/8eGT7/Z7Dog8TpeNX5KgYr9BRkY
	PmPqaR4Iyew+/ZBqd1H/p3aVOWMXBHHM5dGSpChr/woOWghVMlT2DATUQnwNLnV9iVPS+hifukB
	765aeqF7Q0WmqkFe9QkjYsk63lLwMx7HL9Vb8qOml8DiCRg==
X-Received: by 2002:a05:690c:5688:b0:886:b9a9:238 with SMTP id
 00721157ae682-89736d2ef33mr29537287b3.65.1790062702955; Tue, 22 Sep 2026
 00:38:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2217.git.1788508426.gitgitgadget@gmail.com>
 <pull.2217.v4.git.1788942331.gitgitgadget@gmail.com> <b7b97262f27782f3271369115496c67f9774b8b2.1788942331.git.gitgitgadget@gmail.com>
 <aqOvAttPrhUIP_7U@pks.im>
In-Reply-To: <aqOvAttPrhUIP_7U@pks.im>
From: Thomas Bachem <mail@thomasbachem.com>
Date: Tue, 22 Sep 2026 09:38:10 +0200
X-Gm-Features: AcwNN1U0AuPVcXbnUSQkCxSDIL-seHMulhg7DW9EIOXMK7GGqtSe-rpGzvWrtKQ
Message-ID: <CAA0xjtpEXxuEkQRjwVACYfbk97WRdygi5W5ODaEF_5rfH5w+fQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/3] rebase, cherry-pick, revert: run auto maintenance
 when done
To: ps@pks.im
Cc: git@vger.kernel.org, phillip.wood@dunelm.org.uk, gitster@pobox.com, 
	johannes.schindelin@gmx.de, phillip.wood123@gmail.com, 
	kristofferhaugsbakk@fastmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Patrick,

On 11/09/2026 09:34, Patrick Steinhardt wrote:
> The only exception that I could spot is when we abort the sequencer. But
> I'd rather have us call auto-maintenance when `pick_commits()` is done
> and when we abort rather than having every user of the sequencer do it
> manually.
>
> Or am I missing something here?

The single picks. "git cherry-pick <commit>" and "git revert <commit>"
return from sequencer_pick_revisions() through single_pick(). Their
"--continue" returns from sequencer_continue() through
continue_single_pick() when there is no todo file, and their "--skip"
from sequencer_skip() when there is no sequencer directory. None of the
three reaches pick_commits().

The paragraph you proposed for 2/3 says it too:

> Unfortunately, there is no single exit point for this backend where we
> could add a call to `run_auto_maintenance()`. While one might expect
> that we could simply trigger auto-maintenance in `pick_commits()` and
> call it a day, a single pick as it is performed by e.g. git-revert(1)
> never executes that function. So instead, manually trigger
> auto-maintenance at several sites.

2/3 in v5 names those three returns. My answer went out under the 1/3
subject by mistake [1].

Phillip's answer when I offered the move [2]:

> That works for we and means we don't have to sprinkle calls to
> run_auto_maintenance() around to accommodate the different code paths
> for single and multiple picks.

So inside the sequencer the call would go to the end of pick_commits(),
to those three returns, and to the aborts. "git rebase --abort" already
runs it from finish_rebase(), so that leaves the cherry-pick and revert
aborts. The two builtins are the sequencer's only callers, which is why
I moved it there. Both work for me, say which and I'll reroll.

Thanks,
Thomas

[1] <CAA0xjtoW3JfSbuBot0ANFiDEhEv1N-Di4mSd5tYfgkFEeh07Nw@mail.gmail.com>
[2] <1e9f7b72-9f77-46e9-950e-df60b5a0539f@gmail.com>
