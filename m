From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: 7fb9de4a830dd8969bc17a219c509a76dd3c9aad
Date: Tue, 7 Jun 2005 02:05:23 +1000
Message-ID: <2cfc4032050606090514981174@mail.gmail.com>
References: <20050606153940.20039.qmail@blackcubes.dyndns.org>
	 <Pine.LNX.4.58.0506060858140.1876@ppc970.osdl.org>
Reply-To: jon@blackcubes.dyndns.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 06:58:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgF6r-0000N0-IW
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 06:57:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVFIFBm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 01:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbVFIFBm
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 01:01:42 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:50976 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262269AbVFIFBf convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Jun 2005 01:01:35 -0400
Received: by rproxy.gmail.com with SMTP id i8so642875rne
        for <git@vger.kernel.org>; Wed, 08 Jun 2005 22:01:35 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JFVQuuIAaYVNPJ+SAiKWq6yuuEtAx/i6Sz/rUTzhmR/K+wb79BobYf3oaUcuao19OaAwe9w+tPEenm+jfpvrJetPMSoW8czLEoyWLcMdYi9LgUdgbzLseYiTSrWlmKRhvj3TON1p82GCK04k5m/bwORx+O9de3JaAJD5kf5jgtw=
Received: by 10.38.203.29 with SMTP id a29mr2494711rng;
        Mon, 06 Jun 2005 09:05:23 -0700 (PDT)
Received: by 10.38.104.42 with HTTP; Mon, 6 Jun 2005 09:05:23 -0700 (PDT)
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506060858140.1876@ppc970.osdl.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On 6/7/05, Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
> On Mon, 6 Jun 2005 jon@blackcubes.dyndns.org wrote:
> >
> > [PATCH] Modify git-rev-list to linearise the commit history in merge order.
> 
> Much nicer. Will apply after testing, however, not this part:
> 
> > @@ -110,6 +145,8 @@ static enum cmit_fmt get_commit_format(c
> >       if (!strcmp(arg, "=short"))
> >               return CMIT_FMT_SHORT;
> >       usage(rev_list_usage);
> > +
> > +     return CMIT_FMT_DEFAULT;
> >  }
> >
> >
> 
> If you're bothered by a compiler warning (that I don't see, wonder why?),
> please mark usage() and die() with "__attribute__ ((__noreturn__))". Make
> it depend on GCC, ie
> 
>         #ifdef __GCC__
>         #define NO_RETURN __attribute__((__noreturn__))
>         #else
>         #define NO_RETURN
>         #endif
> 
> and then do
> 
>         extern void die(const char *, ...) NO_RETURN;
> 
> or something like that.
> 
> Anyway, that's indepdendent of this patch, but just fyi.
> 
>                 Linus
> 

Here's my gcc version string:

          gcc (GCC) 3.3.3 20040412 (Red Hat Linux 3.3.3-7)

Shall I resend you the patch with that taken out?

jon.
-- 
homepage: http://www.zeta.org.au/~jon/
blog: http://orwelliantremors.blogspot.com/
