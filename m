From: Drew Northup <drew.northup@maine.edu>
Subject: Re: gc getting called on each git command ... what's wrong?
Date: Wed, 08 Jun 2011 12:02:10 -0400
Message-ID: <1307548930.19438.30.camel@drew-northup.unet.maine.edu>
References: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com>
	 <BANLkTiksHRmp102XDJP5+-CLGj8hZXUR=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: geoffrey.russell@gmail.com, git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Wed Jun 08 18:03:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QULDr-0002Qg-KI
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 18:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756664Ab1FHQDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 12:03:07 -0400
Received: from beryl.its.maine.edu ([130.111.32.94]:47697 "EHLO
	beryl.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756084Ab1FHQDE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 12:03:04 -0400
Received: from [IPv6:2610:48:100:827::97] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827::97])
	by beryl.its.maine.edu (8.13.8/8.13.8) with ESMTP id p58G2EQc017670
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 8 Jun 2011 12:02:14 -0400
In-Reply-To: <BANLkTiksHRmp102XDJP5+-CLGj8hZXUR=g@mail.gmail.com>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-UniversityOfMaineSystem-Metrics: beryl.its.maine.edu 1003; Body=3 Fuz1=3
	Fuz2=3
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p58G2EQc017670
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1308153739.77278@FAKB9VrtLQac3uC2FyFkhw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175390>


On Tue, 2011-06-07 at 21:48 -0400, Peter Harris wrote:
> On Tue, Jun 7, 2011 at 9:33 PM, Geoff Russell wrote:
> >
> > As of today, almost every time I do a git command, gc is getting
> > invoked.
<re-added>
> >   I have packSizeLimit set to 30M 
</re-added>
> >   There are 96 pack files.
> 
> That's why. See gc.autopacklimit in "git help config" -- by default,
> git will gc if there are more than 50 pack files.

Do we want to consider ignoring (or automatically doubling, or something
like that) gc.autopacklimit if that number of packs meet or exceed
gc.packSizeLimit? I have no idea what the patch for this might look
like, but it seems to make more sense than this situation.

Just a random brain fart...

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
