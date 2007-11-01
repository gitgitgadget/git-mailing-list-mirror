From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/3] gitweb: Simplify some gitweb URLs generation
Date: Thu, 01 Nov 2007 15:47:57 -0700
Message-ID: <7v1wb98twi.fsf@gitster.siamese.dyndns.org>
References: <1193918789-16421-1-git-send-email-jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 01 23:48:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iniq6-0005ic-TK
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 23:48:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756035AbXKAWsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 18:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755401AbXKAWsI
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 18:48:08 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:59684 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755153AbXKAWsH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 18:48:07 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E776C2F0;
	Thu,  1 Nov 2007 18:48:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 82F95912DF;
	Thu,  1 Nov 2007 18:48:25 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63030>

Jakub Narebski <jnareb@gmail.com> writes:

> This series of patches simplifies some gitweb URLs generation by
> providing -replay option to href() subroutine, and then using this
> feature in gitweb code.
>
> Shortlog:
>  gitweb: Easier adding/changing parameters to current URL
>  gitweb: Use href(-replay=>1, page=>...) to generate pagination links
>  gitweb: Use href(-replay=>1, action=>...) to generate alternate views
>
> Diffstat:
>  gitweb/gitweb.perl |   82 ++++++++++++++++++++++-----------------------------
>  1 files changed, 35 insertions(+), 47 deletions(-)

If this "-replay" is used carelessly, it could add parameters
that were passed to the page that the original code stripped
away from passing on purpose.  Have you checked if the
conversion done with 2/3 and 3/3 are correct (I haven't)?
