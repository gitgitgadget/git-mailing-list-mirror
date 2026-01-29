Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DAAA227BA4
	for <git@vger.kernel.org>; Thu, 29 Jan 2026 19:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769715063; cv=none; b=CsPa4je3kUuVSB6Mby3cYSCYb3njCV7jhOkKVS36fzzNcP2wnE7ioovi82XBqDUr75bVglyu33tEcpFLFrgjZeIembi2xMSiN3rcjAiHd60IvH5SriHr1EN4UpoPwTYkx+KF164dwwqN9v9VALrUPUpKrxs62C6wQ2TMlqIZ+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769715063; c=relaxed/simple;
	bh=I+UCM17eLIcVxBwPgTlWXfmRqgoQ8AZTphXhOfytvec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP2BJbGs0D1E7TxNylYe9bvp4TaxX8TFaHr117FWhT+5lgkHmMcTjwA2hcj6GHSslhxNgdKDklMAY0zrYM5/i8vwMPggxm5F15tIaTJ2g4J5zVhrdeN/OIHrApsGk75mkUZNA8dcuM2026heszsaZH9eOuuRMa34EaYdb/PDTCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NsMJdnc4; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NsMJdnc4"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7cfdf7e7d19so1197193a34.2
        for <git@vger.kernel.org>; Thu, 29 Jan 2026 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769715061; x=1770319861; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f/2cKv6GXzEo8dLieY5W/gpTtIqO6MnsVT+bX+eSHDo=;
        b=NsMJdnc4LswTwneVbuS3KXQnqFWQe8f8A75xBywCTdVojPB7IjkW0Um6/8fZxZiQ1b
         0VzSVrYopahR1pc9tmV8MRpNaDUuQQvDWZ8tPzePxrP7S1AcckZdNeFMVkVuTlaADGC3
         hNrzpPfFdYsi1YapczEhBEh0FrsfDq3IPAm+Nk6c2tu5ymrS1sRze15cQdDsgtk1lSLY
         dmpjHro0SXLhp6SyPWcMeyJsrAkbCX918JpOdaLu2Lt/eZ4AMIkPNFmHGi0+entHRW3c
         fgvxRs4bx+UxEJoaRFm/AQJYzmka16MtCednw6rMRUO7WPkxwlJ7ofmZEzcTQ8fbnfHB
         Yc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769715061; x=1770319861;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f/2cKv6GXzEo8dLieY5W/gpTtIqO6MnsVT+bX+eSHDo=;
        b=Id3W299+MChPskI1kVqFIeQYPWMfIGjYMqrhMyjR8t2nC2Xq9zJ/fGDd8YmLp+tRfz
         i7Evz2TLNMrhrHCQ9zQtRvxMhr82lhFtcirUZ91w+4P1bvKMoJ/CTvusHszdKhaKAIau
         WXI97BlRdkegx+9tI8Q/+mN6v57vfl+tAdbXZYWrodmy8yMI+TIjvb9q5LTIugGjBKuY
         lyuPBkc3cyU/em+kZEJCa5gJRWN5eaCfHB+d8ZCLQbWoy0aaxISuG3zw5vmTNDuQ5/xk
         jjnkA7A8KmpGLBnc496jz54IzVrR8/k8LY2+rHeUmeg0aPUS1ifgA9Sv9ahDOwT9VxCm
         43+Q==
X-Gm-Message-State: AOJu0YzjjhFagWZ/QXVrVCNtlfcfoscB49C+DK1nKeNC8dWc4MgzSAVP
	yUp4YHUAIqSpB1B47IbS3O6roDkQzqHddH7dBmZ8RGOi1+ETtWDOOAqKMUnlZw==
X-Gm-Gg: AZuq6aI+lpoHT+quoY1T1/qoKFyCtFcdFuzGvI/xZyO2A1Kc+klkw8b/qG/gA7jZ+Ai
	NXQ92wMlvMkEXiCndk6buFmJDMXcVPZ+EGz5EckAozrVzEDg3D7D8xYlGHHTg3ovr3JP/0bTDGl
	Tl+4X6U3CzfCAS67AI2IjxUeh6E8KB7+fwsFR5DQskhYURL/5NowezHF5vtxhNO4yh4nkOSiBfD
	bmdElyiA+1jWRq4BcElsIOM75dWKblrAfyJaNLvdikYLvnooo6vVxlmIKHOvPMCSBE9SNHvAYFN
	EThzqvWcsocn6WMonA43c+RCVAyBIzQnJLGclMk236Sykmocn18RG+bwv1ugq+Jm2xLWNi01bUu
	TfA/0kOxmxkEoaHdNacgnI0MN+dzN4l1jvNI6SORx0UDqI1cflZBLXkFUuIeePE3NXxyZkJMhQe
	tPKIxRw57tt9q8Fgw=
X-Received: by 2002:a05:6830:63ca:b0:7d1:8e24:724d with SMTP id 46e09a7af769-7d1a53d3833mr433596a34.38.1769715060931;
        Thu, 29 Jan 2026 11:31:00 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d18c8016fdsm4159133a34.25.2026.01.29.11.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 11:31:00 -0800 (PST)
Date: Thu, 29 Jan 2026 13:30:54 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] odb: store ODB source in `struct odb_transaction`
Message-ID: <aXu1IDsaUbmUzHop@denethor>
References: <20260128234519.2721179-1-jltobler@gmail.com>
 <20260128234519.2721179-2-jltobler@gmail.com>
 <aXtDYY0Ao24Mpgyb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXtDYY0Ao24Mpgyb@pks.im>

On 26/01/29 12:24PM, Patrick Steinhardt wrote:
> On Wed, Jan 28, 2026 at 05:45:16PM -0600, Justin Tobler wrote:
> > diff --git a/object-file.c b/object-file.c
> > index e7e4c3348f..196509b252 100644
> > --- a/object-file.c
> > +++ b/object-file.c
> > @@ -728,7 +728,7 @@ static void prepare_loose_object_transaction(struct odb_transaction *transaction
> >  	if (!transaction || transaction->objdir)
> >  		return;
> >  
> > -	transaction->objdir = tmp_objdir_create(transaction->odb->repo, "bulk-fsync");
> > +	transaction->objdir = tmp_objdir_create(transaction->source->odb->repo, "bulk-fsync");
> >  	if (transaction->objdir)
> >  		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> >  }
> 
> This makes me wonder whether we should first refactor the `tmp_objdir`
> subsystem to receive a source instead of a repository as input.
> Otherwise we "pretend" that the transaction is on the source level, but
> we ultimately still end up creating the temporary directory in the
> repository's object directory unconditionally.
> 
> It wouldn't really change anything right now as we only ever write
> objects via the primary object source anyway, so the end result would be
> the same. But it just feels like a good first step to me to fix this
> conceptual inconsistency, and it shouldn't be too involved either as
> `tmp_objdir_create()` only has three callsites.

Ya this seems reasonable and I agree that it makes sense to do as a
first step. In the next version I'll make this change in a prepatory
commit.

-Justin
