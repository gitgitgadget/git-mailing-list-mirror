From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Skip unwritable tests for root
Date: Mon, 30 Jun 2008 02:08:18 -0700
Message-ID: <7vabh31e9p.fsf@gitster.siamese.dyndns.org>
References: <1214809551-14603-1-git-send-email-ferdy@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Fernando J. Pereda" <ferdy@ferdyx.org>
X-From: git-owner@vger.kernel.org Mon Jun 30 11:09:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDFOF-00007o-OG
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 11:09:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754145AbYF3JIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jun 2008 05:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753502AbYF3JIf
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 05:08:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40028 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754082AbYF3JIe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 05:08:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0DD01667D;
	Mon, 30 Jun 2008 05:08:31 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 826FD667C; Mon, 30 Jun 2008 05:08:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1C00DF0A-4684-11DD-A138-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86893>

"Fernando J. Pereda" <ferdy@ferdyx.org> writes:

> Signed-off-by: Fernando J. Pereda <ferdy@ferdyx.org>

Hmm.  Actually we've deliberately ignored this so far.  If we were to do
anything, don't we rather want to fail everything upfront when the tests
are run by root?

Running "make" and "make test" before "make install" is so that you have
less chance hurting your running system, and I find it simply crazy to
build (i.e. "make all") as root, let alone running tests.
