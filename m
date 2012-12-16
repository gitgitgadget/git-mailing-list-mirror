From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Documentation: don't link to example mail addresses
Date: Sun, 16 Dec 2012 10:48:45 -0800
Message-ID: <7vd2y9rfxu.fsf@alter.siamese.dyndns.org>
References: <20121215150314.GC2725@river.lan>
 <20121215172018.GA18696@sigill.intra.peff.net>
 <20121215182408.GD2725@river.lan>
 <20121216120405.GA14320@sigill.intra.peff.net>
 <20121216140029.GE2725@river.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Sun Dec 16 19:49:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkJGx-00050M-Sb
	for gcvg-git-2@plane.gmane.org; Sun, 16 Dec 2012 19:49:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751537Ab2LPSsu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 13:48:50 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57665 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751450Ab2LPSst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 13:48:49 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92C96A99D;
	Sun, 16 Dec 2012 13:48:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8fxWF0ZiIchTtCTXrxBHQBsZSxU=; b=THwlsI
	6Gatmv2yDCvaq/hcn+oTd9vVCLkclGyeU8/fT2vIEjMyvAp+rFbkxgaE3S7OOtr5
	CaJqnJidD59/3Ztj16wy3xOR0ModbHeqIWBda0J2ZwIRBMAqykjStUvCjfQKD58h
	QdKBSUFrZL9MlnXuClWaNiVgBGtxWqnHxz/fw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EMCjJXBWa55Z3qu/UDwl6Y4nbBeXBkce
	w/UYrNjKwwUw7RW++NuW86ECqLKJ/yAPgvl08xIvZZpdFvY5NKBusiCMRJrqLoIv
	hJHgqXMvbe6YHOzp7qY+6wpIN+qXR/fTp11HkQ09iVKZf126gV4WH72/FsO15Xi1
	eHlKOnPdgjs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80974A99C;
	Sun, 16 Dec 2012 13:48:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2E0DA993; Sun, 16 Dec 2012
 13:48:47 -0500 (EST)
In-Reply-To: <20121216140029.GE2725@river.lan> (John Keeping's message of
 "Sun, 16 Dec 2012 14:00:29 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 39C808A0-47B1-11E2-A525-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211602>

John Keeping <john@keeping.me.uk> writes:

> Email addresses in documentation are converted into mailto: hyperlinks
> in the HTML output and footnotes in man pages.  This isn't desirable for
> cases where the address is used as an example and is not valid.
>
> Particularly annoying is the example "jane@laptop.(none)" which appears
> in git-shortlog(1) as "jane@laptop[1].(none)", with note 1 saying:
>
> 	1. jane@laptop
> 	   mailto:jane@laptop
>
> Fix this by escaping these email addresses with a leading backslash, to
> prevent Asciidoc expanding them as inline macros.
>
> In the case of mailmap.txt, render the address monospaced so that it
> matches the block examples surrounding that paragraph.
>
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>
> On Sun, Dec 16, 2012 at 07:04:05AM -0500, Jeff King wrote:
>> Furthermore, the right way to suppress
>> expansion of macros is with a backslash escape.
> [snipped an example]
>> I think it's a little less ugly
>> than the "$$" quoting, but not by much. No clue if one is accepted by
>> more asciidoc versions or not.
>
> From a quick reading of the Asciidoc changelog, I think backslash
> escaping should be supported just as well as "$$" quoting, which leaves
> the minimal patch looking like this.

The patch looks reasonable to me, too.  We were bitten by relying on
the description in AsciiDoc documentation (which shows the state of
their latest software) before; between the constructs that work, it
is safer to use the older, more vanilla and more common one.

Thanks.
