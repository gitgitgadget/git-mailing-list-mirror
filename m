Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACB4200BF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=initialcommit-io.20230601.gappssmtp.com header.i=@initialcommit-io.20230601.gappssmtp.com header.b="Sc5CUB9H"
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 725792D5F
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:30:59 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1c9d407bb15so29631315ad.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 10:30:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=initialcommit-io.20230601.gappssmtp.com; s=20230601; t=1698082258; x=1698687058; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iY2OB19gpvTG7npqMbtwgCYnLipbIJ+UJcqCcHgyJVA=;
        b=Sc5CUB9HRx7YmSwQdgJRAy9kQbfNta2m5ORqyOQldsJWox75rFHnfa5PEbPyLywCVD
         5d1diRfMRv2XXWVJkump9BIjenEHsKzd8B69EhXKz8eAKOEiRf1GYUJlV4ja91PQfG4j
         1D1y6AX3xQdVAfphqFWgueCI0Gl9PkrvqH3EqxYAqAhJSfWyJPYUJR+n5s4KUngcdmYa
         R+tlld0ucL0H3mt+FEGm5ik7GfuP0EVX7g/bVaSIazU1HwnoSiyMGOFbDxBh/LWIvW8J
         oxCjGD+HyNNgpfQUtW6ytOnLaUvd7RMYWwCkDEVFvDz/DblfgXRZqkUmNbq5XfKQmMpd
         LPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698082258; x=1698687058;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iY2OB19gpvTG7npqMbtwgCYnLipbIJ+UJcqCcHgyJVA=;
        b=t2TQMp1apy1EzjHsUcn5jjWDELSW0W3D1zuYLbMKAtwcbLA74SdVIyFgw8G3rGhDT+
         3pR21wkaGDAvEUFd/HtExycpVsM6hXZv+g1G20FX/I3B8kx9MRrkMbTCRUKkaL45X+q7
         sP8PwGNNXA0Nsp6dmFRiLLUVXlEVwYR/71hnH96WxGkJbD9TWQq46vSdN0Fvf7GzH645
         +/IF3XWGkh9iPPL/J4BTzZ3/osyLF7KezQY/U2yIplb2IfC9hZ5jzWmPf4vrXu1jBbPh
         LsmTI7LSMruo9Xfssm5C/u3ETg0U/kSPT2AiqUELz/VKMxRBQxsloeA5LzhAu5Testux
         L25w==
X-Gm-Message-State: AOJu0YwUbfkPGXNA1EaJiTVuKpq5W7Aza3IkJrweCaLTfz5kEr00uXqD
	H4nMBrvoe2GvsQ7cRBCA7E4Kpg==
X-Google-Smtp-Source: AGHT+IEfs+5y9qNXJ7KKkufajsN+ZGcaomJ0Db4XHH4QBKiLU6euqTVr0RXSzey34u7NjyRS1s82bA==
X-Received: by 2002:a17:902:da90:b0:1ca:1c55:abcf with SMTP id j16-20020a170902da9000b001ca1c55abcfmr9937114plx.3.1698082258433;
        Mon, 23 Oct 2023 10:30:58 -0700 (PDT)
Received: from initialcommit.io (mobile-166-170-44-139.mycingular.net. [166.170.44.139])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c21500b001c9c47d6cb9sm6169609pll.99.2023.10.23.10.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 10:30:57 -0700 (PDT)
Date: Mon, 23 Oct 2023 10:30:54 -0700
From: Jacob Stopak <jacob@initialcommit.io>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [RFC PATCH 0/5] Introduce -t, --table for status/add commands
Message-ID: <ZTatzlzCkPOW3Rn7.jacob@initialcommit.io>
References: <20231020183947.463882-1-jacob@initialcommit.io>
 <fd26df85661d554ced9d8e0445f75952@manjaro.org>
 <ZTL1wJIIK/5YWQK5.jacob@initialcommit.io>
 <d3bbe53c3b910f891c80465ea0c3f53f@manjaro.org>
 <ZTS4jfsU6oS6LW0u.jacob@initialcommit.io>
 <5fac8607a3c270e06fd610551d7403c7@manjaro.org>
 <ZTT5uI5Hm1+n0Agx@ugly>
 <58a6a25a7b2eb82c21d9b87143033cef@manjaro.org>
 <ZTZQZhtTxvGT/s81@ugly>
 <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc55e29274da0d8059a8cd4383aa1b22@manjaro.org>

