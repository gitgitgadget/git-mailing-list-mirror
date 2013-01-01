From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/8] Make the Manual Directory if Needed
Date: Tue, 01 Jan 2013 13:44:08 -0800
Message-ID: <7vobh88tp3.fsf@alter.siamese.dyndns.org>
References: <1357012655-24974-1-git-send-email-greened@obbligato.org>
 <1357012655-24974-7-git-send-email-greened@obbligato.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Jesper L. Nielsen" <lyager@gmail.com>
To: "David A. Greene" <greened@obbligato.org>
X-From: git-owner@vger.kernel.org Tue Jan 01 22:44:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tq9dN-0001hq-RX
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jan 2013 22:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508Ab3AAVoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jan 2013 16:44:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51206 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752460Ab3AAVoK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jan 2013 16:44:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 744779B27;
	Tue,  1 Jan 2013 16:44:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tVgtqCZni4fWw5CiBuDP9Rd4aSo=; b=vzAoY7
	a1aiCXptAyaoURgubIw2oTO+xe09ell51GGZ4oFDAtZz8u86myRhd3t1/sHSPuiJ
	No77O6FN3RTeVEcmRxK5EDrgGAu3ltFoHSNQvSywzVz2LCZLcETvJ32uLnuyDb1Y
	iVJ0qTpDkN6JRIwBzO8MHvXsGH9aiO/Awm6gM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AThxyzK2a221jRQgAL1LD6DxBp52wQPe
	FsC/YM/rITP0JopFeqYu1o/m9npZyYBYKZqtVenfHbgfY6iv8Gwl3pRRmj1QRXxQ
	kmp5cLPmQzsAO4wbEu65I2AwOoBGE2K/9TCvIWClDUFB3Nb0AMJBcH/ORrA27lZQ
	uLItfHfITV0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 652EC9B26;
	Tue,  1 Jan 2013 16:44:10 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EC9DB9B25; Tue,  1 Jan 2013
 16:44:09 -0500 (EST)
In-Reply-To: <1357012655-24974-7-git-send-email-greened@obbligato.org> (David
 A. Greene's message of "Mon, 31 Dec 2012 21:57:33 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 600DB390-545C-11E2-A6C8-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212453>

"David A. Greene" <greened@obbligato.org> writes:

> From: "Jesper L. Nielsen" <lyager@gmail.com>
>
> Before install git-subtree documentation, make sure the manpage
> directory exists.
>
> Author:    Jesper L. Nielsen <lyager@gmail.com>
>
> Signed-off-by:    Jesper L. Nielsen <lyager@gmail.com>
>
> Signed-off-by: David A. Greene <greened@obbligato.org>
> ---
>  contrib/subtree/Makefile |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
> index 36ae3e4..52d6fb9 100644
> --- a/contrib/subtree/Makefile
> +++ b/contrib/subtree/Makefile
> @@ -35,6 +35,7 @@ install: $(GIT_SUBTREE)
>  install-doc: install-man
>  
>  install-man: $(GIT_SUBTREE_DOC)
> +	mkdir -p $(man1dir)

We seem to use "$(INSTALL) -d -m 755" for this kind of thing (see
the Documentation/Makefile).

>  	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
>  
>  $(GIT_SUBTREE_DOC): $(GIT_SUBTREE_XML)
