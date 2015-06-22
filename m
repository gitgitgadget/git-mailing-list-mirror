From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Add list-all-objects command
Date: Mon, 22 Jun 2015 22:48:19 +0100
Message-ID: <20150622214818.GA18677@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-2-git-send-email-charles@hashpling.org>
 <20150622083822.GB12259@peff.net>
 <20150622103321.GB12584@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:48:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z79Zw-0003mo-4u
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:48:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751843AbbFVVs0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:48:26 -0400
Received: from avasout05.plus.net ([84.93.230.250]:57033 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbbFVVsY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 17:48:24 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id jZoK1q0032iA9hg01ZoLTo; Mon, 22 Jun 2015 22:48:21 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=FZvKv8K6 c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=jyHyhOuc2Cr4eh1hMAcA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z79Zj-0004sa-9l; Mon, 22 Jun 2015 22:48:19 +0100
Content-Disposition: inline
In-Reply-To: <20150622103321.GB12584@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272423>

On Mon, Jun 22, 2015 at 06:33:21AM -0400, Jeff King wrote:
> On Mon, Jun 22, 2015 at 04:38:22AM -0400, Jeff King wrote:
> 
> > > +	prepare_packed_git();
> > > +	for (p = packed_git; p; p = p->next) {
> > > +		open_pack_index(p);
> > > +	}
> > 
> > Yikes. The fact that you need to do this means that
> > for_each_packed_object is buggy, IMHO. I'll send a patch.
> 
> Here's that patch. And since I did not want to pile work on Charles, I
> went ahead and just implemented the patches I suggested in the other
> email.

I have to say that I think that adding this functionality to cat-file
makes a lot of sense. If it only catted files it might be a stretch but
as it's already grown --batch-check functionality, it now seems a
reasonable extension. I'm not particularly attached to having a
standalone "list-all-objects" command per se.
