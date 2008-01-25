From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 20:33:12 +0100
Message-ID: <200801252033.13142.jnareb@gmail.com>
References: <alpine.LNX.1.00.0801251336080.13593@iabervon.org> <m3fxwlagbu.fsf@localhost.localdomain> <alpine.LNX.1.00.0801251355490.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 20:34:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JIUJI-0000Km-Ml
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 20:33:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974AbYAYTdZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 14:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbYAYTdZ
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 14:33:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:46798 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751985AbYAYTdY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 14:33:24 -0500
Received: by ug-out-1314.google.com with SMTP id z38so563149ugc.16
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 11:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=1AC+e4c1HigJMw9lxWwaD4T6ulMiCFiyqUn9zS8WqUA=;
        b=wxt1mw3aVtAP/tHBSvLugqIIlOl0AsoYls9a0Lla1/N7cXeq4lC5u1i9FWPcJvJuGHCR9krjWh1yHDWSRNYmZp0jP3S+xw2dCgQm1ZMXipWf7cGSMHoTOPfuwc0wYk1fVSTNSEzTkZh9xiJHS7L4KZYRDKWGW4L0RsG4t2jATaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Sr11KPbfVfVOKk2BEeMHyicp1EFj7uIXXUBzl2PMUvKwwIOKrhaWw66WqrIuK/oRRwEHnDWSdcRdxnYA5mWrnCk0LnQfHPgfhx3YzCJNilT2XMkUP7d+/UMF+3BGDeJCesFABt6wFhUYdYcm2O+qBVXLfiBAqvXnT9TmpNzpVF8=
Received: by 10.67.116.16 with SMTP id t16mr3911316ugm.55.1201289601134;
        Fri, 25 Jan 2008 11:33:21 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.250.186])
        by mx.google.com with ESMTPS id z40sm3101437ugc.82.2008.01.25.11.33.18
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Jan 2008 11:33:20 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LNX.1.00.0801251355490.13593@iabervon.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71730>

On Friday, 25 January 2008, Daniel Barkalow wrote:
> On Fri, 25 Jan 2008, Jakub Narebski wrote:
>> Daniel Barkalow <barkalow@iabervon.org> writes:
>> 
>>> This allows users with different preferences for access methods to the
>>> same remote repositories to rewrite each other's URLs to get the
>>> desired access.
>> 
>> [...]
>>> +host.<name>.base::
>>> +	The base URL which should be used for this particular
>>> +	host. This can be used by a user who has a better access
>>> +	method to a repository than other users to make use of the
>>> +	preferable path despite getting URLs from other users using
>>> +	more commonly-available methods. Alternatively, a user who
>>> +	only has less privileged access to a repository than the usual
>>> +	audience can use this mechanism to replace disallowed methods
>>> +	with public ones.
>>> +
>>> +host.<name>.alias::
>>> +	Additional base URLs which refer to this host. If a URL
>>> +	matches this, any access to it will use the URL formed with
>>> +	the corresponding base URL instead of the given URL.
>>> +
>> 
>> From this I could not get how those configuration are meant to be
>> used. Perhaps some usage example?
> 
> [host "kernel"]
>         base = git://git.kernel.org/pub/
>         alias = git+ssh://master.kernel.org/pub/
>         alias = master.kernel.org:/pub/
> 
>> BTW. wouldn't the same be solved better by enabling remote.<name>.url
>> to be multi-valued, first working for fetch, all URLs for push?

Ah, thanks. I have misunderstood the above description (hint, hint!)...
 
> The real point is actually for when you're dealing with URLs on the 
> command line which you've cut-and-paste from email or other things. For 
> example, the patches in the -mm quilt series say where the git trees are, 
> but they're all like 
> "git+ssh://master.kernel.org/pub/scm/linux/kernel/git/dtor/input.git", 
> which is ideal for people (like Andrew) who have accounts on master, but 
> requires manual fixing for people (like me) who don't.
> 
> With the above config, I can do:
> 
> git fetch git+ssh://master.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

Couldn't you just configure "kernel" remote, and use "git fetch kernel"
instead?

> and it actually fetches
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git
>
> which actually works for me.

So this config variable is actually about _rewriting_ URLs, rather than
having multiple _alternate_ URLs to fetch from. IMHO either the
documentation above should be (re)written better (there is time, as we
are in feature freeze), or the example mentioned above should be added
(but where?).

-- 
Jakub Narebski
Poland
