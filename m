From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] parse-opt: migrate builtin-apply.
Date: Sat, 27 Dec 2008 13:47:13 -0800
Message-ID: <7vvdt5cmu6.fsf@gitster.siamese.dyndns.org>
References: <1230387764-11230-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Dec 27 22:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGh1k-0008ID-PG
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 22:48:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754250AbYL0VrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 16:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754234AbYL0VrU
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 16:47:20 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64822 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383AbYL0VrT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 16:47:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 677761B30C;
	Sat, 27 Dec 2008 16:47:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6117F1B310; Sat,
 27 Dec 2008 16:47:14 -0500 (EST)
In-Reply-To: <1230387764-11230-1-git-send-email-vmiklos@frugalware.org>
 (Miklos Vajna's message of "Sat, 27 Dec 2008 15:22:44 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: EEC91E0C-D45F-11DD-92A4-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104020>

Miklos Vajna <vmiklos@frugalware.org> writes:

> +static int option_parse_inaccurate(const struct option *opt,
> +				   const char *arg, int unset)
> +{
> +	options |= INACCURATE_EOF;
> +	return 0;
> +}
> +
> +static int option_parse_recount(const struct option *opt,
> +				const char *arg, int unset)
> +{
> +	options |= RECOUNT;
> +	return 0;
> +}

I still haven't applied and ran the testsuite myself, but these makes me
wonder if there isn't a built-in "bit" type support in parse_options().
