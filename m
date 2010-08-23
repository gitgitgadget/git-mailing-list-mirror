From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Compiling git with makepp patch
Date: Mon, 23 Aug 2010 02:00:04 -0700 (PDT)
Message-ID: <m3k4nhogbr.fsf@localhost.localdomain>
References: <84FD9808A65CDF4C959FDB41FC3D134CBCF306D6@MSSRVS4.atlas.de>
	<4C71A53F.2020108@t-online.de>
	<201008230947.06777.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Pfeiffer <occitan@esperanto.org>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Aug 23 11:00:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OnSt5-0007uJ-QI
	for gcvg-git-2@lo.gmane.org; Mon, 23 Aug 2010 11:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab0HWJAJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Aug 2010 05:00:09 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52746 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753494Ab0HWJAH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Aug 2010 05:00:07 -0400
Received: by fxm13 with SMTP id 13so2721673fxm.19
        for <git@vger.kernel.org>; Mon, 23 Aug 2010 02:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=S4yZoWDNmDl2CGdnwEfZDA11LGvnHqBRZGdbF3fYpDY=;
        b=EYukb4I3K+iO84/nOLIDwZGmN5DcuMldI0lOX7keY/RZvJqmeHB5KxWPUGkjyhOv3D
         wnc9skqnUrb1UWgaOuH/DraLN6/Z6LrdBO8m1IPuYqosZ+5QPnt1jKnUwJalx47uSGFG
         IrVhVLQdgGUt+OOwjUKX0PcBAZpPyX6nyUrWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=VydRRZn96Xlh8yG097SbAWpxZGOi/6zJzbO4xouAi6/pR+UuazsH4a/bB+2BZKcY2E
         fqhik93jwmLAhixtXyduitvIgX7UQiwckyZ/mVC9bANjCgSzjBOw9nPpEq4raRtdWyQX
         D/mah00pW8DiE+A6m3CCmXyU6WGOJrFAmr+ww=
Received: by 10.223.121.16 with SMTP id f16mr3795023far.72.1282554006024;
        Mon, 23 Aug 2010 02:00:06 -0700 (PDT)
Received: from localhost.localdomain (abvo61.neoplus.adsl.tpnet.pl [83.8.212.61])
        by mx.google.com with ESMTPS id 16sm640325fad.2.2010.08.23.02.00.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 23 Aug 2010 02:00:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o7N8xV0L030347;
	Mon, 23 Aug 2010 10:59:42 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o7N8x5O1030341;
	Mon, 23 Aug 2010 10:59:05 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <201008230947.06777.trast@student.ethz.ch>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154208>

Thomas Rast <trast@student.ethz.ch> writes:
> Daniel Pfeiffer wrote:
> > [Attachment: git-makepp.patch]
> 
> Please read Documentation/SubmittingPatches for next time.
> 
> > There are however two things which I can hardly hope to fix:
> [...]
> > PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
> > 
> > [...] makepp parses this line just like Emacs, so it doesn't find
> > the comment, adding in the #' at the point of use, which completely
> > screws the sed command.
> [...]
> >  # Shell quote;
> > -bindir_SQ = $(subst ','\'',$(bindir))#'
> > -gitwebdir_SQ = $(subst ','\'',$(gitwebdir))#'
> > -gitwebstaticdir_SQ = $(subst ','\'',$(gitwebdir)/static)#'
> > -SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))#'
> > -PERL_PATH_SQ  = $(subst ','\'',$(PERL_PATH))#'
> > -DESTDIR_SQ    = $(subst ','\'',$(DESTDIR))#'
> > +Q='
> > +# ' This comment is only to appease IDEs like Emacs.
> > +# The comment is on a new line, else makepp would see it as a quoted hash.
> > +bindir_SQ = $(subst $Q,'\'',$(bindir))
> > +gitwebdir_SQ = $(subst $Q,'\'',$(gitwebdir))
> > +gitwebstaticdir_SQ = $(subst $Q,'\'',$(gitwebdir)/static)
> > +SHELL_PATH_SQ = $(subst $Q,'\'',$(SHELL_PATH))
> > +PERL_PATH_SQ  = $(subst $Q,'\'',$(PERL_PATH))
> > +DESTDIR_SQ    = $(subst $Q,'\'',$(DESTDIR))
> 
> Confusingly, you talk about comments above, but the real issue is that
> your makepp apparently gives the ' special meaning.  For once "info
> make" and "man 1p make" on my system agree on the semantics of ': none
> at all.  From the latter:
> 
>   Early proposals stated that an "unquoted" number sign  was  treated  as  the
>   start of a comment. The make utility does not pay any attention to quotes. A
>   number sign starts a comment regardless of its surroundings.
> 
> So can you quote chapter and verse to show that there is anything to
> fix?

Nevertheless using

  Q='
  SQ='\''
  bindir_SQ = $(subst $Q,$(SQ),$(bindir))

could make substitution more clear ('make' behavior nothwithstanding).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
