From: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
Subject: Re: 3 failures on test t9100 (svn)
Date: Wed, 3 Mar 2010 20:52:49 +0100
Message-ID: <20100303195249.GA12919@vidovic>
References: <20100302194518.GA12942@vidovic> <20100302212806.GA21413@coredump.intra.peff.net> <20100303005804.GA17120@vidovic> <20100303172302.GA10168@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 03 20:53:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nmud5-00004y-7x
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 20:53:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752099Ab0CCTxG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 14:53:06 -0500
Received: from mail-pw0-f46.google.com ([209.85.160.46]:59644 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751001Ab0CCTxB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 14:53:01 -0500
Received: by pwj8 with SMTP id 8so1127493pwj.19
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 11:53:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=5ikm5Os22gKrYEmeqEfvCNeXdY+b1oWTpR17e1SkUWQ=;
        b=anWxf+l+zm7rmMnlDav3Npvt/6alwwEVlSxEU5Zk5DfXu6Z7Gw1GNAQW/8WWhTm/jp
         bPncSvYPAuDeGcAA/iZL/YsRA4GcDc9NzkGkHWugkdRHEa5MzIAnecbAxXNxCPjksuPs
         CkTY2H78CSP1R3DemiqEyWwGQ3HhxW7GjmFhM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DrcEXmvTngR/ulIRSvyOiTIet/G8rVj0yjsT66WXgc4uToLwDR+tzTbMU+RVSJezN2
         3Elnz3t+eg/5dVk1xd8POQVsU58vMr9iJIvSfMvjVOOXbSl59aBQKlGtq1XDfIGl8V1b
         tKc5i2YvxfR17rKWwcAAxr2rNJQLi84CvVZtE=
Received: by 10.114.11.2 with SMTP id 2mr374089wak.73.1267645980857;
        Wed, 03 Mar 2010 11:53:00 -0800 (PST)
Received: from @ (88-121-126-130.rev.libertysurf.net [88.121.126.130])
        by mx.google.com with ESMTPS id 15sm759883pxi.0.2010.03.03.11.52.53
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 11:52:56 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100303172302.GA10168@coredump.intra.peff.net>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141463>

The 03/03/10, Jeff King wrote:
> On Wed, Mar 03, 2010 at 01:58:04AM +0100, Nicolas Sebrecht wrote:
> 
> That's weird. Can you test this in each of your shells:
> 
>   foo() {
>     echo "in foo, arg=$1"
>   }
>   VARIABLE='foo bar'
>   $VARIABLE
> 
> It should print "in foo, arg=bar". If it doesn't, then the shell is
> broken.

It works, so the shell isn't that broken. :)

> Also, can you confirm that you aren't setting SHELL_PATH in the Makefile
> (or in your environment) when building and testing git?

I run "make install" and I only tune the prefix variable.

> I have this same version of bash on my Debian stable box, and it passes
> the test I outlined above. So perhaps there is something more subtle
> going on.

Thanks Jeff for your feedbacks.

> > That said, I did the svn tests because sometimes I have reproductible
> > errors with 'git svn fetch' or 'git svn clone'. I'm not sure how both
> > problems could be related... git-svn is a Perl script. The given message
> > for this one is "error: died with signal 11" from what I remember (but
> > I'm sure about the "signal 11" part).
> 
> I doubt they are related. This test_cmp problem is a problem in the test
> harness, but it may be masking actual problems by giving false
> negatives.

I agree. I'll correct the git-svn issue before coming back to the tests
issues.

-- 
Nicolas Sebrecht
