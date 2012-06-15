From: Luka Perkov <lists@lukaperkov.net>
Subject: Re: [PATCH] git-http-fetch: remove unused cmd_http_fetch
Date: Fri, 15 Jun 2012 20:40:59 +0200
Message-ID: <20120615184059.GA27940@w500.iskon.local>
References: <20120614202336.GA3755@w500.iskon.local>
 <20120615162136.GC4572@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 15 20:41:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SfbSC-0001hK-Tf
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jun 2012 20:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923Ab2FOSlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jun 2012 14:41:00 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:45962 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753958Ab2FOSk7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jun 2012 14:40:59 -0400
Received: by weyu7 with SMTP id u7so2251143wey.19
        for <git@vger.kernel.org>; Fri, 15 Jun 2012 11:40:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent
         :x-gm-message-state;
        bh=eBkv/DkI72Mg58nxBpFvhKT8jOGDBHixTaqLJa1T+ZM=;
        b=msk6+eYXdUaDUB678Rgcgah98C6XKEnf0BXKtI3K+6/gTztU3Yj6D6HKBb86osXBvS
         Iu9/I5AXCSfqAPPW/WyplxAMhimBm2/cNKmLxopeIZQagy9+codoXwRPzyG7cpkD/4+n
         VSzz411UvQwsUEEddMxLTsU5m4XwOKufUpQZxghYNihdRutUDw0JGd0byk4cRJxHoJPZ
         lIy6UP+F/46oRV1u5bHgYX5pCCO1ATc1KI9ySWRxbOID76DWNoM5dYkn6gQACfDqM/mZ
         693wJxWaf10yOaw9dmKfOCWh/iGrBXJPgDMMIw4xM68xPERjSD9Z/bQ5rHC5ZtOUzI7t
         smFw==
Received: by 10.180.83.196 with SMTP id s4mr6500111wiy.15.1339785658137;
        Fri, 15 Jun 2012 11:40:58 -0700 (PDT)
Received: from localhost (213-191-157-213.dhcp.iskon.hr. [213.191.157.213])
        by mx.google.com with ESMTPS id f19sm7966449wiw.11.2012.06.15.11.40.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Jun 2012 11:40:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120615162136.GC4572@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Gm-Message-State: ALoCoQnUmYgcJExCp7FCbVA14gVUxieqZtvXDq8SCFqSTyOd0KhZhnjDsdHIjKf/hIuTh2uwcqBp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200079>

On Fri, Jun 15, 2012 at 12:21:36PM -0400, Jeff King wrote:
> On Thu, Jun 14, 2012 at 10:23:37PM +0200, Luka Perkov wrote:
> 
> > It was left out from commit 1088261f6fc90324014b5306cca4171987da85ce
> 
> This commit message left me scratching my head. Did we get rid of
> http-fetch? If not, then don't we still need cmd_http_fetch? Or did we
> just make it not a builtin, in which case we wouldn't be getting rid of
> cmd_http_fetch, but rather converting it to main?
> 
> Reading the 1088261, I find the answer: we did make it not a builtin,
> and it was indeed converted into "main". But its _declaration_ hung
> around.
> 
> So maybe a better commit message would be:
> 
>   Subject: builtin.h: drop cmd_http_fetch declaration
> 
>   This was converted from a builtin into a stand-alone program by
>   1088261f6fc90324014b5306cca4171987da85ce, but that commit forgot to
>   drop the declaration.

I agree. Sorry for the confusing message.

> Other than that, the patch looks obviously correct.
> 
> -Peff
> 
> PS There seem to be some other similar declarations: at least
>    cmd_upload_tar and cmd_pickaxe.

I noticed only cmd_http_fetch when I was hacking a patch for OpenWrt.

Luka
