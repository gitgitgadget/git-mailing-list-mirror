Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E52E7F5
	for <git@vger.kernel.org>; Sat, 28 Oct 2023 03:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/F7fePH"
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCDBAD
	for <git@vger.kernel.org>; Fri, 27 Oct 2023 20:22:24 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id d75a77b69052e-41cc7379b23so18111331cf.3
        for <git@vger.kernel.org>; Fri, 27 Oct 2023 20:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698463343; x=1699068143; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Lg6S6wBjACxvdvOXiPud+ybn/XES6+U89kQpdmCXZ98=;
        b=F/F7fePHDPJI1oyjdM2hmvsAkIU8wVt2BQMoSCI72/IXUFsAktxG7POP+navw4zlr0
         Xlurc7IH46Q/6fsmxzlebdEp5XI/hS5Rlej06mnGfYKDhRmRLvqOC5qrH4kDPAErF49n
         3izUS6iGd4QAaU/XJxwQS/9iNI/UudKPbHjbqDMFfqq5QDsQEYaCzqSrxm+TUMPSTWFi
         t7fE30lrJ3ecxMdQpbQAZSP1tGlGTq86bDHZ4Lwhlne7IwUpu4nZNTu/q/cWgb6q17C6
         AXcAJL+rxOrKcX2Ba1xkCsl4s9WM2dYElFXMPNDCR59zchPaFgU4dZVPhsPV7BxoXHzr
         nlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698463343; x=1699068143;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lg6S6wBjACxvdvOXiPud+ybn/XES6+U89kQpdmCXZ98=;
        b=QNQN9quQ25pP1lGFKH4OunsM5ckgOzXi9bXqnxE2dtgOa83MyyLEm08RNcLobScXzM
         0zKDlMNn7SUh/F/m9tu50ZInQQAH4oro6RLl0tBqgHGWN951AASqp++bGxx4QEzjUGTd
         7lGtvim1pBNI7O1rUBSvuBRnstPTLhZL3o43hYCYWN/lLa2e4mr1WzfZqo5mKz0nTMuO
         mBzAOxxm8W8fSL+CPQQR2xx2p7skXXIu5uwMPZ8eFUFHOjmsyv/COo8LLxFu8P/2qmkM
         DMqCCqs3btmg9xhEGrAqn95g6aRxfLH+5uY5GbSHQm25Bty2Zib755DmkhF7YQOCQA0n
         pDug==
X-Gm-Message-State: AOJu0Yz5NfIbWZZHe90Ig9sE8nuxeAvhdQyFpajuiutEH6pDaxxALdRK
	NLbRkQYzHGV5gI5t4NDy668=
X-Google-Smtp-Source: AGHT+IHYvDDOEZuCK6ij6m+lWbMwdXsxPX8NV6XJMIoTEuUc80zp30chZ3BcNNrJEicpR4bPI12hxw==
X-Received: by 2002:a05:622a:170e:b0:41e:1755:1d5d with SMTP id h14-20020a05622a170e00b0041e17551d5dmr5291777qtk.60.1698463343457;
        Fri, 27 Oct 2023 20:22:23 -0700 (PDT)
Received: from shaak (modemcable063.135-226-192.mc.videotron.ca. [192.226.135.63])
        by smtp.gmail.com with ESMTPSA id d6-20020a0ce446000000b0066d1d2242desm1200421qvm.120.2023.10.27.20.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 20:22:22 -0700 (PDT)
Date: Fri, 27 Oct 2023 23:22:21 -0400
From: Liam Beguin <liambeguin@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Kousik Sanagavarapu <five231003@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] pretty: add '%aA' to show domain-part of email
 addresses
Message-ID: <20231028032221.GB1784118@shaak>
References: <20231026-pretty-email-domain-v1-2-5d6bfa6615c0@gmail.com>
 <20231027184357.21049-1-five231003@gmail.com>
 <xmqq7cn7obah.fsf@gitster.g>
 <20231028021301.GA35796@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231028021301.GA35796@coredump.intra.peff.net>

Hi Junio, Peff,

On Fri, Oct 27, 2023 at 10:13:01PM -0400, Jeff King wrote:
> On Sat, Oct 28, 2023 at 09:12:06AM +0900, Junio C Hamano wrote:
> 
> > Grouping @gmail.com addresses do not smell all that useful, though.

While I agree with you, I think that's more an exception that the rule.

> > More importantly, it is not clear what "Many reports" refers to.  If
> > they are *not* verbatim output from "git log" family of commands,
> > iow, they are produced by post-processing output from "git log"
> > family of commands, then I do not quite see why %aa is useful at
> > all.

I might've been a bit generous with "many report", I was mostly thinking
of the ones published by lwn.net, and U-Boot for example.

To some extent, "git shortlog" could be considered a part of that
post-processing chain.

> One way you could directly use this is in shortlog, which these days
> lets you group by specific formats. So:
> 
>   git shortlog -ns --group=format:%aA

That's exactly what I implemented this for :-)

> is potentially useful.
> 
> I say "potentially" because it really depends on your project and its
> contributors. In git.git the results are mostly either too broad
> ("gmail.com" covers many unrelated people) or too narrow (I'll assume
> I'm the only contributor from "peff.net"). There are a few possibly
> useful ones ("microsoft.com", "gitlab.com", though even those are
> misleading because email domains don't always correspond to
> affiliations).

I agree with your comment here, while grouping everything under
"gmail.com" for example doesn't provide anything really useful we can
rely on mailmap to fix that when appropriate. I think it would otherwise
count as unaffiliated.

I don't claim this to be foolproof, but I do think that it gives a good
overall view of which companies are involved in the project for the most
part.

> So I don't find it useful myself, but I see how it could be in the right
> circumstances. It also feels like a symmetric match to "%al", which
> already exists. I do find "aa" as the identifier a little hard to
> remember. I guess it's "a" for "address", though I'd have called the
> whole local@domain thing an address thing that. Of course "d" for domain
> would make sense, but that is already taken. If we could spell it as
> %(authoremail:domain) that would remove the question. But given the
> existence of "%al", I'm not too sad to see another letter allocated to
> this purpose in the meantime.

I chose the "a" for "address", but I'm not sold on %aa either.
I just couldn't find anything better that wasn't already taken.

What about "a@"?

It's a bit easier to remember, being the first character of the
domain-part.

> Just my two cents as a shortlog --format afficionado. ;) (Of course,
> shortlog itself is the ultimate "you could really just post-process log
> output" example).

I'm a big fan of shortlog --format (and --group) as well!

Taking it a step further, it's also possible to pass in whatever mailmap
you want to generate a "report".  Let's say there's mapping that only
makes sense for a single release something like this could be used:

git -c mailmap.file=git-mailmap-v2.42 shortlog -sn --group=format:%aA

> -Peff

Thanks for your time.

Cheers,
Liam
