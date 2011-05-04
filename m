From: Kacper Kornet <kornet@camk.edu.pl>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Wed, 4 May 2011 15:58:27 +0200
Message-ID: <20110504135827.GC18585@camk.edu.pl>
References: <20110428022922.GC4833@camk.edu.pl>
 <7v62py5nbp.fsf@alter.siamese.dyndns.org>
 <20110428192751.GE4833@camk.edu.pl>
 <4DBFA3C6.8060209@viscovery.net>
 <7vzkn3itb5.fsf@alter.siamese.dyndns.org>
 <4DC0E99E.6090402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed May 04 15:58:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHcb9-0007sZ-G7
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 15:58:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753437Ab1EDN6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 09:58:34 -0400
Received: from moat.camk.edu.pl ([148.81.175.50]:58450 "EHLO moat.camk.edu.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753134Ab1EDN6e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 09:58:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by moat.camk.edu.pl (Postfix) with ESMTP id 387C15F0047;
	Wed,  4 May 2011 15:58:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at camk.edu.pl
Received: from moat.camk.edu.pl ([127.0.0.1])
	by localhost (liam.camk.edu.pl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jCxR15wGz7ZS; Wed,  4 May 2011 15:58:27 +0200 (CEST)
Received: from gatekeeper.camk.edu.pl (gatekeeper.camk.edu.pl [192.168.1.23])
	by moat.camk.edu.pl (Postfix) with ESMTP id 922005F0046;
	Wed,  4 May 2011 15:58:27 +0200 (CEST)
Received: by gatekeeper.camk.edu.pl (Postfix, from userid 1293)
	id 8026C80AF5; Wed,  4 May 2011 15:58:27 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4DC0E99E.6090402@viscovery.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172744>

On Wed, May 04, 2011 at 07:52:30AM +0200, Johannes Sixt wrote:
> Looking closer, the patch introduces git_etcdir for no good reason,
> IIUC.
> It should just re-use sysconfdir (the meaning of this variable is to
> point
> to the etc directory).

And the first version of my patch did it. However Junio has written:

> But this part in the Makefile outside the context of the patch bothers
> me.  It seems to imply that sysconfdir is _not_ that variable you want
> to
> define later.
>
>    # Among the variables below, these:
>    #   gitexecdir
>    #   template_dir
>    #   mandir
>    #   infodir
>    #   htmldir
>    #   ETC_GITCONFIG (but not sysconfdir)
>    #   ETC_GITATTRIBUTES
>    # can be specified as a relative path some/where/else;
>
> So I have a suspicion that your patch as is will break when prefix is
> set
> to something other than /usr directory.  I don't think anybody in-tree
> currently uses sysconfdir, but that does not mean nobody will ever do.

>From that I understood that he prefers sysconfdir to be always an
absolute path.
-- 
  Kacper Kornet
