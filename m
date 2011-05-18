From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git & patterns
Date: Wed, 18 May 2011 12:55:14 -0700
Message-ID: <7vsjsbbx7h.fsf@alter.siamese.dyndns.org>
References: <4DD3A402.3040802@hupie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ferry Huberts <mailings@hupie.com>
X-From: git-owner@vger.kernel.org Wed May 18 21:55:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMmq9-0003Av-Up
	for gcvg-git-2@lo.gmane.org; Wed, 18 May 2011 21:55:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831Ab1ERTzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2011 15:55:24 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46013 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751614Ab1ERTzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2011 15:55:22 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F20804536;
	Wed, 18 May 2011 15:57:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=w9a5MOHXrdGN10+U0jD/EJWQfUc=; b=rj2aEd
	ANXvZ0H/edQihZXhyijEHJB66TKh2S9NAtp+o+tDh/LVeT0FI6cgGJGjDq2z4jmS
	YBQQI4dpgY/W7cCUE2FrM6NCKBd0plaXaKNV6nr+PRHoFetRkMEf1+urpXNRiFWe
	WiC0Q/D8FoxLki8yKKRE75zCOHxOjTxfeklfo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q8QQLlxTGlv/oXyvwfFh+nq9oa0X3Xht
	CpQshqxvoJNWeeL64aYm1261d5LTW0uFyVpAZwVRj2cVp6bK0LQ0ktzhFobOq/i/
	5oW8X5lMKPgVOfx81GmGrmRcfPK7DnXoQQNqj677oC7FxACuFToZVPRcDIYdBXXj
	PQQrG3cx21I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D00754535;
	Wed, 18 May 2011 15:57:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F42334534; Wed, 18 May 2011
 15:57:22 -0400 (EDT)
In-Reply-To: <4DD3A402.3040802@hupie.com> (Ferry Huberts's message of "Wed,
 18 May 2011 12:48:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0D78D5D0-8189-11E0-9492-BBB7F5B2FB1A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173897>

Ferry Huberts <mailings@hupie.com> writes:

> After reading the manual page for git describe it was not clear to me what
> kind of pattern the --match option should take. Was it to be
> a shell pattern (to be expected) or a regular expression pattern?
>
> So I dug in the code to find fnmatch: shell pattern.
>
> Now my question(s):
>
> - could the manual page be update to make this explicit please? (plus
> other manual pages talking about (shell) patterns)

The general design guideline we have is to use glob for things that look
like pathnames. Refs, refspecs, ignore and attribute rules are the
examples of this rule.

We may be lacking this info in our documentation. A patch to add it
somewhere is very welcome.
