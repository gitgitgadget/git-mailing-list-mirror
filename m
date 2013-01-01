From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/8] Honor DESTDIR
Date: Tue, 01 Jan 2013 13:42:51 -0800
Message-ID: <7vsj6k8tr8.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-6-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Adam Tkac <atkac@redhat.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:43:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9c8-0001Ah-Vj
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:43:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752476Ab3AAVmy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:42:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50641 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab3AAVmx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:42:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 353199ADF;
	Tue,  1 Jan 2013 16:42:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=LnkKiWaB4U90zscWbJ9aC7BA/Lg=; b=r20x5z
	NJ5dLo2LjOiubMEMCGfCr5zXwaF3eZ+golU6pPYrkYzPY4N0yEQloYnqkr9Zgxpp
	zvt2LOA73VJ3ifuheS960aHvxx5opvNhb6WxPmmkwZ5jGF+y7k7lxzwMUsXh0oJn
	xGIzAuUeOCJiugc4AG1DmjLj5ayHXpEv7SHeI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=t5PRgpkaAQFeE21O0iRNdw734rIpmMCk
	IM427Ua+W0f0gsUce7HUw/cabHbEDWhbsEXQlwCc64AzW3fdNwedJT+xO5L4Ks1C
	wK1v8+SBntNPOfDgFycjh9wnmmc3mcS4IbcnE2IvpQu8wxnNxfjEaU8KkfbLQTXD
	XXA2wg5jt4s=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2573D9ADE;
	Tue,  1 Jan 2013 16:42:53 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D0239ADD; Tue,  1 Jan 2013
 16:42:52 -0500 (EST)
In-Reply-To: <1357012655-24974-6-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 31 Dec 2012 21:57:32 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31E2AA2A-545C-11E2-A7E9-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212450>

"David A. Greene" <greened@obbligato.org> writes:

> From: Adam Tkac <atkac@redhat.com>
>
> Teach git-subtree's Makefile to honor DESTDIR.
>
> Author:    Adam Tkac <atkac@redhat.com>
>
> Signed-off-by:    Adam Tkac <atkac@redhat.com>
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---

The contents of the patch looks sensible; the above is questionable
as all the other messages in this series, though.  Did any of our
tools cause this failure?  If so I would like to know more about it.

>  contrib/subtree/Makefile |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index 05cdd5c..36ae3e4 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -30,12 +30,12 @@ $(GIT_SUBTREE): $(GIT_SUBTREE_SH)
>  doc: $(GIT_SUBTREE_DOC)
>  
>  install: $(GIT_SUBTREE)
> -	$(INSTALL) -m 755 $(GIT_SUBTREE) $(libexecdir)
> +	$(INSTALL) -m 755 $(GIT_SUBTREE) $(DESTDIR)$(libexecdir)
>  
>  install-doc: install-man
>  
>  install-man: $(GIT_SUBTREE_DOC)
> -	$(INSTALL) -m 644 $^ $(man1dir)
> +	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
>  
>  $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
>  	xmlto -m $(MANPAGE_NORMAL_XSL)  man $^
