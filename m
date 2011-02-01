From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t5526: Fix wrong argument order in "git config"
Date: Tue, 01 Feb 2011 13:28:57 -0800
Message-ID: <7vk4hjzbom.fsf@alter.siamese.dyndns.org>
References: <4D46E88D.1020806@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Libor Pechacek <lpechacek@suse.cz>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Tue Feb 01 22:29:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkNnH-0005zu-Hx
	for gcvg-git-2@lo.gmane.org; Tue, 01 Feb 2011 22:29:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab1BAV3I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Feb 2011 16:29:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:52652 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751596Ab1BAV3G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Feb 2011 16:29:06 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A9D845DD;
	Tue,  1 Feb 2011 16:29:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Twh+KEG4krFX391Easv6ZQ/wz/k=; b=T56lI04J80hp+HaHj1iBFLb
	lYU13xeRd2DEEcO7Rr3FDB2jUIAOjSkVqqvIa4JiYGFuylR6p3JPvXLObUMnDrxw
	/PtO7gowpqM8ipo/rjMrOZw6tzDJheNoX2kBFoAVu0b+JXJ0+krjA21fwdlpVnp5
	M5c+PFP41WGvkck6gDjE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dflkq5gHBNh/N5AbbUfy5B6AC8R0RFxttL1Z6g5kQrssnIQG6
	8B8XCBrGGegO+MdKrJJmva+KmAzom4v6RCGdmRjV8SDIaDcO0kj3ysmC8qvCLMFR
	rxHM+Kjs5XCuk6/RiBpsDyXQq/HhYop8gPrPpmYVpgNkXh5l6RxxgL5YAE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C73A345DA;
	Tue,  1 Feb 2011 16:29:54 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A2AEE45D9; Tue,  1 Feb 2011
 16:29:50 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 69259D10-2E4A-11E0-A317-F13235C70CBC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165860>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> This fixes a typo where the "git config" arguments "-f" and "--unset" were
> swapped leading to the creation of a "--unset" file.
>
> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
> ---
>
> Now that 1.7.4 is out and somebody else already stumbled across this
> typo I introduced ...

Thanks.

>
>  t/t5526-fetch-submodules.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index 884a5e5..a5f4585 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -124,7 +124,7 @@ test_expect_success "--recurse-submodules overrides fetchRecurseSubmodules setti
>  	(
>  		cd downstream &&
>  		git fetch --recurse-submodules >../actual.out 2>../actual.err &&
> -		git config -f --unset .gitmodules submodule.submodule.fetchRecurseSubmodules true &&
> +		git config --unset -f .gitmodules submodule.submodule.fetchRecurseSubmodules &&
>  		git config --unset submodule.submodule.fetchRecurseSubmodules
>  	) &&
>  	test_cmp expect.out actual.out &&
> -- 
> 1.7.3.4.27.g3921d.dirty
