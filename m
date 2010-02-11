From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-mailsplit: add `mailsplit.keepcr` configuration
 variable.
Date: Thu, 11 Feb 2010 15:21:52 -0800
Message-ID: <7vhbpnqrxr.fsf@alter.siamese.dyndns.org>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
 <1265923579-24900-3-git-send-email-stefan.hahn@s-hahn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 00:22:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NfiMS-0005iF-Jy
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 00:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757385Ab0BKXWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2010 18:22:13 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35078 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755775Ab0BKXWK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2010 18:22:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E78299949A;
	Thu, 11 Feb 2010 18:21:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=rW2zXlRCtCMuJ7CqjBz/lwgndpg=; b=oIx26HpHDQDb7FGnH4OQhR0
	fdBXfmp6EfVG7NlYV0TZZ6ozpJkLdcxkHpZ84hM5jqz2MBxPcHib7/NkoxalASUr
	i5i2zUsxMLwAqCmbKoCmoyoUAPpT2JjpNkekdIkdZ4s5ECbope3T5hpVoaOeqM8D
	QdAoC0AZXHvqSyLiuqQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=KeGLNot6I+5+emSO4tSw3YY6RtDgrms9Ii2oFh3CvFqDg4jZr
	wASVc4TsSY7ojL2tcFFXuxSXyk5cCvgWqoFVsIVM199ATkzCNfSQgJwLTLATe8CY
	RmDRAlMTBVbn5aFLZ/ejXTnxFsZ6CAiHWwHZq49s6xfe+jjv2LA+C947sI=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C3E2199499;
	Thu, 11 Feb 2010 18:21:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 205C699495; Thu, 11 Feb
 2010 18:21:53 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3F218586-1764-11DF-A55D-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139642>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> If using git-mailsplit in environments where files with dos and unix
> line ending stay in one repository mbox patches must be split with
> additional parameter '--keep-cr', because the behaviour of
> git-mailsplit have been changed in commit c2ca1d79.
>
> With this patch the behaviour of git-mailsplit can be set via
> configuration file.

This probably is a bad change.  mailsplit is designed to be usable without
being inside any git repository.  With this change, doesn't the command
start failing to run when run outside a git repository?
