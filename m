From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Treating similar blank lines between hunks as part of the hunks
Date: Thu, 26 Aug 2010 21:13:10 -0500
Message-ID: <20100827021310.GA23924@burratino>
References: <AANLkTikZFYSSNMENC5SmKSVt49a+WxXdO0mP=V7Mbi-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Timur Tabi <timur@freescale.com>
X-From: git-owner@vger.kernel.org Fri Aug 27 04:15:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OooT9-000124-PP
	for gcvg-git-2@lo.gmane.org; Fri, 27 Aug 2010 04:15:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752132Ab0H0CO7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Aug 2010 22:14:59 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:58869 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768Ab0H0CO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Aug 2010 22:14:57 -0400
Received: by yxg6 with SMTP id 6so913776yxg.19
        for <git@vger.kernel.org>; Thu, 26 Aug 2010 19:14:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=bWC8jCAYPdqyF2MP6OIZMg6odZj1AEh3L+11RBVTdP0=;
        b=mJ7BUIfy1NoqmyITthPRGb2eYmyRy7zFCzWHpHXvOUpD9D4UxHK/WevsERmHxGkHAp
         0/NcC3z4nRUIfsoBRHqVfke/ClX1J5m+i3pTsoYfiY+rbXyWNiXlesPVD2vACVgWx1Tz
         ItlYDUNSjONgytS/7VgFBG3y15/OocpKmqqfM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=EpXVPdInc5WDy2nSyggo4YcACmkwL4pBn42qpr7X0VMRngr+M1UhDc/cJFpFqUUbfG
         gXTYJXfNb2+3O69BWCRxA2np1X8l31fPAGC8+VB79fW9TVLbTt8uMPd5X63e9n46In+U
         YuI3S1GlbVuHVozVwTe8w535bLlqnDwVz+HlU=
Received: by 10.150.54.1 with SMTP id c1mr1199094yba.141.1282875296783;
        Thu, 26 Aug 2010 19:14:56 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id v6sm8245622ybm.23.2010.08.26.19.14.55
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 26 Aug 2010 19:14:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikZFYSSNMENC5SmKSVt49a+WxXdO0mP=V7Mbi-Q@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Timur Tabi wrote:

> git-diff will do this:
> 
>  A
> -B
> -C
> +F
> +G
> 
> -D
> +H
>  E
> 
> Instead, I would prefer it did this:
> 
>  A
> -B
> -C
> -
> -D
> +F
> +G
> +
> +H
> E
> 
> This second diff is easier to read, especially when the number of
> hunks is large, but the size of each hunk is small.  This can happen
> in source code when one function is replaced with a completely
> different function.

Not sure if it would help in your example, but have you tried
"git diff --patience"?
