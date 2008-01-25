From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Add support for host aliases in config files
Date: Fri, 25 Jan 2008 10:52:27 -0800 (PST)
Message-ID: <m3fxwlagbu.fsf@localhost.localdomain>
References: <alpine.LNX.1.00.0801251336080.13593@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jan 25 19:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JITfk-0000ya-4M
	for gcvg-git-2@gmane.org; Fri, 25 Jan 2008 19:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806AbYAYSwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jan 2008 13:52:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754152AbYAYSwc
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jan 2008 13:52:32 -0500
Received: from mu-out-0910.google.com ([209.85.134.189]:19182 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755806AbYAYSwb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jan 2008 13:52:31 -0500
Received: by mu-out-0910.google.com with SMTP id i10so739296mue.5
        for <git@vger.kernel.org>; Fri, 25 Jan 2008 10:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        bh=1nuwdnt2EsbKW0aDg6CTclkpv2z8Y86cdJX7WJe49+I=;
        b=qpCSqAfOUxjvJoHyMM267HwJahGuU7XpX7L9ON4ivMXXSde1uG2RLBIJoKTELdEym6Qt9X2qproqzXt5uA3NDQ9hUJzmKrNqm7YmpMoKmQ8MalAhdnNLsoQRy0/1aNpNnJnxOIsZ632Col04D3+46QZYv8ak4k2W6GZ66+nFKM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:in-reply-to:message-id:lines:user-agent:mime-version:content-type:from:date;
        b=bR4gu/4YK/lAzRWkhcPOWaQbnOkH2GOs08D1qPzvPDd8uaPQ8kQLbqWASr7MpYszU4wWQ7BW1mW9JF1og1E0I+Xna5ZmhVT4Dw74k+G4moV2m3IUC3+CBIupLbKbkAKMImFG1rCkdX/fWTsZAU2wJKx2S8y2O57wpwyJJtKOK64=
Received: by 10.78.147.6 with SMTP id u6mr3496479hud.59.1201287149192;
        Fri, 25 Jan 2008 10:52:29 -0800 (PST)
Received: from localhost.localdomain ( [83.8.250.186])
        by mx.google.com with ESMTPS id d23sm905354nfh.4.2008.01.25.10.52.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Jan 2008 10:52:27 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m0PIqJmL009934;
	Fri, 25 Jan 2008 19:52:20 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m0PIq6CR009927;
	Fri, 25 Jan 2008 19:52:06 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@fuw.edu.pl using -f
In-Reply-To: <alpine.LNX.1.00.0801251336080.13593@iabervon.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71726>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This allows users with different preferences for access methods to the
> same remote repositories to rewrite each other's URLs to get the
> desired access.

[...]
> +host.<name>.base::
> +	The base URL which should be used for this particular
> +	host. This can be used by a user who has a better access
> +	method to a repository than other users to make use of the
> +	preferable path despite getting URLs from other users using
> +	more commonly-available methods. Alternatively, a user who
> +	only has less privileged access to a repository than the usual
> +	audience can use this mechanism to replace disallowed methods
> +	with public ones.
> +
> +host.<name>.alias::
> +	Additional base URLs which refer to this host. If a URL
> +	matches this, any access to it will use the URL formed with
> +	the corresponding base URL instead of the given URL.
> +

>From this I could not get how those configuration are meant to be
used. Perhaps some usage example?

BTW. wouldn't the same be solved better by enabling remote.<name>.url
to be multi-valued, first working for fetch, all URLs for push?

-- 
Jakub Narebski
Poland
ShadeHawk on #git
