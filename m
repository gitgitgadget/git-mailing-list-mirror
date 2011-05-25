From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 06:53:31 -0700 (PDT)
Message-ID: <m3boyqzy3f.fsf@localhost.localdomain>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
	<SNT124-W39164C74A457129811245DC4740@phx.gbl>
	<BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>
	<SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
	<BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
	<20110525132816.GA6709@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Elazar Leibovich <elazarl@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 25 15:53:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPEWp-0000SX-Rw
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 15:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757689Ab1EYNxf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 09:53:35 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:57036 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757001Ab1EYNxe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 09:53:34 -0400
Received: by wwa36 with SMTP id 36so8506328wwa.1
        for <git@vger.kernel.org>; Wed, 25 May 2011 06:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type;
        bh=Px5+sA2QxoaNWmz6eRkvVIl1ux2O/vzN9Y0jcHuxB4c=;
        b=lmbKB+bdZ1hiNQwZ+rdOnivkgChub3ZQupRnOP4R4Y0tO8Jc7gnG6VMd5atQkfQamP
         ehH8K9xvt1qefLVkDQJW5smmKBa0GeMJ4CZVi88BupGAqoctXlQDFDoTTR1nXnWAGmnJ
         T7w4LjGn4cnDZuzhfN9LeTunv1SKNQvMCsuWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=cRbj4PURy9zcISz/16tPrxK6KpBQQSbRI6Zo49cs3/bWyJRWLlxz7a6HwGoLchEEgb
         HljrxTKvv15oPQ4N4ZU/86rX1SvyfoiWa0qswWPSAfqu9IoRRfGs72cCDwCsOjCuWOzY
         1Bm2sD9Fhf69/wTtpz5X+sk4IDBLhAketUnwA=
Received: by 10.227.205.67 with SMTP id fp3mr4709333wbb.53.1306331612776;
        Wed, 25 May 2011 06:53:32 -0700 (PDT)
Received: from localhost.localdomain (abvv43.neoplus.adsl.tpnet.pl [83.8.219.43])
        by mx.google.com with ESMTPS id o2sm387501wbh.38.2011.05.25.06.53.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 25 May 2011 06:53:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p4PDqsbq005847;
	Wed, 25 May 2011 15:53:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p4PDqcQo005839;
	Wed, 25 May 2011 15:52:38 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20110525132816.GA6709@sigill.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174391>

Jeff King <peff@peff.net> writes:
> On Wed, May 25, 2011 at 02:28:12PM +0300, Elazar Leibovich wrote:

[...]
> > Now that I think of it, we already have the '--not' option for
> > revision specifiers. Why won't we use it for grep patterns? That way
> > -v will not be overloaded (it usually means verbose). For example
> > 
> >     git log --all --not --grep A --grep B
> 
> The problem is that "--not" already has a meaning, and the scope of that
> meaning is different than what you propose. That is, in this command:
> 
>   git log a --not b c
> 
> The "--not" applies to both "b" and "c". So you are changing the meaning
> of the existing:
> 
>   git log a --not --grep b c
> 
> (which now means "grep for b, but do not include commits in c"). And
> even if we wanted to do that, there is a parsing ambiguity. Does the
> "--not" apply _just_ to the grep, or does it also include "not c"?
> 
> Which is a shame, because we already have all of the code for "--and",
> "--or", and "--not" in git-grep. It is just a syntactic conflict. I
> think you could get away with "--grep-and", "--grep-or", and
> "--grep-not". They are obviously less nice to type, but there would be
> not conflict.

Hmmm... perhaps short -! could be alias for --grep-not (it is the only
that needs to be changed to avoid conflict, as there are no --or and
--and for rev-list).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
