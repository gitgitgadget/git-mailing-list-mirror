From: Junio C Hamano <gitster@pobox.com>
Subject: Re: GIT-VERSION-GEN gives "-dirty" when file metadata changed
Date: Thu, 07 Aug 2008 14:48:06 -0700
Message-ID: <7vd4kkijjd.fsf@gitster.siamese.dyndns.org>
References: <sjj6zt28jy9qy7y8@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Gerrit Pape <pape@smarden.org>
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Thu Aug 07 23:49:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRDMI-0006ub-9w
	for gcvg-git-2@gmane.org; Thu, 07 Aug 2008 23:49:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963AbYHGVsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Aug 2008 17:48:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753013AbYHGVsT
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Aug 2008 17:48:19 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59506 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbYHGVsS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Aug 2008 17:48:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 053F04F74B;
	Thu,  7 Aug 2008 17:48:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 134494F749; Thu,  7 Aug 2008 17:48:13 -0400 (EDT)
In-Reply-To: <sjj6zt28jy9qy7y8@jaeger.mine.nu> (Christian Jaeger's message of
 "Thu, 07 Aug 2008 21:35:17 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8BA6BDAC-64CA-11DD-A09A-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91609>

Christian Jaeger <christian@jaeger.mine.nu> writes:

> Today I've created custom Debian packages from Git for the first time (yes I know there are Debian packages already, I'm doing it so that I can patch Git and still have the convenience of a package system),

I personally think that _you_ are responsible for doing the refresh
yourself after becoming root, if you checkout as yourself and then build
as root (or use fakeroot to build as if it is built as root).

By the way "man fakeroot" says...

       -u, --unknown-is-real
              Use the real ownership of files previously unknown  to  fakeroot
              instead of pretending they are owned by root:root.


which sounds like a sensible thing to do (I would even imagine that would
be a sensible default for fakeroot in general), and I would imagine that
would help.

Not that an extra update-index --refresh would be a huge performance hit,
but I hesitate to take a patch that adds something that should
conceptually be unnecessary.
