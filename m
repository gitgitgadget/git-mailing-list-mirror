From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Q: how can i find the upstream merge point of a commit?
Date: Thu, 16 Jun 2011 04:33:02 -0700 (PDT)
Message-ID: <m3aadiui6d.fsf@localhost.localdomain>
References: <20110608093648.GA19038@elte.hu>
	<201106141156.56320.johan@herland.net>
	<20110614171204.GC26764@sigill.intra.peff.net>
	<201106150145.12912.johan@herland.net>
	<20110615230033.GB19803@sigill.intra.peff.net>
	<7vips6ircc.fsf@alter.siamese.dyndns.org>
	<20110616004803.GD20355@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ingo Molnar <mingo@elte.hu>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jeff King <peff@github.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 13:33:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXAp2-0004fp-N3
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 13:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755978Ab1FPLdH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 07:33:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:49853 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755902Ab1FPLdE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 07:33:04 -0400
Received: by fxm17 with SMTP id 17so1032781fxm.19
        for <git@vger.kernel.org>; Thu, 16 Jun 2011 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=6Xk2epLFvU8ODzkR7DuvFiQopkmYT1OJRrwd+TBIQ+U=;
        b=caueRXmbbhUiBC9n/N1Lu8AQ8pKQSgMXghLUTUylDdhpBnI0YqaQTWFH4eKqO2s/vy
         gIIAEiej5hCs4eul9mltWbvXSr2XEgmTLkPiAXVuNryQMAsfw3VwGGa5i1DgdKpss+vV
         nt5G6Hwhh9ZblGlbfNpAHWH2JOwGpe1V2sLXk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BenvCUnVxT2rAtBqN8k6fnABO5BHM48GdH/6rhZQB+feO22filzu9UQOrCdenJoBhA
         uf1QxY54TJjhBmgxFaB3Rb0WBHjvzEMusVTZwvD2Inm5hmuGg4wr1hmruOg1dFDnY2jq
         a4TW2V0b7S0WfiPwzlIkkErVjzqS88O+GsldI=
Received: by 10.223.13.207 with SMTP id d15mr1022926faa.38.1308223983587;
        Thu, 16 Jun 2011 04:33:03 -0700 (PDT)
Received: from localhost.localdomain (abve99.neoplus.adsl.tpnet.pl [83.8.202.99])
        by mx.google.com with ESMTPS id m5sm167376fai.1.2011.06.16.04.32.55
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 16 Jun 2011 04:33:02 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p5GBVp5L016183;
	Thu, 16 Jun 2011 13:32:02 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p5GBV6g4016171;
	Thu, 16 Jun 2011 13:31:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110616004803.GD20355@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175893>

Jeff King <peff@github.com> writes:
> On Wed, Jun 15, 2011 at 04:53:55PM -0700, Junio C Hamano wrote:

> > Yes, you demonstrated that it is _possible_ to define disambiguation
> > rules, but do we currently allow (or horrors encourage) hierarchical
> > remote nicknames, and do people rely on being able to do so?  What
> > workflows benefit from such a confusing layout?
> > 
> > I am not fundamentally opposed to it, but just trying to tell between "we
> > do so because we can" and "because we need to for such and such reasons".
> 
> My reasoning is that we don't disallow remote names with slashes, nor do
> we disallow people putting arbitrarily nested refs into refs/remotes. So
> in the name of compatibility, we should assume people are doing it and
> not break them.
> 
> If we want to declare this illegal, I'm not too opposed. The only use
> case I could think of is somebody who works with two different sets of
> remotes, like "upstream" people and internal people. E.g., if I'm at
> company "foo" working on linux internally, I might have a few remotes:
> 
>   origin: linus
>   foo/alice: coworker alice's tree
>   foo/bob: coworker bob's tree

I currently have "gsoc2008/gitweb-caching" and "gsoc2010/gitweb-write"
remotes in my clone of git.git repository...

-- 
Jakub Narebski
Poland
ShadeHawk on #git
