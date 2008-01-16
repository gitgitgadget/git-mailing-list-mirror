From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] close_lock_file(): new function in the lockfile API
Date: Wed, 16 Jan 2008 14:55:41 -0800
Message-ID: <7vy7apmlci.fsf@gitster.siamese.dyndns.org>
References: <7vmyr6bluy.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.44.0801152006260.944-100000@demand>
	<7vejchr3pf.fsf_-_@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801161207220.2806@woody.linux-foundation.org>
	<7vodblo6c9.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0801161443340.31161@torch.nrlssc.navy.mil>
	<7v7ii9o2ld.fsf@gitster.siamese.dyndns.org>
	<478E893F.4070100@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Wed Jan 16 23:56:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHBg-0005Qb-GU
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 23:56:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752980AbYAPWz4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 17:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbYAPWz4
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 17:55:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:40699 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbYAPWzy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 17:55:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C9BD549CD;
	Wed, 16 Jan 2008 17:55:53 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B17D49C8;
	Wed, 16 Jan 2008 17:55:48 -0500 (EST)
In-Reply-To: <478E893F.4070100@nrlssc.navy.mil> (Brandon Casey's message of
	"Wed, 16 Jan 2008 16:46:23 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70761>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Mainly, I prefer to not modify the data structures when a failure occurs.

Ok.  Is the rest of your patch that fixes callers Ok with that
semantics?  If so, I'd agree that is probably cleaner.  I'll
scrap the one we are discussing, resurrecting only the api
documentation part, and replace it with the lockfile.c changes
from your patch, along with the fixes to callers.
 
