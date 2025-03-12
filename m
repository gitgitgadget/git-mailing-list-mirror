Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98DB01ADC98
	for <git@vger.kernel.org>; Wed, 12 Mar 2025 21:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741815882; cv=none; b=Kwt6ursSYmwa1ErE/UA2ngO1qwzgtj+KNqm8wyv27OElvop7OGfY9gt1tMuC6u0Kj6Jq4UQAth7p5z3AkKlDSd8ew8ja2ixRZYI50rTIb5XhPCP2u7c4KoNe1CrdLE7rBoSZr9CkYs2GYmbBMGeJOeDyzeLuIcGOnqQ3An9QLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741815882; c=relaxed/simple;
	bh=N5SjDU+aiVUjNEa4avGcITJ72d8Q98iNSIlJZ3xrt3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZlriBoUG+t2rlzGe70R7CyP4d/ObStAwbqaZfw4SqtdWEXqh5dVgFWqlL0g3f09InUhFgNehfXP+M95veAhvc0MRfE3k1UoJB+XadAnzkkF8ERfm/tOzjz80zFeWBiJHyDjqZMvk5lG2vORgG35w1nMFHgXDC9Ben7DR7S+wLiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mikt8AhA; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mikt8AhA"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-2c2c754af3cso225691fac.3
        for <git@vger.kernel.org>; Wed, 12 Mar 2025 14:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741815879; x=1742420679; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MlOU56nsws8cJJ+iZ4wx1qgxuGORp76kCFSLWfoXyi8=;
        b=Mikt8AhAS0yGHR5WFfjSK6ZMjky2nT22OCjy9q59JfzC5U0TQ0m9y+hyiAhX3hOC+h
         FWItzkV1xPubGGhus3JYBdiz6+zVVRjOi/Nq854CaK8+UQWJ0TU4RTGk7H5tBM2L9ijo
         MuneRIT51/3Smp6sifoRcmzXsPzgjZa0hmYKCnJgxjhe7vtHv7Zd1mA8SymK4n8PL7mc
         NiKniixGUgoakHl4mwmNLA/3ppv+lKcIWlIBRykdfjTScfQs3EI5lVKoaq//m5qpebMO
         5RtLp7YIQcugzM9PqDNTxhG7xp+NovhvUFs/ZbbtU5UBik5+SL5/yCP70199WJaOfH3E
         uLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741815879; x=1742420679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MlOU56nsws8cJJ+iZ4wx1qgxuGORp76kCFSLWfoXyi8=;
        b=Q7SngiZs1WxgnfJl4yVPmpAsorZiZyYuOfjt+ZQbocogIBiW6hD2snk4T9MNEg4yTM
         YyCPkbzFAC1CvK0KAel6337nfGe3JYl5Gwdpnv1GtYbtOqm/WFw/6nHwV2uDDqAausaM
         x5NJYHhi9c/WOtkqaDZLp4A8EXgI3+WAlUn8irc4zmobl1iiT1+6oBcXUyCv+uNoHL37
         aRz8VrHZ1pGRWmdY/co0KNf05r0caJjSfF/MbwnSM/RXfeq6wFXJ8SPD+lbs8X0vCtIM
         5x0MfhH9CrgaQ1Hfls9E4TMIvcvkjgM2U8cZa6ymkPTe7sB92jnV/uZuW6vYpU2ppjua
         AAww==
X-Gm-Message-State: AOJu0YxfQnvVnh5nWiMwesc95t76saFuTn8sJLW+EDx1WfsUW0k5Rzl/
	8BgpIBDR8i3ReE2pSteuVsgkchAny8h5FKPyacHBvhZezjZActKE
X-Gm-Gg: ASbGnct1MPZuscQqvt0S4SifItWgNwbbzmlZc03fquN02lv+wYqWsNQtm79Tt6du3G3
	lpgMW2DD2G0Sn63BIIFIbmXE2jKmojShcxKlVu3hI3FxpS9XLX48aocYroWnsYqZoB5XLamafhC
	+ah/3WhxErovMdDOaY2q7XkQ4FbuwpzzhYbzJ13y/NisG+txIl2r4hoZ5XLdsn6rseWvK3X7xti
	aWI0fU3iYhbV8usLxYWbErEIhCeCnmJFtOdqxRbwcKONM9DOfLRAiCjGMEgIXHPGCKXrBAOAkTC
	Dri1aRMlvogX6I0x8bRe3/WY8UkuXuWAFr1q+rK2dLGCpLbX
X-Google-Smtp-Source: AGHT+IFuXptOzEAgWbbfC/lSEUp03C0eFIz9XU3Cjoqt60Q60n4T2gsBuPkYHsJ1fZyxIHuK3MDkNg==
X-Received: by 2002:a05:6871:5883:b0:2b8:e6f2:ba7e with SMTP id 586e51a60fabf-2c261023eacmr12015963fac.12.1741815879655;
        Wed, 12 Mar 2025 14:44:39 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 46e09a7af769-72b41f24512sm2028623a34.66.2025.03.12.14.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Mar 2025 14:44:39 -0700 (PDT)
Date: Wed, 12 Mar 2025 16:41:11 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, christian.couder@gmail.com
Subject: Re: [PATCH 3/4] rev-list: support delimiting objects with NUL bytes
Message-ID: <rm6fvk3biqgk22qeuh2ur6xywrkiiofugtnndpuh4lnmqb4ivl@hvc4vfodb2wm>
References: <20250310192829.661692-1-jltobler@gmail.com>
 <20250310192829.661692-4-jltobler@gmail.com>
 <Z9E81I52prH-ROab@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9E81I52prH-ROab@pks.im>

On 25/03/12 08:50AM, Patrick Steinhardt wrote:
> On Mon, Mar 10, 2025 at 02:28:28PM -0500, Justin Tobler wrote:
> > diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> > index 04d9c893b5..86b3ce5806 100644
> > --- a/builtin/rev-list.c
> > +++ b/builtin/rev-list.c
> > @@ -757,6 +778,14 @@ int cmd_rev_list(int argc,
> >  		usage(rev_list_usage);
> >  
> >  	}
> > +
> > +	if (nul_delim) {
> > +		if (revs.graph || revs.verbose_header || show_disk_usage ||
> > +		    info.show_timestamp || info.header_prefix || bisect_list ||
> > +		    use_bitmap_index || revs.edge_hint || arg_missing_action)
> > +			die(_("-z option used with unsupported option"));
> > +	}
> > +
> 
> Not sure whether it's worth it, but do we maybe want to add a comment
> here that mentions that this isn't an inherent limitation, but rather
> that the initial implementation simply didn't implement compatibility
> with these options? This would explicitly keep the door open for any
> future improvements in this area.

That's fair. I'll mention this is a comment that way we know support
NUL-delimited mode support can be added for some of the options in the
future.

Thanks
-Justin
