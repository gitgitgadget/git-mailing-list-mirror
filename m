From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/3] Teach builtin-clone to pack refs
Date: Sat, 22 Mar 2008 17:45:56 -0700
Message-ID: <7v8x0agtdn.fsf@gitster.siamese.dyndns.org>
References: <200803220210.30957.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Mar 23 01:46:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdEMK-0002T2-QO
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 01:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754559AbYCWAqI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 20:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752379AbYCWAqG
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 20:46:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62451 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbYCWAqE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 20:46:04 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7FD54104F;
	Sat, 22 Mar 2008 20:46:03 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 00319104C; Sat, 22 Mar 2008 20:45:59 -0400 (EDT)
In-Reply-To: <200803220210.30957.johan@herland.net> (Johan Herland's message
 of "Sat, 22 Mar 2008 02:10:30 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77860>

Johan Herland <johan@herland.net> writes:

> Although most of the speedup from current "next" is achieved by the
> builtin-clone work, there is still a considerable additional improvement
> from writing all refs to a single file instead of writing one file per
> ref. I expect the performance improvement to be much bigger on platforms
> with slower filesystem (aka. Windows).

At some point, additional speedups are hidden in the noise.

Not writing reflogs is a _different_ behaviour from the previous, but I
suspect it might even be an improvement.  When you have 1000 remote
branches, probably most of them are not even active.
