From: David Kastrup <dak@gnu.org>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS keyword expansion
Date: Sun, 22 Jul 2007 21:17:12 +0200
Message-ID: <85644ci6yv.fsf@lola.goethe.zz>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com>
	<alpine.LFD.0.999.0707221205080.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:17:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICgvm-0002wB-89
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:17:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762171AbXGVTRS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761606AbXGVTRR
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:17:17 -0400
Received: from mail-in-06.arcor-online.net ([151.189.21.46]:48809 "EHLO
	mail-in-06.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1761391AbXGVTRO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 15:17:14 -0400
Received: from mail-in-02-z2.arcor-online.net (mail-in-02-z2.arcor-online.net [151.189.8.14])
	by mail-in-06.arcor-online.net (Postfix) with ESMTP id 6A61431F19F;
	Sun, 22 Jul 2007 21:17:13 +0200 (CEST)
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net [151.189.21.44])
	by mail-in-02-z2.arcor-online.net (Postfix) with ESMTP id 5DAD411446D;
	Sun, 22 Jul 2007 21:17:13 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-022-107.pools.arcor-ip.net [84.61.22.107])
	by mail-in-04.arcor-online.net (Postfix) with ESMTP id 2D7E71D7143;
	Sun, 22 Jul 2007 21:17:13 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 16DCB1D1E182; Sun, 22 Jul 2007 21:17:12 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707221205080.3607@woody.linux-foundation.org> (Linus Torvalds's message of "Sun\, 22 Jul 2007 12\:09\:01 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3729/Sun Jul 22 18:10:33 2007 on mail-in-04.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53302>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Jul 2007, Jon Smirl wrote:
>>
>> It would really be useful if git diff had an option for suppressing
>> diffs caused by CVS keyword expansion.
>
> I really think it's not a "git diff" issue, but it might be a "import" 
> issue.
>
> IOW, I think you'd be a *lot* better off just not importing those
> things in the first place (which is what CVS does internally), or
> possibly importing them as two trees (ie you'd have the "non-log"
> version and the "log expansion" version, so that you can track and
> compare both).

One problem is that those strings more often than not are involved in
some magic computation, like placing version and date information into
extracted output.  While an import of the unexpanded version is really
the sanest option, it might render the resulting code inoperable.

CVS diff itself reports those differences, too (and it makes for a
good quota of merge problems even in CVS), so it is not like we are in
bad company here.

Uh, strike that.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
