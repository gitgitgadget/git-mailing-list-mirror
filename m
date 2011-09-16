From: "Christopher M. Fuhrman" <cfuhrman@panix.com>
Subject: Re: [PATCH] gitweb: Strip non-printable characters from syntax
 highlighter output
Date: Fri, 16 Sep 2011 11:11:01 -0700 (PDT)
Message-ID: <alpine.NEB.2.01.1109161050080.2073@vc75.vc.panix.com>
References: <1314053923-13122-1-git-send-email-cfuhrman@panix.com> <7v8vqfdf0l.fsf@alter.siamese.dyndns.org> <201108270006.19289.jnareb@gmail.com> <201109161441.58946.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Christopher Wilson <cwilson@cdwilson.us>,
	Sylvain Rabot <sylvain@abstraction.fr>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 16 20:11:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R4csY-0002Tr-FN
	for gcvg-git-2@lo.gmane.org; Fri, 16 Sep 2011 20:11:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755438Ab1IPSLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Sep 2011 14:11:04 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:42076 "EHLO
	mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963Ab1IPSLD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Sep 2011 14:11:03 -0400
Received: from vc75.vc.panix.com (vc75.vc.panix.com [166.84.7.75])
	by mailbackend.panix.com (Postfix) with ESMTP id E15B934213;
	Fri, 16 Sep 2011 14:11:01 -0400 (EDT)
X-X-Sender: cfuhrman@vc75.vc.panix.com
In-Reply-To: <201109161441.58946.jnareb@gmail.com>
User-Agent: Alpine 2.01 (NEB 1266 2009-07-14)
X-OpenPGP-Key-ID: F37818CF
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181540>

Howdy,

On Fri, 16 Sep 2011 at 5:41am, Jakub Narebski wrote:

> The commit message is from Christopher, but I have replaced his solution
> of stripping non-printable characters via col(1) program by having gitweb
> strip characters not allowed in XML.
>
> Christopher, could you check that it fixes your issue?

After applying the patch, I tested it successfully against the following
files:

 * linux.git : arch/ia64/kernel/unwind.c
 * git.git   : t/t3902-quoted.sh

Furthermore, I'm pleased to report that non en_US.UTF8 characters (e.g.,
Chinese hanzi) as found in t3902-quoted.sh are displayed properly when
highlight is enabled.

Tested Web Browsers:

 * Safari (5.1 (6534.50)
 * Firefox 6.0.2 under Mac OS X Snow Leopard
 * Google Chrome 13.0.782.220 under OpenSuSE 11.4

>
>  gitweb/gitweb.perl |   14 +++++++++++++-
>  1 files changed, 13 insertions(+), 1 deletions(-)
>

Cheers!

-- 
Chris Fuhrman
cfuhrman@panix.com
