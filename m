From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git clone / svn checkout
Date: Sat, 13 Nov 2010 09:34:13 -0800 (PST)
Message-ID: <m362w1f7rt.fsf@localhost.localdomain>
References: <4CDD72D8.9010205@dewereldmorgen.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bruno De Bondt <bruno@dewereldmorgen.be>
X-From: git-owner@vger.kernel.org Sat Nov 13 18:35:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHK0h-0000im-VH
	for gcvg-git-2@lo.gmane.org; Sat, 13 Nov 2010 18:35:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755543Ab0KMReQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Nov 2010 12:34:16 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36532 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239Ab0KMReP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Nov 2010 12:34:15 -0500
Received: by fxm6 with SMTP id 6so911600fxm.19
        for <git@vger.kernel.org>; Sat, 13 Nov 2010 09:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=1vf3984PI6TGto35IrTWq7GZy6jLAxGE5KLaC3AzDB4=;
        b=wmqqj8SW9gT7Fqc0spbXNGbJm3r/w58fScg3HrH75s1DGsoJIf8Fvr/L9q/zEVobHL
         Br/lwCI5kqdtnGcLXwwODShsotak6FOD4U1CfJAXUm2SbjzPonE4CvpJ0nGdX8c1zWUl
         97dljE8v9Lk74StvLW88JTJ8FS/o60/UACVr8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=hDZcys27qKQ8wlFkHTACgDbmzcu9stkLgi56/fepq07v2ggrq3qYn6BGXYO53Akrrq
         Y4np6ciud3mprbG8PkB/w2MEKR2BErsHiHDgKaEz4dhdBQyui3Po+ZdONOyxYSbpn9ue
         3+Rhh/U6Yz+tv7PY73DxCUN7ZG/FaCy5ypGyg=
Received: by 10.223.123.142 with SMTP id p14mr2903445far.122.1289669654435;
        Sat, 13 Nov 2010 09:34:14 -0800 (PST)
Received: from localhost.localdomain (abwe118.neoplus.adsl.tpnet.pl [83.8.228.118])
        by mx.google.com with ESMTPS id d20sm380118fav.38.2010.11.13.09.34.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Nov 2010 09:34:13 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oADHXg9A023281;
	Sat, 13 Nov 2010 18:33:52 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oADHXQCQ023277;
	Sat, 13 Nov 2010 18:33:26 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4CDD72D8.9010205@dewereldmorgen.be>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161392>

Bruno De Bondt <bruno@dewereldmorgen.be> writes:

> Just started using Git, coming from SVN.
> 
> Something I regularly do in SVN, is checking out part of a repository,
> instead of the complete repository.

On the other hand in SVN you have multiple projects in a single
repository (under single repository hierarchy / svnroot).

> Consider the following: I have a local repository for
> development. On my testing server, I only (SVN) check out part of
> this repository, eg. the document root of a website (and not all the
> project management documents, which are in the same SVN repository,
> but not needed on the testing server).
> 
> How would I do this in Git, ie. only get a specific part of a
> repository? I feel that this is very much against the whole idea of Git
> (where, as far as I understand Git now, you work with complete clones of
> repositories), but is there a way to do this? Or should I just clone
> complete repositories on my testing server as well?

In this case it would be possible, I think, to put project management
documents and website itself in different git repositories, and toe
them together using submodules (see git-submodule manpage, and
documentation on Git Wiki and elsewhere).

There is support in git nowadays (acquired quire recently) to
*checkout* only part of repository (so called "sparse checkout"), but
you still need to clone whole repository.

There was some proof-of-concept work on *partial clone* support; see
git mailing list archives.  This is nevertheless quote hard problem
to solve correctly.
-- 
Jakub Narebski
Poland
ShadeHawk on #git
