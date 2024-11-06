Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DC21EF0AD
	for <git@vger.kernel.org>; Wed,  6 Nov 2024 12:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896617; cv=none; b=SFf4J/cbRaliqVe94rPTg/11ea5RI8scn5a+Mc3j7DuKU3KBxidrQ1nmg0zoAmPQAu2Dl3VMOaHGkbrn0TgAGmb72bueCJQ/D9LMs8bBpASwelh52vgkirvzNaOpTDgVwhGMDNSgeAH89TiLzZBtmo0S5RAoxGXrekSBbx7uPXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896617; c=relaxed/simple;
	bh=/e8dzL6Ph91yGZ8/QRBP25uFpjIfu+aCrMcJivChCXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkBtVW844A+lV7h14YvmiAHb+aBvDmDEbThKNf3brHNu22rdU2zOMuOzIRsoQUrkYAcKoj4APM6vFOf9RGjjxwGoORoZr6YDVtZin9dDIvX/pWQTuuErz34okyp68t9A2bAWk9HEmb18V+b6LjpaWonxNN7dCRyNc3ebwDIgk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fiUSus9W; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fiUSus9W"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-71e4e481692so6420251b3a.1
        for <git@vger.kernel.org>; Wed, 06 Nov 2024 04:36:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730896615; x=1731501415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Uwamclc7mCXiEGUtQwV2oztuAcDxnHHgsy8LZXdCjas=;
        b=fiUSus9WYjE6y++I5e2jPpWKSdtx25wG4OOn6eoCjucIa0LhFQkGIdPTOICteXwOMp
         yJKbgn0b5woGm2bzpWIWFJ8JnuDTH6UCYF6Xb4sO8bbIzES8UOdQbTwBB/7TDrmZnJ9S
         hfQRw9YyCN9LiYuFpgJ/redwcb2I7TgAeO8YUKyVMcLg3iIWny3mLMJ2t0pVq75ibrcO
         OZ2/eUDiFg/SR1aIMVOJNfuXDRBbV3BPhno98qc6zubgvB3wDn4Icni/LtZ1LUhVkZHg
         /vfcbkzXy5xv+px8tp4NuwyUHg7h9ayLlp3ZXIcwa2pv96ux9QgzCxbKULbKAobF84V1
         JORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730896615; x=1731501415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Uwamclc7mCXiEGUtQwV2oztuAcDxnHHgsy8LZXdCjas=;
        b=PLXaHtEAJhwZcHEcDK58NLN9u9CkyqkUmbv+Lx+fidSRrvYoOgTGvFrEhDsJ+0RVjB
         YPac/S00Q07Qi3wtZaG28mkA0hcqF2ght2iWK/38vB0Kxni7w9NzHy24LnrvlNZtM/8B
         qsL/IGdeZ6Uad33rJNya8ydrqaHxXbFVS+lhYCHybKi1WEsITihf2HDTPhAFo8o5g/4K
         trDr9FuqkGIu4WDhd8cUZOCBuKckZ8LQq9AnUYQ9pktXeWL/EwPpocVks2DVd9EbDPMn
         U7bzmjvlxNgGbU03QDMFMXi0Yfzu5m07fkBFr+ymrnV1skfSj0S7LhEOy8tPb8Km7oGq
         v/qw==
X-Gm-Message-State: AOJu0Yx28l8ZoxrtEt1ZKtBEeFCOTXA5S/UnPQafbJPNJ4tn/WBRw0h1
	sIMy07GyAEFmW0BXpPT/iwiSfmNhswmHI5jIomcETCH3avizm37hIfOynFrI
X-Google-Smtp-Source: AGHT+IFPJWVT7Xn7qsl+nGKzj+hrvejTNrfMW4KnZsGVo2oYiUUvb08/pHaWMe7dKsH+CyaCCPThXw==
X-Received: by 2002:a05:6a21:999e:b0:1db:ecbb:39ed with SMTP id adf61e73a8af0-1dbecbb3a35mr9411714637.13.1730896615142;
        Wed, 06 Nov 2024 04:36:55 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc315ad0sm11550210b3a.198.2024.11.06.04.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Nov 2024 04:36:54 -0800 (PST)
