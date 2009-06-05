From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Using different protocols for "pull" and "push".
Date: Thu, 04 Jun 2009 17:52:13 -0700
Message-ID: <7v1vpztsci.fsf@alter.siamese.dyndns.org>
References: <h09kk8$rb4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nikos Chantziaras <realnc@arcor.de>
X-From: git-owner@vger.kernel.org Fri Jun 05 02:52:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCNfS-0008Nw-LN
	for gcvg-git-2@gmane.org; Fri, 05 Jun 2009 02:52:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbZFEAwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jun 2009 20:52:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbZFEAwN
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 20:52:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:61381 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752105AbZFEAwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jun 2009 20:52:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090605005213.GCQQ25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jun 2009 20:52:13 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 00sD1c00F4aMwMQ040sDMW; Thu, 04 Jun 2009 20:52:13 -0400
X-VR-Score: -70.00
X-Authority-Analysis: v=1.0 c=1 a=QvJGQE7t5xcA:10 a=83sOxDfOUXEA:10
 a=w7ExwxCKnfa07g3PMV8A:9 a=skCOmnKnfsD0hcYRb_X0FhiyQkYA:4 a=Xyk-jM_fJCMA:10
X-CM-Score: 0.00
In-Reply-To: <h09kk8$rb4$1@ger.gmane.org> (Nikos Chantziaras's message of "Fri\, 05 Jun 2009 02\:16\:44 +0300")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120732>

Nikos Chantziaras <realnc@arcor.de> writes:

> I wonder if it's possible to setup Git (probably in .git/config) to
> use SSH only for "git push" and use the git protocol for "git pull".

The configuration format does not allow it, unfortunately.  We should be
able to introduce remote.$name.pushurl that is used only for push if
present (and fall back to remote.$name.url if there isn't) reasonably
easily, though.
