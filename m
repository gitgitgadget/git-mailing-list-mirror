From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Cutting history
Date: Sat, 10 Jul 2010 01:47:14 -0700 (PDT)
Message-ID: <m3tyo7lo6n.fsf@localhost.localdomain>
References: <20100710032553.GB554@nibiru.local>
	<4C37F24E.30407@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: weigelt@metux.de, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 10:47:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXViX-0002fy-G8
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 10:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751943Ab0GJIrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Jul 2010 04:47:20 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:46524 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751511Ab0GJIrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jul 2010 04:47:19 -0400
Received: by bwz1 with SMTP id 1so1553025bwz.19
        for <git@vger.kernel.org>; Sat, 10 Jul 2010 01:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=X5BxFnzazzMWwMowBdX/52glT0ofARpal4hlBq9CfvY=;
        b=omZZiT8FbdfB3UQz9N+s1NBlhfYTrGTm+8lNRhj1l0ZsHMaTjsYcj6PAeOtLX1oMyW
         bsQDRy31EylTDmAqiNcVjI0TvFth7wsjYHS7GGUkzq5CzAr97Ra6WKHfE5s7Cj4aXhGQ
         fUeuqP9BkGbbxxGmtgLcHxs43Li6TyIg8qdx0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=L7V2lE1uc8zujQlhqatjUd6kgz1iPV1KPzGOpQogpMQHeLRLFFMXE1+7eQHbDrL4Gh
         xraxwWvQzBWdNGGx4nmnrDH5AcUCjMrw3xtFPvH0bO8g0stiq2zzOK4NNzwJSJUuLM6P
         JmGCYTp0E0CkrZlDzvfs4+6A076pDCLgrfmjY=
Received: by 10.204.47.193 with SMTP id o1mr8365659bkf.134.1278751637589;
        Sat, 10 Jul 2010 01:47:17 -0700 (PDT)
Received: from localhost.localdomain (abvi53.neoplus.adsl.tpnet.pl [83.8.206.53])
        by mx.google.com with ESMTPS id s34sm7726665bkk.13.2010.07.10.01.47.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Jul 2010 01:47:14 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6A8kV6T014921;
	Sat, 10 Jul 2010 10:46:46 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6A8k9qN014910;
	Sat, 10 Jul 2010 10:46:09 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4C37F24E.30407@workspacewhiz.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150715>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

>   ----- Original Message -----
> From: Enrico Weigelt
> Date: 7/9/2010 9:25 PM
>
> > I'm using git for automatic backups (eg. database dumps). This
> > works quite well, but as time goes, the history (and so the repo)
> > gets larger and larger. It would be really nice to allow cutting
> > off old stuff (eg. after N commits in the past).

This is certainly Using Git For What It Was Not Intended...

> >
> > Maybe that could be done by introducing "stopper" tags: commits
> > that have an stopper-tag may have missing parents, and git-gc
> > can be told to ignore those parents and throw away everything
> > behind the stopper (if not referenced otherwise).
> >
> > A probably cleaner, but more invasive way could be making refs
> > to vectors, which may contain stop points (multiple ones in case
> > of merges) additionally to the start point. Remote transmits only
> > contain the commits within this range, and GC also just scans
> > the range (instead of following all parents).
>
> Your post reminded me of this: http://progit.org/2010/03/17/replace.html

Another solution would be to make history shallower like shallow clone
("git clone --depth <depth>") does it[1], and then prune history.  Or
you can use grafts to cauterize history.

Both of those solutions have disadvantages wrt pushing and pulling to
other repositories (shallow clone less so), but I don't think that
would be a problem for your situation.

[1] Documentation/technical/shallow.txt 

-- 
Jakub Narebski
Poland
ShadeHawk on #git
