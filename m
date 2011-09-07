From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: Re: Linux 3.1-rc5
Date: Tue, 6 Sep 2011 22:37:50 -0300
Message-ID: <20110907013750.GA25150@khazad-dum.debian.net>
References: <CA+55aFxDjVJwbpP5YT4o=qud=OcxtT3Ry4HfCtW-FvNdj+RFeQ@mail.gmail.com>
 <4E65307F.5020103@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	git@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 07 03:38:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R175r-0000MT-0U
	for gcvg-git-2@lo.gmane.org; Wed, 07 Sep 2011 03:38:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754269Ab1IGBh7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Sep 2011 21:37:59 -0400
Received: from out4.smtp.messagingengine.com ([66.111.4.28]:44253 "EHLO
	out4.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753843Ab1IGBhz (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Sep 2011 21:37:55 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B071D28AAD;
	Tue,  6 Sep 2011 21:37:54 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute1.internal (MEProxy); Tue, 06 Sep 2011 21:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=smtpout;
	 bh=tuV/IHGYli6+okeKGh5D6xM3cD8=; b=mAIHGJr3XTCatOPqbOIsbQM06Ebu
	vkjhRyLvqDDrN1jGEcfePc/RvGRSq87poEySalxD8tSILqUi5tgS8mcxM2DmlqPX
	E9tbIiO/uxvRuilAewxjZDOwn5I7ORpLq/yqBH/zchKj6OBTFKZ5I+ktbInv2SvX
	umObZAOjeYBgvw0=
X-Sasl-enc: zicRHSnlnxKPhMsu1IdMj3x7+2HQk/yW9WKzZLenvO1P 1315359474
Received: from khazad-dum.debian.net (unknown [201.82.73.183])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 600088611A2;
	Tue,  6 Sep 2011 21:37:54 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by localhost.khazad-dum.debian.net (Postfix) with ESMTP id CFEF3E0103;
	Tue,  6 Sep 2011 22:37:51 -0300 (BRT)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
	by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id dT+aQutVAgYr; Tue,  6 Sep 2011 22:37:50 -0300 (BRT)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
	id D1BBDE204C; Tue,  6 Sep 2011 22:37:50 -0300 (BRT)
Content-Disposition: inline
In-Reply-To: <4E65307F.5020103@redhat.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F
 1CDB 0FE3
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180848>

On Mon, 05 Sep 2011, Mauro Carvalho Chehab wrote:
> It would be great if "git remote update" could also verify the tag
> signature (if present), as most of us just do a "git remote update".

That helps, and it really should be all that matter for a power-end-user
that just wants to build his kernel from a git tree.

However, one can still try to trick someone to base the tree he's going to
use for a future pull request on a tree with a rogue commit, in order to
try to get the rogue commit into mainline through an indirect path, for
example.

Yeah, it is very obvious, and not a real major point of concern around
LKML: we all check the diff, log or shortlog between the tree we're
offering upstream to pull from) and the current upstream tree for any
stray commits after all (if only to avoid embarassing mistakes).   And
upstream does his/her own checks before keeping the merged tree, and so
forth.

It's just that the security of the kernel source trees are not a simple
consequence of how git works: the workflow matters.  I feel that point
deserves to be stressed every once in a while, however obvious it might
be.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
