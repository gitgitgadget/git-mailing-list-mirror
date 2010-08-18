From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] submodule sync: Update "submodule.<name>.url"
Date: Wed, 18 Aug 2010 08:46:49 -0700
Message-ID: <20100818154637.GA10028@gmail.com>
References: <1282125673-22956-1-git-send-email-davvid@gmail.com>
 <4C6BB9E2.4060700@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 18 17:46:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Olkqh-0002va-7J
	for gcvg-git-2@lo.gmane.org; Wed, 18 Aug 2010 17:46:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751517Ab0HRPqi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Aug 2010 11:46:38 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:37578 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751242Ab0HRPqg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Aug 2010 11:46:36 -0400
Received: by pvg2 with SMTP id 2so272311pvg.19
        for <git@vger.kernel.org>; Wed, 18 Aug 2010 08:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=XYFLPy18s7gGldGiAcUFnhwnlQQApNLSVmpHIbSMVw4=;
        b=ko7AKk/ALbz9iXYp3X92fI2FB1dC+IAu/mYeg1I/fpq44iqjGHUnSzPQCFKq+59cXD
         oIjRSyE5Ak+mpZmtEY8omJGvX7qpLtstoQrzQ0c+z/D6lAWFziQ2y7+ycVfoV9cb6bg8
         +16nnZrcFtzxpd8eLxD26W7a0JF6DYqZ11lHY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=TA539M+f3G/1bOKdxvGY2KJspRkdZsB3hggJMZxejwwh84jgu4GYYHp10UzA9Z2aJZ
         M4VPXyN4BT1pit0VaA03Tl0dfbDDwvY5iRApRJI367/sTL9ofcb1p9MakzD/nvmZ/7OX
         KLF7Y7cU08mmZDPqfW908dqJYa1lGGwwUkZHo=
Received: by 10.142.136.1 with SMTP id j1mr7199940wfd.331.1282146396305;
        Wed, 18 Aug 2010 08:46:36 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id n2sm474007wfl.13.2010.08.18.08.46.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 08:46:35 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4C6BB9E2.4060700@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153860>

On Wed, Aug 18, 2010 at 12:45:54PM +0200, Johannes Sixt wrote:
> Am 8/18/2010 12:01, schrieb David Aguilar:
> > @@ -840,9 +840,10 @@ cmd_sync()
> >  		then
> >  		(
> >  			clear_local_git_env
> > +			say "Synchronizing submodule url for '$name'"
> > +			git config submodule."$name".url "$url"
> 
> This git config applies to the super module, right? As such, shouldn't it
> happen before you clear_local_git_env?


Good catch, thanks.  I'll resend.


> 
> >  			cd "$path"
> >  			remote=$(get_default_remote)
> > -			say "Synchronizing submodule url for '$name'"
> >  			git config remote."$remote".url "$url"
> >  		)
> 
> -- Hannes

-- 

	David
