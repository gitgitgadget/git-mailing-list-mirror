From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH maint] builtin-merge.c: fix memory under-allocation
Date: Thu, 09 Oct 2008 04:12:52 -0700
Message-ID: <7vmyheowcr.fsf@gitster.siamese.dyndns.org>
References: <ZuhLzndR5Uvj7-_NyasP-FHF3AqTyLx-0sjNHMd0BC3LXC8LdLqBeQ@cipher.nrlssc.navy.mil> <20081009001727.GP536@genesis.frugalware.org> <0LPLRUZaEHuEZTri_v38ySJHqYAhrfOpOkyUviUH9eOrx8IXBEAzYA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Thu Oct 09 13:14:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KntTG-0007Sp-SI
	for gcvg-git-2@gmane.org; Thu, 09 Oct 2008 13:14:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756323AbYJILNG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2008 07:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756401AbYJILNF
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Oct 2008 07:13:05 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46511 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756323AbYJILNF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2008 07:13:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 78CFF88B81;
	Thu,  9 Oct 2008 07:13:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7AE0288B80; Thu,  9 Oct 2008 07:12:54 -0400 (EDT)
In-Reply-To: <0LPLRUZaEHuEZTri_v38ySJHqYAhrfOpOkyUviUH9eOrx8IXBEAzYA@cipher.nrlssc.navy.mil> (Brandon Casey's message of "Wed, 08 Oct 2008 19:27:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3DA56A0E-95F3-11DD-8C28-FA2D76724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97841>

Brandon Casey <casey@nrlssc.navy.mil> writes:

> Miklos Vajna wrote:
>> On Wed, Oct 08, 2008 at 07:07:54PM -0500, Brandon Casey <casey@nrlssc.navy.mil> wrote:
>>> While we're at it, change the allocation to reference the variable it is
>>> allocating memory for to try to prevent a similar mistake if the type is
>>> changed in the future.
>> 
>> If this is really a problem, then I think it would be good to mention
>> this in Documentation/CodingGuidelines.
>
> That's fine. Though I didn't mean to imply that the memory under-allocation
> was caused by a change in variable type in this case. Re-reading my commit
> message, maybe it sounds like that.

Yeah, it does.  I was scratching my head and had to read the patch three
times until I got it (yes, I am especially slower than usual today, as the
reason I am reading mails right now is because I am jetlagged and cannot
sleep).
