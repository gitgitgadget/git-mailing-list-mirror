From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] git-commit --amend: respect grafted parents.
Date: Thu, 27 Sep 2007 10:39:12 +0200
Message-ID: <86hclgijtb.fsf@lola.quinscape.zz>
References: <11908086961933-git-send-email-johannes.sixt@telecom.at> <Pine.LNX.4.64.0709261322150.28395@racer.site> <46FA5604.101@viscovery.net> <Pine.LNX.4.64.0709261501190.28395@racer.site> <46FA6CD7.1020709@viscovery.net>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?7vd4w51csv.fsf@g?= =?ISO-8859-1?Q?itster.siame=04se.?=
	=?ISO-8859-1?Q?dyndns.org>?= <Pine.LNX.4.64.0709262039250.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 27 10:42:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaoxE-000556-0Z
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 10:42:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753469AbXI0Imd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 04:42:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752493AbXI0Imd
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 04:42:33 -0400
Received: from main.gmane.org ([80.91.229.2]:39811 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751083AbXI0Imc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 04:42:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Iaow3-0007mm-Lr
	for git@vger.kernel.org; Thu, 27 Sep 2007 08:41:27 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 08:41:27 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 27 Sep 2007 08:41:27 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:NHhrB+zPgesUeN+4FfdMksSSWNU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59276>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Wed, 26 Sep 2007, Junio C Hamano wrote:
>
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>> > Johannes Schindelin schrieb:
>> >> The reason why I insist on not putting this into --amend is that I 
>> >> think this is not really an amend, but actively a rewrite of the 
>> >> merge commit.
>> >
>> > You have a point here. I'm convinced. Scrap the patch.
>> 
>> I am slow today.  Since when --amend is not about "a rewrite of commit"?
>
> Technically, you are right, of course.  Commit objects are immutable.  But 
> from a _porcelain_ view I maintain that "amending" is about changes _to_ a 
> commit.  It is not about redefining the (a) parent.

Well, if you already branched off the commit, the changes "to the
commit" will not register on the branch.  So my view is that amending
is about changes to HEAD, not to the HEAD commit.  And since branching
is certainly a porcelain operation and is clearly not affected by
amending commits, I think that the "rewrite of a commit" wording
strikes a good balance between "the original commit remains" and "it
is functionally replaced in the HEAD".

-- 
David Kastrup
