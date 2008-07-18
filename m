From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [PATCH] Link git-shell only to a subset of libgit.a
Date: Fri, 18 Jul 2008 10:03:21 +0400
Message-ID: <20080718060321.GJ2925@dpotapov.dyndns.org>
References: <20080718005814.GA4155@spearce.org> <1216343070-20237-1-git-send-email-s-beyer@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jul 18 08:04:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJj4y-0005g1-IP
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 08:04:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751512AbYGRGDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 02:03:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750763AbYGRGDc
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 02:03:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:1193 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751202AbYGRGDc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 02:03:32 -0400
Received: by fg-out-1718.google.com with SMTP id 19so97634fgg.17
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 23:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=ZzswMYTElrIT5VPUpmXQvclgbN45pcTeiKUuMOfBdks=;
        b=kkyhrVZHal5igzOLAfg74YHlL88zzv0ERROM8MIZuY+BQykevIx4a1om5PcJj3/Wf1
         x4wNPphDdIz3tuqStqw3OjmC9JvBXH2IIWsT3HYzzbontGItxuxR31YrP9D/KcJdZQpZ
         OaNLWkLGWHMaRKvPpucmVcbafjVc9ymh9OhTM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=BXoWL1XPHCJ0S9NcgfEgjAc6UnJqXUGAZ51TzZuZYYI9Df8wBqIiQGwA8dSD0Sucau
         tqXJSvCM9mG1a8+1BqplzsRxNcvQbA6zEhbUqFg/QVJBHU5XIbWNTzHUC8llkZdl6iqq
         sF+Y+8KzKgq32LZAhZgyLtjAIIShnPERjSGQU=
Received: by 10.86.59.2 with SMTP id h2mr5329017fga.12.1216361006503;
        Thu, 17 Jul 2008 23:03:26 -0700 (PDT)
Received: from localhost ( [85.140.168.212])
        by mx.google.com with ESMTPS id d6sm1100017fga.2.2008.07.17.23.03.23
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 23:03:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1216343070-20237-1-git-send-email-s-beyer@gmx.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88992>

On Fri, Jul 18, 2008 at 03:04:30AM +0200, Stephan Beyer wrote:
> Commit 5b8e6f85 introduced stubs for three functions that make no sense
> for git-shell. But those stubs defined libgit.a functions a second time
> so that a linker can complain.
> 
> Now git-shell is only linked to a subset of libgit.a.
> 
> Signed-off-by: Stephan Beyer <s-beyer@gmx.net>

I agree, it is probably better to specify explicitly what files to link
for git-shell if we want to keep it small and avoid the problem with
some linkers.

Dmitry
