From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [PATCH] make inline is_null_sha1 global
Date: Tue, 15 Aug 2006 23:58:12 +0200
Message-ID: <20060815215812.GB15797@diku.dk>
References: <Pine.LNX.4.63.0608151335020.1475@chino.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 15 23:59:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GD6wA-0007JW-6L
	for gcvg-git@gmane.org; Tue, 15 Aug 2006 23:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWHOV6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Aug 2006 17:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750746AbWHOV6z
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Aug 2006 17:58:55 -0400
Received: from [130.225.96.91] ([130.225.96.91]:4240 "EHLO mgw1.diku.dk")
	by vger.kernel.org with ESMTP id S1750742AbWHOV6y (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Aug 2006 17:58:54 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id 21FA07700CC;
	Tue, 15 Aug 2006 23:58:42 +0200 (CEST)
Received: from mgw1.diku.dk ([127.0.0.1])
 by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 32363-08; Tue, 15 Aug 2006 23:58:13 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id F16867700C5;
	Tue, 15 Aug 2006 23:58:12 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 60C0B6DF835; Tue, 15 Aug 2006 23:57:06 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id D68AB629F3; Tue, 15 Aug 2006 23:58:12 +0200 (CEST)
To: David Rientjes <rientjes@google.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0608151335020.1475@chino.corp.google.com>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25486>

David Rientjes <rientjes@google.com> wrote Tue, Aug 15, 2006:
> diff --git a/builtin-diff.c b/builtin-diff.c
> index 82afce7..9003d55 100644
> --- a/builtin-diff.c
> +++ b/builtin-diff.c
> @@ -68,8 +68,7 @@ static void stuff_change(struct diff_opt
>  {
>  	struct diff_filespec *one, *two;
>  
> -	if (memcmp(null_sha1, old_sha1, 20) &&
> -	    memcmp(null_sha1, new_sha1, 20) &&
> +	if (is_null_sha1(old_sha1) && is_null_sha1(new_sha1) &&
>  	    !memcmp(old_sha1, new_sha1, 20))
>  		return;
>  

Looks like this should be !is_null_sha1(...) in both cases.

-- 
Jonas Fonseca
