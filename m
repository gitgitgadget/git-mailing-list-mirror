From: Nicolas Pitre <nico@cam.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Wed, 15 Apr 2009 07:51:22 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904150738340.6741@xanadu.home>
References: <alpine.LFD.2.00.0904070903020.6741@xanadu.home>
 <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet>
 <alpine.LFD.2.00.0904071454250.6741@xanadu.home>
 <20090407202725.GC4413@atjola.homenet>
 <alpine.LFD.2.00.0904080041240.6741@xanadu.home>
 <20090410T203405Z@curie.orbis-terrarum.net>
 <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
 <alpine.LFD.2.00.0904141542161.6741@xanadu.home>
 <20090414T202206Z@curie.orbis-terrarum.net>
 <fcaeb9bf0904142009w5a21e483v7e98f91e5e35b14a@mail.gmail.com>
 <7vljq2zckw.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	"Robin H. Johnson" <robbat2@gentoo.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 15 13:53:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lu3fr-0005W3-Vl
	for gcvg-git-2@gmane.org; Wed, 15 Apr 2009 13:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752874AbZDOLva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2009 07:51:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752682AbZDOLv3
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Apr 2009 07:51:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:21165 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbZDOLv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2009 07:51:28 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KI5007SX4XMCX10@VL-MO-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 15 Apr 2009 07:51:22 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vljq2zckw.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116606>

On Tue, 14 Apr 2009, Junio C Hamano wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> > How can you do that? If I understand git protocol correctly, there is
> > no difference between a fetch request and a clone one.
> 
> At the protocol level, you can tell a clone request by noticing that the
> downloading side does not have any "have" lines, but it is a different
> matter what the software does out of the box.
> 
> You can patch upload-pack to reject such requests.  I am sure gentoo folks
> are capable of doing that ;-)
> 
> Also a rogue client can send a bogus "have" to fool that logic, and that
> is the primary reason why we do not have such a patch to upload-pack.  It
> is not worth it as a protection against determined people who want to DoS.

Implementing a minimum treshold with merge-base to ensure that the 
client has at least commit X should be easy to do.  Unfortunately we 
don't have any hook for such a purpose yet.


Nicolas
