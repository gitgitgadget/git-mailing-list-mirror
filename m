From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Dealing with an upstream cherry-picked branch
Date: Tue, 16 Mar 2010 15:56:45 -0700
Message-ID: <7vy6hrzxhu.fsf@alter.siamese.dyndns.org>
References: <76718491003142117w4fd10449j51deef27548c4d2e@mail.gmail.com>
 <7vocipjmrg.fsf@alter.siamese.dyndns.org>
 <76718491003161038u3dc567a7pb0ae558fd3b6b9c9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 16 23:57:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nrfh9-0000u3-Ix
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 23:57:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752998Ab0CPW4w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 18:56:52 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752940Ab0CPW4v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Mar 2010 18:56:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 32E48A2863;
	Tue, 16 Mar 2010 18:56:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=hKKKED44WkshRDRx3g6ffnKR4cY=; b=UnyFb3Y+60/9gTRx62V12Sk
	4c8Eb6a6QJokQjBVxQJawP92II9O1T8e8cXL2zxCnaOUUvJ5Bqe9GsGrGBrzf9Nn
	/pJIXhCP6uLt5N7FxZbD+vIa2eVKbRVYfhHicOxSszmEBYtA8NM/L2HSGC2+to5U
	5J0eqZTFzkyJO7r0JPiE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=HpsOO5gDu8OstCjgxSOJQmuv2OenEajl8Oirdy1FmvQSLawu3
	qXwZ2e7xxcYvI3b6O2OcxKeyjo64xN8kLeJZGK2XlUxNbulzbx60jO4QiivnTr4I
	Cb78wSMQwH7GmMGAFRUCYU7dp0qr9HiZ4NorMLHsHuTjsOB+yqTkDXRhoI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10E6EA2861;
	Tue, 16 Mar 2010 18:56:49 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8076DA2859; Tue, 16 Mar
 2010 18:56:46 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 34158A16-314F-11DF-BD02-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142359>

Jay Soffian <jaysoffian@gmail.com> writes:

> I think I'm not clear how it helps to make the integration branch
> throw-away. Unless you mean something like git pu?

The whole idea of making it throw-away came from that you do not have
control over your upstream and you would want to work with their
upstream-master and "upstream-a of the week".

I think your squinted version essentially is the same as what I outlined,
modulo that your "local-master" corresponds to what I called "local-base".
No matter what we call that branch, as long as you need to be able to
integrate cleanly with both upstream-master and the upstream-a (that is
built by cherry-picking and then thrown away from time to time) and able
to move forward without too much cruft in your history, "local-base" needs
to stay away from merging upstream-a.
