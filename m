From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Restore ls-remote reference pattern matching
Date: Sun, 09 Dec 2007 10:15:45 -0800
Message-ID: <7vmysjpwdq.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712082134350.5349@iabervon.org>
	<7vodd0tuuu.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712082346310.5349@iabervon.org>
	<7v8x44tl7q.fsf@gitster.siamese.dyndns.org>
	<20071209162632.a16bfd6e.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
To: Sergey Vlasov <vsu@altlinux.ru>
X-From: git-owner@vger.kernel.org Sun Dec 09 19:16:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1QhV-0001Y0-Gk
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 19:16:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751307AbXLISP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 13:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbXLISP4
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 13:15:56 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:38117 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751285AbXLISP4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 13:15:56 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 87C165B9F;
	Sun,  9 Dec 2007 13:15:50 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E8D75B9E;
	Sun,  9 Dec 2007 13:15:47 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67641>

Sergey Vlasov <vsu@altlinux.ru> writes:

> This still does not match the behavior of the old shell implementation
> completely - because $pat was not quoted, shell pattern characters in
> $pat worked, and things like "git ls-remote . 'refs/heads/something--*'"
> were possible (and used in some of my scripts), so a full fnmatch()
> call is still needed.

Ah, true.  I wanted to cheat but that was a mistake.
