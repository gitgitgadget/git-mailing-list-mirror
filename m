From: David Kastrup <dak@gnu.org>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 13:18:37 +0100
Message-ID: <851w9tl90i.fsf@lola.goethe.zz>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	<9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	<7vlk82hrdt.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.99999.0712102225240.555@xanadu.home>
	<85bq8xlc8w.fsf@lola.goethe.zz>
	<20071211120851.GK30948@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <gitster@pobox.com>,
	Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pierre Habouzit <madcoder@artemis.madism.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 13:18:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J244G-0006oq-VC
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 13:18:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbXLKMSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 07:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752113AbXLKMSJ
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 07:18:09 -0500
Received: from fencepost.gnu.org ([140.186.70.10]:59420 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115AbXLKMSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 07:18:07 -0500
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1J243p-0007Iz-Gc; Tue, 11 Dec 2007 07:18:05 -0500
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 9980B1C4CE33; Tue, 11 Dec 2007 13:18:37 +0100 (CET)
In-Reply-To: <20071211120851.GK30948@artemis.madism.org> (Pierre Habouzit's
	message of "Tue, 11 Dec 2007 13:08:51 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67843>

Pierre Habouzit <madcoder@artemis.madism.org> writes:

> On Tue, Dec 11, 2007 at 11:08:47AM +0000, David Kastrup wrote:
>
>> Maybe address space fragmentation is involved here?  malloc/free for
>> large areas works using mmap in glibc.  There must be enough
>> _contiguous_ space for a new allocation to succeed.
>
>   Note that I find your explanation unlikely: glibc uses mmap for
> sizes over 128k by default (IIRC), and as soon as you use mmaps,
> that's the kernel that deals with the address space, and it's not
> necessarily contiguous, that's only true for the heap.

Every single allocation needs to be contiguous in virtual address space
and must not collide with existing virtual address space allocations.
So fragmentation is at least a logistical issue.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
