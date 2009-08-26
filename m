From: Johan Herland <johan@herland.net>
Subject: Re: [RFC] Use a 16-tree instead of a 256-tree for storing notes
Date: Wed, 26 Aug 2009 16:43:44 +0200
Message-ID: <200908261643.45097.johan@herland.net>
References: <1248834326-31488-1-git-send-email-johan@herland.net> <81b0412b0908260624v30d32cc1m96e798076b51cbc9@mail.gmail.com> <4A95383A.4080104@op5.se>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, gitster@pobox.com, trast@student.ethz.ch,
	tavestbo@trolltech.com, git@drmicha.warpmail.net,
	chriscool@tuxfamily.org, spearce@spearce.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Wed Aug 26 16:45:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgJky-0006MW-E5
	for gcvg-git-2@lo.gmane.org; Wed, 26 Aug 2009 16:45:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750886AbZHZOpn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2009 10:45:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbZHZOpm
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Aug 2009 10:45:42 -0400
Received: from sam.opera.com ([213.236.208.81]:37903 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750862AbZHZOpm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2009 10:45:42 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n7QEhjW3015806
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 26 Aug 2009 14:43:50 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <4A95383A.4080104@op5.se>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127100>

On Wednesday 26 August 2009, Andreas Ericsson wrote:
> Alex Riesen wrote:
> > On Wed, Aug 26, 2009 at 14:56, Johan Herland<johan@herland.net> 
wrote:
> >> On Wednesday 26 August 2009, Alex Riesen wrote:
> >>> On Wed, Aug 26, 2009 at 12:31, Johan Herland<johan@herland.net> 
wrote:
> >>>> The 256-tree structure is considerably faster than storing all
> >>>> entries in a
> >>>
> >>> This part is confusing. Was 256-tree better (as in "faster")
> >>> then?
> >>
> >> 256-tree is faster than the everything-in-hash_map draft.
> >> 16-tree is slightly faster than 256-tree
> >>
> >> 256-tree uses more memory (in the worst case) that the
> >> everything-in-hash-map draft.
> >> 16-tree uses less memory than both.
> >>
> >> Makes sense?
> >
> > Oh, it does, it is just confusingly presented. How about:
> >
> > The 16-tree is both faster and has lower footprint then 256-tree
> > code, which in its turn is noticably faster and smaller then
> > existing hash_map implementation. ...
>
> If it's to be squashed in, why mention the 256-tree at all (except
> for possibly as something to compare with at the end)?
> If it goes on top, why mention the hash_map at all?

Ah. Sorry for the confusion. These patches are not meant to standalone 
patches in the jh/notes series. They just compare various solutions to 
the problem of parsing a notes tree structure with fanout in an 
efficient manner.

The next iteration of the jh/notes series will include the preferred 
solution (16-tree unless something better shows up), _without_ talking 
about the differences between alternative solutions. As such the 
hash_map and 256-tree will not be mentioned at all.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
