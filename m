From: david@lang.hm
Subject: Re: RFC: a minimal plugin architecture
Date: Thu, 28 Apr 2011 18:12:05 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104281808490.7120@asgard.lang.hm>
References: <BANLkTi=53dShgcsyTUP2aA+hvm6p+93XrA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <ae@op5.se>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Pau Garcia i Quiles <pgquiles@elpauer.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 03:12:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFcFp-0006IF-8P
	for gcvg-git-2@lo.gmane.org; Fri, 29 Apr 2011 03:12:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753026Ab1D2BMP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2011 21:12:15 -0400
Received: from mail.lang.hm ([64.81.33.126]:42101 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751992Ab1D2BMP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2011 21:12:15 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id p3T1C5E3027014;
	Thu, 28 Apr 2011 18:12:05 -0700
X-X-Sender: dlang@asgard.lang.hm
In-Reply-To: <BANLkTi=53dShgcsyTUP2aA+hvm6p+93XrA@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172420>

On Fri, 29 Apr 2011, Jon Seymour wrote:

> However, let's start simple, what would a minimal plugin directory
> look like and, assuming there was one per git-install, where would it
> be located relative to the prefix?
>
> Here's a suggestion for the layout:
>
> bin/
>   - all scripts and sh libraries
> man/
>   - all man pages
> html/
>   - all html pages
>
> What about location?
>
>   ${prefix}/git-plugins
>   ${prefix}/lib/git-plugins
>
> Or, decided by distribution?

distros are going to change this anyway, so start by accepting that, then 
make the default just that, a default, not something hard-coded.

> Is there support for the idea of adding a --man-path switch to the main line?
>
> What about a --plugins-path, that would answer the question about
> where plugins should go?

I think it would be better to put it in the config file, nobody is going 
to add command line options to every command they run.

> Per Jonathan's and Junio's suggestions, the idea of having a plugins
> search path seems like a reasonable one, so that users without control
> over the git install can at least customize it themselves.

only if you make sure that the plugins only run as the user, with no 
chance of them being invoked as a privilaged user.

David Lang

> How would this path be configured by the user? Would the user
> configuration edit the git default or would it override it?
>
> If there are multiple plugin directories, how would a plugin discover
> which one it has been installed in so that it can find any
> plugin-specific resource it might need?
>
> Regards,
>
> jon.
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
