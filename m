From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Improved and extended t5404
Date: Wed, 14 Nov 2007 21:34:09 +0100
Message-ID: <20071114203409.GD3973@steel.home>
References: <20071112213823.GB2918@steel.home> <20071112213938.GC2918@steel.home> <20071113075240.GA21799@sigill.intra.peff.net> <20071113194731.GC3268@steel.home> <20071113194909.GD3268@steel.home> <20071113230234.GI3268@steel.home> <7vmythr8xf.fsf@gitster.siamese.dyndns.org> <20071114071929.GA2942@steel.home> <Pine.LNX.4.64.0711141709410.4362@racer.site> <20071114194522.GA3973@steel.home>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 21:35:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsOwl-0004PW-Gj
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 21:34:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760641AbXKNUeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 15:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761079AbXKNUeO
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 15:34:14 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:60829 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754740AbXKNUeN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 15:34:13 -0500
Received: from tigra.home (Fad5d.f.strato-dslnet.de [195.4.173.93])
	by post.webmailer.de (mrclete mo60) (RZmta 14.0)
	with ESMTP id x0276ejAEIVCqT ; Wed, 14 Nov 2007 21:34:11 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id E9E23277AE;
	Wed, 14 Nov 2007 21:34:09 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id C0F3456D22; Wed, 14 Nov 2007 21:34:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20071114194522.GA3973@steel.home>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CculzyCll4dQ==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65012>

Alex Riesen, Wed, Nov 14, 2007 20:45:22 +0100:
> Johannes Schindelin, Wed, Nov 14, 2007 18:10:25 +0100:
> > On Wed, 14 Nov 2007, Alex Riesen wrote:
> > > Junio C Hamano, Wed, Nov 14, 2007 01:02:20 +0100:
> > > > Alex Riesen <raa.lkml@gmail.com> writes:
> > > > 
> > > > > Ignore exit code of git push in t5404, as it is not relevant for the 
> > > > > test
> > > > 
> > > > This proposed log message solicits a "Huh? -- Since when ignoring exit 
> > > > code is an improvement?" reaction.  If this push is expected to error 
> > > > out, then wouldn't you want to make sure it errors out as expected?  
> > > > If the problem is that the exit status is unreliable, maybe we need to 
> > > > make it reliable instead?
> > > 
> > > Well, it is kind of undefined. git push just updated some remote 
> > > references and failed on the others. It has had some failures, so it 
> > > returns non-0. And as I said, it really is not about the operation, but 
> > > about if the tracking and remote branches are set as we want them.
> > 
> > If you know it should fail, why not make the test dependent on that 
> > failure?  I mean, should git-push have a bug and not fail, it would be 
> > nice to catch this early...
> > 
> 
> Well, I do not know it _should_ fail. Personally, I would not even
> care: I see no way to cover with just one exit code multiple
> failures. Some references were updated and I don't even know which.
> So I'd better check whatever exit code.

"I'd better check whatever was updated and damn the exit code"
