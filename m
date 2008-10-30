From: Deskin Miller <deskinm@umich.edu>
Subject: Re: [PATCH] Documented --no-checkout option in git-svn
Date: Thu, 30 Oct 2008 14:07:36 -0400
Message-ID: <20081030180736.GA20322@euler>
References: <1225382900-22482-1-git-send-email-_vi@list.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com,
	Vitaly _Vi Shukela <public_vi@tut.by>
To: _vi@list.ru
X-From: git-owner@vger.kernel.org Thu Oct 30 19:09:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvbx5-0002ra-Aw
	for gcvg-git-2@gmane.org; Thu, 30 Oct 2008 19:08:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754164AbYJ3SHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2008 14:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754135AbYJ3SHp
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Oct 2008 14:07:45 -0400
Received: from hs-out-0708.google.com ([64.233.178.244]:53789 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753994AbYJ3SHo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2008 14:07:44 -0400
Received: by hs-out-0708.google.com with SMTP id 4so358342hsl.5
        for <git@vger.kernel.org>; Thu, 30 Oct 2008 11:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent:sender;
        bh=Kgt5NIeWyWsjGzivzW1DGA3hgqyG6sRfEao4dYvck2w=;
        b=fsyjltbtcD+3DrB1ahYMxlnC+Ki4kH/PV2ZCf35SZbPsSoRhm0KU5+DLDSE9noidn0
         hYRduAUcgk8XaBAmnnYsFpOdXvPx5gop+jf5tnkvnwWFBB+f/M6WG0SeVCtS71bxaDwe
         GQB+i52tZLz3N4HI7oaghLRJ2tDAfiy90Vc3w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent:sender;
        b=dtSDwMaut1zQv9z2iIo/miJVqBaZGcisD3S9u8sPDf7Rjthw3SQ+ksJc/XwrY3/weA
         WA2vg8VeWKwtdc7Jkvg7CwvFg134fo0bI8B2/v+XHfofNFhR9cbXNdyvcuZi0r6ycOtH
         NlPJf/lTct6wt9Zw4lBuwJFoI2XqMU75ejwg8=
Received: by 10.64.195.20 with SMTP id s20mr2925905qbf.20.1225390063038;
        Thu, 30 Oct 2008 11:07:43 -0700 (PDT)
Received: from euler ([141.213.134.25])
        by mx.google.com with ESMTPS id 25sm3869520qbw.1.2008.10.30.11.07.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 30 Oct 2008 11:07:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1225382900-22482-1-git-send-email-_vi@list.ru>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99515>

On Thu, Oct 30, 2008 at 06:08:20PM +0200, _vi@list.ru wrote:
> From: Vitaly "_Vi" Shukela <public_vi@tut.by>
> 
> Signed-off-by: Vitaly "_Vi" Shukela <public_vi@tut.by>
> ---
>  Documentation/git-svn.txt |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
> index 84c8f3c..90784a5 100644
> --- a/Documentation/git-svn.txt
> +++ b/Documentation/git-svn.txt
> @@ -91,6 +91,9 @@ COMMANDS
>  	tracking.  The name of the [svn-remote "..."] section in the
>  	.git/config file may be specified as an optional command-line
>  	argument.
> +	
> +--no-checkout
> +	Do not checkout latest revision after fetching.

This isn't quite how the other options are listed in the source; for one, this
ends up formatted in the final manpage like

--no-checkout Do not checkout latest revision after fetching.

Instead of

--no-checkout
	Do not checkout latest revision after fetching.

Also, the wording seems slightly imprecise; in fact, if the repository already
has a checkout, git svn fetch would not attempt to check anything out in its
place, nor will it check anything out if there is a local master branch
already.  With clone this is not typically a problem, but in fact it is
possible to clone into a preexisting git repository, so the same concerns
exist.

Deskin Miller
