Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6087221E3BC
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 23:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034895; cv=none; b=lF79TMrVS4wir7gW98LkwWVu3X5rbGKqD/TPrreBcYuw3KkVhAStZWX31Gg5xl8QM8/MOSNSU44CAf12O7GYin45BcQBL+JkWC2UqCe01SPOfqPtxPLi03Kt6ebEijpmSBVzJwR9FNWT0z8Didp28D7REJO8C7xsaEozBFAMMvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034895; c=relaxed/simple;
	bh=RDW2iQWwzHFH3F+ey1eWZyfYBoexbK0T9+nSchj6Dn8=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPNVrPSFqlSsr25JOBUPC/9kbFtCOJcoT6wPgA+8Ykz1Fy+INyQPAfSJtUqHPLINKr/oQPD/uycoTcGDT7i7igxjgHw0w63EJkPjjxb6O/pYYGAu14QIhVzf0X4wXQMH3OdMuYIGTNIH/rwyk5uQGQII0kezMzx+LsUOfzSjca8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FQd291wM; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FQd291wM"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6e34339d41bso41704607b3.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 16:28:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729034892; x=1729639692; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RDW2iQWwzHFH3F+ey1eWZyfYBoexbK0T9+nSchj6Dn8=;
        b=FQd291wMTt+mmBY7f5VrcJ5E36JZ8FQu8ZbrIrxc2HvVkVa3GAJaF0EC9kLNLoh3NU
         BGFWJDHUcMG2xclyI7a7v7aPVhcX2ZV2kl5E5uJdT5mgejesQeE7++p25c1moC4i5ArF
         /whBEi1rPoLnwLZVey+LCaBx7zDebX+jvmWbts6qgcLtXkqHdRMLxnf3qzX5aE71imrb
         OHgX8cMUdSB0YUf6ZAWEVsCUMr94cmcrlsaCniZDG0+zw4hGhnBZJcs533ZJXdz8byx3
         x0eBYxs38jgVTaYX8iuZo3eeT9J/yJjnXzlRfKnn/uUMZnQBRh0WypX2m7LYRcUBoh/G
         xySA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729034892; x=1729639692;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RDW2iQWwzHFH3F+ey1eWZyfYBoexbK0T9+nSchj6Dn8=;
        b=r0wFlINtZCxmflwScaJ2Mi8s4x7gQnyvkBkQbcSpZ4dB+hAxZB1QDz1oEBJnfaLSUa
         Z6GAeI7MTIzQDdGW9i0kCFxYERXj0lJ9L49g//JyzzYpl/Wso4CTZ2CuqFLh/a4dB9fF
         Wo/CF4q+GJ4/DgN9qB6gZsqAnj3yUtYhB9w3z5/xzH4BRUt2yowtIUHMi60Xv0yZsyVj
         2cLtXiCXbXWx09gUeTlJO00LgFJsaKjzMaLOmVgThaROxdIFsrGKR1kzCO6oQwHhehDl
         bAWf3GJLeV8puTOg2HV7KyvB4FfkAHEyWLKLSM0wPf05/KFhgIxcIqylyeh0Qose4SrV
         4Qfg==
X-Gm-Message-State: AOJu0YyC7Eo6yOOyTvXHSw1qiYyS+N+jDkVDrYSP1K0jnN3C8vEpbPBP
	/Iil+qy8ZFu+JRcvdqC1KjoZo466L1PD/tCnfV+NdfYVmv/RPka2ngsR6V0ouBpc/9IJEXIQjCb
	c
X-Google-Smtp-Source: AGHT+IHhrocbbuswFm7Rsh9b5Ph+agj0cQ7HKnWNOuFTLkG6SrUtmAx6dImQBAADD0r4+mKA8+0o4g==
X-Received: by 2002:a05:690c:7004:b0:6dd:76ce:d6c9 with SMTP id 00721157ae682-6e3d41e8da5mr25248787b3.42.1729034891664;
        Tue, 15 Oct 2024 16:28:11 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5b86de7sm4873197b3.59.2024.10.15.16.28.10
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 16:28:10 -0700 (PDT)
Date: Tue, 15 Oct 2024 19:28:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Subject: Re: [RFC PATCH] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <Zw76iYXJQq9gJCj8@nand.local>
References: <20241011183445.229228-1-wolf@oriole.systems>
 <r4btv3hmwv6haflwhmjbjshova4wnth5mkbknsuuqcvose5lix@bvy5e6gxnit6>
 <Zw7IiwK5mi1rmqFN@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zw7IiwK5mi1rmqFN@nand.local>

On Tue, Oct 15, 2024 at 03:54:51PM -0400, Taylor Blau wrote:
> On Tue, Oct 15, 2024 at 11:33:35AM +0200, Wolfgang Müller wrote:
> > On 2024-10-11 20:34, Wolfgang Müller wrote:
> > > Whilst git-shortlog(1) does not explicitly need any repository
> > > information when run without reference to one, it still parses some of
> > > its arguments with parse_revision_opt() which assumes that the hash
> > > algorithm is set. However, in c8aed5e8da (repository: stop setting SHA1
> > > as the default object hash, 2024-05-07) we stopped setting up a default
> > > hash algorithm and instead require commands to set it up explicitly.
> > >
> > > This was done for most other commands like in ab274909d4 (builtin/diff:
> > > explicitly set hash algo when there is no repo, 2024-05-07) but was
> > > missed for builtin/shortlog, making git-shortlog(1) segfault outside of
> > > a repository when given arguments like --author that trigger a call to
> > > parse_revision_opt().
> > >
> > > Fix this for now by explicitly setting the hash algorithm to SHA1.
> > >
> > > Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
> > > ---
> > > I think there is a much cleaner patch here if one would look at
> > > disentangling the parsing machinery split between cmd_shortlog() and
> > > parse_revision_opt() such that the latter is only called if there is an
> > > actual repository, but I'm not at all familiar enough with the codebase
> > > to do that. Like the commit says some other commands were fixed like
> > > this as well, so I thought to send this patch your way.
> >
> > Was this topic maybe missed? It's not a critical fix but would solve a
> > segfault that is pretty easy for a user to trigger.
>
> Yeah. It looks like this was sent out on Friday, which was Junio's last
> working day before vacation. I think we probably both assumed the other
> picked it up ;-).

I picked this up today and applied it to 'seen', but ejected it before
pushing the result out, as this appears to break CI, presumably due to
the mixed declaration and code in the patch.

Thanks,
Taylor
