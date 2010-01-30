From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: [PATCH v6] add --summary option to git-push and git-fetch
Date: Sat, 30 Jan 2010 10:57:50 +0200
Message-ID: <20100130085750.GA27906@Knoppix>
References: <20100130020548.GA29343@cthulhu>
 <7vsk9oysds.fsf@alter.siamese.dyndns.org>
 <20100130075129.GA27702@Knoppix>
 <7vd40sxbli.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Larry D'Anna <larry@elder-gods.org>, git@vger.kernel.org,
	Daniel Barkalow <barkalow@iabervon.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 09:58:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb99a-0000iF-Ma
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 09:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab0A3I57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2010 03:57:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752711Ab0A3I57
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jan 2010 03:57:59 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:44661 "EHLO
	emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752620Ab0A3I57 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2010 03:57:59 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh06-2.mail.saunalahti.fi (Postfix) with SMTP id 3B26DC81EE;
	Sat, 30 Jan 2010 10:57:58 +0200 (EET)
Received: from emh01.mail.saunalahti.fi ([62.142.5.107])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0716437C9D; Sat, 30 Jan 2010 10:57:58 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh01.mail.saunalahti.fi (Postfix) with ESMTP id 675B74075;
	Sat, 30 Jan 2010 10:57:51 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <7vd40sxbli.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138467>

On Sat, Jan 30, 2010 at 12:04:25AM -0800, Junio C Hamano wrote:
> Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:
> 
> > Also, what about multiple-URL case? Don't know if there are problems, but it
> > seems to be quite rarely tested...
> 
> Pushing to more than one deliberately chooses to fork for each remote IIRC
> to avoid any funnies.

I don't see any forking in the code. It redoes transport_get() (transports
can't really be reused...) and in the end does transport_disconnect().

And besides, what it did with internal protocol following remote helper
didn't look very much like what would happen if it forked...

-Ilari
