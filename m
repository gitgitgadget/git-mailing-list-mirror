From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] "needs update" considered harmful
Date: Sun, 20 Jul 2008 00:48:31 -0700
Message-ID: <7v1w1pdmi8.fsf@gitster.siamese.dyndns.org>
References: <7vtzelf4mf.fsf@gitster.siamese.dyndns.org>
 <7vk5fhf35p.fsf@gitster.siamese.dyndns.org>
 <7v3am5f20f.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 09:49:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKTg3-0004q4-JC
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 09:49:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbYGTHsh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 03:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753052AbYGTHsg
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 03:48:36 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:48170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbYGTHsg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 03:48:36 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id D3A232E78E;
	Sun, 20 Jul 2008 03:48:35 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 671F52E78D; Sun, 20 Jul 2008 03:48:34 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 421C4740-5630-11DD-B7E0-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89170>

The previous two variants both aim to reword the somewhat unpopular "needs
update" message to easier "locally modified".

"Politically correct" thing to do would be to keep the output from the
update-index (plumbing) intact and update only output from "reset" and
"add --refresh -v" which are Porcelain.  This has smaller chance of
breaking people's existing scripts, but some people may find the two
messages that say the same thing inconsistent.

Rewording to "locally modified" even at the plumbing level is a simpler
patch, keeps the API to refresh_index() intact, and probably is a better
approach in the longer term, especially if we can ignore people's existing
scripts.
