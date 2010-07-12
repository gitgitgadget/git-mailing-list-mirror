From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/13] print the line log
Date: Mon, 12 Jul 2010 14:52:17 -0700
Message-ID: <7vsk3o8j1q.fsf@alter.siamese.dyndns.org>
References: <1278829141-11900-1-git-send-email-struggleyb.nku@gmail.com>
 <1278829141-11900-9-git-send-email-struggleyb.nku@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 23:52:35 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYQvR-0000lR-KC
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 23:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754304Ab0GLVw0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 17:52:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:60856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754067Ab0GLVwZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 17:52:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DCDA9C3324;
	Mon, 12 Jul 2010 17:52:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=mXm8yCSQndRqF1sdMjaOicV80ko=; b=OTiHKCTN1x6SI4U1i45WiKk
	l2lI/4N+YWt4B+pOVMcV5V67UoZ5eLDAX0ptP6C9MOXLFhB89ndJgLL6eHc6+E1v
	tax8E0gKgHuftfu1TFNvqwZskaxumwfXrKRl7mBJ9fg4zWimYFlWYHKwkseL5+H9
	Zvfxq7o5F28vb+XbJkvg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=TNNK3UvGCQsQ46hE9t6h4HK6ghoLqGzdKYA0LTqimFfsKrJtN
	YnWg2Z+mpfef8XaL35CF9BHBEXpja5DvsL/VRceAUQi9+vNmTPERNqxh6Dw2vGkv
	uef48CysrN3DrJpBMVkzWVJMI+7s1lMrB8Q8uQ6LtRyidOxMl1jJqvIO8M=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B6DEDC3322;
	Mon, 12 Jul 2010 17:52:22 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B85EFC331E; Mon, 12 Jul
 2010 17:52:18 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C052833C-8DFF-11DF-9B82-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150848>

Bo Yang <struggleyb.nku@gmail.com> writes:

> +static void flush_lines(struct diff_options *opt, const char **ptr, const char *end,
> +		int slno, int elno, int *lno, const char *color, const char heading)
> +{
> +	const char *p = *ptr;
> +	struct strbuf buf = STRBUF_INIT;
> +	const char *reset;
> +
> +	if (strcmp(color, ""))

Did you mean "if (*color)"?

> +	/*
> +	 * todo: when --graph landed on master, this should be changed
> +	 * a little.
> +	 */

Hmm, don't we already have it?

> +static void diff_flush_filepair(struct rev_info *rev, struct diff_line_range *range)
> +{
> +...
> +}

Looks suspiciously familiar...  Cut-and-paste without refactoring?
