Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0123F12F4
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 16:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527714; cv=none; b=gMPPH9wR2RS2nOf/AGahzSkUspttK9697VuLW4V+OSp3LAVbuGeXqG6YaivN2BywKw4Rq520zUMkTuoDwdS0Yw6JQ+7ORHx55Oy0eY+xEiBryHTAyEVtBlPx50Uc7HE0+b4t9QuN7y3MNpipKymqci+GDh8roYxaibRVPtNSf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527714; c=relaxed/simple;
	bh=gEh0Hl/FuAQrU2iAze7tU5nogRIRjNt6oXBGmHxJ9cE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j2qR7IIKwYSSCEnCC7tOOD+BgjzNPpcfDpE+3fVg2zgoHfEtRqLaR9mInXjBNaodrjLyPSsNmb3yWaW4DHHqsi8SelUrfOaqqfaG2r68eLUJMmR0T546WktyoHgcyfGXwpXNXEW/jHGYBxUqHrri6sKcjCOVeA9SBm/mSw92gN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1hA6gzy; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1hA6gzy"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-48982e3f12cso638031b6e.1
        for <git@vger.kernel.org>; Wed, 08 Jul 2026 09:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783527712; x=1784132512; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GarTvlTB8nXvA4D1/pGrN7cZbITKQIN/zyFqicspTco=;
        b=J1hA6gzy/T4itKgssW9j9Qdg8d2iTD2ZLUH69se0O0R4CiMEemuXVUSY0S407Z+gui
         bU+kct5buJ9sfww9TjrdldHocXohqQ145pZOP3Xm9HHwkgJSnzChlbTGPyUoIpvvjUfk
         yGcQ8MBVs6aJ322w9sgrOZ2K9P8K5SQy+8BKibUm6JPHScFst8Ydjb1MrMWiQoYGaVDE
         xCIcckm2SHWo9gd68WAgbf3B8FFuUkiMIs11GeIIJHKQ8pKzEzPk/mJbJsBgS51WdNes
         bcvPIjjWuVop4glv/eviv31rYeEs7+KbC5SyMoN12C4YjZaXDlcT4eQgQsdFjOMhvGTB
         7KLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783527712; x=1784132512;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GarTvlTB8nXvA4D1/pGrN7cZbITKQIN/zyFqicspTco=;
        b=TyL+n72LnqRiyuxXLyYBWWA/GCrQj/Gvxnou7vJuBXfoEAhjWqv1whOBrxTHe5hTPX
         s4tO9VjsKKbKm4+QHCkXBkv9yOtQREzoRpcE1Yo/Nv9DRQKqv3oL61J/l63sZG+hXEC6
         laPu3aHjOubJYxAfQV9vk0tjuNAmpVHDsSFTAO4BI7fqN6qDB0TlHE6COyLmyGrssPrs
         hgLYVuawKIF7SiCorGsFrVk2rIlaB2DeMROmeSuao0SSIMaDFKGjihBnzM5FdIvie0G7
         oDuRDz3uiA5S1LIeRIykCxr44fsQvVwWw9NuvGhcDTFAKfjAs6bmYRebABXd2ZxXYnMt
         Ap5A==
X-Gm-Message-State: AOJu0YwhcbNOfQ6GbbUMx5iZ3u/tOmk9Ulw90MHPAGeoomK4swRwHFss
	LdTF4rSeIA4dyWulsO/M9PWthymCUiY8bB4tvUip2vov75+wQ5mFbSgz
X-Gm-Gg: AfdE7cnou2CUNMI2qyFgIAdbURCLVxpCS1zN4sW0oNRNwMVo/+xP/J2CgSGSs3y5q67
	6tiHvyyOIgRRqtfh30ykxYW4DLckt6rjaDfvt1eP5f2r5qYG3er9S3yFhdLEtn+y4jkvBOeGneI
	fWIvsOlFkbTvlgEBJX1DwzZH/DQoyCd4EFTvq13jZ46xtTo1pEgg6WBHNiPNQgK7BZpkcgL+4vy
	HvGtPIHCW8H4FZK4XYSgKK6Eg/tf2ZVTKDVTQLvIuJUINtvksLqMjOPJ7aJ5I9YkKaI1qKzmH+T
	WqAloGIOXgngxUVXKUiUON9/Dm/SHhQWEaCjzlT2s1i6Vbb/5YIPYQhr1FYyyLzifkjhYgF8Wiv
	qzmpvggBhZSCAxVQbGvFySxo5f9En3B7eKE0wIHLiksn3j5LlpMTThFJayJ60fROdzsSMb4eyE6
	EyNWCs/A==
X-Received: by 2002:a05:6808:5384:b0:497:d0ea:7dad with SMTP id 5614622812f47-4a203cc0028mr2381738b6e.22.1783527711908;
        Wed, 08 Jul 2026 09:21:51 -0700 (PDT)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a1acc82f3csm2037815b6e.3.2026.07.08.09.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 09:21:51 -0700 (PDT)
Date: Wed, 8 Jul 2026 11:21:48 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 05/11] object-file: propagate files transaction errors
Message-ID: <ak54WpyT2QRMtfa1@denethor>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-6-jltobler@gmail.com>
 <ak3xHiOQfNxqFR58@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ak3xHiOQfNxqFR58@pks.im>

On 26/07/08 08:41AM, Patrick Steinhardt wrote:
> On Tue, Jul 07, 2026 at 11:14:06PM -0500, Justin Tobler wrote:
> > diff --git a/object-file.c b/object-file.c
> > index e51389833a..64cb874fe7 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
> >  	 * added at the time they call odb_transaction_files_begin.
> >  	 */
> >  	if (!transaction || transaction->objdir)
> > -		return;
> > +		return 0;
> >  
> >  	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
> > -	if (transaction->objdir)
> > -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> > +	if (!transaction->objdir)
> > +		return -1;
> 
> As far as I can see we don't report any errors as part of
> `tmp_objdir_create()`, so we should probably print an error here.
> 
> > @@ -1668,14 +1672,19 @@ static void odb_transaction_files_commit(struct odb_transaction *base)
> >  		 * Make the object files visible in the primary ODB after their data is
> >  		 * fully durable.
> >  		 */
> > -		tmp_objdir_migrate(transaction->objdir);
> > +		if (tmp_objdir_migrate(transaction->objdir))
> > +			return -1;
> > +
> 
> Likewise.

Ya, printing some error messages seems like a good idea here. Will do so
in the next version.

-Justin
