From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git submodule: Fix adding of submodules at paths
 with ./
Date: Wed, 25 Feb 2009 13:25:09 -0800
Message-ID: <7v7i3e1a6i.fsf@gitster.siamese.dyndns.org>
References: <80055d7c0902241556s4d24285bqd171275f58bdb37d@mail.gmail.com>
 <1235559820-3096-1-git-send-email-git@drmicha.warpmail.net>
 <1235559820-3096-2-git-send-email-git@drmicha.warpmail.net>
 <1235559820-3096-3-git-send-email-git@drmicha.warpmail.net>
 <49A529AB.8010700@viscovery.net> <49A53B15.4060608@drmicha.warpmail.net>
 <49A541D3.4030001@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Andrei Thorp <garoth@gmail.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 25 22:27:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LcRHX-0002qq-Gt
	for gcvg-git-2@gmane.org; Wed, 25 Feb 2009 22:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbZBYVZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Feb 2009 16:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752453AbZBYVZU
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Feb 2009 16:25:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43574 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbZBYVZS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Feb 2009 16:25:18 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id C81EE105C;
	Thu, 26 Feb 2009 16:25:14 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 126EA1059; Thu,
 26 Feb 2009 16:25:09 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F50E453C-044B-11DE-8F82-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111498>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Michael J Gruber schrieb:
> ...
>> Now, the /// are in fact a valid concern[1], although probably not that
>> common an isue.
>
> I'm fine if only common use cases are taken care of. If you say that ./ is
> common and /// is not, then I'll believe it because I'm not a git
> submodule user (yet) and can't argue about this with my own experience.

Even if it is not worth the complication to the code to fix /// or /../
cases, I think it is worth *detecting* such an incoming path and error
out, telling the user not to give a "funky" path.
