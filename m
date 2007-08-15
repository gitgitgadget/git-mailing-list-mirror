From: Junio C Hamano <gitster@pobox.com>
Subject: git clone regression
Date: Wed, 15 Aug 2007 05:28:26 -0700
Message-ID: <7v643hrnh1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 15 14:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILHzS-0007k9-Jg
	for gcvg-git@gmane.org; Wed, 15 Aug 2007 14:28:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697AbXHOM2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 08:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751005AbXHOM2b
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 08:28:31 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:36519 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752168AbXHOM2b (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 08:28:31 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 96A88121B2C;
	Wed, 15 Aug 2007 08:28:50 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55896>

It appears that with 1.5.3-rc5

	$ git clone --bare $origin_url target.git

does not set "core.bare = true" in target.git/config.  We used
to, at least with 1.5.2.2.  I am strongly suspecting that this
is another fallout from the worktree series.
