From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 8/8] push: teach push to be quiet if local ref is strict subset of remote ref
Date: Sun, 28 Oct 2007 00:28:45 -0700
Message-ID: <7vfxzvwvde.fsf@gitster.siamese.dyndns.org>
References: <119350380778-git-send-email-prohaska@zib.de>
	<11935038081211-git-send-email-prohaska@zib.de>
	<11935038081650-git-send-email-prohaska@zib.de>
	<1193503808519-git-send-email-prohaska@zib.de>
	<11935038083369-git-send-email-prohaska@zib.de>
	<11935038084055-git-send-email-prohaska@zib.de>
	<11935038084130-git-send-email-prohaska@zib.de>
	<11935038083116-git-send-email-prohaska@zib.de>
	<11935038083335-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Oct 28 08:29:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Im2aA-0006YK-Vq
	for gcvg-git-2@gmane.org; Sun, 28 Oct 2007 08:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751030AbXJ1H2y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2007 03:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751031AbXJ1H2y
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Oct 2007 03:28:54 -0400
Received: from rune.pobox.com ([208.210.124.79]:46217 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbXJ1H2x (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2007 03:28:53 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 2347F14F200;
	Sun, 28 Oct 2007 03:29:15 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 45D95151703;
	Sun, 28 Oct 2007 03:29:09 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62532>

Steffen Prohaska <prohaska@zib.de> writes:

> git push reports errors if a remote ref is not a strict subset
> of a local ref. The push wouldn't be a fast-forward and is
> therefore refused. This is in general a good idea.

> This commit teaches git push to be quiet if the local is a strict
> subset of the remote and no refspec is explicitly specified on
> the command line. If the --verbose flag is used a "note:" is
> printed for each ignored branch.

What happens to the summary reporting after such a push?  Does
it say "branch foo was not pushed because you did not touch it
since you fetched and it is already stale with respect to the
remote side which has updates since then"?

How does this interact with the "pretend we have fetched
immediately after we pushed by updating the corresponding remote
tracking branch" logic?
