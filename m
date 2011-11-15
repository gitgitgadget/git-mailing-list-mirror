From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] documentation fix: git difftool uses diff tools, not
 merge tools.
Date: Mon, 14 Nov 2011 16:20:56 -0800
Message-ID: <7v62imi6c7.fsf@alter.siamese.dyndns.org>
References: <1321311352-8950-1-git-send-email-thh@inter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: Thomas Hochstein <thh@inter.net>
X-From: git-owner@vger.kernel.org Tue Nov 15 01:21:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ6lu-0007Pw-He
	for gcvg-git-2@lo.gmane.org; Tue, 15 Nov 2011 01:21:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752253Ab1KOAVA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 19:21:00 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751808Ab1KOAU7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 19:20:59 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7DB0558F;
	Mon, 14 Nov 2011 19:20:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DeuhtYDO+rsrrNUcwEM6bNpeHmc=; b=shwmnh
	5K2CSqvBKqeZZN8GliXJXMvYQTJHHldTxhxsTJO57tJczCgmEN/ONOuCzoXJrZdo
	Gni4Bdp4npBixyCnEKPWlPdQDf9lA+6hJZDZw0EBChiNfTJmLVwCz2ezYpQ7fO/z
	wz9ozVKXbbtYgLgAmY6JUBeoUR8avl2gWQLFk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GfzKTHlqfdxkE1ZqDwLySavFO5ViHKMl
	um4BRqdGRfZjbMhL8OQo/PWaDludiszTRbAd0lUFdTSsdy+WGd7g/cUNj8XUbtNT
	lzOEzxRX56xJnDQSEQpexYMm3/bGsA7/Tg7nfmgq1rkWWWYWgXOLAuV5nuyIkgOw
	J7J20Eant9k=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF5A5558E;
	Mon, 14 Nov 2011 19:20:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1E842558D; Mon, 14 Nov 2011
 19:20:58 -0500 (EST)
In-Reply-To: <1321311352-8950-1-git-send-email-thh@inter.net> (Thomas
 Hochstein's message of "Mon, 14 Nov 2011 23:55:52 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B0BC4776-0F1F-11E1-BDA8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185419>

Thomas Hochstein <thh@inter.net> writes:

> Let the documentation for -t list valid *diff* tools,
> not valid *merge* tools.
>
> Signed-off-by: Thomas Hochstein <thh@inter.net>
> ---
>  Documentation/git-difftool.txt |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
> index a03515f..19d473c 100644
> --- a/Documentation/git-difftool.txt
> +++ b/Documentation/git-difftool.txt
> @@ -31,7 +31,7 @@ OPTIONS
>  -t <tool>::
>  --tool=<tool>::
>  	Use the diff tool specified by <tool>.
> -	Valid merge tools are:
> +	Valid diff tools are:
>  	araxis, bc3, diffuse, emerge, ecmerge, gvimdiff, kdiff3,
>  	kompare, meld, opendiff, p4merge, tkdiff, vimdiff and xxdiff.
>  +

The patch is obviously correct, and it is so trivial that there is no risk
of breaking anything. It would even be OK for 1.7.7.X maintenance series.

But in the longer term, I suspect that we would want to drop this
enumeration from the documentation, and instead give "--list-tools"
option or something to the command. That way, we only need to keep
the list of known tools in one place where it matters, namely, the
command that knows about them.

David, what do you think?

The same comment applies to "git mergetool", I would think.
