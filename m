From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Probably a GIT bug..
Date: Wed, 23 Apr 2008 13:10:42 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804231257300.19665@iabervon.org>
References: <20080422164311.67c3d02b@Vorago> <7v63u8tt62.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tomasz bla Fortuna <bla@thera.be>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:11:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoiVL-0000kN-HV
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 19:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752482AbYDWRKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 13:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbYDWRKt
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 13:10:49 -0400
Received: from iabervon.org ([66.92.72.58]:33029 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752402AbYDWRKs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 13:10:48 -0400
Received: (qmail 6343 invoked by uid 1000); 23 Apr 2008 17:10:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Apr 2008 17:10:42 -0000
In-Reply-To: <7v63u8tt62.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80232>

On Wed, 23 Apr 2008, Junio C Hamano wrote:

> Tomasz bla Fortuna <bla@thera.be> writes:
> 
> > I guess that GIT should check if he can create a tree link before
> > creating a commit.
> 
> Thanks.
> 
> That's a somewhat contrived example, and I do not know how you found it.
> 
> I suspect the same breakage would trigger when you ran out of disk quota
> to write out the tree while you still have barely enough quota to create
> the commit and update the ref, which would result in corrupt repository.
> So in that sense, this breakage is more likely to bite people in reality
> than the initial reaction your test may invite which is "don't do that
> then".

make
su
make install
git commit

and then log out from your desktop environment, and you've got objects 
subdirectories owned by root without realizing. Of course, you shouldn't 
do that, either, but it's an easier mistake than accidentally removing 
your own write permission to something.

	-Daniel
*This .sig left intentionally blank*
