From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC eb/double-convert-before-merge 0/6] merge
 -Xrenormalize
Date: Wed, 04 Aug 2010 11:10:51 -0700
Message-ID: <7v39uugses.fsf@alter.siamese.dyndns.org>
References: <cover.1278093311.git.eyvind.bernhardsen@gmail.com>
 <20100804031935.GA19699@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Finn Arne Gangstad <finnag@pvv.org>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 20:11:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgiQs-00045p-GJ
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 20:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab0HDSLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Aug 2010 14:11:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:45557 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717Ab0HDSLH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 14:11:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 30156CAF80;
	Wed,  4 Aug 2010 14:11:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=b/dcrZ2VK1dQkP5JWQpb9KRF2pM=; b=Hcoakm
	B2Za69F+dzxlrrAQl8w5M0f9PDnHg4NXxoCJyzK+oefWhpQjcSogu2KNvy7xWyOg
	ualX58e5In3HDOpGM9iCwQDFh5TUC8ofR3Hu7qsBc3zKLCGmhM+yJcrnBX92iW3C
	/PGQDnowlnaU789e2ZhcoiWCP58HoQ7ZuOLSU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GqqM4KwUE6JfGrL92+lY35Tn8Vy6duVu
	j1kCcND6QJOzfTLHBhMQkCRERzABxFiiQIRJr8Pltz4X0/yOFnUJbtGN+NIkitLS
	ehUaYfox/YHCMkkbkysvy4Au749Vgq9ox4rTfNhYN+Lix2KDKHg6Y0ZIpgVf2fUi
	1vegNx+Rv2E=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C540FCAF7F;
	Wed,  4 Aug 2010 14:10:59 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D400BCAF7E; Wed,  4 Aug
 2010 14:10:53 -0400 (EDT)
In-Reply-To: <20100804031935.GA19699@burratino> (Jonathan Nieder's message of
 "Tue\, 3 Aug 2010 22\:19\:35 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A292984A-9FF3-11DF-BD58-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152587>

Jonathan Nieder <jrnieder@gmail.com> writes:

> But for later, they tell a nice story.  The idea is that the
> "merge.renormalize" is not really about the behavior of the "git
> merge" command but about the merge-recursive driver; and so it
> should be usable everywhere else that driver is used, too.
> ...
> So in an ideal world, you would be able to, e.g.:
>
> 	git checkout -m -Xrenormalize otherbranch
>
> or
>
> 	git revert -Xrenormalize otherpatch
>
> or
>
> 	git pull --rebase -Xrenormalize
>
> Of course, the plumbing is not all there yet; many commands that
> use merge drivers cannot pass through arbitrary options through
> yet.
>
> Well, enough talking.  Here are the patches; what do you think?

Nicely summarized.
