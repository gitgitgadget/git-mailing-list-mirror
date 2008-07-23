From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] sort_in_topological_order(): avoid setting a commit
 flag
Date: Tue, 22 Jul 2008 18:01:30 -0700
Message-ID: <7v7ibdifbp.fsf@gitster.siamese.dyndns.org>
References: <alpine.DEB.1.00.0807230148130.8986@racer>
 <alpine.DEB.1.00.0807230150480.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pasky@suse.cz, git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 03:03:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLSku-0000OO-5X
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 03:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbYGWBBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 21:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbYGWBBi
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 21:01:38 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54459 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbYGWBBi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 21:01:38 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D04BD2A36D;
	Tue, 22 Jul 2008 21:01:36 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 205AA2A36B; Tue, 22 Jul 2008 21:01:31 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807230150480.8986@racer> (Johannes
 Schindelin's message of "Wed, 23 Jul 2008 01:51:36 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: E67B8980-5852-11DD-AC39-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89584>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This is the same behavior as before, since indegree could not be
> non-zero when TOPOSORT was unset.
>
> Incidentally, this fixes the bug in show-branch where the 8th column
> was not shown: show-branch sorts the commits in topological order,
> assuming that all the commit flags are available for show-branch's
> private matters.

Do people still actively use show-branch as a G/CUI, especially after that
"log --graph" thing was introduced?

If that is the case, it might also make sense to stop using the object
flags but allocate necessary number of bits (not restricted to 25 or so)
pointed at by commit->util field to remove its limitation.

Hint, hint...
