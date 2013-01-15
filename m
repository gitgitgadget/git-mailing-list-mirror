From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] test-lib.sh: unfilter GIT_PERF_*
Date: Tue, 15 Jan 2013 11:31:50 -0800
Message-ID: <7vsj622qft.fsf@alter.siamese.dyndns.org>
References: <1358254409-15187-1-git-send-email-pclouds@gmail.com>
 <1358257856-3274-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 15 20:32:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvCF4-00048b-73
	for gcvg-git-2@plane.gmane.org; Tue, 15 Jan 2013 20:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab3AOTby convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 15 Jan 2013 14:31:54 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37481 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698Ab3AOTbx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Jan 2013 14:31:53 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0006EADCC;
	Tue, 15 Jan 2013 14:31:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=G+Ll0oxL3w7u
	GMYQh5LPoAEg10s=; b=bj2r0+FUFVUHiasJ07ZmajMJsxyLLi2ChiWlCkn+pQZt
	6qJduxJpeiFPCMtKGNgwt3AdGjfRB50RIWtkvTNQlK0UMrgpf4aAYfbi/AlYCtHx
	zj1kOcevFNRknRp6JWE4iqIhKg/r2PEleeIlnXcEHEuaw+M5LjQlD2MQNYEuWvs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=riPkFj
	INRcu29MVhFhl3h09P8Rdhsa3MZbtfE/PludvdYZXpwr+Al4ThnMNmMbj0DajyQ3
	tsPdcf4P6AroCUBEixbeHIwOxLqBxCWPEFYKWil4/DvVvBwt9+XIeWAPrdSOMnPN
	CvRI+1DJ2cKScdWnTmEV2IgomuvoQWTolu2ww=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E869CADCB;
	Tue, 15 Jan 2013 14:31:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 50BE9ADC9; Tue, 15 Jan 2013
 14:31:52 -0500 (EST)
In-Reply-To: <1358257856-3274-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 15 Jan
 2013 20:50:56 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 36A2A27E-5F4A-11E2-AB8F-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213666>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> These variables are user parameters to control how to run the perf
> tests. Allow users to do so.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

I think the Subject makes more sense, so I'd suggest replacing the
current one with "PERF_", not with "PERF".

>  t/test-lib.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f50f834..e1c8c85 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -85,7 +85,7 @@ unset VISUAL EMAIL LANGUAGE COLUMNS $("$PERL_PATH" =
-e '
>  		.*_TEST
>  		PROVE
>  		VALGRIND
> -		PERF_AGGREGATING_LATER
> +		PERF
>  	));
>  	my @vars =3D grep(/^GIT_/ && !/^GIT_($ok)/o, @env);
>  	print join("\n", @vars);
