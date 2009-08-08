From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: git gc expanding packed data?
Date: Sat, 08 Aug 2009 03:11:35 +0200
Message-ID: <m2tz0j154o.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Hin-Tak Leung <hintak.leung@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Aug 08 03:11:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZaTN-00070L-9D
	for gcvg-git-2@gmane.org; Sat, 08 Aug 2009 03:11:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754135AbZHHBLk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 21:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbZHHBLk
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 21:11:40 -0400
Received: from mail-out.m-online.net ([212.18.0.10]:37462 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752600AbZHHBLj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 21:11:39 -0400
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 606021C00100;
	Sat,  8 Aug 2009 03:11:39 +0200 (CEST)
Received: from localhost (dynscan2.mnet-online.de [192.168.1.215])
	by mail.m-online.net (Postfix) with ESMTP id 0AEB49027D;
	Sat,  8 Aug 2009 03:11:39 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.3.149])
	by localhost (dynscan2.mnet-online.de [192.168.1.215]) (amavisd-new, port 10024)
	with ESMTP id zGvwiBMqhFc1; Sat,  8 Aug 2009 03:11:37 +0200 (CEST)
Received: from igel.home (DSL01.83.171.175.39.ip-pool.NEFkom.net [83.171.175.39])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat,  8 Aug 2009 03:11:37 +0200 (CEST)
Received: by igel.home (Postfix, from userid 501)
	id 1CA2310C1BE; Sat,  8 Aug 2009 03:11:35 +0200 (CEST)
X-Yow: HELLO KITTY gang terrorizes town, family STICKERED to death!
In-Reply-To: Nicolas Pitre's message of "Wed\, Aug 5\, 2009 at 11\:39 PM"
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125236>

Nicolas Pitre <nico@cam.org> writes:

> It appears that the git installation serving clone requests for
> git://gcc.gnu.org/git/gcc.git generates lots of unreferenced objects. I
> just cloned it and the pack I was sent contains 1383356 objects (can be
> determined with 'git show-index < .git/objects/pack/*.idx | wc -l').
> However, there are only 978501 actually referenced objects in that
> cloned repository ( 'git rev-list --all --objects | wc -l').  That makes
> for 404855 useless objects in the cloned repository.

Those objects are not useless.  They are referenced by the remote refs
on the remote side, which are not fetched by default.  If you clone a
mirror of the repository you'll see no unreferenced objects.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
