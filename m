From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] check-builtins: Strip any executable suffix to make it work on Windows
Date: Thu, 05 Feb 2015 12:01:03 -0800
Message-ID: <xmqqa90sku0w.fsf@gitster.dls.corp.google.com>
References: <CAHGBnuNvesez_Ctvpi16vzsOZnaHiY5Fcf5+b+u0HNZ9zAyNZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, normalperson@yhbt.net,
	amyrick@apple.com
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 21:01:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YJSby-0004hK-E5
	for gcvg-git-2@plane.gmane.org; Thu, 05 Feb 2015 21:01:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880AbbBEUBJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2015 15:01:09 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60874 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751540AbbBEUBI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2015 15:01:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7B642353BA;
	Thu,  5 Feb 2015 15:01:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rMM5UFn0V2vH9eyiYwzUy0JZ04M=; b=U48Es6
	iOaC6HqmYzV8WKxiwjEo8UQKJvwD65UYFSGX0XfJzY0J/s6tpV/bYYTLORtjxyCU
	YyASazgaGMItOAORl1qR0CRTLPWHY6QNFhz9oVAkRLjxTnYU6U64NDbrRvdf5VmH
	t+cibyrC6LMZMey4uFWjQRrwJ3ZxaxWR6fL1o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hMPBIApCWQ2rKcns4tqRC6ZDw3JPHYuS
	OOYzfwFMOpv3LQ3nAfFiir5fL01Pmhk4rmlmu+LdvBe7YUlcxR6umtMGcOAWt1iK
	8UMEq1jo75eoy74UskYjdmBPGGQErWZf+K3YKnW8r2rtNE1fGwZo1zhS82CFPiOH
	c58+jGeAPeY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 716B1353B9;
	Thu,  5 Feb 2015 15:01:06 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 40CE3353B7;
	Thu,  5 Feb 2015 15:01:04 -0500 (EST)
In-Reply-To: <CAHGBnuNvesez_Ctvpi16vzsOZnaHiY5Fcf5+b+u0HNZ9zAyNZw@mail.gmail.com>
	(Sebastian Schuberth's message of "Thu, 5 Feb 2015 14:28:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: B72397BA-AD71-11E4-986F-7BA29F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263395>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>
> ---
>  check-builtins.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/check-builtins.sh b/check-builtins.sh
> index 07cff69..a0aaf3a 100755
> --- a/check-builtins.sh
> +++ b/check-builtins.sh
> @@ -3,7 +3,7 @@
>  {
>      cat <<\EOF
>  sayIt:
> -    $(foreach b,$(BUILT_INS),echo XXX $b YYY;)
> +    $(foreach b,$(BUILT_INS),echo XXX $(b:$X=) YYY;)
>  EOF

Makes sense; thanks.
