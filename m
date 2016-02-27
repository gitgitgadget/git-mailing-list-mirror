From: Santiago Torres <santiago@nyu.edu>
Subject: Re: [PATCH/RFC] builtin/tag: Changes argument format for verify
Date: Sat, 27 Feb 2016 12:45:24 -0500
Message-ID: <20160227174523.GB11593@LykOS>
References: <1456532864-30327-1-git-send-email-santiago@nyu.edu>
 <20160227043625.GC11604@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Feb 27 18:45:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZivr-0006zb-0N
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 18:45:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756613AbcB0Rp1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Feb 2016 12:45:27 -0500
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34658 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756340AbcB0Rp0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Feb 2016 12:45:26 -0500
Received: by mail-qg0-f45.google.com with SMTP id b67so88261124qgb.1
        for <git@vger.kernel.org>; Sat, 27 Feb 2016 09:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nyu-edu.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xf78LrOZ8F3ff3ChVy9QVbUuKMefBgQWuFzxfeA79Y8=;
        b=qVzu3GX3s1ph7W6uZGBtZDvdHoR7nzegt1AjUlFvhuh65bZ0IPW9lm5FMdtc7JBKfn
         MQ0Yv5t8H3YVdC0VNldjuALc+S/n68QD0C0To8mY2YHqSrOngfVznRnr4I9j9LYLzEej
         wFnSQPwEAaa5A3nOXjoGDjPeatFT6lqxPJBgRqp9nMZfgEeYCKCjmyTgkI5yqMZPSqDt
         xdXxESejBPA5YNP07bTdlQayHYNPWbh14oypZHoykc6UCgL4igsvTNOwJIVlK3tkwOge
         G42Gw2YMwjvzD1kH/UOp/8+gQACpY9qcayivtTP5VDhr+8AWkuCvtUy7oVEwTLkH+Rqb
         n6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xf78LrOZ8F3ff3ChVy9QVbUuKMefBgQWuFzxfeA79Y8=;
        b=ArLIvMJMLZW9cnJ7UgpuqS8Siqz+xTcEIsr1EF6HQbJ4xubH2/hhaI5/AD0FT0mfyu
         adxeqD1eI48eOxnkq3KCLrFAK7Yp0fgj81zejE6hWyGAibwEpCtj/VvWKV6iiSOeJFNQ
         zgtcxQaK43xgw7njKfWzVoSiZdvi+FwxviAHiymaGqLaCzidomvDa2IELLjvmH6lAkEd
         Uvs4UCum3hO3bEZppTlkBabzaGM8tgBYFNMfef9XyKA9cJpEKDd8+F+DIkjeEUwtMoeK
         CqrnNB2XkbdDqd7CrP+a4gXzAjOFVGgHY5aqjYkdBsCcpZsNkmaRiday8vHHT2zQodR2
         Ix1A==
X-Gm-Message-State: AD7BkJLgiZ7Bzut+BL0l4JGQDVc1j5ABhgwnuiXAuqBNoBuv+QtRqRhNLzMuxcJKL/uaSLsK
X-Received: by 10.140.18.163 with SMTP id 32mr9403545qgf.11.1456595125247;
        Sat, 27 Feb 2016 09:45:25 -0800 (PST)
Received: from LykOS (NYUFWA-WLESSAUTHCLIENTS-01.NATPOOL.NYU.EDU. [216.165.95.72])
        by smtp.gmail.com with ESMTPSA id s8sm6353419qhb.20.2016.02.27.09.45.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 27 Feb 2016 09:45:24 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20160227043625.GC11604@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287711>

Hello Jeff, thanks for going through the patch.
 
> > diff --git a/builtin/tag.c b/builtin/tag.c
> > index 1705c94..5de1161 100644
> > --- a/builtin/tag.c
> > +++ b/builtin/tag.c
> > @@ -105,8 +105,7 @@ static int verify_tag(const char *name, const char *ref,
> >  				const unsigned char *sha1)
> >  {
> >  	const char *argv_verify_tag[] = {"verify-tag",
> > -					"-v", "SHA1_HEX", NULL};
> > -	argv_verify_tag[2] = sha1_to_hex(sha1);
> > +					"-v", name, NULL};
> 
> You are passing in "name" here, not "ref". git-tag knows it is operating
> specifically on tags, and completes a name like "foo" to
> "refs/tags/foo". Whereas verify-tag is plumbing that can operate on any
> ref, and will do the usual lookup for "foo", "refs/heads/foo",
> "refs/tags/foo", etc.
> 
> So by passing the unqualified name, we may end up finding something
> entirely different, generating "ambiguous name" errors, etc. So if we
> _were_ to go this route, I think we'd need to use "ref" here, not
> "name".

Yeah, you are right. I found this little detail while going through the
code yesterday, and I thought it was odd at first and "fixed" it. Given
that it worked for me (and tests pass) I thought I was actually removing
one function call. Howerver, as you point out, it is less efficient
because the resolution is done twice.

I read the log regarding this file and I didn't quite get what was all
the issue with disambiguation when I was submitting. After reading your
email, it's clear why things are done in this way now.

> 
> But I'm not really sure I see the upside.
> 
> A much more interesting change in this area, I think, would be to skip
> verify-tag entirely. Once upon a time it had a lot of logic itself, but
> these days it is a thin wrapper over run_gpg_verify(), and we could
> improve the efficiency quite a bit by eliminates the sub-process
> entirely.

I agree here too. while going through gdb to follow the logic on this I saw that
this code forks three times (git, tag-verify and gpg). I'm sure that
removing one layer should be good efficiencly-wise.

Is it ok if I give this a shot?

Thanks!
-Santiago.
