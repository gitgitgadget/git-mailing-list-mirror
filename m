From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: git clone: very long "resolving deltas" phase
Date: Wed, 07 Apr 2010 10:20:41 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004071009180.7232@xanadu.home>
References: <loom.20100406T161552-321@post.gmane.org>
 <vpqljd062xb.fsf@bauges.imag.fr> <4BBB5346.6070607@gmail.com>
 <4BBB53F5.9010106@op5.se>
 <q2mec874dac1004060850r5eaa41fak2ba9889d07794651@mail.gmail.com>
 <v2qecffb261004060856qcb769a06vf40ad2a75a3aa4fd@mail.gmail.com>
 <alpine.LFD.2.00.1004061705390.7232@xanadu.home> <4BBC1E15.9040403@gmail.com>
 <20100407080049.GA14041@LK-Perkele-V2.elisa-laajakaista.fi>
 <4BBC3EEC.6010702@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>,
	Andreas Ericsson <ae@op5.se>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Vitaly <vitaly.berov@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 07 16:20:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NzW7c-0004Uk-Nx
	for gcvg-git-2@lo.gmane.org; Wed, 07 Apr 2010 16:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932577Ab0DGOUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Apr 2010 10:20:43 -0400
Received: from relais.videotron.ca ([24.201.245.36]:65133 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932283Ab0DGOUn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Apr 2010 10:20:43 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR003.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L0I000CWFUHP2J0@VL-MH-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 07 Apr 2010 10:20:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <4BBC3EEC.6010702@gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144220>

On Wed, 7 Apr 2010, Vitaly wrote:

> Too bad..
> Yes, we really have a very large repo with binary files.
> 
> So, as far as I understand, the fastest way is to use rsync or smth like this
> instead of "git clone".

You should still be able to use 'git clone' with a rsync:// style URL.

> P.S. Btw, how can I ask for a feature of incorporating hashes into transport
> stream in trusted environments?

As I'm trying to make you understand repeatedly now, this shouldn't be 
needed.  A real fix for the bad behavior would be in order before 
papering over it.

If the large binary blobs are the source of the clone problem, then they 
will cause the same problems with other commands such as 'git diff' or 
even 'git checkout' later on.  So that "feature" you're asking for is 
misguided.

What you might try on your client machines is this:

	git config --global core.deltaBaseCacheLimit 256m

before doing a clone.


Nicolas
