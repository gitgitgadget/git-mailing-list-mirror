From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t0050: mark TC merge (case change) as success
Date: Sun, 13 Jan 2013 15:24:49 -0800
Message-ID: <7v7gnghdj2.fsf@alter.siamese.dyndns.org>
References: <201301132138.37154.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 14 00:25:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TuWvQ-0000XV-Ko
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jan 2013 00:25:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756180Ab3AMXYw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Jan 2013 18:24:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37642 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754688Ab3AMXYv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 13 Jan 2013 18:24:51 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3890FAF8E;
	Sun, 13 Jan 2013 18:24:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=fwaPdA3UtWUn
	ZFb8vvxvGUhLHzY=; b=DZN7hWIoWX+MYVwlEGiD1S/d1UV7vmRFKRYRjBpl3Dko
	SNaK7wUCTi+vmEGdnGT5akt9lT5rIfjFn7g9099z3Eiwu3cwt30XYYN05RqZk0mf
	e5nluWqIFgWrwvPZcKBv9lCNPUsywC4XOOZ6CTdpG/gqdAuH+G3AamY9YAM//Oc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u6eDg2
	uQrIv3I1Np2cu9gRmjUB3VeL836f/vpE9tKYFJika1qVCARfRwj7KznVR2TlBLDg
	7/bH+wbhlzVjEojbYyMcyjCEqpCV1bB4ogJNTuEuw3yLwdKT3Ae18FpBz4++5lYW
	SwwW7tzExnree18vEggmgnHofWH04YVzlLnHg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D840AF8D;
	Sun, 13 Jan 2013 18:24:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B3F51AF8C; Sun, 13 Jan 2013
 18:24:50 -0500 (EST)
In-Reply-To: <201301132138.37154.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?= message of "Sun, 13 Jan 2013 21:38:36
 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6D9684D0-5DD8-11E2-9A36-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213409>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> The test "merge (case change)" passes on a case ignoring file system
>
> Use test_expect_success to remove the "known breakage vanished"
>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---

Interesting.  When did this change?  Do you happen to have a
bisection?  Or did the test pass from the very beginning?

>  t/t0050-filesystem.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
> index 78816d9..ccd685d 100755
> --- a/t/t0050-filesystem.sh
> +++ b/t/t0050-filesystem.sh
> @@ -77,7 +77,7 @@ $test_case 'rename (case change)' '
> =20
>  '
> =20
> -$test_case 'merge (case change)' '
> +test_expect_success 'merge (case change)' '
> =20
>  	rm -f CamelCase &&
>  	rm -f camelcase &&
