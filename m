From: Jan Hudec <bulb@ucw.cz>
Subject: checkout --push/--pop idea (Re: What's cooking in git.git (topics))
Date: Mon, 31 Dec 2007 11:47:23 +0100
Message-ID: <20071231104723.GD20098@efreet.light.src>
References: <7vhci9u5qi.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 31 11:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J9IBe-0006CO-48
	for gcvg-git-2@gmane.org; Mon, 31 Dec 2007 11:48:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754416AbXLaKrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Dec 2007 05:47:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754970AbXLaKrg
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Dec 2007 05:47:36 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:58394 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753631AbXLaKrf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Dec 2007 05:47:35 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 986565727B;
	Mon, 31 Dec 2007 11:47:34 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 5ovru4VWz0EV; Mon, 31 Dec 2007 11:47:30 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 645C557325;
	Mon, 31 Dec 2007 11:47:29 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1J9IB1-0002OX-HT; Mon, 31 Dec 2007 11:47:23 +0100
Content-Disposition: inline
In-Reply-To: <7vhci9u5qi.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69397>

On Sun, Dec 23, 2007 at 01:20:53 -0800, Junio C Hamano wrote:
> * ns/checkout-push-pop (Wed Dec 5 07:04:06 2007 +0900) 1 commit
>  - git-checkout --push/--pop
> 
> A reasonably cleanly written cute hack, and I do not see this breaking
> the normal codepath.  But I tend to agree with people that 'push' is
> too late for forgetful mortals, and just a single "previous" would be
> easier to use.

Shouldn't reflog of a symbolic ref contain (or also contain) the name of
pointee ref, instead of the resolved value? Than we could still get the exact
past revisions by looking at the pointee reflog by time, but could also get
the past branch names.

It would require an extension to the commitish syntax for specifying how to
resolve the pointee. Eg. HEAD^{1} would mean the previous sha1, HEAD^{1}{}
would mean the previous branch (but current value of it), and, by extension,
HEAD^{}{1} could mean previous value of currently selected branch.

Hm, the slight problem seems to be, that users would want previously checked
out branch even though commits were already done to the current one, so it is
not the previous reflog entry anymore...

-- 
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
