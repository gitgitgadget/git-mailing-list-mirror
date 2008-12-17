From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is it possible to roll back unstaged changes while leaving the
 staged ones for the next commit?
Date: Wed, 17 Dec 2008 12:30:41 -0800
Message-ID: <7vy6yelf2m.fsf@gitster.siamese.dyndns.org>
References: <c115fd3c0812171157m3d180534gb5630fbcf39b2bbd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Tim Visher" <tim.visher@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 17 21:32:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LD33u-00078a-74
	for gcvg-git-2@gmane.org; Wed, 17 Dec 2008 21:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751321AbYLQUas (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Dec 2008 15:30:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbYLQUas
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Dec 2008 15:30:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:33918 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751279AbYLQUar (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Dec 2008 15:30:47 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 872581A806;
	Wed, 17 Dec 2008 15:30:46 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 786181A7DB; Wed,
 17 Dec 2008 15:30:43 -0500 (EST)
In-Reply-To: <c115fd3c0812171157m3d180534gb5630fbcf39b2bbd@mail.gmail.com>
 (Tim Visher's message of "Wed, 17 Dec 2008 14:57:08 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 95AF9942-CC79-11DD-9A35-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103383>

"Tim Visher" <tim.visher@gmail.com> writes:

> My question is this: is it possible to revert the changes that I
> haven't staged so that the file looks as if everything inside of it
> has been staged because none of the stuff I didn't stage is there
> anymore.

The last part of the sentence after "because" does not parse for me at
all, but I think you are after one of the following:

 (1) if you want to get rid of garbage changes in your work tree, you
     would want "git checkout $that_path";

 (2) if you want to temporarily stash away further changes in your work
     tree, because you would want to first test what is staged, commit it,
     and then later continue to refine the changes stashed away thusly,
     you would want "git stash --keep-index".
