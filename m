From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 21:18:02 +0200
Message-ID: <20100113191802.GA8110@Knoppix>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com>
 <20100113135753.GA7095@Knoppix>
 <20100113141218.GA17687@inner.home.ulmdo.de>
 <20100113144745.GA7246@Knoppix>
 <20100113161711.GB17687@inner.home.ulmdo.de>
 <20100113173610.GA7609@Knoppix>
 <20100113183520.GA23674@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 20:18:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NV8jP-00064x-Ki
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 20:18:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754991Ab0AMTSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 14:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754923Ab0AMTSK
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 14:18:10 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:42393 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab0AMTSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 14:18:09 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id 87FD4EF4A9;
	Wed, 13 Jan 2010 21:18:06 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A004824B040; Wed, 13 Jan 2010 21:18:06 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 55BECE51CA;
	Wed, 13 Jan 2010 21:18:03 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100113183520.GA23674@inner.home.ulmdo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136860>

On Wed, Jan 13, 2010 at 07:35:20PM +0100, Andreas Krey wrote:
> On Wed, 13 Jan 2010 19:36:10 +0000, Ilari Liusvaara wrote:
> 
> Ok, then I'll be really interested in the server-side support and
> the man pages on the whole stuff. Especially in how this is going
> to be different from what ssh:// does or can do.

That feature is grossly underdocumented (and also nonportable). Unix(7)
should document it, except that it doesn't for me (it documents that
SO_PASSCRED takes a boolean, except that what the server implementation
passes is something completely different).

I found the intformation about how to forcibly get peer UID on Linux
from one secure programming HOWTO.

One other software that I know uses similar stuff is D-BUS. AFAIK, SSH
can't do it.

Essentially, it involves asking the kernel about UID the socket peer
runs as (with local sockets, kernel knows that information).
 
> Please consider my objections revoked, other than the claim that
> it could be done with stunnel, however ugly that would be.

Only if you don't care about complexity introducing PKI would bring
(yes, I read those manuals).

> I don't see how that would endanger the standard certificate auth in ssl
> (client or server).

It doesn't, but...

> Of course, you have another problem in that case...also I'd personally
> like to rely on ssl client certificates when using https.

And how many (relative) use client ceritificates with SSL? Keypairs with SSH?
Why you think this is?

-Ilari
