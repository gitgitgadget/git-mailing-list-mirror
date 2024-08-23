Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CFC32C85
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724412982; cv=none; b=aisCK/eO4+dEhWAZCfYCS0b6WPP9nUmnimfgdUiMKFV4WTGKimdDWf/9fDvyphARrXPARja6Xhyctvx6fz7MhyqdiJWflP0gTID46P5A+4dHIpZc/g1Or3qfWbPl+gHKJWmn8c9JB7rvBlNLGEjsNaLPQofghw4rPleshf5Pkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724412982; c=relaxed/simple;
	bh=XnAy7kLKVAQ6V+x/95d73gibpX77jwHw1h4rD+PQMXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nz8wKVwwRlip6Q9W0U5Op4JXi7feAzksxC7SFmJeUT+1aeWYKeFbucY88vOEEE2untLBoySu7IKuTpXZ+pe5XsshYU+ufHSmmNO47oiMkmTDWIMt6V2T2P6mKTp7nVEH8RDwNnSFaT6TzSCkJMMhMvcOT5oqiVsB2AzIbpofBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMMQMDy3; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMMQMDy3"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5d5b22f97b7so1845909eaf.2
        for <git@vger.kernel.org>; Fri, 23 Aug 2024 04:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724412979; x=1725017779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zCH1Ab4RDANQ2CCYUN95txGJOaCVcFStYtCRWgWg8Ac=;
        b=dMMQMDy3dBMQceOtgT629GzKptGIxhbyGAaqcehBS9pvwOPwkvk5nxA+MGZWnLNSZn
         pphf1uhhD/p+n4iGULpmZopfufcW9tulGAjAKQqsrE4Ww13ccccFEAonwrKycDVjzk1N
         odstAN1CQKf2NePGOmYqZMfhHY6xabbh8iACO+5Am/sJlpqQQAeD2HdvkcqtNM5aYaZs
         U3mTE117NshPeZGNmcQBO2XY/UASBrseYF+8sWA12DrBTaM40oh5okEoP1W3g0B3QpGy
         TCUMDNnCSTaC33F9G/J8G3zTtme21oSB1bblK1V0A8P7sCZiIt+2N9AMazjBGp0xKlON
         y0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724412979; x=1725017779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zCH1Ab4RDANQ2CCYUN95txGJOaCVcFStYtCRWgWg8Ac=;
        b=UsN4W78qDdqUUVHO0x2ldN+8fWVszR7ORt/9mXG3NNJbMtcUOzlCYM1xCCpDEEnTlX
         jCrdcDviujCWFDCm3+HD+Gr/7L9AIMXiI4hpd4EZ2+ahhYzGsscI5ez8+vYLM1SxLM8w
         HHQgi8ytA8WJUenZ0yAk6l+Y28IYVzNosLtLOX2cMM4EZlWrYFK7eEuUEOmsLJmSsgxK
         TofJxVHOj2CEB+sLM7BCXADhwmcBSh0+0BPY0GrUZIiFnRizf9m0i3FQLr3ich80yk8Z
         vrKtemF4XG5OoouG7yaubJJ7xZrGgjHMqWLBo+f7Yx1yYeQUolTRYd1Q4y945QNS6Ppx
         3JqQ==
X-Gm-Message-State: AOJu0Ywy4FLiJ9NahYcjalfiUm33pt9txZ3aKU3gksKGDzz1XITxxTjn
	HOm7EtNMzhXpbpk9e/HJUof1d3l2gDLJCWlQMrOrrrZFfEZyYNp5
X-Google-Smtp-Source: AGHT+IHTi3y7oCueVUENrmhvQ0dC3NnWcq3iDiy913hDQGxRF6l9V469RhjvzMeJkZv/eBM8jhQVGA==
X-Received: by 2002:a05:6871:821:b0:268:2922:83cc with SMTP id 586e51a60fabf-273e66f6babmr1885018fac.51.1724412979471;
        Fri, 23 Aug 2024 04:36:19 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7cd9ad6e86fsm2589039a12.85.2024.08.23.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 04:36:19 -0700 (PDT)
Date: Fri, 23 Aug 2024 19:37:05 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 3/4] ref: add symbolic ref content check for files
 backend
Message-ID: <Zsh0YZDHQPfdkzhd@ArchLinux>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <ZsIM4OZWfylcP5Ix@ArchLinux>
 <Zsb8oDA-vyLxNY0U@tanuki>
 <ZscyGg8M8TbJVKNS@ArchLinux>
 <ZsgfyogIFC1ECN32@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZsgfyogIFC1ECN32@tanuki>

On Fri, Aug 23, 2024 at 07:36:10AM +0200, Patrick Steinhardt wrote:
> On Thu, Aug 22, 2024 at 08:42:02PM +0800, shejialuo wrote:
> > On Thu, Aug 22, 2024 at 10:53:57AM +0200, Patrick Steinhardt wrote:
> > 
> > 
> > > > +		if ((space_num || newline_num) && !isspace(*p)) {
> > > > +			ret = fsck_report_ref(o, report,
> > > > +					      FSCK_MSG_BAD_REF_CONTENT,
> > > > +					      "contains non-null garbage");
> > > > +			goto out;
> > > > +		}
> > > > +
> > > > +		if (*p == '\n') {
> > > > +			newline_num++;
> > > > +		} else if (*p == ' ') {
> > > > +			space_num++;
> > > > +		}
> > > > +		p++;
> > > > +	}
> > > 
> > > Can't we replace this with a single `strchr('\n')` call to check for the
> > > newline and then verify that the next character is a `\0`? The check for
> > > spaces would then be handled by `check_refname_format()`.
> > > 
> > 
> > We cannot. Think about this situation.
> > 
> >   "ref: refs/heads/master  \n   "
> > 
> > We find that the next character of '\n' is not '\0'. Then we leave it to
> > "check_refname_format". But "check_refname_format" will report an error
> > here, but this is an allowed symref.
> 
> Wouldn't it be correct to warn about this? To me the above very much
> looks like garbage after the refname, same like we'd also warn about
> such garbage for direct refs.
> 

Yes, we should warn about this. But only null-garbage is allowed for
symref. The following situation is bad:

  "ref: refs/heads/master  \n   garbage\n"

We should report error here, from my perspective, it's a FATAL ERROR.
However, let's decide how to do this when we know what fsck error level
we should set.

> Patrick
