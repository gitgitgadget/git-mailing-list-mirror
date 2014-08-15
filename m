From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git on Mac OS X 10.4.10
Date: Fri, 15 Aug 2014 09:29:46 -0700
Message-ID: <xmqqlhqp1zt1.fsf@gitster.dls.corp.google.com>
References: <53ECA7DB.7060407@jump-ing.de> <53ECCA14.40900@web.de>
	<53ED0257.3070505@jump-ing.de>
	<xmqqppg21wyk.fsf@gitster.dls.corp.google.com>
	<273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Hitter <mah@jump-ing.de>, git@vger.kernel.org
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 18:30:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIKOa-0002xe-MP
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 18:30:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbaHOQ36 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2014 12:29:58 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64607 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751499AbaHOQ35 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2014 12:29:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8B6122FE8B;
	Fri, 15 Aug 2014 12:29:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eRi6i7D4ti/yMSJ6Jt9hoIJxEjY=; b=GU8JKg
	/Jl8Or8eGWzyGNKkXbGvqY7TQ6MqFnuKM3XroQD9uFqhqaMu97TsILToWWJ9vrF5
	H0Yn/GmraUwNL98PfJgbWNj6pxwuphppjc/TSQQhONbGgjsbSnTpL+EhYQ7eI6NK
	QlKbqhGpucm/3sc02x2t+fPN8hH8amSBjIAG0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QnbKMF8CAOCJznJezPn1vwp/rfuB7nJp
	cGBtyCrL5t/07GbTov9B5gaqcM7LbeEnThTlVGF3ahP9ym/mP9saLR9ZCKcbcF0e
	NDnr1/7ASeibOg3Mudw5v/Djo6ZAZn2R69zqpMR4Jgkw1fQ5pYFZUhfvAa/HKOaT
	MEMgU9s6E8Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 812512FE8A;
	Fri, 15 Aug 2014 12:29:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 39B1C2FE76;
	Fri, 15 Aug 2014 12:29:48 -0400 (EDT)
In-Reply-To: <273241271546c07e692ae93774993f5@74d39fa044aa309eaea14b9f57fe79c>
	(Kyle J. McKay's message of "Fri, 15 Aug 2014 00:46:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5FB8B3A4-2499-11E4-8D30-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255293>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> On Aug 14, 2014, at 16:18, Junio C Hamano wrote:
>
>> Markus Hitter <mah@jump-ing.de> writes:
>>
>>>> The  <CommonCrypto/CommonHMAC.h> is in Mac OS X 10.6 .. 10.9,
>>>> but not in 10.4 (I don't know about 10.5).
>
> That header is new with 10.5
>
>> Is this about platform dependency, or what the end user happens to
>> choose to install (in other words, is there an add-on users of 10.4
>> can choose to add, which allows them to use that header)?
>
> Nope, it's a platform dependency.  Not available prior to 10.5.
>
> The below patch does the right thing.  Conveniently there's already
> a test for 10.4 and earlier so only a single line need be added.
>
> --Kyle

Nice.  Use of APPLE_COMMON_CRYPTO thing is not new to the upcoming
release, so let me queue it for the next development cycle, not
applying directly before curring 2.1 release today.

Thanks.


>
> ---- 8< ----
> Subject: [PATCH] config.mak.uname: set NO_APPLE_COMMON_CRYPTO on older systems
>
> Older MacOS systems prior to 10.5 do not have the CommonCrypto
> support Git uses so set NO_APPLE_COMMON_CRYPTO on those systems.
>
> Signed-off-by: Kyle J. McKay <mackyle@gmail.com>
> ---
>  config.mak.uname | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/config.mak.uname b/config.mak.uname
> index 7846bd76..f8e12c96 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -88,6 +88,7 @@ ifeq ($(uname_S),Darwin)
>  	NEEDS_LIBICONV = YesPlease
>  	ifeq ($(shell expr "$(uname_R)" : '[15678]\.'),2)
>  		OLD_ICONV = UnfortunatelyYes
> +		NO_APPLE_COMMON_CRYPTO = YesPlease
>  	endif
>  	ifeq ($(shell expr "$(uname_R)" : '[15]\.'),2)
>  		NO_STRLCPY = YesPlease
