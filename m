From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 2/2] git_remote_cvs: Use $(shell) in the Makefile
Date: Sun, 16 Aug 2009 13:47:00 -0700
Message-ID: <20090816204658.GA23522@gmail.com>
References: <7v7hx35ym1.fsf@alter.siamese.dyndns.org> <1250455088-23457-1-git-send-email-davvid@gmail.com> <1250455088-23457-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, barkalow@iabervon.org,
	Johannes.Schindelin@gmx.de, mhagger@alum.mit.edu
To: gitster@pobox.com, johan@herland.net
X-From: git-owner@vger.kernel.org Sun Aug 16 22:47:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1McmdJ-0005aj-HW
	for gcvg-git-2@lo.gmane.org; Sun, 16 Aug 2009 22:47:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756043AbZHPUrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Aug 2009 16:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756028AbZHPUrG
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Aug 2009 16:47:06 -0400
Received: from mail-px0-f196.google.com ([209.85.216.196]:58959 "EHLO
	mail-px0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755896AbZHPUrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Aug 2009 16:47:05 -0400
Received: by pxi34 with SMTP id 34so928609pxi.4
        for <git@vger.kernel.org>; Sun, 16 Aug 2009 13:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=eQvHxntY1+aO6WOPNSipmygM6w8huBsaBbkYsaJJ/wc=;
        b=JdydWqeUFNniRl2C+XxW/9LTPj2RKNtgiBjnwIHokSYZAp0UBvi962n13UFeS4jyEc
         6sZUgCsLFxS7N4nM0YmZl03mrUQHkd8nGpoQwkOVK3gtP5R84ZQBJZPLOliiMZu7pNOu
         ROaTLrbMOneMzYX2ROfIRj3Oz5fHohaR1ZDJw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=mM5mcAGH1XZ8VFP01pXOpifjNYpT788OkpK+6YI2DuKKRA7vBcCfFaIqMsZeeUL78G
         Mcw0FMdHB4Y0Tek4IIlzyfbVB29QihsyYMmdJjKrZ0vEM2NGPoAIcL7GlNVsL4j/37M6
         aWniw9Zb/BgwQ0rWM1qRzMrOqgzyoKZ9GjTtw=
Received: by 10.114.146.2 with SMTP id t2mr4076316wad.177.1250455626945;
        Sun, 16 Aug 2009 13:47:06 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id d20sm8636277waa.12.2009.08.16.13.47.05
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 16 Aug 2009 13:47:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1250455088-23457-2-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126074>

On Sun, Aug 16, 2009 at 01:38:08PM -0700, David Aguilar wrote:
> This updates the git_remote_cvs Makefile to use the same
> $(shell <cmd>) style used by the top-level git Makefile.
> 
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---

I should have mentioned here that I also spaced stuff out and
chopped the long line so that it fits within 78 chars.

I intentionally broke this out as a 2nd patch in case using
$(shell ...) was not the right thing to do.




>  git_remote_cvs/Makefile |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/git_remote_cvs/Makefile b/git_remote_cvs/Makefile
> index f52c096..d281d48 100644
> --- a/git_remote_cvs/Makefile
> +++ b/git_remote_cvs/Makefile
> @@ -23,10 +23,13 @@ ifndef V
>  	QUIETSETUP = --quiet
>  endif
>  
> -PYLIBDIR=`$(PYTHON_PATH) -c "import sys; print 'lib/python%i.%i/site-packages' % sys.version_info[:2]"`
> +PYLIBDIR=$(shell $(PYTHON_PATH) -c \
> +	 "import sys; \
> +	 print 'lib/python%i.%i/site-packages' % sys.version_info[:2]")
>  
>  all: $(pysetupfile)
>  	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) build
> +
>  install: $(pysetupfile)
>  	$(PYTHON_PATH) $(pysetupfile) install \
>  		--prefix $(prefix) \
> @@ -34,6 +37,7 @@ install: $(pysetupfile)
>  
>  instlibdir: $(pysetupfile)
>  	@echo "$(prefix)/$(PYLIBDIR)"
> +
>  clean:
>  	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
>  	$(RM) *.pyo *.pyc
> -- 
> 1.6.4.169.g64d5
> 

-- 
		David
