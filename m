From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [PATCH 2/3] git-daemon: use getnameinfo to resolve hostname
Date: Wed, 14 Jan 2009 14:06:12 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901141404150.23212@fbirervta.pbzchgretzou.qr>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr> <alpine.LSU.2.00.0901141148130.16109@fbirervta.pbzchgretzou.qr> <7vsknm2kbs.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 14:07:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN5TC-00035Z-MC
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 14:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762126AbZANNGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 08:06:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762064AbZANNGP
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 08:06:15 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:37072 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762046AbZANNGO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 08:06:14 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id 0721B180C566A; Wed, 14 Jan 2009 14:06:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id 060BC1D160A19;
	Wed, 14 Jan 2009 14:06:13 +0100 (CET)
In-Reply-To: <7vsknm2kbs.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105625>


On Wednesday 2009-01-14 12:33, Junio C Hamano wrote:
>> git-daemon: use getnameinfo to resolve hostname
>>
>> This is much shorter than inet_ntop'ing, and also translated
>> unresolvable addresses into a string.
>
>translated?  (I think you meant "translates" but my English is bad, so I
>am double checking).

yes, keyboard slipped away.

>This indeed is much nicer, provided if it is available at least as widely
>as inet_ntop() is.

Both inet_ntop and getnameinfo are in POSIX.1-2001.

> (1) Do we need similar compat/ function for getnameinfo()?  I am guessing
>     that most likely places are the ones that need NO_INET_NTOP and
>     NO_INET_PTON, and googling seems to indicate old Cygwin and HP-UX
>     11.00 may be among them.
>
> (2) Do we still use inet_ntop() elsewhere, and if not, can we remove the
>     compat/ definitions?
>

Yes, it is still used elsewhere.
