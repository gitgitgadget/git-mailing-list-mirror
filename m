From: Denys Duchier <duchier@ps.uni-sb.de>
Subject: Re: [Gnu-arch-users] Re: [GNU-arch-dev] [ANNOUNCEMENT] /Arch/ embraces `git'
Date: Thu, 21 Apr 2005 11:09:58 +0200
Message-ID: <86d5soa42h.fsf@speedy.lifl.fr>
References: <200504201000.DAA04988@emf.net> <877jixfjxw.fsf@star.lifl.fr>
	<1114036849.5880.61.camel@perun.redhat.usu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: duchier@ps.uni-sb.de, gnu-arch-dev@lists.seyza.com,
	talli@museatech.net, git@vger.kernel.org, torvalds@osdi.org
X-From: git-owner@vger.kernel.org Thu Apr 21 11:06:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOXdU-0003sE-66
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 11:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVDUJKW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 05:10:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261223AbVDUJKW
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 05:10:22 -0400
Received: from justus.rz.uni-saarland.de ([134.96.7.31]:7661 "EHLO
	justus.rz.uni-saarland.de") by vger.kernel.org with ESMTP
	id S261220AbVDUJKM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Apr 2005 05:10:12 -0400
Received: from cs.uni-sb.de (cs.uni-sb.de [134.96.254.254])
	by justus.rz.uni-saarland.de (8.12.10/8.12.10) with ESMTP id j3L9A8Hs009755;
	Thu, 21 Apr 2005 11:10:09 +0200 (CEST)
Received: from mail.cs.uni-sb.de (mail.cs.uni-sb.de [134.96.254.200])
	by cs.uni-sb.de (8.13.4/2005033000) with ESMTP id j3L9A7P9010938;
	Thu, 21 Apr 2005 11:10:08 +0200 (CEST)
Received: from ps.uni-sb.de (grizzly.ps.uni-sb.de [134.96.186.68])
	by mail.cs.uni-sb.de (8.13.4/2005033000) with ESMTP id j3L9A5lL023269;
	Thu, 21 Apr 2005 11:10:05 +0200 (CEST)
X-Authentication-Warning: mail.cs.uni-sb.de: Host grizzly.ps.uni-sb.de [134.96.186.68] claimed to be ps.uni-sb.de
Received: from ps.uni-sb.de (localhost [127.0.0.1])
	by ps.uni-sb.de (8.12.10/8.12.10) with ESMTP id j3L9A2Ud015312;
	Thu, 21 Apr 2005 11:10:02 +0200
Received: from localhost (localhost [[UNIX: localhost]])
	by ps.uni-sb.de (8.12.10/8.12.10/Submit) id j3L9A2e6015310;
	Thu, 21 Apr 2005 11:10:02 +0200
To: Tomas Mraz <t8m@centrum.cz>
In-Reply-To: <1114036849.5880.61.camel@perun.redhat.usu> (Tomas Mraz's message
	of "Thu, 21 Apr 2005 00:40:48 +0200")
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.5.1 (justus.rz.uni-saarland.de [134.96.7.31]); Thu, 21 Apr 2005 11:10:09 +0200 (CEST)
X-AntiVirus: checked by AntiVir Milter 1.0.6; AVE 6.30.0.7; VDF 6.30.0.122
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tomas Mraz <t8m@centrum.cz> writes:

> If we suppose the maximum number of stored blobs in the order of milions
> probably the optimal indexing would be 1 level [0:2] indexing or 2
> levels [0:1] [2:3]. However it would be necessary to do some
> benchmarking first before setting this to stone.

As I have suggested in a previous message, it is trivial to implement adaptive
indexing: there is no need to hardwire a specific indexing scheme.  Furthermore,
I suspect that the optimal size of subkeys may well depend on the filesystem.
My experiments seem to indicate that subkeys of length 2 achieve an excellent
compromise between discriminatory power and disk footprint on ext2.

Btw, if, as you indicate above, you do believe that a 1 level indexing should
use [0:2], then it doesn't make much sense to me to also suggest that a 2 level
indexing should use [0:1] as primary subkey :-)

Cheers,

-- 
Dr. Denys Duchier - IRI & LIFL - CNRS, Lille, France
AIM: duchierdenys
