Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC2B1CC160
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 19:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729540351; cv=none; b=KhH8Iua+a6D+OQWVOTzt7TsTNmiq/qQjkfMjVo4mLFsyjkg9kk3BGktB7B8EDFb33kY4VbbysHS0n1KKH6ohcsgd8ksCBGWcTs1oC0qe3/7YkNdqWh0XgFjD5LkzxcI/G3ODxzkb2yjLwbeXqo6bBLkrpZ0+2OMAoZAR2uNvGcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729540351; c=relaxed/simple;
	bh=O9/9RHjOc/4qbxAnGPvfV81X+Pm96KroOlDnC0C4Sa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N/wkWfFtZxW6bwd8znMw0nDCCHpdZg3f3PxfnrOk8rLtTP5HItkqCTZ4k+Xe5Q3yb3aRqe2Qsg3/twhOSN/pnEP8ghYx0Wh1c5wSsFLVku5zkSQXS0Lr39CZq6Og/Kz9VvQNtGssId1pkYPVu5dDl90+kOFZn/0fSmie86VjYds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ekRgv1Z9; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ekRgv1Z9"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e2bdbdee559so1657818276.1
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729540348; x=1730145148; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PwPL5VcPYpdWS66ZtIBJAfWEJBacBmpBhRUTfKC1MOI=;
        b=ekRgv1Z9JY62tFY6A56e7Emko0g20eZtZmEswC0MGMmsdfuaMlswMuhLJmSVhEXt5+
         hdOsZR8DDCOjLNak+aW73zUPO2A/gQHFSlDF3glyO2B3N8x7qo1axw7OloTuH76ZXYr1
         Wu+57w8GbPLqLNkSEkZ7RjKfAm/UevHpcYtGoUXQA/iVinrrO58XhYtUSc3dpVdh0MHA
         5nm8PTmmDquN9F4uGYv3hWvIAbpu7Ip4jVPcImv57OvIIoV6FJKW5PubpK/bp11xtShV
         GF3FsmX7hERnB6Y3IlaN50V0YZVZ2Gxi7x57XiGThEFn4C6kEMz6R6QngtL1CFcyk3sr
         UArQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729540348; x=1730145148;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PwPL5VcPYpdWS66ZtIBJAfWEJBacBmpBhRUTfKC1MOI=;
        b=L0N3b+MID2DeCFF1t0RNZnGZ/mmwkkPoK2wZ1VDctBu5+tcc9oSCXAyHDMa96TqqZF
         6BsGnhKNhdzzcp363Uxmw0c6BAZa7gN5LZKdup4azHk5Ep+BNZfrQC1q0VGwmuyPPWGX
         YX3LL+mPTSdXOvfyXruVEb2KYwNsqpz4cH2mCB0e0AOyvNBxGg23PRYxhjebiJV6/o/o
         KI/V70avL4+fnycQ4Baapt+YyyriXlUjQzEdPFMagn2GAOj6SusNFcr3CyiXye9dwtqi
         vKNaU5AJCS7Lj6Q2GnVwUkDLvjDBvjO+C3Cm/TnY0KXmH/aBqxazzP2hJTjKIgKdJhFx
         zf2w==
X-Forwarded-Encrypted: i=1; AJvYcCVT5w99OQN9WioXyE/zUPsXttrooCLn9X2P30+5JrRoDwr8xe7IDYiHG7pPgrNNmWR0fP8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqoD0UOxqCb5JYi8zqpyRKBs4AZKrcA7nOiOOAN2EIqSBRH0Bw
	3rMM1FoKLNffvZMPFlecZSHB7eltNF9vvy9VmG6M8veKmYhTisYW30xYugrzJqU=
X-Google-Smtp-Source: AGHT+IFQ+oSKiApp9qsLquYHTgfYdO4hfroQXbR1Z8F+q2RmIqis3CeGj8ZNhe48GhsGR1+RS6dvxA==
X-Received: by 2002:a05:690c:330a:b0:6e3:1903:5608 with SMTP id 00721157ae682-6e5bf9e816bmr101608527b3.21.1729540348458;
        Mon, 21 Oct 2024 12:52:28 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5acfbb4sm7929357b3.65.2024.10.21.12.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 12:52:28 -0700 (PDT)
Date: Mon, 21 Oct 2024 15:52:26 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Samuel Adekunle Abraham via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Samuel Adekunle Abraham <abrahamadekunle50@gmail.com>
Subject: Re: [PATCH v3] notes: teach the -e option to edit messages in editor
Message-ID: <Zxaw+pUMT4juAePD@nand.local>
References: <pull.1817.v2.git.1729382580491.gitgitgadget@gmail.com>
 <pull.1817.v3.git.1729521495497.gitgitgadget@gmail.com>
 <ZxaG67wuvjOXc5kr@nand.local>
 <CAPig+cSw_F97nBzO3Z7t2Zrv5TZwGnYiQLhpq2iKgLfxhhxvfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSw_F97nBzO3Z7t2Zrv5TZwGnYiQLhpq2iKgLfxhhxvfQ@mail.gmail.com>

On Mon, Oct 21, 2024 at 02:28:05PM -0400, Eric Sunshine wrote:
> On Mon, Oct 21, 2024 at 12:53 PM Taylor Blau <me@ttaylorr.com> wrote:
> > On Mon, Oct 21, 2024 at 02:38:15PM +0000, Samuel Adekunle Abraham via GitGitGadget wrote:
> > > +     MSG="Edited notes message" git notes add -m "Initial notes message" -e &&
> > > +     echo "Edited notes message" >expect &&
> >
> > Very nice use of the fake_editor script here.
> >
> > It is a little cumbersome to repeat the same message in MSG= and when
> > populating the 'expect' file. Perhaps instead this could be written as:
> >
> >     echo "edited notes message" >expect &&
> >     MSG="$(cat expect)" git notes -add -m "initial" -e
>
> This suggested rewrite feels unusually roundabout and increases
> cognitive load for readers who now have to trace the message flow from
> script to file and back into script, and to consider how the loss of
> trailing newline caused by use of $(...) impacts the behavior. It also
> wastes a subprocess (which can be expensive on some platforms, such as
> Windows). If we're really concerned about this minor duplication of
> the message, we can instead do this:
>
>     msg="edited notes message" &&
>     echo "$msg" >expect &&
>     MSG="$msg" git notes -add -m "initial" -e

I am not sure I agree that the suggested version is clearer. The way I
read mine is that we are writing what we expect to see in "expect", and
then setting up MSG to be the same thing.

I definitely do not feel strongly between the two and would rather avoid
nitpicking something as trivial as this when compared to the rest of the
patch, especially considering that I would be equally happy with your
version.

I think the whole thing is a little bit of a moot point, though, because
by far the thing that is least clear here is that setting MSG has the
side-effect of modifying the behavior of the fake-editor that we set up
earlier in the script. So I don't know that optimizing for clarity in
how we setup and write to the "expect" file is the right thing to spend
our time on.

Thanks,
Taylor
