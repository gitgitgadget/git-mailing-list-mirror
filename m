From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git rm / format-patch / am fails on my file: patch does not apply
Date: Mon, 11 Nov 2013 11:37:02 -0800
Message-ID: <xmqqd2m6logx.fsf@gitster.dls.corp.google.com>
References: <CAD3a31XPKsnuNE+szw7xgvaDrcxhKZ2jTDHKzTwdwtnCwFb_0w@mail.gmail.com>
	<xmqqhabilpzx.fsf@gitster.dls.corp.google.com>
	<52812CC0.5050805@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ken Tanzer <ken.tanzer@gmail.com>, git@vger.kernel.org,
	Philip Oakley <philipoakley@iee.org>
To: Stefan Beller <stefanbeller@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Nov 11 20:37:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VfxId-0005Ij-8c
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 20:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755080Ab3KKThU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Nov 2013 14:37:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754340Ab3KKThJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Nov 2013 14:37:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A077B4F763;
	Mon, 11 Nov 2013 14:37:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=peOrnbE/rKDb3hP7ATYJ3qnkm10=; b=sLUKQH
	xIYOzgWHhxUxWYcs0Vq6CDv1BaKvHlG7mIwagiNYhEDoiyx0DuKjh3UcOIBLEc9v
	ex9DqNXGSZIRjbgNMyqM6ZlK7qTQaFN++P63gtW+UtHUyp1T0i4nLkfWC0w+U/uL
	+6HC5Zz493fhzqzzxgXmXWOVehEVH83h6JiC4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MgZ98+ckLvlqHh5aQ4qDRzr5VuJrY3FX
	6nznpzxxp58PYxGLXOJKKh40EfJRPx3I7Drnf2IRh6pievrFSFsGE+FCp2fTf8qO
	Dr8DNIJMFEWgL2u3zteHm3EYhzu96jqK/PY9d0a6k3RuHOsknGRcVb4T4Nw5HqdM
	flmGOP9gIXY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8D8704F762;
	Mon, 11 Nov 2013 14:37:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F198C4F760;
	Mon, 11 Nov 2013 14:37:03 -0500 (EST)
In-Reply-To: <52812CC0.5050805@googlemail.com> (Stefan Beller's message of
	"Mon, 11 Nov 2013 20:15:12 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A4532C3A-4B08-11E3-BEE8-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237640>

Stefan Beller <stefanbeller@googlemail.com> writes:

> I do have this global config
> 	core.safecrlf=warn
> regarding line endings.

Oh, that sounds very suspicious.  If the payload has CRLF, CR and LF
mixed, that would immediately violate safecrlf, so failing the
application sounds like the right thing to do.

> I was using 1.8.5.rc1.17.g0ecd94d
>
> Trying to understand the problem,

Likewise.  Thanks for chiming in.
