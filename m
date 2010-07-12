From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log -S with evil merges
Date: Sun, 11 Jul 2010 23:12:45 -0700
Message-ID: <7v39vpfcte.fsf@alter.siamese.dyndns.org>
References: <20100710194838.GA2315@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 12 08:12:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYCG9-0002QQ-Ro
	for gcvg-git-2@lo.gmane.org; Mon, 12 Jul 2010 08:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753814Ab0GLGMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 02:12:53 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:37893 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850Ab0GLGMw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 02:12:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C7DCC3725;
	Mon, 12 Jul 2010 02:12:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+n1TlAZ+66nIEfyVuQHEdMhDk3M=; b=R5/VkP
	whGqIUpDFWES9OPV46PlHpk/AC45+gOsq8d2tcVfU51dotJdbNGBIK/GJZDfz07L
	6iQS5LxgqVm3RjUWv3ocNafjGWn9Ue0dXhELl0gtvIGUgmzq6t58UM2Gq+i18ryw
	h6a2treovUZ54DrjAsH4hU2GEY+XflLcOnQNk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mc571KDDcn9c2Z7R2LdsOoPAGXELRzVt
	ejYqfA25ASoKBjx0n3qifPanUxLdNJMU0bSPer7wHFudltSvY/qCmMoe2VhsolG7
	k87PfpCz0v49wwgOUvYGoPGU1+SpJsNfsKVoMvNFIGTJDtD8awUulbM+p/xRrV7P
	fQE6YZuzJDQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id ED0BEC3723;
	Mon, 12 Jul 2010 02:12:49 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E173C3722; Mon, 12 Jul
 2010 02:12:47 -0400 (EDT)
In-Reply-To: <20100710194838.GA2315@burratino> (Jonathan Nieder's message of
 "Sat\, 10 Jul 2010 14\:48\:38 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7F87405A-8D7C-11DF-B887-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150796>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The more logical
>
>  ; git log --oneline -c -S'UE_ALWAYS' --follow builtin/reflog.c
>
> does not work --- it mentions _all_ merges.  Why?

I don't think --follow, which is merely a checkbox item, is friendly to
most other git features.  Does it even show diff with the corresponding
file at the commit where filename is changed?
