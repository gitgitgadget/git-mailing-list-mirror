From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RFC 0/2] Mixing English and a local language
Date: Thu, 13 Sep 2012 10:30:52 -0700
Message-ID: <7v4nn1akz7.fsf@alter.siamese.dyndns.org>
References: <1345922816-20616-1-git-send-email-pclouds@gmail.com>
 <CACsJy8CG72PzvndV7C4a9hspxhprKn2tcb49HxeZ14pmEDycGQ@mail.gmail.com>
 <7vligfcdgh.fsf@alter.siamese.dyndns.org>
 <20120913132847.GD4287@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 13 19:31:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCDFn-00021X-Oj
	for gcvg-git-2@plane.gmane.org; Thu, 13 Sep 2012 19:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750955Ab2IMRa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Sep 2012 13:30:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48330 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab2IMRay (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Sep 2012 13:30:54 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 68A2C7DDF;
	Thu, 13 Sep 2012 13:30:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rxDa+/FGEnjWTPGJVCGpNzL4q5A=; b=Iilk4N
	9aSzpigvOQsv/8PFgR5PvcuNjGePDM6t9nIeYg7ChTpZde2P6tFNWqr3TB12VixW
	+UgYwN9VMVaUWUh5NWRLIVt8flVH3Q9lXrRLXgd/5gexxlIw4zXvdMk3LlR44JgW
	CmQ7kHrYPIrnJGX7487JvC1JCguZzzYKu43S4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TjoQ1oFN07W+PfPK9Y2sl3YnkdD55sUd
	JpFx4FHDxrlqBG2jFkgLcsLyD/hbFFvsBe+FCHz+IGwfUAybYje+5ywTjw0sCt8B
	sQA/O4vYt8Io5yT8HaEUvxz5PlAByk+7ZNzmaSuMn3MzSzcm3rNTbxW0GK0YeS+e
	AYrPHa3PNwc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52F767DDE;
	Thu, 13 Sep 2012 13:30:54 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AFBA57DDC; Thu, 13 Sep 2012
 13:30:53 -0400 (EDT)
In-Reply-To: <20120913132847.GD4287@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 13 Sep 2012 09:28:47 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C4F17F48-FDC8-11E1-B27B-BAB72E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205395>

Jeff King <peff@peff.net> writes:

> I think I'd prefer:
>
>   1. Revert diffstat to always be in English/C locale for now. For all
>      commands. People too frequently end up showing the output of things
>      besides format-patch. It means they will have to read the English
>      when they are just running locally, but since format-patch is
>      generating it, it is something that they would need to
>      understand anyway.
>
>   2. If people on non-English projects find that too cumbersome, then we
>      can switch the "English/C" above for `i18n.projectlang` or
>      something.

That part I sort-of understand.

>      But it should not be per-command, but per-message, and
>      should include all output that is not diagnostic and is not
>      machine-parseable (e.g., what I mentioned above, request-pull
>      output, etc). If it is the project's language, then the team
>      members will need to know it anyway, so it should not be too big a
>      burden to have a potentially different language there than in the
>      diagnostic messages.

No matter what the project languages is, machine parseable part will
not be localized but fixed to "C" anyway, so I do not think it comes
into the picture.

My take on this is, if there is the project language, it should
apply to _everything_.  Please do not introduce any per-command,
per-message, per-anything mess.  Just set LANG/LC_ALL up and be done
with it.

And I think you justified why that is the right thing to do very
well in the second sentence in the above paragraph I quoted from
you.
