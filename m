From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Tue, 06 Apr 2010 17:09:04 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004061705390.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
 <4BBB53F5.9010106@op5.se>
 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
 <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Shawn Pearce <spearce@spearce.org>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Vitaly Berov <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 23:09:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzG1H-0001CC-Hk
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 23:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756475Ab0DFVJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Apr 2010 17:09:07 -0400
Received: from relais.videotron.ca ([24.201.245.36]:50560 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755361Ab0DFVJF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Apr 2010 17:09:05 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L0H003XU434YF80@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 06 Apr 2010 17:09:04 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144170>

On Tue, 6 Apr 2010, Vitaly Berov wrote:

> Why does git compute checksums on the client side? Isn't it already
> calculated on the "server" side?

Yes.  But Git clients can't trust the server like that.

The only way to make sure the server didn't send you crap data, or worse 
maliciously altered data, is actually to not transfer any checksum data 
but to recompute and validate the received payload locally.

This being said, you should never have to wait 6 hours for that phase to 
complete.  It is typically a matter of minutes if not seconds.


Nicolas
