From: david@lang.hm
Subject: Re: Git commit generation numbers
Date: Fri, 22 Jul 2011 11:02:07 -0700 (PDT)
Message-ID: <alpine.DEB.2.02.1107221100560.6496@asgard.lang.hm>
References: <20110721202722.3765.qmail@science.horizon.com> <201107221418.52414.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: George Spelvin <linux@horizon.com>,
	Anthony Van de Gejuchte <anthonyvdgent@gmail.com>,
	git@vger.kernel.org, Phil Hord <hordp@cisco.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	Shawn Pearce <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 22 20:02:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkK3p-0002Ku-Qi
	for gcvg-git-2@lo.gmane.org; Fri, 22 Jul 2011 20:02:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753118Ab1GVSCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 14:02:48 -0400
Received: from mail.lang.hm ([64.81.33.126]:54236 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752119Ab1GVSCs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 14:02:48 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p6MI27LW008843;
	Fri, 22 Jul 2011 11:02:07 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <201107221418.52414.jnareb@gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177652>

On Fri, 22 Jul 2011, Jakub Narebski wrote:

>> Yes, the cache validity/invalidation criteria are the tricky bit.
>> Honestly, this is where the code gets ugly, not computing and storing
>> the generation numbers.
>
> BTW. with storing generation number in commit header there is a problem
> what would old version of git, one which does not understand said header,
> do during rebase.  Would it strip unknown headers, or would it copy
> generation number verbatim - which means that it can be incorrect?

Linus has already pointed out that this is safe.

old versions won't create generation numbers, but they will ignore them if 
they exist. Since commits are not modified after they are created, the old 
versions don't copy or modify them.

David Lang
