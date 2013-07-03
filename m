From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-config: update doc for --get with multiple values
Date: Wed, 03 Jul 2013 11:47:50 -0700
Message-ID: <7vd2qzfpk9.fsf@alter.siamese.dyndns.org>
References: <41dc25ceac50731a7c5da753c04b7c13c41c1b51.1372876047.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Jul 03 20:48:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuS61-0004L1-Ip
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 20:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933345Ab3GCSr6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 14:47:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51541 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933155Ab3GCSr4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 14:47:56 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 711CD2D0F4;
	Wed,  3 Jul 2013 18:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UrLLvyRCFC5KYZhGTd7RfLEPG9Y=; b=gaOu3D
	4+MX9IS6RJDM5POHKrTgpP8+bbsCLam/rSQ10cs8PwckNgSVSthwhCSdRQtSwa3W
	W+mdMxBkAyZA6iLoDeLf8QECdkYBoF7VMxEctFzmYI3nk8sz0aID89XGnTiYsuRB
	B96mukt1Z/kbR/vUZRQ7Gu3U2EM2uNcHPkqRs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qJUjWPGgGyWN+6w75gEuDkOIMCcGJ03+
	kQiP3QH9WGJMQMAv0LcfFpmMKGwQLb3SMVJZEF/3USghkOSYIc5vJpZPCDFvG+B/
	wgGwiOP3zxd2DAA0S6oLgCYrAI2NMMa5Cixx4EhcdgA2jQJDWshtjXFBRpNiyoK2
	vkFTWXQQaXQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58BF12D0F3;
	Wed,  3 Jul 2013 18:47:54 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2F992D0F0;
	Wed,  3 Jul 2013 18:47:52 +0000 (UTC)
In-Reply-To: <41dc25ceac50731a7c5da753c04b7c13c41c1b51.1372876047.git.john@keeping.me.uk>
	(John Keeping's message of "Wed, 3 Jul 2013 19:27:39 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 11559386-E411-11E2-ACEF-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229510>

John Keeping <john@keeping.me.uk> writes:

> Since commit 00b347d (git-config: do not complain about duplicate
> entries, 2012-10-23), "git config --get" does not exit with an error if
> there are multiple values for the specified key but instead returns the
> last value.  Update the documentation to reflect this.
>
> Signed-off-by: John Keeping <john@keeping.me.uk>
> ---
>  Documentation/git-config.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index 19a7be0..fbad05e 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -82,7 +82,7 @@ OPTIONS
>  --get::
>  	Get the value for a given key (optionally filtered by a regex
>  	matching the value). Returns error code 1 if the key was not
> -	found and error code 2 if multiple key values were found.
> +	found and the last value if multiple key values were found.
>  
>  --get-all::
>  	Like get, but does not fail if the number of values for the key

Thanks.

I wondered if we should explain the significance of "last" a bit
more (like "this results in the value from the most specific
configuration file to be used, the ones in $GIT_DIR/config
overriding what is in $HOME/.gitconfig"), but I do not have a strong
opinion either way.  Let's queue this for 'maint' for now.
