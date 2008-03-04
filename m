From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix git init --shared=all on FreeBSD 4.11
Date: Tue, 04 Mar 2008 00:08:24 -0800
Message-ID: <7vir02ap3b.fsf@gitster.siamese.dyndns.org>
References: <20080303234406.GA28158@steel.home>
 <7v1w6rfhyn.fsf@gitster.siamese.dyndns.org>
 <20080304072519.GA3070@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 09:09:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWSDO-0000nQ-6E
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 09:09:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756285AbYCDIIz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 03:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755971AbYCDIIz
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 03:08:55 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754560AbYCDIIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2008 03:08:54 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id EC2923722;
	Tue,  4 Mar 2008 03:08:52 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 548393721; Tue,  4 Mar 2008 03:08:47 -0500 (EST)
In-Reply-To: <20080304072519.GA3070@steel.home> (Alex Riesen's message of
 "Tue, 4 Mar 2008 08:25:19 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76045>

Alex Riesen <raa.lkml@gmail.com> writes:

> It is a directory. The bit 02000 is S_ISGID on FreeBSD too. It just
> does not work (now I am just observing, no coding).

IIRC, g+s on directory to make group ownership inherited was a SysVism;
BSD did not need that as it did the sane thing by default without g+s.

Perhaps we should make it conditional.

