From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Makefile: create an install-symlinks target
Date: Wed, 18 Jul 2007 16:06:23 +0200
Message-ID: <861wf5iz6o.fsf@lola.quinscape.zz>
References: <86bqe9lwy8.fsf@lola.quinscape.zz> <81b0412b0707180608j7c22631ak87f3ddd6481bccf2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 16:06:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBAAn-0001KX-HG
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 16:06:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753132AbXGROGf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 10:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753852AbXGROGe
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 10:06:34 -0400
Received: from main.gmane.org ([80.91.229.2]:38514 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752976AbXGROGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 10:06:34 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBAAh-0005ll-GA
	for git@vger.kernel.org; Wed, 18 Jul 2007 16:06:31 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 16:06:31 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 16:06:31 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:X7fv3WJTqfo5cqkkOx3FFXCOOpc=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52864>

"Alex Riesen" <raa.lkml@gmail.com> writes:

> On 7/18/07, David Kastrup <dak@gnu.org> wrote:
>> +       @: $(MAKE) && cd '$(prefix_SQ)' && find . -mindepth 1 ...
>
> Sometime about now you'll need to define $(FIND) or even $(GNUFIND)
> for find. There are proprietary systems where find is not available or
> does not do what you want it to. There is often a gfind installed somewhere
> on these systems.

I think that the install-symlinks target is rather more specialized
than the tags and TAGS targets, yet those use just "find".  I think
I'll be able to throw out the -mindepth, however.  It was necessary in
a version that used find $(prefix), since /opt/git matched
-type d -name git*
but with find . this should not be relevant.

I'll amend that patch and prepare a separate one that uses $(FIND)
everywhere.

-- 
David Kastrup
