From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v1 1/1] t5601: Remove trailing space in sed expression
Date: Mon, 09 May 2016 11:38:16 -0700
Message-ID: <xmqqd1ovulev.fsf@gitster.mtv.corp.google.com>
References: <CALR6jEhTTo-6fgy3_TnGseXJr2OZM+cK+t4BCVEzpCZNfhn5Bg@mail.gmail.com>
	<1462816392-29561-1-git-send-email-tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, megabreit@googlemail.com
To: tboegi@web.de
X-From: git-owner@vger.kernel.org Mon May 09 20:38:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azq4W-0005Wo-0M
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 20:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbcEISiU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 May 2016 14:38:20 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751352AbcEISiT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2016 14:38:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2A7ED18C22;
	Mon,  9 May 2016 14:38:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=eN5D2k1tnaDa
	F7nCizYAFENf4j8=; b=qDWLEQoipi/BaTLJFiwkTC70N758eSJYl1cQq43w3KUD
	vBb5bSIT47yZJRI+G5Hrg61PoOA/T3PUEtr6SNCYwaRddQbvaBDVfZ0uGeG+rUXL
	pH5T13+PvppZC9FBnR2/XU2KywHKdwy+A583nQZ4gRBFucpjcjOyyqtwZlbdk5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=AAxrDe
	EQtM/k0gWG30MYyPaNcYnufUh91pJOWXoHoSPE1YhpaTxWvaueF8zlOg8POai63C
	rgYfRFSr3z6Ke2yig8ur8Q5Scm6tQyr3TujIg/XboBBGokWbodNYL3469ziUy4O2
	tjvsbIIGEpkaQlhyceqQd+pilJaX7qmYw9rEo=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 21F6D18C20;
	Mon,  9 May 2016 14:38:18 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9AE5018C1E;
	Mon,  9 May 2016 14:38:17 -0400 (EDT)
In-Reply-To: <1462816392-29561-1-git-send-email-tboegi@web.de>
	(tboegi@web.de's message of "Mon, 9 May 2016 19:53:12 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 325D4B3A-1615-11E6-83D1-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294037>

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> The sed expression for IPv6, "Tested User And Host" or "tuah" used a =
wrong
> sed expression, which doesn't work under all versions of sed.
>
> Reported-By: Armin Kunaschik <megabreit@googlemail.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Good.  Thanks.

>  t/t5601-clone.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 150aeaf..a433394 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -466,7 +466,7 @@ test_expect_success 'clone ssh://host.xz:22/~repo=
' '
>  #IPv6
>  for tuah in ::1 [::1] [::1]: user@::1 user@[::1] user@[::1]: [user@:=
:1] [user@::1]:
>  do
> -	ehost=3D$(echo $tuah | sed -e "s/1]:/1]/ "| tr -d "[]")
> +	ehost=3D$(echo $tuah | sed -e "s/1]:/1]/" | tr -d "[]")
>  	test_expect_success "clone ssh://$tuah/home/user/repo" "
>  	  test_clone_url ssh://$tuah/home/user/repo $ehost /home/user/repo
>  	"
