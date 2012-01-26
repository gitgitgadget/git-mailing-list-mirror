From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Finding all commits which modify a file
Date: Thu, 26 Jan 2012 14:42:27 -0800
Message-ID: <7vwr8e13xo.fsf@alter.siamese.dyndns.org>
References: <46043.208.70.151.129.1327095331.squirrel@mail.lo-cal.org>
 <4F1B4764.3010501@gmail.com>
 <41090.38.96.167.131.1327335283.squirrel@mail.lo-cal.org>
 <CA+gHt1DxY42W9g+gJQTFrXuXBN-Jny+Jg60gKssdftZ5wxu91A@mail.gmail.com>
 <52932.38.96.167.131.1327422884.squirrel@mail.lo-cal.org>
 <CA+gHt1BjqJpUke8JKjUmFyg3Zj5FmASd77LR-7P+6RrNLddD1A@mail.gmail.com>
 <30433.38.96.167.131.1327508582.squirrel@mail.lo-cal.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <santi@agolina.net>,
	"Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Neal Groothuis" <ngroot@lo-cal.org>
X-From: git-owner@vger.kernel.org Thu Jan 26 23:42:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqY1e-000499-Bq
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 23:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab2AZWmc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 17:42:32 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56558 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753408Ab2AZWma (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 17:42:30 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 547957AD4;
	Thu, 26 Jan 2012 17:42:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8qoAMwBxO5+DWlqUM2BecUsf4qE=; b=M5CUt2
	8sHQoSxZCzxU+M3hqXE42vxNF6pUNQ35CE+/BNTo812nueAs3s8YVF7GMzVueaNn
	o7zVAXxTG+TxIPjpV7rLjj/wDHE4CyGh5nNcNk5RkJy2JvlV6m2dAfIxC9yXTiZ8
	QLZisJ0MTrGvFYq/f9JmKd7NN7S9qofE0hH4M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T+FBWbcDd5noWeOsbUzDkQJNO/L209wo
	9B86wjAcBYIRz1SLGglw8jxyi8ivaBz3cyCespQ7aSBlbQaHS4nNZalHZLxTUsn9
	SYZvP1tUuUPWZMmlQxvVSkl46LEiDqTdDioi8XwmweAIqdtLQaP1j6OkeuxdHLZM
	VJ/LvvbRwAE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BC4F7AD3;
	Thu, 26 Jan 2012 17:42:29 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D25FE7AD2; Thu, 26 Jan 2012
 17:42:28 -0500 (EST)
In-Reply-To: <30433.38.96.167.131.1327508582.squirrel@mail.lo-cal.org> (Neal
 Groothuis's message of "Wed, 25 Jan 2012 11:23:02 -0500 (EST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06B20A70-486F-11E1-893F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189168>

"Neal Groothuis" <ngroot@lo-cal.org> writes:

> Is there a situation where checking for TREESAMEness before simplification
> is desirable and checking after would not be?

When you do not want to see a side branch that does not contribute to the
end result at all, obviously ;-). Outside that situation, before or after
should not make a difference, I would think.
