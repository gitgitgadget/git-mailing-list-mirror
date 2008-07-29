From: David Brown <git@davidb.org>
Subject: Re: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 18:41:20 -0700
Message-ID: <20080729014120.GA26807@old.davidb.org>
References: <20080725055547.GA3699@blimp.local> <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org> <20080728063128.GA4234@blimp.local> <20080728160446.GA16351@old.davidb.org> <alpine.LFD.1.10.0807280906530.3486@nehalem.linux-foundation.org> <7vbq0ho5g7.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.10.0807281817230.3486@nehalem.linux-foundation.org> <7v3alto4r7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 03:42:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNeEd-0000O3-DO
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 03:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216AbYG2Bln (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 21:41:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYG2Bln
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 21:41:43 -0400
Received: from mail.davidb.org ([66.93.32.219]:41194 "EHLO mail.davidb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751505AbYG2Blm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 21:41:42 -0400
Received: from davidb by mail.davidb.org with local (Exim 4.69 #1 (Debian))
	id 1KNeDI-0007EM-AP; Mon, 28 Jul 2008 18:41:20 -0700
Content-Disposition: inline
In-Reply-To: <7v3alto4r7.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90546>

On Mon, Jul 28, 2008 at 06:31:24PM -0700, Junio C Hamano wrote:
>Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> The kernel does caching really well, and the kernel is fast as hell, so 
>> _of_course_ when you benchmark, using kernel data structures looks good, 
>> especially if you benchmark against code that isn't well written for the 
>> particular usage case.
>
>Ok.  While I have your attention on st_ctime, let me ask you a stupid
>question.  Why does "rename(old, new)" change st_ctime when you move a
>regular file?

A simple answer might be that posix requires it.  But, from the point of
view of backup software, not updating the ctime on rename would be
horrible, because you'd never know when files got renamed.

David
