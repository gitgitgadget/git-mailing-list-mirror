From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: GSoC resumable clone
Date: Fri, 11 Mar 2011 22:50:41 +0200
Message-ID: <20110311205041.GA10210@LK-Perkele-VI.localdomain>
References: <AANLkTinrgqLhZK=fQ_+gUanT-zy9Mcbw-y3o7nYV9A-m@mail.gmail.com>
 <20110311153752.GA30329@sigill.intra.peff.net>
 <AANLkTi=D5kYh-w-6CKuCf39fnH1SYT5HxJ31tdq2vb9d@mail.gmail.com>
 <20110311154822.GA30605@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Alexander Miseler <alexander@miseler.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>, git <git@vger.kernel.org>,
	Pranav Ravichandran <prp.1111@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Mar 11 21:48:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py9G0-00041h-NH
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 21:48:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754114Ab1CKUsP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 15:48:15 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:59433 "EHLO
	emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753833Ab1CKUsO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 15:48:14 -0500
Received: from saunalahti-vams (vs3-12.mail.saunalahti.fi [62.142.5.96])
	by emh07-2.mail.saunalahti.fi (Postfix) with SMTP id DBADC18CFF2;
	Fri, 11 Mar 2011 22:48:12 +0200 (EET)
Received: from emh05.mail.saunalahti.fi ([62.142.5.111])
	by vs3-12.mail.saunalahti.fi ([62.142.5.96])
	with SMTP (gateway) id A0783CBFFF1; Fri, 11 Mar 2011 22:48:12 +0200
Received: from LK-Perkele-VI (a88-112-55-20.elisa-laajakaista.fi [88.112.55.20])
	by emh05.mail.saunalahti.fi (Postfix) with ESMTP id 4223027D85;
	Fri, 11 Mar 2011 22:48:01 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <20110311154822.GA30605@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168924>

On Fri, Mar 11, 2011 at 10:48:22AM -0500, Jeff King wrote:
> On Fri, Mar 11, 2011 at 07:41:14AM -0800, Shawn O. Pearce wrote:
> 
> > Fair enough. Though I wouldn't limit this to bundles. Instead I would
> > suggest supporting any valid Git URLs, and then extend our URL syntax
> > to support bundles over http://, rsync://, and torrent.
> 
> Sorry, I didn't mean to imply that it was limited to bundles. It would
> support arbitrary URLs or schemes. See this thread for some past
> discussion:

Security pitfall: You need a way to restrict URL schemes that can
be specified from the remote. Some URL schemes are wildly unsafe
to use that way (or just don't make sense).

The URL schemes where it is safe and makes sense are (at least):
- git://
- ssh:// (and the scp syntax)
- http://
- ftp://
- https://
- ftps://
- rsync://
- file:// (?)

New capabilities perhaps? This would allow allowing it on
per-remote-helper basis if that remote helper is deemed safe to
be able to receive arbitrary URLs from untrusted sources.

-Ilari
