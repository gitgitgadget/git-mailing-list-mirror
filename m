From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: gitattributes - clean filter invoked on pull?
Date: Mon, 11 Apr 2011 14:49:21 +0530
Message-ID: <20110411091919.GE28959@kytes>
References: <20110411084229.GW5146@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, timar74@gmail.com
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Mon Apr 11 11:20:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9DIE-0004xg-C8
	for gcvg-git-2@lo.gmane.org; Mon, 11 Apr 2011 11:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757997Ab1DKJUL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Apr 2011 05:20:11 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:65419 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757930Ab1DKJUI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Apr 2011 05:20:08 -0400
Received: by iwn34 with SMTP id 34so5433091iwn.19
        for <git@vger.kernel.org>; Mon, 11 Apr 2011 02:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=mD2k1ubBCmXX1DZ4Jw3Kl64ETQWZYKVoS4e+krOmY/s=;
        b=N1X40vIKfPZyTJqBX7NWTHeremDHnuJ2xEPmAKSuPWLfPqD9TS67zsPb616C8hvtB/
         RJnFiP+weq1vI0h+iiQKUJwIcOLBQgAk83Zdb+qZSOWR6isvdKfHvMi1hgVVHCmY4hhv
         n7GZE5tFYZTuFkvv3S9ORM+kGSi7xAcjG08TU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=h93jjHE0vTgEcuZXgw6R/p2SwHPVlS5tr3f4vMj2VEOeyEqiGoDJ8tOzJl1lSEmVO2
         wJZ3TwD2kXgKlxBthUG3bnBM6hwzN5Px5uJfLjnzqFs/5RSdQWjHM0+kV8tNDuClzhJJ
         t/nm2H/e9RpOeRjX4kYlWV2vn/59VGMNUBYq4=
Received: by 10.231.177.97 with SMTP id bh33mr3799837ibb.175.1302513608284;
        Mon, 11 Apr 2011 02:20:08 -0700 (PDT)
Received: from kytes ([203.110.240.41])
        by mx.google.com with ESMTPS id i3sm4101187iby.57.2011.04.11.02.20.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 11 Apr 2011 02:20:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20110411084229.GW5146@genesis.frugalware.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171319>

Hi Miklos,

Miklos Vajna writes:
> Background: We at LibreOffice are trying to use the 'filter'
> gitattributes feature to clean up line wrappings in po files.
> 
> The problem is that it seems the clean filter - which is supposed to be
> invoked only in case a new blob is created - is invoked even on
> clone/pull, and other developers are claiming that it slows down their
> workflow.
> 
> Is this a bug? I don't exactly understand why this would be necessary.

>From config.txt:
- 'clean' is "The command which is used to convert the content of a
worktree file to a blob upon checkin".
- 'smudge' is "The command which is used to convert the content of a
blob object to a worktree file upon checkout."

According to the documentation, 'smudge' is *supposed* to be invoked
on a clone/ pull, since it involves a checkout.  I don't see how you
can avoid running these filters on every checkin/ checkout unless you
cache the result somewhere.

-- Ram
