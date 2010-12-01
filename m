From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] status: show branchname with a configurable color
Date: Wed, 01 Dec 2010 14:06:27 -0800
Message-ID: <7vlj49tafw.fsf@alter.siamese.dyndns.org>
References: <1290037205-19470-1-git-send-email-aga@iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: aga@iki.fi
X-From: git-owner@vger.kernel.org Wed Dec 01 23:06:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNup0-0005IQ-65
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 23:06:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755768Ab0LAWGh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 17:06:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:60527 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755650Ab0LAWGg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 17:06:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 87AA2210B;
	Wed,  1 Dec 2010 17:06:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=+6AJl+S8oYw2Z+KnCiBD81g49XE=; b=JZUvYPv8cw1thnbFBC2Lfp3
	j05P/xb4zB6wV3RQWapBA+2XdpTkEieVvFAOU+So5G/wk7c6DgJbUeEtaiUnmExL
	eiegWeyDi1uK4IyNc1ugc/8wdR7KNAT8vml+Y0cRCP4R2Uik2mLURsCpkmNjJQgf
	UZS2Go12G/5gs7NkSSV4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dhJMdEnOMyJY9E7mfAYBThs+tnfLUqEOoCQGS6cM0/ZZrLha+
	DUu4h9aTJgOK5F073d6tGXEwDYy9j82TmdFNtmW+BApPdo5Nke8LGeQAjde4wzN6
	iGT5M/+cr0T5uFdpHsNcLKP9IsxX2IIUXDu8vCXYVjgRoDVwk2jJ/XHmu0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 654692108;
	Wed,  1 Dec 2010 17:06:51 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 71DDD2107; Wed,  1 Dec 2010
 17:06:48 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4CBD3F9A-FD97-11DF-9CD2-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162622>

aga@iki.fi writes:

>  color.status.<slot>::
> -	Use customized color for status colorization. `<slot>` is
> -	one of `header` (the header text of the status message),
> -	`added` or `updated` (files which are added but not committed),
> -	`changed` (files which are changed but not added in the index),
> -	`untracked` (files which are not tracked by git), or
> -	`nobranch` (the color the 'no branch' warning is shown in, defaulting
> -	to red). The values of these variables may be specified as in
> -	color.branch.<slot>.
> +	Use customized color for status colorization. `<slot>` is one of
> +	`header` (the header text of the status message), `added` or `updated`
> +	(files which are added but not committed), `changed` (files which
> +	are changed but not added in the index), `untracked` (files which
> +	are not tracked by git), `branch` (the current branch) or `nobranch`
> +	(the color the 'no branch' warning is shown in, defaulting to red). The
> +	values of these variables may be specified as in color.branch.<slot>.

Yuck.  Why did you have to re-wrap the paragraph to make diff unreadable?

It also is customary to make the default plain, so that existing users
won't suddenly get a new and funky behaviour.

I'll queue with a slight rearrangement.

Thanks.
