From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: provide a way to customize html headers
Date: Thu, 20 Oct 2011 17:37:02 -0700
Message-ID: <7vmxcv89jl.fsf@alter.siamese.dyndns.org>
References: <201110170928.56075.lenaic@lhuard.fr.eu.org>
 <201110171357.00278.jnareb@gmail.com>
 <201110210046.34679.lenaic@lhuard.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: =?utf-8?B?TMOpbmHDr2M=?= Huard <lenaic@lhuard.fr.eu.org>
X-From: git-owner@vger.kernel.org Fri Oct 21 02:37:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RH36r-00070U-GD
	for gcvg-git-2@lo.gmane.org; Fri, 21 Oct 2011 02:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752276Ab1JUAhG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 20 Oct 2011 20:37:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62847 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751980Ab1JUAhF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 20 Oct 2011 20:37:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A6A696E82;
	Thu, 20 Oct 2011 20:37:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yG82G6BJSbBJ
	FuljiOI+623kwsA=; b=Foiy6nCiBSgsUZab9nmmIc6jMMHMH/oQAG46XS7R/h5w
	wjB/zDzofDYNr21jhP9wYZbjnzZtHJTBnOXS22PsyCNQsdiou34YhHujZKcfGYyz
	/Ofb/C5hB2deC28UYZzjTo4rIApzAvAgrkkQZgCmY0ou8x/g27Q62W4w1jFHdJE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=w358Bp
	qcGGPoTDVKEkkcrvAdeYMU1HsWtFvKdL6mB5argqR93n9Pfv9D5a91BoJ1t0KPud
	zt+njnFgDmbQbqWMPbBycLiOcsNdMLX8slTay/ffF4Ox8JZ53FfedC+lc4F0Hjya
	mr6wC95Pud11FynJUfLJ7ZOtUfu0ECUc3bQx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9D9566E81;
	Thu, 20 Oct 2011 20:37:04 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 048996E80; Thu, 20 Oct 2011
 20:37:03 -0400 (EDT)
In-Reply-To: <201110210046.34679.lenaic@lhuard.fr.eu.org> (=?utf-8?B?Ikw=?=
 =?utf-8?B?w6luYcOvYw==?= Huard"'s message of "Fri, 21 Oct 2011 00:46:34
 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CC203FE2-FB7C-11E0-A6A8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184046>

L=C3=A9na=C3=AFc Huard <lenaic@lhuard.fr.eu.org> writes:

> +GITWEB_SITE_HTMLHEADER =3D
>  GITWEB_SITE_HEADER =3D
>  GITWEB_SITE_FOOTER =3D

Is it just me or does the inconsistency between the existing two variab=
les
and this new one with a very similar name stand out like a sore somethi=
ng?

It might have been better if GITWEB_SITE_(HEADER|FOOTER) were named wit=
h
"_FILE" suffix, but as long as we consider/declare insert_file is the n=
orm
and in-place inclusion of mini-string is an oddball, it is sufficient t=
o
call this GITWEB_SITE_HTML_HEAD_STRING to avoid confusion?

Perhaps GITWEB_SITE_HEADER_STRING and GITWEB_SITE_FOOTER_STRING might t=
urn
out to be useful in the future for in-place inclusion of mini-strings, =
and
when that happens, you two would thank me for this suggestion ;-)
