From: Eygene Ryabinkin <rea-git@codelabs.ru>
Subject: Re: [PATCH] Introduce file with the common default build-time items.
Date: Thu, 14 Jun 2007 13:56:54 +0400
Message-ID: <20070614095654.GT86872@void.codelabs.ru>
References: <20070613054316.GN86872@void.codelabs.ru> <20070614043633.GV6073@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 11:57:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hym56-0001q7-Ku
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 11:57:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbXFNJ5F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 05:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751603AbXFNJ5E
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 05:57:04 -0400
Received: from pobox.codelabs.ru ([144.206.177.45]:54390 "EHLO
	pobox.codelabs.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbXFNJ5C (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 05:57:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=simple; s=one; d=codelabs.ru;
	h=Received:Date:From:To:Cc:Message-ID:References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:Sender:X-Spam-Status:Subject;
	b=jY8uRomVAekutWOHPd8uHDKuw7l4UuiNPd0LMNlajNlQ9+TIN6rM1WqbRDnDvaOXgz5/avk5mB5giIJpIYiGOIW4FqbE7dHsveFxvrGwMn1aGB/8VnTejfOLG2Z7B6K4toc0ft8xtEcTmDSa9K5zGLS5G8IKDmk6NpJvqblEnfE=;
Received: from void.codelabs.ru (void.codelabs.ru [144.206.177.25])
	by pobox.codelabs.ru with esmtpsa (TLSv1:AES256-SHA:256)
	id 1Hym4Z-000Ef9-3n; Thu, 14 Jun 2007 13:56:59 +0400
Content-Disposition: inline
In-Reply-To: <20070614043633.GV6073@spearce.org>
X-Spam-Status: No, score=-1.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_50
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50185>

Shawn, good day.

Thu, Jun 14, 2007 at 12:36:33AM -0400, Shawn O. Pearce wrote:
> Eygene Ryabinkin <rea-git@codelabs.ru> wrote:
> > Words 'wish' and 'tclsh' are scattered across at least three files,
> > but they are tied to the same entities.  To ease the maintenance
> > and remove errors, these configuration items were gathered into the
> > separate file named 'common-make-vars.def'.
> ...
> > diff --git a/git-gui/Makefile b/git-gui/Makefile
> > index 3de0de1..654641a 100644
> > --- a/git-gui/Makefile
> > +++ b/git-gui/Makefile
> > @@ -6,6 +6,8 @@ all::
> >  GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
> >  	@$(SHELL_PATH) ./GIT-VERSION-GEN
> >  -include GIT-VERSION-FILE
> > +# Default values
> > +-include ../common-make-vars.def
> 
> A good idea to try and make these all common, but you cannot do this,
> or at least this part of the patch.
> 
> The git-gui subdirectory of git.git is actually its own project,
> maintained in its own Git repository.

OK, but then may be it will be logical to put Tcl/Tk-related variables
to the git-gui/common-make-vars.def?  I am a little worried about
this, because gitk is the part of the git.git and it should get the
variables too.  The drawback here is if you will update your git-gui
repo, then git.git will need to wait for your import to get the
changes in the variables.  And this will seriously couple git.git
and git-gui, though I don't know if it is good or bad.

Any ideas?
-- 
Eygene
