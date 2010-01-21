From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: problem cloning via http since v1.6.6-rc0
Date: Thu, 21 Jan 2010 12:35:01 +0200
Message-ID: <20100121103500.GA19285@Knoppix>
References: <20100121004756.GA18213@onerussian.com>
 <20100121050850.GA18896@Knoppix>
 <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yaroslav Halchenko <debian@onerussian.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 11:35:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXuNk-0001dD-4n
	for gcvg-git-2@lo.gmane.org; Thu, 21 Jan 2010 11:35:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754777Ab0AUKfM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Jan 2010 05:35:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754773Ab0AUKfM
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jan 2010 05:35:12 -0500
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:38760 "EHLO
	emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753769Ab0AUKfK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jan 2010 05:35:10 -0500
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh02-2.mail.saunalahti.fi (Postfix) with SMTP id A3926EF837;
	Thu, 21 Jan 2010 12:35:06 +0200 (EET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A0215E993AF; Thu, 21 Jan 2010 12:35:06 +0200
Received: from LK-Perkele-V (a88-113-39-59.elisa-laajakaista.fi [88.113.39.59])
	by emh06.mail.saunalahti.fi (Postfix) with ESMTP id E1932E51A5;
	Thu, 21 Jan 2010 12:35:01 +0200 (EET)
Content-Disposition: inline
In-Reply-To: <be6fef0d1001202247l7467a14ap8181eb3ed830167a@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137651>

On Thu, Jan 21, 2010 at 02:47:37PM +0800, Tay Ray Chuan wrote:
> Hi,
> 
> On Thu, Jan 21, 2010 at 1:08 PM, Ilari Liusvaara
> >
> > (i.e. webserver would ignore the query). This isn't true for git.debian.org.
> > Requesting the latter works (and the data formatting looks sane), but the
> > former is 404. This causes the fetch to fail.
> 
> afaik, putting a "?var1=val1&var2=...." still makes it a normal GET
> request, even if the url requested is just a plain file and not some
> cgi handler that uses those variables/values.

Yes, it is normal GET (POST would be something else). And wheither it is CGI
doesn't come into play for request since client decides wheither to send GET
or POST and wheither to include query or not.

Query is just technical name for part between ? and # (or end of HTTP URL),
and can be present in any type of request that accepts http:// URL.

As said, code expects query part to be ignored if target is regular file
but broke when it didn't get ignored.

-Ilari
