From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: merge two local mirrors with detached heads and similar remotes
Date: Sun, 07 Nov 2010 03:52:39 -0800 (PST)
Message-ID: <m3vd49fj1k.fsf@localhost.localdomain>
References: <AANLkTinidbrJjmt5w=TyFGMyNpaGobE1iDBm3VAWmZvX@mail.gmail.com>
	<AANLkTi=JmpXEiEe-7-ZicUp-QosWjTZQgK77-f=9iAtL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Sun Nov 07 12:52:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PF3nn-0001Ai-Nx
	for gcvg-git-2@lo.gmane.org; Sun, 07 Nov 2010 12:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751853Ab0KGLwo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Nov 2010 06:52:44 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:61792 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751762Ab0KGLwn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Nov 2010 06:52:43 -0500
Received: by ewy7 with SMTP id 7so2419478ewy.19
        for <git@vger.kernel.org>; Sun, 07 Nov 2010 03:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=jmQ/LOib2WXIYUFXeL1DwKjFO00Hw+WjotMEi9zKGpE=;
        b=SSZAb2gTDKQoii5wtoWTRsQNT5R0liB6kKrki5srcJZaqASjY/hBmTR4criyce/Ciq
         HtJ4CBQAz7wwZsL5+TCiNrUZPcl3tymVLVE6JLxB/d6a4WBvYQAFW41WHtpD6yR4F3EY
         qYj1wc1Ph3r4DXUh3pa3KbJbIhcsLobMPvx7s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=fzZENyyr1ia9Nus3W1TiX4+glNsEZiraEbyNcujzCRBo4Nd7brcEFyX1SRmODzyYOt
         jxPgnPC0kuzYZL6H6Ps1NEQVd3IdF4BLeE1nOZ1Xc4wZg7H+CflMCz5Vsf4YBvK1bDzC
         4uYxg//p9Gy1J25aRuU2UyDgWiXPdFNFshSxA=
Received: by 10.14.48.12 with SMTP id u12mr2380074eeb.34.1289130760490;
        Sun, 07 Nov 2010 03:52:40 -0800 (PST)
Received: from localhost.localdomain (abwh115.neoplus.adsl.tpnet.pl [83.8.231.115])
        by mx.google.com with ESMTPS id v51sm3107556eeh.16.2010.11.07.03.52.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Nov 2010 03:52:39 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oA7Bq9Tp021283;
	Sun, 7 Nov 2010 12:52:15 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id oA7BprNf021231;
	Sun, 7 Nov 2010 12:51:53 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTi=JmpXEiEe-7-ZicUp-QosWjTZQgK77-f=9iAtL@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160876>

Zenaan Harkness <zen@freedbms.net> writes:

> ---------
> Looks very much like success to me. Small thing I notice is this line:
>   remotes/origin/HEAD -> origin/master
> 
> has become this:
>   remotes/lach/HEAD
> 
> (ie it's not a link any more - probably not particularly relevant,
> perhaps git gc would automate tidying this?)

It might be detached head: you can check it by using

  $ git rev-parse --symbolic-full-name remotes/lach/HEAD

If it is 'remotes/lach/HEAD' or 'HEAD', it is detached HEAD
(unnamed branch).


> Should something like Junio's tutorial go into
> Documentation/gitworkflows.xml(ARGGH!) ?
> If not, where else?
> Is there anything besides vim (about all I know) you can recommend for
> editing xml(ARGGH!) docs?

Documentation/gitworkflows.txt is source of XML, HTML, info and
manpage versions - please edit source (in AsciiDoc), and not generated
documentation.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
