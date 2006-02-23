From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Convert open("-|") to qx{} calls
Date: Thu, 23 Feb 2006 09:53:35 -0800
Message-ID: <7v1wxuhsgw.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0602231532470.29635@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0602230738s3445bd86h2d1d670e0ef5daed@mail.gmail.com>
	<86hd6qgit5.fsf@blue.stonehenge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 23 18:54:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCKf4-0000BN-Lx
	for gcvg-git@gmane.org; Thu, 23 Feb 2006 18:53:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbWBWRxl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Feb 2006 12:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932366AbWBWRxl
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Feb 2006 12:53:41 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:58073 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932373AbWBWRxk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Feb 2006 12:53:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060223175209.MJYO20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Feb 2006 12:52:09 -0500
To: merlyn@stonehenge.com (Randal L. Schwartz)
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16655>

merlyn@stonehenge.com (Randal L. Schwartz) writes:

> Convert all of these to use "safe_qx" (perl 5.6 compatible):
>
>     sub safe_qx {
>       defined (my $pid = open my $kid, "-|") or die "Cannot fork: $!";
>...

IIRC, that is backwards.  The thread's conversion is not about
5.6 vs 5.8.  The conversion like what you suggested above was
done, but the thing is, and Alex's Perl is unhappy about it.

The version of Perl Alex has to use claims to be 5.8, but does
not understand open($kid, '-|'), and he is trying to come up
with a workaround.

I wish Perl had a stricter trademark policy that required
language features to be fully ported for an implementation to
use that name ;-).
