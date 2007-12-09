From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Remove .git/branches from the .git template.
Date: Sun, 09 Dec 2007 10:30:55 -0800
Message-ID: <7v3aubpvog.fsf@gitster.siamese.dyndns.org>
References: <20071209183856.GA5587@bitplanet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@bitplanet.net>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:31:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1QwE-0007Kk-TQ
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbXLISbS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Dec 2007 13:31:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751137AbXLISbS
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:31:18 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbXLISbR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Dec 2007 13:31:17 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 130CF5FFF;
	Sun,  9 Dec 2007 13:31:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 98D9E5FFD;
	Sun,  9 Dec 2007 13:31:07 -0500 (EST)
In-Reply-To: <20071209183856.GA5587@bitplanet.net> (Kristian =?utf-8?Q?H?=
 =?utf-8?Q?=C3=B8gsberg's?=
	message of "Sun, 9 Dec 2007 13:38:56 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67648>

Kristian H=C3=B8gsberg <krh@bitplanet.net> writes:

> The code in git to read the info in .git/branches is still there,
> but nothing ever writes to this, so lets stop creating it.
>
> Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
> ---
>
> As far as I can see this should be safe, but I admit to never really
> knowing what .git/branches was originally used for - tracking remote
> branches or something?  In any case, we only ever read from this dir
> so the only left in git to deal with this seems to be for compatibilt=
y
> with older repos.

This was done purely so that Cogito would not barf on a repository
initialized with "git init" even if it did not bother creating necessar=
y
leading directories when it writes its rough equivalent to .git/remotes=
/
information.  I do not recall if Cogito had such a problem anymore, but
I think it can safely go when Cogito is effectively dead.
