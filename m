From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] git_remote_helpers: remove GIT-PYTHON-VERSION upon
 "clean"
Date: Wed, 30 Jan 2013 20:03:56 +0000
Message-ID: <20130130200356.GL1342@serenity.lan>
References: <7vzjzqjwot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 21:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0dtR-0001Ru-JJ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 21:04:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648Ab3A3UED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 15:04:03 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:42202 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753574Ab3A3UEC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 15:04:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id C34FF60651D;
	Wed, 30 Jan 2013 20:04:01 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SgA-DXXoPvV1; Wed, 30 Jan 2013 20:04:01 +0000 (GMT)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 8EDDB198043;
	Wed, 30 Jan 2013 20:03:58 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vzjzqjwot.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215068>

On Wed, Jan 30, 2013 at 11:30:10AM -0800, Junio C Hamano wrote:
> fadf8c7 (git_remote_helpers: force rebuild if python version changes, 2013-01-20)
> started using a marker file to keep track of the version of Python interpreter
> used for the last build, but forgot to remove it when asked to "make clean".
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Looks obviously correct to me.  Sorry for missing this at the time.
FWIW:

Reviewed-by: John Keeping <john@keeping.me.uk>

> ---
>  git_remote_helpers/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/git_remote_helpers/Makefile b/git_remote_helpers/Makefile
> index 0d2ae74..3d12232 100644
> --- a/git_remote_helpers/Makefile
> +++ b/git_remote_helpers/Makefile
> @@ -42,4 +42,4 @@ instlibdir: $(pysetupfile)
>  
>  clean:
>  	$(QUIET)$(PYTHON_PATH) $(pysetupfile) $(QUIETSETUP) clean -a
> -	$(RM) *.pyo *.pyc
> +	$(RM) *.pyo *.pyc GIT-PYTHON-VERSION
