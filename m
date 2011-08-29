From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 4/5] branch: introduce --list option
Date: Sun, 28 Aug 2011 22:55:10 -0700
Message-ID: <7v8vqc92yp.fsf@alter.siamese.dyndns.org>
References: <cover.1314367414.git.git@drmicha.warpmail.net>
 <cover.1314543252.git.git@drmicha.warpmail.net>
 <05a1a73e0b942dd94dd091c233be964fa19dfc6a.1314543252.git.git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Aug 29 07:55:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxuoZ-0003Op-6e
	for gcvg-git-2@lo.gmane.org; Mon, 29 Aug 2011 07:55:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752764Ab1H2FzP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Aug 2011 01:55:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58654 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752680Ab1H2FzN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2011 01:55:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E9E25F3F;
	Mon, 29 Aug 2011 01:55:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Gwav5i5/OmplLdNSoOda9RqT0TI=; b=umRmOy
	VZm6LSz/jCZ0OtQdNI/eQ+4BLZgYNtvb0AW6qAIM30Uep52268JdvdyHNOXGOrSg
	fSyzBj5fh1d9cTo0F4wwM3/O0Znh2byTZrvb3g1qA8hsyL4eqsosmjMGEhuajbPs
	BnS4IXtPh/vjfFv7o7VfgCxDnyiGbeGzxNbd4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ek2vovQ/szQ7t3pAG7+cgt7gPysQyICS
	Pndcte9RDjAQW4w3cfd0hBnZqHR9hZdUymdYVTuPgs2dwl9i5aDC5PkLkacL9Vbt
	n93WZkjubdzC1BJ4XF26Qupc9ZvKGM5CE2GuAs98WRJum7b36CFOJtkohcvLDxU3
	ErlfkzT1wPI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 463925F3E;
	Mon, 29 Aug 2011 01:55:12 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D35995F3C; Mon, 29 Aug 2011
 01:55:11 -0400 (EDT)
In-Reply-To: <05a1a73e0b942dd94dd091c233be964fa19dfc6a.1314543252.git.git@drmicha.warpmail.net> (Michael J. Gruber's message of "Sun, 28 Aug 2011 16:54:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7579BD32-D203-11E0-853B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180297>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> +test_expect_success 'git branch --list shows local branches' '
> +	git branch --list >actual &&
> +	test_cmp expect actual
> +'
> +
> +cat >expect <<'EOF'
> +  branch-one
> +  branch-two
> +EOF
> +test_expect_success 'git branch --list pattern shows matching local branches' '
> +	git branch --list branch* >actual &&
> +	test_cmp expect actual
> +'

Does this one exclude the "* master" entry at this stage in the series?
