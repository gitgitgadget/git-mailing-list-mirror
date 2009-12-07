From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git config does not reuse section name
Date: Mon, 07 Dec 2009 12:04:52 -0800
Message-ID: <7vy6le35zv.fsf@alter.siamese.dyndns.org>
References: <4B1D360B.4070203@ubicom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Yakup Akbay <yakbay@ubicom.com>
X-From: git-owner@vger.kernel.org Mon Dec 07 21:05:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHjpf-00067Y-QB
	for gcvg-git-2@lo.gmane.org; Mon, 07 Dec 2009 21:05:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758839AbZLGUE6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 15:04:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758817AbZLGUE5
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 15:04:57 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44144 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758783AbZLGUE4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 15:04:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 83FB686626;
	Mon,  7 Dec 2009 15:05:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MNtrRklW/VDPCg6r80MV9z60UWA=; b=pssk11
	qhViA0Nfvnlk74y2oONO22b1PBr2LeUYeKheKZENMCQzhI9xvINsTfXCs1e0CgB+
	Gmi2z5lAQhbVJj44elED9m7EcY2udycbbtbQ5ceRPlIGwuElyWDmc1I4ZbpkqxYJ
	GjrcDaXy6MclQPiTrsMo2irvWx+ChscZu+qmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oSl2ij18lHq20rv3Sl/Cr7liyH4uZMuW
	0WtlqbEKDOFvVCjilE1LrjzUbizJVtzOBRnVU5ij2NnX+OyaOJsYyAuxvU9ns717
	0GUOu4+Mppigekty/Esenbt3t/mT761PE3tiKd9/Xm8AUIhvxPK4Dt08ssGElmbw
	IzgnWigZdXQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id CA88D86624;
	Mon,  7 Dec 2009 15:04:58 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9804C86623; Mon,  7 Dec
 2009 15:04:54 -0500 (EST)
In-Reply-To: <4B1D360B.4070203@ubicom.com> (Yakup Akbay's message of "Mon\,
 07 Dec 2009 19\:06\:19 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CBCD8D04-E36B-11DE-9918-9F3FEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134774>

Yakup Akbay <yakbay@ubicom.com> writes:

> When I repeat the following n times
>
>    $ git config color.ui always
>    $ git config --unset color.ui
>
>
> it ends up the section name [color] n times in the .git/config file.
>
>
>
> like this for n=4:
>
>    [color]
>    [color]
>    [color]
>    [color]
>
>
> Using git version 1.6.5.3 (I don't know whether this is already fixed
> in in later versions)

If I recall correctly, this hasn't been even noticed/reported/recognized
as an issue, ever since the "git repo-config" was introduced (which later
was renamed to "git config").  Dscho, do you remember details?
