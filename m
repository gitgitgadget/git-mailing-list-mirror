From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v11 1/4] test-parse-options: print quiet as integer
Date: Thu, 31 Mar 2016 11:19:59 -0700
Message-ID: <xmqqegaqo6gg.fsf@gitster.mtv.corp.google.com>
References: <01020153b478cf07-758c7f14-33a1-4a67-9bc9-4688de3d6742-000000@eu-west-1.amazonses.com>
	<01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 20:20:16 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alhCY-0008En-23
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 20:20:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757714AbcCaSUH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2016 14:20:07 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:60804 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751703AbcCaSUF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 14:20:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EAB7652AC7;
	Thu, 31 Mar 2016 14:20:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5Z7XZmEBJAQ98gtt4cxweBI28AQ=; b=onPSjZ
	wEQU/a/cGZBpKLSZHyP5mFVSGMhscnWF15mdG8uUqbIdsgCCY7XGSk08+wkxmnFD
	9Rm3JTeM5OgvkHtEdjI93Gfl1kwxSEmZSniENzn2CE0+toECuE8RaWAJqzSSwi5+
	q1iPl5VgIYclLX9pa4/HE3C9zY4jv6Snh1KdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UnzToZ4C6fDHj26lHTUHrqKK6P5vj8LH
	U/gyCeiHH5Iw7TBPKUiAe3AqUMMUViDBC7h0P9iwSTk4HYol6yRJmCztFUa5V5o4
	hASQTVPYDV4jkScvE179ciDCR1tBsYvGHja2rI+uwGFmbtZfNLjPFXT7kuoJMjee
	ucj4ydIgjI0=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B44F552AC4;
	Thu, 31 Mar 2016 14:20:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A86C952AB9;
	Thu, 31 Mar 2016 14:20:01 -0400 (EDT)
In-Reply-To: <01020153cd2340f8-4665cd5f-cd5c-41ab-a162-20acc43ca52e-000000@eu-west-1.amazonses.com>
	(Pranit Bauva's message of "Thu, 31 Mar 2016 14:45:53 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 2F122598-F76D-11E5-91D8-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290439>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> Current implementation of parse-options.c treats OPT__QUIET() as integer
> and not boolean and thus it is more appropriate to print it as integer
> to avoid confusion.
>
> While at it, fix some style issues.

I counted the changes in t0040 and you have _more_ style fixes than
the real change.  That is not "while at it".

While I welcome the style fix, it is better done as a preparatory
clean-up step before the real change.

> ---

Missing sign-off.

> -cat > typo.err << EOF
> +cat >typo.err <<EOF
>  error: did you mean \`--boolean\` (with two dashes ?)
>  EOF

If your "style cleanup" patch were separate, you could fix this (and
other that have backslash escape inside the here-document) further
to something like this:

	cat >type.err <<\EOF
	error: did you mean `--boolean` (with two dashes ?)
        EOF

Thanks.
