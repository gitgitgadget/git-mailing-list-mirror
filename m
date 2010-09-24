From: Tait <git.git@t41t.com>
Subject: Re: Minimum Perl version?
Date: Fri, 24 Sep 2010 13:40:32 -0700
Message-ID: <20100924204032.GU23563@ece.pdx.edu>
References: <20100924100019.GT23563@ece.pdx.edu>
 <AANLkTin_wrCnpz-fz=FuJ96j+xBHM1-5HTGG0vP7bmDY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
	David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 24 22:40:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzF4U-0003oO-BA
	for gcvg-git-2@lo.gmane.org; Fri, 24 Sep 2010 22:40:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753694Ab0IXUkg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 16:40:36 -0400
Received: from rcpt.cat.pdx.edu ([131.252.208.107]:51702 "EHLO
	rcpt.cat.pdx.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab0IXUkg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 16:40:36 -0400
Received: from nemo.ece.pdx.edu (root@nemo.ece.pdx.edu [131.252.209.162])
	by rcpt.cat.pdx.edu (8.14.2/8.14.2/Debian-2build1) with ESMTP id o8OKeWjP029552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 24 Sep 2010 13:40:32 -0700
Received: from nemo.ece.pdx.edu (tait@localhost [127.0.0.1])
	by nemo.ece.pdx.edu (8.13.6/8.13.1) with ESMTP id o8OKeWXn020261;
	Fri, 24 Sep 2010 13:40:32 -0700 (PDT)
Received: (from tait@localhost)
	by nemo.ece.pdx.edu (8.13.6/8.12.6/Submit) id o8OKeWsK020260;
	Fri, 24 Sep 2010 13:40:32 -0700 (PDT)
X-Authentication-Warning: nemo.ece.pdx.edu: tait set sender to git.git@t41t.com using -f
Content-Disposition: inline
In-Reply-To: <AANLkTin_wrCnpz-fz=FuJ96j+xBHM1-5HTGG0vP7bmDY@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (rcpt.cat.pdx.edu [131.252.208.107]); Fri, 24 Sep 2010 13:40:32 -0700 (PDT)
X-Spam-Status: No, score=0.0 required=6.0 tests=none autolearn=unavailable
	version=3.3.1
X-Spam-Checker-Version: SpamAssassin 3.3.1 (2010-03-16) on rcpt.cat.pdx.edu
X-Virus-Scanned: clamav-milter 0.96.1 at rcpt
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157054>

> > What is the minimum Perl version git expects to support?
> >
> > I ask, because f922df8... seems to have introduced a open() syntax that
> > is not compatible with some older Perl versions.
>
> We generally support 5.6 or above, but 5.8 or above for some other
> programs.

I am having to use a system with 5.6.1 to do cvsimport and cvsexportcommit,
and interactive add. I haven't tried sendmail or other functions, yet. This
system was previously using git 1.6.5.something, and did not have these
problems as of that release, but now that I'm building git 1.7.3, they
have appeared.

Perl 5.6.1 doesn't support the list open syntax, so one must replace
open(my $fh, '-|', @list) with open(my $fh, '-|'), and then exec(@list).
I'm working up a patch set to fill my own needs on this system, but based
on the subsequent discussion about setting 5.8 as the minimum, it sounds
like it's not worth submitting.

Thanks.
