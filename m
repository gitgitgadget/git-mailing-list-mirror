From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Allow combined diff to ignore white-spaces
Date: Wed, 13 Mar 2013 16:53:39 -0700
Message-ID: <7vzjy6zwjg.fsf@alter.siamese.dyndns.org>
References: <7v38wdc4ei.fsf@alter.siamese.dyndns.org>
 <1363209683-10264-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 14 00:54:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFvUt-0000g4-6z
	for gcvg-git-2@plane.gmane.org; Thu, 14 Mar 2013 00:54:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934418Ab3CMXxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 19:53:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61690 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933336Ab3CMXxm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 19:53:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F832B45B;
	Wed, 13 Mar 2013 19:53:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=l5MD3iiDW+MeYGN9t2/ojofwOeY=; b=DUA1Xv
	WBuijosfc61OdtJKmlK/VsgALMsU+Oxi6Z7h2oeo65H75z9jVr7NV37qr2pfd+71
	N/hW3mkBW3rHpk6zX6G0F1YIeayaR0edzo6g5aYA8uIM3EsWogALmIzio3yCYTuH
	PF5dL+mGmsGiNrqyN3u9Y0e2G9ha/ZyQZ8ovA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sfTu17jP9561X30C/Z0Ej36UqILw9xXg
	wBj2balRq3FE7TR+5xrbS969t5IHpmYx6jEv4z0qSS1zwt1PvhUja89+0YrJfyKX
	2wmFclqfvfifxNri6OkhNe26+DCp4/nQQ0orhi1Amq714QKWYxW2YBZtxf9NPn7g
	Y9bo5G8fQ+E=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14449B45A;
	Wed, 13 Mar 2013 19:53:42 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 77EFEB452; Wed, 13 Mar 2013
 19:53:41 -0400 (EDT)
In-Reply-To: <1363209683-10264-1-git-send-email-apelisse@gmail.com> (Antoine
 Pelisse's message of "Wed, 13 Mar 2013 22:21:23 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B9228A6-8C39-11E2-BBC3-4AAA2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218105>

Antoine Pelisse <apelisse@gmail.com> writes:

> OK, I added some tests and coalesce similar lost lines (using the same flags
> we used for diff.

Hmph, why doesn't this pass its own tests?

> +test_expect_success 'check combined output (no ignore space)' '
> +	git show | test_i18ngrep "^-\s*eol spaces" &&

What kind of grep pattern is "\s*"?
