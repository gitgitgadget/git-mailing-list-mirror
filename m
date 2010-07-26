From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: [PATCH] upload-pack: Remove some unused code
Date: Mon, 26 Jul 2010 14:29:44 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007261424490.30890@xanadu.home>
References: <1280002151-7527-1-git-send-email-newren@gmail.com>
 <7vr5iqaje0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org,
	Nick Edelen <sirnot@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 26 20:29:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdSQw-0004I0-UC
	for gcvg-git-2@lo.gmane.org; Mon, 26 Jul 2010 20:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753954Ab0GZS3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jul 2010 14:29:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:42434 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751973Ab0GZS3p (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jul 2010 14:29:45 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MO-MR006.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L66006F4GPK5YA0@VL-MO-MR006.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 26 Jul 2010 14:29:44 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vr5iqaje0.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151873>

On Sun, 25 Jul 2010, Junio C Hamano wrote:

> Elijah Newren <newren@gmail.com> writes:
> 
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> > I'm not sure if this is too trivial to submit, but I noticed it while
> > poking around in upload-pack.
> >
> > Ever since f0cea83f631689331fce73b51f22707e897f7939, the
> > 'create_full_pack' argument has been unused and is always false.  We
> > can make it clear that this argument is currently unused and remove some
> > associated code from an 'if' block.
> 
> While it is true that currently we memset(&rev_list) to always pass NULL
> there, I wonder if that was an unintended behaviour change introduced by
> the commit you mentioned...

I don't think so.  Especially since now do_rev_list() is only used for 
shallow clones/fetches, there can never be a full pack in that case.  
The create_full_pack logic remans present and local to 
create_pack_file().


Nicolas
