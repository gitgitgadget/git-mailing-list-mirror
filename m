From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Add list-all-objects command
Date: Mon, 22 Jun 2015 12:38:21 +0100
Message-ID: <20150622113821.GA31118@hashpling.org>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-2-git-send-email-charles@hashpling.org>
 <20150622083822.GB12259@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 22 13:38:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7040-0004GV-0j
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 13:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756313AbbFVLiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 07:38:46 -0400
Received: from avasout06.plus.net ([212.159.14.18]:45783 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756096AbbFVLiY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 07:38:24 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id jPeM1q0052iA9hg01PeNwm; Mon, 22 Jun 2015 12:38:23 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=foEhHwMf c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=J0QyKEt1u0cA:10 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10
 a=Ew9TdX-QAAAA:8 a=XAFQembCKUMA:10 a=aEPQRs_zItBb80r-d7IA:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.84)
	(envelope-from <charles@hashpling.plus.com>)
	id 1Z703R-00086b-FW; Mon, 22 Jun 2015 12:38:21 +0100
Content-Disposition: inline
In-Reply-To: <20150622083822.GB12259@peff.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272334>

On Mon, Jun 22, 2015 at 04:38:22AM -0400, Jeff King wrote:
> On Sun, Jun 21, 2015 at 08:20:31PM +0100, Charles Bailey wrote:
> 
> > +	prepare_packed_git();
> > +	for (p = packed_git; p; p = p->next) {
> > +		open_pack_index(p);
> > +	}
> 
> Yikes. The fact that you need to do this means that
> for_each_packed_object is buggy, IMHO. I'll send a patch.

I'm glad you said that; the interface did seem a bit warty at the time
but as I "fixed" this early in my hacking I didn't remeber to revisit
this and ask if it was actually intentional.
