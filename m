From: Rodrigo Silva =?utf-8?b?KE1lc3RyZUxpb24p?= 
	<linux@rodrigosilva.com>
Subject: Re: [PATCH] Documentation: improve description of =?utf-8?b?R0lUX0VESVRPUg==?= and preference order
Date: Mon, 26 Mar 2012 08:11:44 +0000 (UTC)
Message-ID: <loom.20120326T100258-967@post.gmane.org>
References: <loom.20120323T133648-453@post.gmane.org> <7vty1ftc4e.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 26 10:12:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SC52S-00037r-OG
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 10:12:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab2CZIMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 04:12:03 -0400
Received: from plane.gmane.org ([80.91.229.3]:60578 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754034Ab2CZIMB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 04:12:01 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1SC51z-0002uh-RU
	for git@vger.kernel.org; Mon, 26 Mar 2012 10:12:00 +0200
Received: from baddd5e7.virtua.com.br ([baddd5e7.virtua.com.br])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 10:11:59 +0200
Received: from linux by baddd5e7.virtua.com.br with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 26 Mar 2012 10:11:59 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 186.221.213.231 (Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:11.0) Gecko/20100101 Firefox/11.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193899>

Junio C Hamano <gitster <at> pobox.com> writes:

> >
> > diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
> > index 5317cc2..9c49163 100644
> > --- a/Documentation/git-var.txt
> > +++ b/Documentation/git-var.txt
> > @@ -43,7 +43,8 @@ GIT_EDITOR::
> >      `$SOME_ENVIRONMENT_VARIABLE`, `"C:\Program Files\Vim\gvim.exe"
> >      --nofork`.  The order of preference is the `$GIT_EDITOR`
> >      environment variable, then `core.editor` configuration, then
> > -    `$VISUAL`, then `$EDITOR`, and then finally 'vi'.
> > +    `$VISUAL`, then `$EDITOR`, and then finally a hardcoded fallback
> > +    editor set at build time, by default 'vi'.
> 
> I do not think this is needed; please file a bug to whoever is replacing
> 'vi' with 'nono' and distributing the resulting binary, without updating
> this part of the documentation.

Ok, I'll do so. Just a clarification: the actual built-time replacement
value is "/usr/bin/editor", which, in my system, points to nano.

This is done in Debian and other derivatives, like Ubuntu and Linux Mint

> 
> > diff --git a/Documentation/git.txt b/Documentation/git.txt
> > index d5b7667..fac57ba 100644
> > --- a/Documentation/git.txt
> > +++ b/Documentation/git.txt
> > @@ -711,6 +711,12 @@ other
> >  	a pager.  See also the `core.pager` option in
> >  	linkgit:git-config[1].
> >  
> > +'GIT_EDITOR'::
> > +    This environment variable overrides `$EDITOR` and `$VISUAL`.
> > +    It is used by several git comands when, on interactive mode,
> > +    an editor is to be launched. See also linkgit:git-var[1]
> > +    and the `core.editor` option in linkgit:git-config[1].
> > +
> 
> This is a good addition.  Thanks.

You're welcome, always glad to help such a fabulous project.


> >  'GIT_SSH'::
> >  	If this environment variable is set then 'git fetch'
> >  	and 'git push' will use this command instead
> 


So, what should I do now? Re-send the patch with just the accepted parts
(and adjusting commit message accordingly)? Or this will be done by you?
This is my first contribution, not sure about the workflow

Thanks,
ML
