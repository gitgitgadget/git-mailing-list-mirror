From: Junio C Hamano <gitster@pobox.com>
Subject: Re: auto commit merge using the default merge message
Date: Thu, 23 Apr 2009 01:32:20 -0700
Message-ID: <7vocunwz1n.fsf@gitster.siamese.dyndns.org>
References: <81bfc67a0904230046j48ed06b7s5693406332ee52dc@mail.gmail.com>
 <81b0412b0904230057k1653d039vfc3962e6affda584@mail.gmail.com>
 <49F025E7.7090404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 10:34:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwuNl-0004Lf-FE
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 10:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754989AbZDWIca (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2009 04:32:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754660AbZDWIca
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 04:32:30 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:51666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754492AbZDWIc3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2009 04:32:29 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 19428AC664;
	Thu, 23 Apr 2009 04:32:29 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7DA4BAC663; Thu,
 23 Apr 2009 04:32:22 -0400 (EDT)
In-Reply-To: <49F025E7.7090404@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Thu, 23 Apr 2009 10:25:11 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 480F57C4-2FE1-11DE-93BB-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117310>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I think he wants the auto generated message which may be different for
> each merge. Maybe something like
>
> GIT_EDITOR=/bin/true git commit
>
> will do the trick.

Use "GIT_EDITOR=:" instead.  It also is *true* just like /bin/true, but
git knows a simple magic about this and avoids an extra fork+exec.

A similar trick exists for GIT_PAGER=cat (not "/bin/cat"), by the way.
