From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] usage.c: remove unused functions
Date: Thu, 25 Sep 2008 14:48:36 +0200
Message-ID: <20080925124836.GI10360@machine.or.cz>
References: <20080925184104.6117@nanako3.lavabit.com> <200809251348.42789.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Sep 25 14:50:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiqIA-000126-Oc
	for gcvg-git-2@gmane.org; Thu, 25 Sep 2008 14:49:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753175AbYIYMsj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 08:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753035AbYIYMsj
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 08:48:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:33960 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752750AbYIYMsi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Sep 2008 08:48:38 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 8E6123939B42; Thu, 25 Sep 2008 14:48:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200809251348.42789.trast@student.ethz.ch>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96758>

On Thu, Sep 25, 2008 at 01:48:37PM +0200, Thomas Rast wrote:
> Nanako Shiraishi wrote:
> > This removes three functions that are not used anywhere.
> [...]
> > -void set_usage_routine(void (*routine)(const char *err) NORETURN)
> [...]
> > -void set_error_routine(void (*routine)(const char *err, va_list params))
> [...]
> > -void set_warn_routine(void (*routine)(const char *warn, va_list params))
> 
> These blame to the following commit:
> 
>   commit 39a3f5ea7c0352a530338d30d4e618f6b4db84e4
>   Author: Petr Baudis <pasky@suse.cz>
>   Date:   Sat Jun 24 04:34:38 2006 +0200
> 
>       Customizable error handlers
>       
>       This patch makes the usage(), die() and error() handlers customizable.
>       Nothing in the git code itself uses that but many other libgit users
>       (like Git.pm) will.
>   [...]
> 
> So apparently the intent was that they would only be used from outside
> Git.  I don't know whether anyone still plans to do that, but they're
> certainly not "just" unused.

I don't think it will be a big deal to remove these functions, though it
does feel like a little bit of a step backwards in the libgit efforts.
There are some programs that already link to Git, like CGit - I wonder
if some of them don't use them (CGit itself doesn't).

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
