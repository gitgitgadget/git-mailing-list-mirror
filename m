From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] filter-branch: get rid of "set -e"
Date: Wed, 18 Jul 2007 15:27:12 +0200
Message-ID: <86vechj0zz.fsf@lola.quinscape.zz>
References: <20070710205202.GA3212@steel.home> <Pine.LNX.4.64.0707181416050.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 18 15:27:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IB9Z4-00036k-6i
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 15:27:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758963AbXGRN1e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 09:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758514AbXGRN1e
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 09:27:34 -0400
Received: from main.gmane.org ([80.91.229.2]:52556 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758666AbXGRN1d (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 09:27:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IB9Yw-0002Ru-EV
	for git@vger.kernel.org; Wed, 18 Jul 2007 15:27:30 +0200
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 15:27:30 +0200
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 18 Jul 2007 15:27:30 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.51 (gnu/linux)
Cancel-Lock: sha1:7wNa0bnDjNDNbFtHtsnPWklyjag=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52862>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It was reported by Alex Riesen that "set -e" can break something as 
> trivial as "unset CDPATH" in bash.

Not in bash.  Just tried it.  But there are Bourne shells that do get
annoyed.

> So get rid of "set -e".

I'd rather write

[ "X$CDPATH" = "X" ] || unset CDPATH


With regard to shells, there is an interesting document
(info "(autoconf) Portable Shell")
which is rather disillusioning.

A real horror show is
(info "(autoconf) Limitations of Builtins")
where one learns that using if without else can lead to bad exit
status, too.

-- 
David Kastrup