On Mon, Oct 23, 2023 at 04:34:15PM +0200, Dragan Simic wrote:
> On 2023-10-23 12:52, Oswald Buddenhagen wrote:
> > On Sun, Oct 22, 2023 at 02:55:05PM +0200, Dragan Simic wrote:
> > > Oh, that's awesome and I'm really happy to be wrong with my broad
> > > classification of VCS users.  However, I still need to be convinced
> > > further, and I'd assign your example as an exception to the rules,
> > 
> > i don't see myself as exceptional at all in that regard.
> > in fact, your second user group seems like unicorns, and the first
> > like a disparaging attitude from an elitist. in reality, users lie on
> > a spectrum of willingness to engage with the details of the tools they
> > use, and that willingness is circumstantial. a tool that is
> > forthcoming with information has a higher chance of being actively
> > engaged.

Just a note here, in my initial reply I was thinking of writing something
similar about how in reality users of a tool as ubiquitous as Git would
form a continuous spectrum in terms of their usage habits and trying to
neatly plop them into 2 categories by speculating on their motives is
an oversimplification to the point where it might not be so helpful
evaluating whether an option like this would make sense to implement.

To me the bigger question is much simpler:

"Would this feature improve the Git experience for a signficant number
of users?"

I have some evidence to support the claim that it would.

My Git-Sim tool does essentially what this proposal suggests and it has
about 31,000 installs since I released it early this year. Granted this
is a drop in the bucket in the grand scheme of things, but it still shows
that there is demand for such a thing.

Git-Sim is a visual dry-run tool for Git that creates images simulating
what the corresponding Git command will do, without actually making any
change to the underlying repo state. Another important aspect is that
command syntax mimics Git's exactly - so to simulate any Git command, like:

$ git add asdf.txt qwer.txt

You would just replace the executable name and run:

$ git-sim add asdf.txt qwer.txt

and it will show you in an image exactly what will happen.

This is important because even simulating the command requires the user
to know and use the Git CLI syntax for the command. It keeps them on the
command line to do all of their actual work, unlike other true "pointy
clicky GUI's" I've seen which expect the user to do all their work in the
GUI. In fact this tool and feature expect no pointing or clicking at all.

The purpose of this is that users actually do all their work in the CLI
and learn to use Git as intuitively as possible, the way the "spartan"
CLI folks use it, the way it is meant to be used.

The reason to include a format like this in Git instead of just in my
tool is simply to reach a wider audience and benefit more people. Of
course it also appears much more trustworthy when a feature is part of
the native tool itself instead of some external thing.

> > i for one think that it would be a perfectly valid experiment to go
> > all-in and beyond with jacob's proposal - _and make it the default_
> > (when the output is a tty). more advanced users who feel annoyed would
> > be expected to opt out of it via configuration, as they are for the
> > advice messages. because it's really the same idea, only thought
> > bigger.
> 
> I'd never support that, FWIW.

FWIW, I'd _never suggest_ that. I very much value Git's current usage
and wouldn't dream to make this the default. This proposal is for an
optional flag to help users who would benefit from it, nothing more,
nothing less. Speculating on user motives to classify them into 2 broad
categories in order to prove the feature isn't helpful misses the point
that there is a (relatively large IMO) subset of users who would benefit
from it.

As an optional flag, experienced users wouldn't bat an eyelash, and the
type of users who installed my tool could use the flag on and off until
they feel confident enough to drop it. But it is always there in case
they need a refresher.
