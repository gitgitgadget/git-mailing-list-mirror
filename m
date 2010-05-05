From: Eli Barzilay <eli@barzilay.org>
Subject: Re: [PATCH] An alias that starts with "!!" runs in the current  directory.
Date: Wed, 5 May 2010 18:13:45 -0400
Message-ID: <19425.60825.824552.716664@winooski.ccs.neu.edu>
References: <1273019122.16093.6.camel@ubuntu.ubuntu-domain>
	<20100505005153.GC25390@coredump.intra.peff.net>
	<4BE115EF.8010306@viscovery.net>
	<20100505070131.GA11265@coredump.intra.peff.net>
	<19425.9169.537598.876589@winooski.ccs.neu.edu>
	<7v1vdql4c9.fsf@alter.siamese.dyndns.org>
	<19425.54504.163875.379151@winooski.ccs.neu.edu>
	<7vvdb2hurp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Jared Hance <jaredhance@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 06 00:14:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9mrJ-0006Tz-Er
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 00:14:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753464Ab0EEWOF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 May 2010 18:14:05 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:41229 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752109Ab0EEWOD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 18:14:03 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1O9mqf-0002Uq-Qw; Wed, 05 May 2010 18:13:45 -0400
In-Reply-To: <7vvdb2hurp.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146426>

On May  5, Junio C Hamano wrote:
> Eli Barzilay <eli@barzilay.org> writes:
> 
> > It looks like setup_git_directory_gently() returns the original CWD,...
> 
> It is designed to return what we internally call "prefix".  You
> however have to be careful as it can return NULL or an empty string
> when you are already at the top of the working tree.

OK, in this case it looks like it should work as expected.  At least
provided that chdir("") stays in the same directory -- and given the
call at the end of handle_alias(), it looks like this assumption is
already made.  Does this sound right?

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
