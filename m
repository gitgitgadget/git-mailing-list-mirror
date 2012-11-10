From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 2/3] git-submodule foreach: export .gitmodules settings
 as variables
Date: Sat, 10 Nov 2012 14:21:35 -0500
Message-ID: <20121110192135.GF2739@mjolnir>
References: <20121029222759.GI20513@sigill.intra.peff.net>
 <cover.1352431674.git.wking@tremily.us>
 <2121ce36cf4eb02385255cbd5b0bbd1dcc803113.1352431675.git.wking@tremily.us>
 <20121109164516.GB922@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Phil Hord <phil.hord@gmail.com>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nahor <nahor.j+gmane@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:23:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGen-0003Av-Aw
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:23:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752533Ab2KJTXi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 14:23:38 -0500
Received: from vms173003pub.verizon.net ([206.46.173.3]:56155 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752265Ab2KJTXi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 14:23:38 -0500
Received: from mjolnir.tremily.us ([unknown] [69.141.221.103])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDA009PUDS54C00@vms173003.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 10 Nov 2012 13:23:17 -0600 (CST)
Received: by mjolnir.tremily.us (Postfix, from userid 1000)
	id 2C0D7271F70; Sat, 10 Nov 2012 14:21:35 -0500 (EST)
Content-disposition: inline
In-reply-to: <20121109164516.GB922@book.hvoigt.net>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209298>

On Fri, Nov 09, 2012 at 05:45:22PM +0100, Heiko Voigt wrote:
> > can now be reduced to
> > 
> >   git submodule foreach 'git checkout $submodule_branch && git pull'
> 
> What other use cases are there? Would the need for this maybe go away
> once you had floating submodules following branches?

None that I can think of, but I don't use submodules very much.  The
idea of easily-accessible per-submodule configuration variables
strikes me as pretty useful, but I agree the code is a bit ugly.
Actually, I think exporting environment variables and calling the
foreach command in a subshell would be better than the current local
variables and eval.  The subshell would also make variable cleanup
irrelevant, which would make for a cleaner patch.

> For completeness you should make the variables possible to override by
> repository from the local repository configuration like all other
> submodule options that are read directly from .gitmodules.

Good idea (I wasn't aware of the override before).  Will do in v4.

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
