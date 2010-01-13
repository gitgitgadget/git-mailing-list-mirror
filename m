From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [RFC 0/2] Git-over-TLS (gits://) client side support
Date: Wed, 13 Jan 2010 22:47:32 +0200
Message-ID: <20100113204732.GB8383@Knoppix>
References: <1263388786-6880-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <fcaeb9bf1001130539p2971caavd101d46de9269769@mail.gmail.com>
 <20100113135753.GA7095@Knoppix>
 <20100113141218.GA17687@inner.home.ulmdo.de>
 <20100113144745.GA7246@Knoppix>
 <20100113161711.GB17687@inner.home.ulmdo.de>
 <20100113173610.GA7609@Knoppix>
 <20100113183520.GA23674@inner.home.ulmdo.de>
 <20100113191802.GA8110@Knoppix>
 <20100113194050.GA11688@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 13 21:47:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVA7y-00012N-7V
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jan 2010 21:47:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756260Ab0AMUri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2010 15:47:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755627Ab0AMUri
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jan 2010 15:47:38 -0500
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:39122 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755213Ab0AMUrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2010 15:47:37 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id BCB1B8BC1B;
	Wed, 13 Jan 2010 22:47:36 +0200 (EET)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0572791C88; Wed, 13 Jan 2010 22:47:36 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 8AB682BD5F;
	Wed, 13 Jan 2010 22:47:33 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20100113194050.GA11688@inner.home.ulmdo.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136884>

On Wed, Jan 13, 2010 at 08:40:50PM +0100, Andreas Krey wrote:
> On Wed, 13 Jan 2010 21:18:02 +0000, Ilari Liusvaara wrote:
> ...
> > That feature is grossly underdocumented (and also nonportable). Unix(7)
> > should document it, except that it doesn't for me (it documents that
> > SO_PASSCRED takes a boolean, except that what the server implementation
> > passes is something completely different).
> 
> Actually, I meant how you plan to map credentials (however obtained)
> into allowed actions inside git-daemon (or the hooks).

Its actually git-daemon2. And it doesn't authorize anything, only delegates
the authorization (e.g. to gitolite).
 
> ...
> > And how many (relative) use client ceritificates with SSL? Keypairs with SSH?
> > Why you think this is?
> 
> Because ssh is much more popular than ssl client auth. Obtaining client
> certificates isn't much more complicated than getting an ssh account,
> once you have scripts for the stuff ready.

SSL client certificate usability is horrible. SSH keypairs are actually
almost usable.

> But I wonder: When you want keypair auth, why not just use ssh?

IIRC, I already have told at least twice...

> I didn't quite understand the use case yet, it seems. With ssh
> I have all the infrastructure like ssh-agent in place already;
> with gits: (any kind of) it will be asked for sooner or later.

gpg-agent can be used (since client uses gpg to protect the keys
if needed).

-Ilari
