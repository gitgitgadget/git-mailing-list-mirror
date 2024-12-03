Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD9B17BB16
	for <git@vger.kernel.org>; Tue,  3 Dec 2024 14:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733235918; cv=none; b=ivC47mjUYv27ll9rsc8FCQdCrkIIJWlQJLRE1ThHZQJ7Rt8+ic/y+hEtKlLl+tdpL95I91b+UzOjbq7LnQKlGeCsxwF+Gts2dZGKYYqk/L/qRBToiST5haJ7I8O64DOH7mWIod//Aqqno2IiLwZEcFnKyFEKOa/fG9MCNH1RwQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733235918; c=relaxed/simple;
	bh=5dynLA9l4+rRsWZhW+jWnqmZjYUvUDMASZeEKYd0CHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kytovTxoVtS72iPjvciyoow5g2ItrLEJXLTiihNNo7jS1k0OOJ+1TZNKmXDcByAgqKq+ZTTja7pGluhL/tOCk6kDWe3YF1SSJbGGxDnd/9dSir28Gqp6igXvDUMq2Uxq2umw/6pzXZ13kKfTPPNlaUcBcfUfoGakqSzxC94wlvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVM88VuI; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVM88VuI"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3ea55a2a38bso2974059b6e.1
        for <git@vger.kernel.org>; Tue, 03 Dec 2024 06:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733235916; x=1733840716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DBBj1feQvKa/5oK2Qh4IW9vzak4C/TQV4XYxGxQaU/8=;
        b=GVM88VuIQa4OeK3iDPG8Tc1LmkVGYvWfP04yjbbYST/647kkTbFI9DadR0yRs3XsVm
         YiAjzLiEg2E0SRI2hAj4gfOpmWvvDJV3NlTXEa8XVjMrS7SYBKOpyGg8uJOMAFd/qGq+
         f36pVxMylrKHWraCqy3+jE6PPnW8V2Ug//9Ak61gLEAtXBoMfbrMLWqYSfu9B+vI2gKr
         vHWk64RP0Hu3BtaDu87uAzRI8TPHTkT+GRpSQ0voYLPKUSsoY+BabkIJYdHxwqX4JLOc
         +jd+K1oH8VVXSU6C17++V97yQTso9OYn4FpSrFwzjMZyZ1+lCmKTFppArUeMIULDs27g
         CfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733235916; x=1733840716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBBj1feQvKa/5oK2Qh4IW9vzak4C/TQV4XYxGxQaU/8=;
        b=sxdVSPCNpR8Vv+NEMUCiIq2fp74ySmkmZ5+Jb2vP4DsX6u+LRK6tUcOlE/U72qpt4H
         6RfURhyv7n0puV1DU8sdRj1buXpJ6QzTxgmmmV5p3mGTsH8bmqEY7+zPlXbXKvVyKgp/
         Jjk21/Ad7dE9Mq/Ng2cPPmmpHt1eobqp6RLvZ/RDvVvVRGWCVycWmHGhYiyk75jeIKrK
         Ps+Rz4kzHY55vE63UuhuftBH/AulwQtcp/Ql7awFCSh6beNjVzdDbdRNEi54W9Tbg5mn
         9h6YUalZE9LwnTUgw+bXsnhhDoI3qUEInMdYyPLmhSPjwDNp0WIMj/thKxg4GSzHYze+
         +pGA==
X-Forwarded-Encrypted: i=1; AJvYcCXBfcqnisIiC9eu79Lv5gqR/BrPzw7txQFNt+zvRzjp8fCgqPs+Lqo06TikWZhJSgcreEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT5S69QDJwRgZ6VY8I2+5PGMj4rDH3utDwHGoRQ6BWzzbzox0q
	BnrkoZ3XCCdZpBO1SC3cIg9Gz83i43iPBtZYfClVkm66As0BI6XF
X-Gm-Gg: ASbGncu+AsuoSWRkl9YVkjPfAZ3U9jYfcxaXPonSlj73o717J7Qo1s5FGEqUYBhLj4I
	JPLarmlNW0qMRUomrpSQwBLP8FBfe3YJYI0Wpl0rwYDwFRK51aa+rTKs/8WGQBQJ/NoszGySp4n
	WB1T6GXWLYfmDUn9zHL2YWu9NYWXBrs/saATh1LVLMEFCpYloFbDpvCUtEl1YLFi6YvxIanoEFI
	YuomhYFIgNHupK9puC6+s+9ZojsM1QyOD8PnvGVGoc=
X-Google-Smtp-Source: AGHT+IE44iTp/ttbufPBnYYonMeqbVM03vouQa0bbZwCBzyRJidwDNFf72wWT7Pn+H9N3ZvkBBoEzA==
X-Received: by 2002:a05:6808:23d3:b0:3ea:431c:4f70 with SMTP id 5614622812f47-3eae4c7f3d3mr2334175b6e.0.1733235915776;
        Tue, 03 Dec 2024 06:25:15 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29e7beb059csm722990fac.15.2024.12.03.06.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:25:15 -0800 (PST)
Date: Tue, 3 Dec 2024 08:23:11 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 3/4] fetch-pack: split out fsck config parsing
Message-ID: <i7tvwk462uwe3syarrnmjttgu4p7urtymq4n72kj7ziaptu7iy@vh4td5fd24ko>
References: <20241127005707.319881-1-jltobler@gmail.com>
 <20241127233312.27710-1-jltobler@gmail.com>
 <20241127233312.27710-4-jltobler@gmail.com>
 <xmqqed2wox8n.fsf@gitster.g>
 <Z07QqowPVEgJ3sIw@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z07QqowPVEgJ3sIw@pks.im>

On 24/12/03 10:34AM, Patrick Steinhardt wrote:
> On Thu, Nov 28, 2024 at 12:25:44PM +0900, Junio C Hamano wrote:
> > Justin Tobler <jltobler@gmail.com> writes:
> > 
> > > For `fetch_pack_fsck_config()` to discern between errors and unhandled
> > > config variables, the return code when `git_config_path()` errors is
> > > changed to a different value also indicating success. This frees up the
> > > previous return code to now indicate the provided config variable
> > > was unhandled. The behavior remains functionally the same.
> > 
> > > @@ -1866,9 +1866,9 @@ static int fetch_pack_config_cb(const char *var, const char *value,
> > >  		char *path ;
> > >  
> > >  		if (git_config_pathname(&path, var, value))
> > > -			return 1;
> > > +			return 0;
> > 
> > So, after getting complaint about a misconfiguration, the caller
> > used to be able to, if they wanted to, tell two cases apart: a
> > misconfigured variable was ignored here, and we happily parsed the
> > configuration.  Now they no longer can tell them apart, because we
> > return 0 for both cases.
> 
> I wonder why we want to ignore these errors though. Grepping through the
> codebase surfaces that all other callsites of `git_config_pathname()`
> return its return value directly, which means that we'll die in case the
> path name cannot be parsed. Shouldn't we do the same here, or is there a
> good reason why we need to ignore it other than "We used to do it like
> that"? In other words, I would have the below diff.

In both "fsck.c:git_fsck_config()" and
"receive-pack:receive_pack_config()", the `git_config_pathname()`
callsites are set to return 1 on error. The main reason for ignoring the
error was to keep it consistent with the other fsck operations usage.
Outside of that, I also wasn't quite sure why specifically
"fsck.skipList" parsing is not as strict.

I do think being consistent would be nice, but I don't feel super
strongly either way. I'm open to changing it in another version if that
is best. :)

-Justin
