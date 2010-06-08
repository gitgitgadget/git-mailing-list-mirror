From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC/PATCH 1/4] gitweb: Move subroutines to Gitweb::Config
 module
Date: Tue, 8 Jun 2010 21:55:52 +0200
Message-ID: <20100608195552.GA3408@machine.or.cz>
References: <1275943844-24991-1-git-send-email-pavan.sss1991@gmail.com>
 <201006081446.22587.jnareb@gmail.com>
 <20100608141321.GP20775@machine.or.cz>
 <AANLkTiksOpUqxGc7Lo4clrLwOF6GvkT7CZH5CVeirtBr@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 08 21:56:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OM4u2-0000Jd-0p
	for gcvg-git-2@lo.gmane.org; Tue, 08 Jun 2010 21:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755793Ab0FHTz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jun 2010 15:55:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41013 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab0FHTzz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jun 2010 15:55:55 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 480A986208F; Tue,  8 Jun 2010 21:55:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTiksOpUqxGc7Lo4clrLwOF6GvkT7CZH5CVeirtBr@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148705>

On Wed, Jun 09, 2010 at 12:52:11AM +0530, Pavan Kumar Sunkara wrote:
> I am graining Gitweb::HTML into Gitweb::HTML::* to reduce circular
> dependancies of the modules.

I'm sorry, I don't understand. How is splitting up Gitweb::HTML to
submodules helping to reduce circular dependencies? I don't quite see
that right now. :-( Can you give a concrete example? Perhaps it would be
better to refactor the few problematic users instead of convoluting the
whole module structure because of the offenders.

>   Gitweb::Parse

What will this module do?

>   Gitweb::Util

What will this module do?

>   Gitweb::Action::* (All action subs like git_blame, git_log)

Do we need to do this right now? I think moving huge chunks of the code
around like this right now is unneccessary and it might just enlarge the
patch queue and delay you in your main GSoC efforts; perhaps we could do
this later when the dust settles a bit and we are sure that the rest of
the modular structure we have introduced fits well?

> I will be rebasing the whole series, edit them and send them once
> every module has undergone as RFC in the mailing list.

Ok! I have meant to ask about that.

> I have been stuck many times trying to workaround the circular module
> dependancies and believe me, the patches I am sending and the modules
> I am creating involves a lot of effort from my side and as long as you
> think there's nothing wrong with the grouping of subroutines in my
> modules and their names, you need not worry about the module
> structure.

I'm sorry but it doesn't work like that - if you have put a lot of
effort behind it, you need to present us with the rationale you have
reached and convince us that this is the right way to take.

-- 
				Petr "Pasky" Baudis
The true meaning of life is to plant a tree under whose shade
you will never sit.
