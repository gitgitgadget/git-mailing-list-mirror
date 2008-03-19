From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 03/16] more tr portability test script fixes
Date: Wed, 19 Mar 2008 23:56:17 +0100
Message-ID: <20080319225617.GA3139@steel.home>
References: <cover.1205356737.git.peff@peff.net> <20080312213106.GD26286@coredump.intra.peff.net> <20080318222302.GA3450@steel.home> <20080318224436.GA6806@coredump.intra.peff.net> <7v8x0e2xzq.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Whit Armstrong <armstrong.whit@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 23:58:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc7E9-0008FA-32
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 23:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941752AbYCSW4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 18:56:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S941748AbYCSW4V
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 18:56:21 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.190]:32454 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S941741AbYCSW4U (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 18:56:20 -0400
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3Cculz1E3jGqw==
Received: from tigra.home (Fae0f.f.strato-dslnet.de [195.4.174.15])
	by post.webmailer.de (mrclete mo51) (RZmta 16.14)
	with ESMTP id a0018bk2JGMwSB ; Wed, 19 Mar 2008 23:56:17 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5A44B277BD;
	Wed, 19 Mar 2008 23:56:17 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 4365156D28; Wed, 19 Mar 2008 23:56:17 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7v8x0e2xzq.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77584>

Junio C Hamano, Wed, Mar 19, 2008 22:40:57 +0100:
> Jeff King <peff@peff.net> writes:
> 
> > On Tue, Mar 18, 2008 at 11:23:02PM +0100, Alex Riesen wrote:
> >
> >> Jeff King, Wed, Mar 12, 2008 22:31:06 +0100:
> >> > -    tr '\000' '\012' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> >> > -    tr '\000' '\012' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> >> > +    perl -pe 'y/\000/\012/' <"$1" | sed -e "$sanitize_diff_raw_z" >.tmp-1
> >> > +    perl -pe 'y/\000/\012/' <"$2" | sed -e "$sanitize_diff_raw_z" >.tmp-2
> >> 
> >> These break in presence of ActiveState Perl on Windows.
> >> 
> >> I suggest replacing such simple construction with a simplified,
> >> in-tree, version of tr.
> >
> > <sigh> It's sad that it must come to that, but your test-tr patches seem
> > like the only sane choice. They seem to work fine on my Solaris box.
> 
> I am very tempted to say that it might make more sense to declare
> ActiveState unsupported.

I am not asking to really support it, it is too offending a thought.
I am just asking to consider the patch, which removes another
dependency on local system. Wasn't there issues with tr already?

> How many times have we suffered from it, and notice it was only from
> Alex every time, nobody else?

Well, I say that every time. I think by know everyone, who seen a
patch from me, noticed how very specially stupid my kind of setup is.

BTW, who suffered from what?

> Are there silent majorities involved here?

Yeah, the windows-people. They are used to silently workaround their
system.
