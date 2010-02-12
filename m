From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] git-mailsplit: add `mailsplit.keepcr` configuration
 variable.
Date: Fri, 12 Feb 2010 13:49:12 -0800
Message-ID: <7vr5oqnmzr.fsf@alter.siamese.dyndns.org>
References: <1265923579-24900-1-git-send-email-stefan.hahn@s-hahn.de>
 <1265923579-24900-3-git-send-email-stefan.hahn@s-hahn.de>
 <7vhbpnqrxr.fsf@alter.siamese.dyndns.org> <20100212210336.GB32018@pille.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
X-From: git-owner@vger.kernel.org Fri Feb 12 22:49:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ng3O8-0007HL-A6
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 22:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab0BLVtU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2010 16:49:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:58341 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab0BLVtT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 16:49:19 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E3B31974BC;
	Fri, 12 Feb 2010 16:49:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZYAOl+Edm9PmtB+NRt6dnHb0yUE=; b=yhrcHI
	CDGwAGhNkd4qh0JVTVdyGy0ykZAzIlNCDkfRdSTo84jUDwezn4aIjLvE3HjpZCBR
	taB9EOZI75AoCOK+rVRkYDOjhTRtPxinK7p/NEBE6ig/KUuT2afeYt7SOOJG1hoL
	8gsuYocqkI083RRk2ZZhRJDc67BISRscs/L9M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=XD0pzxkaI3RbNIWE8hrWryrga4jhGlpI
	Gv3VwULuD441vx611pu7AZZLOpmynBw9pg8r6J+6PL2+zSS69sZ+AK8BjUvrw0A3
	UyGxK0bl2KOTmbe/JfuYg5MZSIwiFYv3d9iTVEiZr7ZXGBsKsNYgd0Zv6POLSFaB
	qavqEI4B7gg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C291C974B9;
	Fri, 12 Feb 2010 16:49:16 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 12AE0974B8; Fri, 12 Feb
 2010 16:49:13 -0500 (EST)
In-Reply-To: <20100212210336.GB32018@pille.home> (Stefan-W. Hahn's message of
 "Fri\, 12 Feb 2010 22\:03\:36 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7785CF9C-1820-11DF-83D3-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139751>

"Stefan-W. Hahn" <stefan.hahn@s-hahn.de> writes:

> But perhaps it will be a better aproach to make such a configuration
> available for git-am. I will make a patch for this soon.

If a configuration is desired, I think that is probably a saner place to
put it.

Regardless of where the configuration goes between am and mailsplit, you
need to think about the interaction between rebase and am.  You might set
the configuration for am---should that automatically and always kick in
when you run rebase?  Do we need some way to override it per invocation
when running rebase?
