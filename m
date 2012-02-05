From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Specifying revisions in the future
Date: Sun, 05 Feb 2012 13:57:55 -0800 (PST)
Message-ID: <m3ehu9kknw.fsf@localhost.localdomain>
References: <jgjkk0$qrg$1@dough.gmane.org> <vpqipjlf309.fsf@bauges.imag.fr>
	<m21uq9x8q2.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, jpaugh@gmx.us,
	git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Feb 05 22:58:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RuA5y-000469-Aj
	for gcvg-git-2@plane.gmane.org; Sun, 05 Feb 2012 22:58:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752251Ab2BEV56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Feb 2012 16:57:58 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:46648 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751654Ab2BEV55 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Feb 2012 16:57:57 -0500
Received: by eekc14 with SMTP id c14so1962172eek.19
        for <git@vger.kernel.org>; Sun, 05 Feb 2012 13:57:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=zXEKthok16z0quRKXzuA+nUA56v6kSM5U2wKrefhUHU=;
        b=GXN3vEuTRWoKzheOrhEGgp2QpUrd30O37dUp8rWIWjKpSHSoJbCl5Z/EDtkUCmY7mE
         q8tPLvOzR189NZM2bJjXDeVBLFQofub/ErUYle4iyDrvJmhNvish67HP/fKckBl4Ks4p
         3fdoNdmwD6FxoUc/ju9SshK3yAVq0/fnNkP8Q=
Received: by 10.14.0.76 with SMTP id 52mr3787661eea.23.1328479076173;
        Sun, 05 Feb 2012 13:57:56 -0800 (PST)
Received: from localhost.localdomain (abvp235.neoplus.adsl.tpnet.pl. [83.8.213.235])
        by mx.google.com with ESMTPS id a58sm53238264eeb.8.2012.02.05.13.57.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 05 Feb 2012 13:57:55 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q15LvwYC005627;
	Sun, 5 Feb 2012 22:57:58 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q15LvuW7005624;
	Sun, 5 Feb 2012 22:57:56 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <m21uq9x8q2.fsf@igel.home>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189972>

Andreas Schwab <schwab@linux-m68k.org> writes:
> Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:
> 
> > "the successor of <commit>", OTOH, is not well defined, since there can
> > be several successors, and one can't order them reliably (you can't
> > really know the set of successors, because they can exist in different
> > repositories).
> 
> Yet it would be nice to have a concise notation for "the nth successor
> of <commit> towards <commit>" (using --first-parent ordering when
> ambiguous).

First, "the nth successor"... from which refs?  Commit objects have
pointers in one direction only, from commit to its ancestors (earlier
commits).

Second, `--first-parent' won't help here.  Take for example the
following situation:

   ---X<---*<---.<---A
            \
             \--.<---B

X+3 is A or B?  Note that pointers point _to_ '*' commit, so there is
not first or second here - no natural ordering like in the case of
commit parents.

-- 
Jakub Narebski
