From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: some questions
Date: Fri, 22 Aug 2008 02:28:17 -0700 (PDT)
Message-ID: <m3bpzls8ld.fsf@localhost.localdomain>
References: <48AE6B41.1070005@jentro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thomas Pasch <thomas.pasch@jentro.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 11:29:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWSxT-0002FS-Bs
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 11:29:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755891AbYHVJ2X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 05:28:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755348AbYHVJ2X
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 05:28:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:43660 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754236AbYHVJ2V (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 05:28:21 -0400
Received: by ug-out-1314.google.com with SMTP id c2so87838ugf.37
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 02:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=bC5j2K//VgOmGSNqCyd3yG8AbSvtZDvnoDYTviUWM/A=;
        b=wDjtd4NoYxyaL4KAin3UPyjZbSYAhE1ONSFdXdwpvRUW/gxOQFYR/AEaqaeO8j0+XF
         x8qEyTGNQpufINqtbjdC+H/GHcR34k+9RM4suOuiOh2wBQFgYqqNdr3cTzAinNvSwuMt
         X3hNPA25iFk0S9Nr0RKm8Bhq2pezxmcncZE94=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=HdbSxWV4G2tgFyDDLkRl+Urrf8DYSXaO34l6OsyS/u2ZPRyreDsesicJ6Ad456Fzuy
         LNmdgOnNcuKnp3NI74qiofJb7qQHtXsBXmLwvmzRCsYoomDZv3JJ9yPe88BE5avEXM87
         DoQYWR0CqA+cjZ6byIKANdbcsgBAyZK4XUQqQ=
Received: by 10.66.221.19 with SMTP id t19mr2342650ugg.69.1219397298271;
        Fri, 22 Aug 2008 02:28:18 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.249.91])
        by mx.google.com with ESMTPS id h1sm835239nfh.19.2008.08.22.02.28.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Aug 2008 02:28:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m7M9RhUF003425;
	Fri, 22 Aug 2008 11:27:53 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m7M9RQk5003418;
	Fri, 22 Aug 2008 11:27:26 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <48AE6B41.1070005@jentro.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93279>

Thomas Pasch <thomas.pasch@jentro.com> writes:

> I try to migrate our old cvs repo to git.
> However, I still have to following questions
> that I found difficult to answer with
> the documentation.
> 
> - Is there a way to convert a indexVersion 1
>   repo to indexVersion 2? (And vice versa?)

I think the only solution is to simply remove index,
ensure configuration (pack.indexVersion), and recreate
it using git-index-pack(1).
 
> - Is there a way to find out if a repository
>   is indexVersion 1 or indexVersion 2 (from
>   the pack/index files)?

There is some magic number used to distinguish between
pack index version 1 and version 2.

See Documentation/technical/pack-format.txt for details.

> - http for git seems to be read-only/fetch.
>   Would it be (theoretically) possible to
>   support write/push (with WebDAV or so)?

It *is* supported (via https).

There was even attempt to create 'smart' http
push via web server module or CGI script, but
IIRC it hit feature freeze and discussion petered
out, so only parts of it are in 'pu'.

Search for "Add Git-aware CGI for Git-aware smart
HTTP transport", "More on git over HTTP POST"

  http://thread.gmane.org/gmane.comp.version-control.git/91104
 
> - I do not fully understand the implication
>   of 'git repack -a' (or 'git repack -A -d').
>   Is this bad for remote repos that are used
>   with http? (as '-a' is 'Especially useful when
>   packing a repository that is used for private
>   development and there is no need to worry about
>   people fetching via dumb protocols from it').

Dumb protocols currently _always_ download whole packfiles,
so if you want to serve dumb protocols you might want to
offer (also?) smaller packfiles.  You can, for example,
use .keep files and 'git repack -a' wouldn't matter.

You can try to search archives for "generational packing"
or something like that...

> - What would be the implication to mount the
>   git repo with nts (or another remote fs).
>   Is it save to use such a mounted repo from
>   more than one computer?

Should work without problems, _unless_ you mean that
you want to use multiple working directories with single
repository.  Then there are a couple of thing that you
have to be beware of (but you can instead use alternates
mechanism).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
