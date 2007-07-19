From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 18:28:16 +0200
Message-ID: <86ir8g4au7.fsf@lola.quinscape.zz>
References: <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr> <20070719105105.GA4929@moonlight.home> <Pine.LNX.4.64.0707191310430.14781@racer.site> <86wswwa8ej.fsf@lola.quinscape.zz> <7FE87F7A-53AD-4B92-8F33-ECDFAE6A7EFB@silverinsanity.com> <Pine.LNX.4.64.0707191642270.14781@racer.site> <6C96EBA9-CDCE-40EA-B0EC-F9195DBE83DB@silverinsanity.com> <Pine.LNX.4.64.0707191715000.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 18:28:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBYrf-00008K-8C
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 18:28:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934857AbXGSQ21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 12:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933156AbXGSQ21
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 12:28:27 -0400
Received: from main.gmane.org ([80.91.229.2]:40558 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1764856AbXGSQ20 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 12:28:26 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBYrW-0006Sw-L1
	for git@vger.kernel.org; Thu, 19 Jul 2007 18:28:22 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 18:28:22 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 18:28:22 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:2knlTtsIDUdWT4JfvtU7x9PL9FQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53005>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Here a short description, which you should read until you understand
> it and then leave me alone:
>
> To add a directory to the tracked content, you have to _mark_ it as
> tracked.  So that when you remove the _real_ content of the
> directory, Git will not remove it.

Correct.  That is what my proposal is about.

> Alas, we already have such a marker.  It is called ".gitignore", and
> has been ignored by _you_.  There is _nothing_ wrong, from a
> technical standpoint, to call this marker ".gitignore", and it is
> _also_ not wrong to put this marker into the file system _in
> addition_ to the index.

Uh, then the directories are no longer empty.

> So go and add your directories via that marker, and _be done with
> it_.

But one is not done before running

find -name .gitignore -delete

and then the next recursive add will remove the .gitignore "markers".
The idea of "." is to have a marker that does _not_ appear in the work
directory.

-- 
David Kastrup