Date: Wed, 6 Nov 2024 20:37:17 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 2/9] ref: check the full refname instead of basename
Message-ID: <Zyti_WrBfP8wA2ny@ArchLinux>
References: <ZxZX5HDdq_R0C77b@ArchLinux>
 <ZxZYXpuCD2I_3bNh@ArchLinux>
 <ZynFKPFcNQILce3E@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZynFKPFcNQILce3E@pks.im>

On Tue, Nov 05, 2024 at 08:11:42AM +0100, Patrick Steinhardt wrote:

[snip]

> > diff --git a/refs/files-backend.c b/refs/files-backend.c
> > index 03d2503276..f246c92684 100644
> > --- a/refs/files-backend.c
> > +++ b/refs/files-backend.c
> > @@ -3519,10 +3519,10 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
> >  	if (iter->basename[0] != '.' && ends_with(iter->basename, ".lock"))
> >  		goto cleanup;
> >  
> > -	if (check_refname_format(iter->basename, REFNAME_ALLOW_ONELEVEL)) {
> > +	strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
> > +	if (check_refname_format(sb.buf, 0)) {
> >  		struct fsck_ref_report report = { 0 };
> >  
> > -		strbuf_addf(&sb, "%s/%s", refs_check_dir, iter->relative_path);
> >  		report.path = sb.buf;
> >  		ret = fsck_report_ref(o, &report,
> >  				      FSCK_MSG_BAD_REF_NAME,
> 
> So this only works right now because we never check root refs in the
> first place? Maybe that is worth a comment.
> 

Yes, I agree. I will improve this in the next version.

> > diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
> > index 71a4d1a5ae..0aee377439 100755
> > --- a/t/t0602-reffiles-fsck.sh
> > +++ b/t/t0602-reffiles-fsck.sh
> > @@ -25,6 +25,13 @@ test_expect_success 'ref name should be checked' '
> >  	git tag tag-2 &&
> >  	git tag multi_hierarchy/tag-2 &&
> >  
> > +	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
> > +	git refs verify 2>err &&
> > +	cat >expect <<-EOF &&
> > +	EOF
> > +	test_must_be_empty err &&
> > +	rm $branch_dir_prefix/@ &&
> 
> `expect` isn't used here as you use `test_must_be_empty`.
> 

Thanks, I will improve this in the next version.

> >  	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/.branch-1 &&
> >  	test_must_fail git refs verify 2>err &&
> >  	cat >expect <<-EOF &&
> > @@ -33,20 +40,20 @@ test_expect_success 'ref name should be checked' '
> >  	rm $branch_dir_prefix/.branch-1 &&
> >  	test_cmp expect err &&
> >  
> > -	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/@ &&
> > +	cp $branch_dir_prefix/branch-1 $branch_dir_prefix/'\'' branch-1'\'' &&
> >  	test_must_fail git refs verify 2>err &&
> >  	cat >expect <<-EOF &&
> > -	error: refs/heads/@: badRefName: invalid refname format
> > +	error: refs/heads/ branch-1: badRefName: invalid refname format
> >  	EOF
> > -	rm $branch_dir_prefix/@ &&
> > +	rm $branch_dir_prefix/'\'' branch-1'\'' &&
> >  	test_cmp expect err &&
> 
> Okay, we now allow `refs/heads/@`, but still don't allow other bad
> formatting like spaces in the refname.
> 

Yes, this is a mistake. Junio have told me in this patch and I have
realized this.

  https://lore.kernel.org/git/xmqqjzei1mtb.fsf@gitster.g/

> Patrick

Thanks,
Jialuo
