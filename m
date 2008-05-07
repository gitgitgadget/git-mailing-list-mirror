From: David Kastrup <dak@gnu.org>
Subject: Re: Sort of a feature proposal
Date: Wed, 07 May 2008 20:05:20 +0200
Message-ID: <868wymrnvj.fsf@lola.quinscape.zz>
References: <86fxsutbke.fsf@lola.quinscape.zz>
	<alpine.LFD.1.10.0805070924300.3024@woody.linux-foundation.org>
	<86k5i6rp23.fsf@lola.quinscape.zz>
	<37fcd2780805071050n5153f5d2rf31a0f263820e92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 07 20:07:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jto28-0003kW-1f
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 20:06:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756704AbYEGSFh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2008 14:05:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756679AbYEGSFh
	(ORCPT <rfc822;git-outgoing>); Wed, 7 May 2008 14:05:37 -0400
Received: from main.gmane.org ([80.91.229.2]:33463 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752889AbYEGSFf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2008 14:05:35 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jto1A-0002bo-Vi
	for git@vger.kernel.org; Wed, 07 May 2008 18:05:28 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 May 2008 18:05:28 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 07 May 2008 18:05:28 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
Cancel-Lock: sha1:qVdpppBdGeGABmMMRNBV8PucKDE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81470>

"Dmitry Potapov" <dpotapov@gmail.com> writes:

>>  Is there a way to completely invalidate the disk cache without
>>  unmounting?
>
> echo 3 > /proc/sys/vm/drop_caches

Sigh.  It is the disk cache after all.  Looks like "git svn rebase"
can't just work from the index (ok, it checks whether there are
unstashed modifications).  And indeed, flushing the cache will make much
less of a difference for "git svn fetch" than for rebase.

Sorry for the noise.

-- 
David Kastrup
