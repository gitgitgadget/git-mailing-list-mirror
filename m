From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 0/5] Pretty formats for reflog data
Date: Fri, 16 Oct 2009 02:00:45 -0700 (PDT)
Message-ID: <m37huvg1a8.fsf@localhost.localdomain>
References: <20091014050645.GD31810@coredump.intra.peff.net>
	<cover.1255645570.git.trast@student.ethz.ch>
	<20091016052003.GA10629@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	Jef Driesen <jefdriesen@hotmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Oct 16 11:02:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Myih0-0001Fy-Dt
	for gcvg-git-2@lo.gmane.org; Fri, 16 Oct 2009 11:01:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757538AbZJPJB0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Oct 2009 05:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753273AbZJPJBZ
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Oct 2009 05:01:25 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33242 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751125AbZJPJBY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Oct 2009 05:01:24 -0400
Received: by fxm18 with SMTP id 18so2138225fxm.37
        for <git@vger.kernel.org>; Fri, 16 Oct 2009 02:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=E7suG1xhn8XTPQG6eXgG0MLgCga/Ols8HjKSYXaYxc4=;
        b=a6t16vKmSimWZClA+elF1MVMusMSw+crK5ss6Mob4CSSYBkYJZ2hmHNdB5t921EcQ7
         bFyyugwie4kOkXOvTzDMaWblLLfZfnXkrBMK+wuEoPTtduPoz79m7i6B4/AOqhWol3Mj
         Ldc0O5sKI4yniwaov+lTZTnHGpzeXqUilPqRc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=f6FVK010vcGf3+Hra3u24OHdWi9B/CDRvWkorTAkH5OAwnybBLwFP9ffPQ8BOdLk2H
         X2eGFqFo5mb7FHE8I3ojYbt1lhFmtZCPFQUMQNEZylCrTlP78QGZmCybAqCY4WSBT2lz
         JZz4juqwpCQ3w6a6jCPF1O6INdZuoXEC5JMS8=
Received: by 10.204.154.198 with SMTP id p6mr1055967bkw.131.1255683646836;
        Fri, 16 Oct 2009 02:00:46 -0700 (PDT)
Received: from localhost.localdomain (absh57.neoplus.adsl.tpnet.pl [83.8.127.57])
        by mx.google.com with ESMTPS id 3sm1131132fge.9.2009.10.16.02.00.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 16 Oct 2009 02:00:45 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n9G91skw008765;
	Fri, 16 Oct 2009 11:01:55 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n9G91pb7008760;
	Fri, 16 Oct 2009 11:01:51 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20091016052003.GA10629@coredump.intra.peff.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130469>

Jeff King <peff@peff.net> writes:

> On Fri, Oct 16, 2009 at 12:41:43AM +0200, Thomas Rast wrote:

> > I think going for %(...) wouldn't be too bad since we already have
> > that in for-each-ref, and it can be backwards compatible.  So we would
> > have different sets of short and long specifiers, e.g.
> > 
> >   %ae = %(authoremail)
> >   %aE = %(authoremail:mailmap)
> > 
> > We can then pass arguments via some yet-to-be decided syntax, say,
> > %(body:indent(10)).
> 
> That seems reasonable to me, though if we can limit ourselves to one
> argument per specifier (I suspect most specifiers would simply be
> boolean, but a few may take numbers or strings), then something like
> %(body:indent=10) might be a little more readable.
> 
> It would also be nice to have some sort of conditional inclusion, which
> could deal with your extra ": " in patch 3. Either something like:
> 
>   %(reflog:short)%(reflog:+: )
> 
> or even
> 
>   %(reflog:short:prefix=\: )
> 
> and note that allowing arbitrary arguments means we get to deal with
> quoting.
> 
> But that is all for another potential series.

Or we could go the whole nine miles, and implement some subset of
advanced shell syntax, 

  %(parameter:-word)
  %(parameter:=word)
  %(parameter:?word)
  %(parameter:+word)

RPM spec syntax, 

  %(?parameter)      # expand if exists
  %(!?parameter)     # expand if does not exists
  %(?parameter:literal)
  %(!?parameter:literal)

or RPM queryformat

  %10(parameter)
  %-30(parameter)

  [    %(messagebody)\n]   # messagebody is list of lines
  [%(=param) %(list)\n]    # param is not a list; repeat it

  %|parameter?{present}:{missing}|

  %(parameter:date)
  %(parameter:shescape)

-- 
Jakub Narebski
Poland
ShadeHawk on #git
