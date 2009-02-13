From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [JGIT PATCH 0/6] Add prune of stale tracking branches to fetch
Date: Thu, 12 Feb 2009 16:37:44 -0800
Message-ID: <7v7i3vi33b.fsf@gitster.siamese.dyndns.org>
References: <1234482880-1316-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 13 01:39:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXm5Q-0000Lk-Jn
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 01:39:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753746AbZBMAhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 19:37:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753113AbZBMAhx
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 19:37:53 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54809 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbZBMAhw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 19:37:52 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 25E4E2B000;
	Thu, 12 Feb 2009 19:37:50 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 636042B01B; Thu,
 12 Feb 2009 19:37:46 -0500 (EST)
In-Reply-To: <1234482880-1316-1-git-send-email-spearce@spearce.org> (Shawn O.
 Pearce's message of "Thu, 12 Feb 2009 15:54:34 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8AC8E99C-F966-11DD-9676-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109693>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> This series teaches "jgit fetch" how to prune stale tracking branches
> that have been removed from the remote repository.  We can now do
> both a fetch and a prune in a single network connection.

I am not sure if that is a good feature.

The user at the local side may well be using the (now stale) tracking
branch as an achoring point to remember where his own development forked
from, and that may be the reason he is fetching but not running "remote
prune", not to lose that anchor.
