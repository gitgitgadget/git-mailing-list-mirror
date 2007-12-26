From: Sean <seanlkml@sympatico.ca>
Subject: Re: [PATCH] git-send-email: Generalize auto-cc recipient mechanism.
Date: Tue, 25 Dec 2007 23:54:38 -0500
Message-ID: <BAYC1-PASMTP131135B69209F6EB72F809AE5B0@CEZ.ICE>
References: <7vk5n2o58p.fsf@gitster.siamese.dyndns.org>
	<1198641389-959-1-git-send-email-git@davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Joel Becker <Joel.Becker@oracle.com>,
	Junio C Hamano <gitster@pobox.com>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Wed Dec 26 06:02:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J7OPK-0000jt-Ki
	for gcvg-git-2@gmane.org; Wed, 26 Dec 2007 06:02:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbXLZFBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2007 00:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751159AbXLZFBy
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Dec 2007 00:01:54 -0500
Received: from bay0-omc2-s2.bay0.hotmail.com ([65.54.246.138]:43799 "EHLO
	bay0-omc2-s2.bay0.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751151AbXLZFBx (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Dec 2007 00:01:53 -0500
X-Greylist: delayed 433 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Dec 2007 00:01:53 EST
Received: from BAYC1-PASMTP13 ([65.54.191.186]) by bay0-omc2-s2.bay0.hotmail.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Dec 2007 20:54:40 -0800
X-Originating-IP: [74.15.76.104]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([74.15.76.104]) by BAYC1-PASMTP13.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.2668);
	 Tue, 25 Dec 2007 20:54:39 -0800
Received: from guru.attic.local ([10.10.10.28])
	by linux1.attic.local with smtp (Exim 4.43)
	id 1J7OHn-000758-ET; Tue, 25 Dec 2007 23:54:31 -0500
In-Reply-To: <1198641389-959-1-git-send-email-git@davidb.org>
X-Mailer: Sylpheed 2.4.5 (GTK+ 2.12.1; i686-pc-linux-gnu)
X-OriginalArrivalTime: 26 Dec 2007 04:54:39.0573 (UTC) FILETIME=[6BD50050:01C8477B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69241>

On Tue, 25 Dec 2007 19:56:29 -0800
David Brown <git@davidb.org> wrote:

> Add a new option --suppress-cc, which can be specified one or more
> times to list the categories of auto-cc fields that should be
> suppressed.  If not specified, it defaults to values to give the same
> behavior as specified by --suppress-from, and --signed-off-cc.  The
> categories are:
> 
>   self   - patch sender.  Same as --suppress-from.
>   author - patch author.
>   cc     - cc lines mentioned in the patch.
>   cccmd  - avoid running the cccmd.
>   sob    - signed off by lines.
>   all    - all non-explicit recipients
> 

Hi Dave,

It's great to see you're taking care of this issue, it's one that i've tripped over
a few times.  If your patch is accepted as-is, i think it's an improvement.

But i wonder about the case where a user has "sendemail.suppresscc = all" in their
~/.gitconfig.   For the occasion when they do want to cc the author of
a patch, what do they do?  The above UI seems to lack a way to enable a cc option
that has been disabled by default.

Cheers,
Sean
