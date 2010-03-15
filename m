From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] rebase--interactive: don't enforce valid branch
Date: Sun, 14 Mar 2010 22:20:02 -0700
Message-ID: <7vsk82i2kd.fsf@alter.siamese.dyndns.org>
References: <1268628502-29696-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 15 06:20:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nr2iw-0005HF-7V
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 06:20:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744Ab0COFUO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 01:20:14 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35520 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932186Ab0COFUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 01:20:11 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EB053A2A5A;
	Mon, 15 Mar 2010 01:20:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JPLJAlYUszu/GqxQ8vpRYIGsgo8=; b=cfQ3Mr
	QWHtYouAgb/0G1teIrEFn+bOuyKUY7ajJP2pS/BoG9NQyC8+7Ccj8rCEtbAAYDLA
	Yj5/JWnyP4jICTv1V1JyaadND8VOCaBh9Ab9C7dVDuIK6n8Tjb4j1TFWXlF4bJC4
	W/HYZpCRuCCfhFQPrtexYqgeCHI3AfOyRz5jU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KiVQBDhRl28a9jXuE/3KwvavoGkEM5b1
	zdl10tB3iBXysNF1GrTKDgnCdCmv2kacxFSn9o+4D1DBy/qgQvv+zz6JEuQ2cYnv
	Z8zcncRfyHUfiU7oXRKPMlaAXw2wXcGZXlK+QDlHktZRg6+s8mA/bGWNGGGsIzjx
	s0IjDDTtnGE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C8FB0A2A57;
	Mon, 15 Mar 2010 01:20:06 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3987FA2A56; Mon, 15 Mar
 2010 01:20:04 -0400 (EDT)
In-Reply-To: <1268628502-29696-1-git-send-email-cxreg@pobox.com> (Dave
 Olszewski's message of "Sun\, 14 Mar 2010 21\:48\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6AFCBCB0-2FF2-11DF-A5D8-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142169>

Dave Olszewski <cxreg@pobox.com> writes:

> git rebase allows you to specify a non-branch commit-ish as the "branch"
> argument, which leaves HEAD detached when it's finished.  This is
> occasionally useful, and this patch brings the same functionality to git
> rebase ---interactive.

Three dashes?

> +test_expect_success 'rebase while detaching HEAD' '
> +	grandparent=$(git rev-parse HEAD~2) &&
> +	test_tick &&
> +	FAKE_LINES="2 1" git rebase -i HEAD~2 HEAD^0 &&

What's the point of saying this?  You could instead say:

	git rebase -i HEAD~2

no?
