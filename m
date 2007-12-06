From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG/PATCH] git grep shows the same hit repeatedly for unmerged paths
Date: Thu, 06 Dec 2007 00:59:43 -0800
Message-ID: <7vtzmwfbb4.fsf@gitster.siamese.dyndns.org>
References: <7vsl2gk7e3.fsf@gitster.siamese.dyndns.org>
	<4757A4DD.901@viscovery.net>
	<7v3auggs8x.fsf@gitster.siamese.dyndns.org>
	<4757B1B9.2050606@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Dec 06 10:00:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J0Cad-0005vc-E2
	for gcvg-git-2@gmane.org; Thu, 06 Dec 2007 10:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753125AbXLFI7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Dec 2007 03:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752925AbXLFI7v
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Dec 2007 03:59:51 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:40898 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226AbXLFI7u (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Dec 2007 03:59:50 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id AEC272EF;
	Thu,  6 Dec 2007 04:00:11 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4DCA19C714;
	Thu,  6 Dec 2007 04:00:09 -0500 (EST)
In-Reply-To: <4757B1B9.2050606@viscovery.net> (Johannes Sixt's message of
	"Thu, 06 Dec 2007 09:24:25 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67271>

Johannes Sixt <j.sixt@viscovery.net> writes:

> No, it doesn't. Neither before nor after this change. (I actually thought it
>  would without this change, but I obviously was wrong.)

Sorry, my mistake.  "git grep" traditionally skips unmerged paths.

It might make sense to grep in stage #2 if a path is unmerged, just like
we use stage #2 in diff-files.
