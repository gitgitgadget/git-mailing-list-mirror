From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pager: remove 'S' from $LESS by default
Date: Wed, 07 May 2014 13:42:02 -0700
Message-ID: <xmqqioph8go5.fsf@gitster.dls.corp.google.com>
References: <xmqq38gwm5ny.fsf@gitster.dls.corp.google.com>
	<1398843325-31267-1-git-send-email-Matthieu.Moy@imag.fr>
	<20140505184441.GS9218@google.com>
	<110110563.544859.1399320654149.JavaMail.zimbra@imag.fr>
	<xmqqppjqg6an.fsf@gitster.dls.corp.google.com>
	<87mweuss7d.fsf@fencepost.gnu.org> <vpqzjiuu4i5.fsf@anie.imag.fr>
	<20140506215516.GA30185@sigill.intra.peff.net>
	<xmqqy4ydbjqm.fsf@gitster.dls.corp.google.com>
	<vpqlhudqxto.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, David Kastrup <dak@gnu.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	d9ba@mailtor.net
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed May 07 22:42:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wi8fM-0006QP-Uj
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 22:42:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751744AbaEGUmJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 16:42:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61251 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751720AbaEGUmH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 16:42:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96B231612A;
	Wed,  7 May 2014 16:42:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=idA55ALyJrZxtEo6krMFreF/byI=; b=ssOUQv
	v0e1UhsNGFzKAwEi0MJKlzdIvlmLOuI2LC4LuyjVtDVO9019lBdfpCHBFl9MhxvW
	3bZ9f5XhtYrFsPDpSFoSkzMPrWemv6SA0kOlF+JT+zRiIRw65kHIHIU3wr4MuMO4
	pQnA/3+5PuI+yItutVFWxqS59vMnMVnuzBixI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IL1/Mu2b5QQd41J0Ly0wHtps0qRnjQjX
	6cRxR2gfAyBS0qQ+9i76sbTo9lMmftwoZewcBhnzP2+zVojr9D5TW1iCcqoZX3CO
	8pcRLIi+/H4nmny1rQVU+LsRLDy2B7WORRJo/t55SQSJrAUDLJVih4ePk7l4QEnB
	gKosw4IYUSc=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B06816129;
	Wed,  7 May 2014 16:42:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 93F5E16123;
	Wed,  7 May 2014 16:42:03 -0400 (EDT)
In-Reply-To: <vpqlhudqxto.fsf@anie.imag.fr> (Matthieu Moy's message of "Wed,
	07 May 2014 19:54:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0BCC3078-D628-11E3-8551-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248364>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Perhaps it deserves a mention in the doc, e.g. squashing this on top of
> my patch:

Thanks, will do.

>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index b7f92ac..ebd1676 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -570,7 +570,9 @@ command to `LESS=FRX less -S`. The environment does not set the
>  long lines. Similarly, setting `core.pager` to `less -+F` will
>  deactivate the `F` option specified by the environment from the
>  command-line, deactivating the "quit if one screen" behavior of
> -`less`.
> +`less`.  One can specifically activate some flags for particular
> +commands: for example, setting `pager.blame` to `less -S` enables
> +line truncation only for `git blame`.
>  +
>  Likewise, when the `LV` environment variable is unset, Git sets it
>  to `-c`.  You can override this setting by exporting `LV` with
