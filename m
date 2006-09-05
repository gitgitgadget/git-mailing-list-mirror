From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH 2/5] autoconf: Add -liconv to LIBS when NEEDS_LIBICONV
Date: Tue, 5 Sep 2006 18:25:26 +0200
Message-ID: <20060905162526.GA5547@diku.dk>
References: <200609050054.24279.jnareb@gmail.com> <200609050055.52980.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 05 18:25:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKdk2-0003QN-1h
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 18:25:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965078AbWIEQZe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 12:25:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbWIEQZe
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 12:25:34 -0400
Received: from [130.225.96.91] ([130.225.96.91]:44253 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S932189AbWIEQZd (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Sep 2006 12:25:33 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id C08F577001D;
	Tue,  5 Sep 2006 18:25:30 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 24267-07; Tue,  5 Sep 2006 18:25:26 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id 7E1FE77000F;
	Tue,  5 Sep 2006 18:25:26 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id CE8016DF845; Tue,  5 Sep 2006 18:23:53 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 6209A62A09; Tue,  5 Sep 2006 18:25:26 +0200 (CEST)
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <200609050055.52980.jnareb@gmail.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26479>

Jakub Narebski <jnareb@gmail.com> wrote Tue, Sep 05, 2006:
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
> ---
> Just in case; it could matter for testing if iconv is properly
> supported (NO_ICONV test).
> 
>  configure.ac |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 36f9cd9..fc5b813 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -147,6 +147,7 @@ AC_CHECK_LIB([c], [iconv],
>  [NEEDS_LIBICONV=],
>  [NEEDS_LIBICONV=YesPlease])
>  AC_SUBST(NEEDS_LIBICONV)
> +test -n "$NEEDS_SOCKET" && LIBS="$LIBS -liconv"

I see that this has entered already, but it looks like it needs a
s/NEEDS_SOCKET/NEEDS_LIBICONV/

>  #
>  # Define NEEDS_SOCKET if linking with libc is not enough (SunOS,
>  # Patrick Mauritz).

-- 
Jonas Fonseca
