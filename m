From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Adjust for the new way of enabling the default
 post-update hook
Date: Mon, 11 Aug 2008 15:57:36 -0700
Message-ID: <7vfxpbuplr.fsf@gitster.siamese.dyndns.org>
References: <20080811223446.8342.37008.stgit@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Aug 12 00:59:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSgLt-0002nY-Ma
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 00:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbYHKW5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Aug 2008 18:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753415AbYHKW5o
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Aug 2008 18:57:44 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59928 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753218AbYHKW5o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Aug 2008 18:57:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 1683E555C0;
	Mon, 11 Aug 2008 18:57:43 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3B2C4555BF; Mon, 11 Aug 2008 18:57:39 -0400 (EDT)
In-Reply-To: <20080811223446.8342.37008.stgit@localhost> (Petr Baudis's
 message of "Tue, 12 Aug 2008 00:34:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E7E0D23E-67F8-11DD-BF86-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92017>

Petr Baudis <pasky@suse.cz> writes:

> The post-update hook, which is required to be enabled in order for
> the repository to be accessible over HTTP, is not enabled by
> chmod a+x anymore, but instead by dropping the .sample suffix.

Thanks for attention to the details.

> This patch emphasizes this change in the release notes (since
> I believe this is rather noticeable backwards-incompatible change).

Anybody who tries to chmod an nonexisting file would notice, so I
personally think you are making a mountain out of a molehill.

Nevertheless, mentioning it in the release notes would be a good finishing
touch.

> +The standard way of making repositories friendly to dumb protocols
> +(i.e. HTTP) changed: instead of making hooks/post-update executable,
> +hooks/post-update.sample is to be moved to hooks/post-update.

I'm actually not very happy with the above wording that makes it sound as
if any of the samples are part of any "standard way".

The only standard thing is to make sure update-server-info runs.  You do
not have to start from the sample hook to do so, even though it may be one
of the easiest ways.

The rest of the patches look good, but have you actually made sure
AsciiDoc markups are correct (I am not complaining, just asking, as I
haven't)?
