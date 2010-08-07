From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Maildir ordering in git-mailsplit (was: Using mutt as a git
 maintainer)
Date: Sat, 7 Aug 2010 08:13:39 +0530
Message-ID: <20100807024337.GA15410@kytes>
References: <20100806222847.GA4240@sceen.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Richard Braun <rbraun@sceen.net>
X-From: git-owner@vger.kernel.org Sat Aug 07 04:45:10 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhZPJ-0001yY-Jj
	for gcvg-git-2@lo.gmane.org; Sat, 07 Aug 2010 04:45:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760830Ab0HGCpF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Aug 2010 22:45:05 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:52086 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752458Ab0HGCpB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Aug 2010 22:45:01 -0400
Received: by pwj7 with SMTP id 7so747977pwj.19
        for <git@vger.kernel.org>; Fri, 06 Aug 2010 19:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=17Wzky4FZhkRh0/INzCtXExJ1w8R6i7t2PtCxTj+0ZU=;
        b=VtV2G01O4s22+pFZWLFXzVc2uZiaY0tkKMT9GHfficRU6Px5AibXabccx4glEyoO7M
         pSPB9u0DH4xK4NDPtOvD7LCnByaNcYmm4N9XM4himgaczYCoOGA21mnOPUbJacjyJg6j
         BLOtbgqvZEYhvSdMv/2ZTVqhuYEgBiPWRKeyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=odTWnL3uSoXScRYbKIY0i5IaILc+KLGEZaOJYHlBCyeqGiHmEzTVidIowfb62fAWUV
         B6trlpxCxNwuij2WVQiRW3rnnHY1ghRrSm8l/w0EdHW8R9pKSRpC1kiu/IvzaOYdjckL
         tXVMt6X2kdqpX3fFX8ga75/LUoiwzF2g9WooE=
Received: by 10.114.112.17 with SMTP id k17mr14963125wac.188.1281149100592;
        Fri, 06 Aug 2010 19:45:00 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id d35sm4078292waa.21.2010.08.06.19.44.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 06 Aug 2010 19:44:59 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100806222847.GA4240@sceen.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152835>

Hi Richard,

Richard Braun writes:
> I'm currently setting up several git repositories, both for personal stuff
> and at work, and I also am an avid Mutt user. But I have a problem with the
> "braindamaged" git-mailsplit program and how it interacts badly with how
> Mutt does some things.
> 
> The specific case that troubles me is when using git send-email with several
> patches, say around 10, then getting those in my lovely Mutt as one thread,
> with chainreplyto set to false because i'm a nice person who RTFM. Until now
> everything looks perfect. Then I tag the thread and copy it out to a
> temporary mailbox so that I can run git am and do something else with my
> life. Problem: I use Maildir mailboxes, and with several files, mutt doesn't
> preserve the order of the patches. As git-mailsplit uses a raw opendir()
> to access patches in Maildir format, and doesn't try to sort anything after,
> some patch series just won't apply simply.

Ah, it looks like this problem went unnoticed probably because
everyone uses mboxes. One possible solution would be to teach
`git-mailsplit` to order the emails correctly. You can reply with an
RFC patch; I've CC'ed the Git list on this email.

> I'm using git 1.5.6.5 and Mutt 1.5.18 (from Debian lenny), pretty old but
> after checking the most recent source code, it just seems to be the same.

Yeah, I don't think git-mailsplit has changed in some time.

-- Ram
