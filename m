From: Junio C Hamano <junkio@cox.net>
Subject: Re: How should I handle binary file with GIT
Date: Wed, 05 Apr 2006 13:20:34 -0700
Message-ID: <7vy7yjzsdp.fsf@assigned-by-dhcp.cox.net>
References: <20060405073022.13054.qmail@web25806.mail.ukl.yahoo.com>
	<7v3bgs4exz.fsf@assigned-by-dhcp.cox.net> <e10mn9$cjs$1@sea.gmane.org>
	<Pine.LNX.4.64.0604051131010.2550@localhost.localdomain>
	<86wte4rq3d.fsf@blue.stonehenge.com>
	<7vslor27n4.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604051521480.2550@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 05 22:20:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FREUj-00041I-B1
	for gcvg-git@gmane.org; Wed, 05 Apr 2006 22:20:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWDEUUh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Apr 2006 16:20:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbWDEUUh
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Apr 2006 16:20:37 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:51900 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751168AbWDEUUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Apr 2006 16:20:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060405202035.QVEI20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 5 Apr 2006 16:20:35 -0400
To: Nicolas Pitre <nico@cam.org>
In-Reply-To: <Pine.LNX.4.64.0604051521480.2550@localhost.localdomain> (Nicolas
	Pitre's message of "Wed, 05 Apr 2006 15:31:05 -0400 (EDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18452>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 5 Apr 2006, Junio C Hamano wrote:
>
>> We've been trying to keep our diff output reversible (e.g. we
>> show what the filemode of the preimage is), so if we take the
>> above route, it probably should record deltas for both going
>> from preimage to postimage _and_ going the other way (unless
>> xdelta can be applied in-reverse, which I do not think is the
>> case).
>
> You cannot reverse a delta.  However if you were able to apply a delta 
> from preimage to postimage that means you must already have had preimage 
> in your object store.  Therefore reverting such a patch would simply 
> involve restoring preimage.

The case I had in mind was where you shipped a tarball of the
tip to somebody (or "a shallow clone"), and after seeing him
having problems with that release, sending him a patch telling
him "reverting this might help, could you please give it a try?"

Of course you could be nicer to him and generate the reverse
diff on your end in such a case instead.
