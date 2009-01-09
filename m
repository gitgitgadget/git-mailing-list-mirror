From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: fetch branch blacklist
Date: Fri, 09 Jan 2009 12:23:08 -0800 (PST)
Message-ID: <m3wsd41b7q.fsf@localhost.localdomain>
References: <87r63ek6cw.fsf@jidanni.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: jidanni@jidanni.org
X-From: git-owner@vger.kernel.org Fri Jan 09 21:24:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLNuJ-00056l-O6
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 21:24:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754796AbZAIUXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 15:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754703AbZAIUXN
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 15:23:13 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:35043 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137AbZAIUXM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 15:23:12 -0500
Received: by bwz14 with SMTP id 14so29559734bwz.13
        for <git@vger.kernel.org>; Fri, 09 Jan 2009 12:23:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=sfjQMGNwNgpI8+Zj7wPGFvXzgwvjB4qHkZQidh2ETqo=;
        b=nB7YcQU4XXxSi2ohMjP7TjC8UMhzPDeFauPcFaC49jfCv4X9WfrABgYyrwejudQ19o
         rRuBUPiXJcUsLgbS/5dEgU12kkQMtvWvDZE9iy4sNu3+ShivMllDTm+JFnG5LVH8pTy2
         uS9aEO020xNT2wjd2W9iXYmnOS9zI4m0syz70=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=sO1Yabjb/T8Jo/WYDnk++tEaTiib6S4FkcI4ql8swKzH3vJSkJGtRQAm0aq0UZhzFj
         1jy8vYK1xyan+/D1jhvdqSdn4SmCyDD6vwtl7VZ8pPRMltceU5LRAOCTcIemv9S+qmeJ
         LkmEnXhI+6adjPmvhVk2IEAUe1dDz6DNnDCKY=
Received: by 10.103.192.2 with SMTP id u2mr9335051mup.95.1231532589319;
        Fri, 09 Jan 2009 12:23:09 -0800 (PST)
Received: from localhost.localdomain (abwp34.neoplus.adsl.tpnet.pl [83.8.239.34])
        by mx.google.com with ESMTPS id e9sm53672684muf.51.2009.01.09.12.23.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Jan 2009 12:23:08 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n09KMX6h026869;
	Fri, 9 Jan 2009 21:22:44 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n09KMHxw026865;
	Fri, 9 Jan 2009 21:22:17 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <87r63ek6cw.fsf@jidanni.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105037>

jidanni@jidanni.org writes:

> If one wants to always fetch all except one remote branch, one cannot
> just blacklist it, but must instead whitelist all the rest.
> $ git branch -rd origin/man origin/html
> Deleted remote branch origin/man.
> Deleted remote branch origin/html.
> Plus I edited them out of FETCH_HEAD. Nonetheless, back from the dead:
> $ git pull
> From git://git.kernel.org/pub/scm/git/git
>  * [new branch]      html       -> origin/html
>  * [new branch]      man        -> origin/man
> The only solution is to change .git/config:
> [remote "origin"]
> 	url = git://git.kernel.org/pub/scm/git/git.git
> #	fetch = +refs/heads/*:refs/remotes/origin/*
> 	fetch = +refs/heads/maint:refs/remotes/origin/maint
> 	fetch = +refs/heads/master:refs/remotes/origin/master
> 	fetch = +refs/heads/next:refs/remotes/origin/next
> 	fetch = +refs/heads/pu:refs/remotes/origin/pu
> 	fetch = +refs/heads/todo:refs/remotes/origin/todo

Well, you can always use hooks for that (see for example
underdocumented contrib/hooks/update-paranoid)... or you can try to
scratch that itch yourself.  gitignore supports inverse (negated)
patterns (!<pattern>), so there is some code dealing with
"blacklisting".  I would propose using the same '!' character, or
perhaps one of forbidden characters (see git-check-ref-format(1)),
i.e.

 [remote "origin"]
 	url = git://git.kernel.org/pub/scm/git/git.git
 	fetch = +refs/heads/*:refs/remotes/origin/*
        fetch = !refs/heads/html
        fetch = !refs/heads/man

-- 
Jakub Narebski
Poland
ShadeHawk on #git
