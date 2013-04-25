From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t9501: Do not use export X=Y
Date: Thu, 25 Apr 2013 13:46:32 -0700
Message-ID: <7va9om2v9z.fsf@alter.siamese.dyndns.org>
References: <201304252049.00811.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Apr 25 22:47:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UVT4J-0006mH-KB
	for gcvg-git-2@plane.gmane.org; Thu, 25 Apr 2013 22:47:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759217Ab3DYUqg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 25 Apr 2013 16:46:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38482 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758772Ab3DYUqf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Apr 2013 16:46:35 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2B5F019A95;
	Thu, 25 Apr 2013 20:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7o7w5wgvKARO
	DnyonZph+Yb+jT4=; b=lEVomMtwB1OdPIBmjTSOGpE/pT7sBnALOwZbALIC9y2y
	wVDKz+Agggtqg8SVpD5ctgk72R4Fdj+f1t/8Iu76gvRCRCCJSFGSzcFefCTw4nJj
	g25ZfBpbN+5Mn+mN2LRP3BbWcMFeArHro/bCxbPvFBxSdTJ/0Br0jKdLIuriOaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UzqbiO
	GwK5AoO2bTGlnnhGWWArYG1T0h40x1msHP0BFZ+FJZZvTMNnPRoQL1NWnNLGZcQ0
	PZ8uZfqbclRb+WeenEfIl1ZvvWIYfYre9qbR3nMqH5GdydAFRFkeoVHcE/Ue3rRd
	S2/ivylkTgeJKzC46beC74vo4LplhMAX0HLmM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2267819A94;
	Thu, 25 Apr 2013 20:46:35 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 41DB519A91;
	Thu, 25 Apr 2013 20:46:34 +0000 (UTC)
In-Reply-To: <201304252049.00811.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 25 Apr 2013 20:49:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 376384EC-ADE9-11E2-BD1F-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222446>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> Spilt lines like export X=3DY into 2 lines:
> X=3DY
> export X

That can be read from the patch text.

If you are going to spend three lines, please describe why it has to
be split; that would help educate developers new to the codebase.

Thanks.

> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>  t/t9501-gitweb-standalone-http-status.sh | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/t/t9501-gitweb-standalone-http-status.sh b/t/t9501-gitwe=
b-standalone-http-status.sh
> index ef86948..d3a5bac 100755
> --- a/t/t9501-gitweb-standalone-http-status.sh
> +++ b/t/t9501-gitweb-standalone-http-status.sh
> @@ -130,7 +130,8 @@ test_expect_success DATE_PARSER 'modification: fe=
ed last-modified' '
>  test_debug 'cat gitweb.headers'
> =20
>  test_expect_success DATE_PARSER 'modification: feed if-modified-sinc=
e (modified)' '
> -	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	export HTTP_IF_MODIFIED_SINCE &&
>  	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
>  	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
>  	grep "Status: 200 OK" gitweb.headers
> @@ -138,7 +139,8 @@ test_expect_success DATE_PARSER 'modification: fe=
ed if-modified-since (modified)
>  test_debug 'cat gitweb.headers'
> =20
>  test_expect_success DATE_PARSER 'modification: feed if-modified-sinc=
e (unmodified)' '
> -	export HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
> +	HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
> +	export HTTP_IF_MODIFIED_SINCE &&
>  	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
>  	gitweb_run "p=3D.git;a=3Datom;h=3Dmaster" &&
>  	grep "Status: 304 Not Modified" gitweb.headers
> @@ -153,7 +155,8 @@ test_expect_success DATE_PARSER 'modification: sn=
apshot last-modified' '
>  test_debug 'cat gitweb.headers'
> =20
>  test_expect_success DATE_PARSER 'modification: snapshot if-modified-=
since (modified)' '
> -	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	export HTTP_IF_MODIFIED_SINCE &&
>  	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
>  	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
>  	grep "Status: 200 OK" gitweb.headers
> @@ -161,7 +164,8 @@ test_expect_success DATE_PARSER 'modification: sn=
apshot if-modified-since (modif
>  test_debug 'cat gitweb.headers'
> =20
>  test_expect_success DATE_PARSER 'modification: snapshot if-modified-=
since (unmodified)' '
> -	export HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
> +	HTTP_IF_MODIFIED_SINCE=3D"Thu, 7 Apr 2005 22:14:13 +0000" &&
> +	export HTTP_IF_MODIFIED_SINCE &&
>  	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
>  	gitweb_run "p=3D.git;a=3Dsnapshot;h=3Dmaster;sf=3Dtgz" &&
>  	grep "Status: 304 Not Modified" gitweb.headers
> @@ -170,7 +174,8 @@ test_debug 'cat gitweb.headers'
> =20
>  test_expect_success DATE_PARSER 'modification: tree snapshot' '
>  	ID=3D`git rev-parse --verify HEAD^{tree}` &&
> -	export HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	HTTP_IF_MODIFIED_SINCE=3D"Wed, 6 Apr 2005 22:14:13 +0000" &&
> +	export HTTP_IF_MODIFIED_SINCE &&
>  	test_when_finished "unset HTTP_IF_MODIFIED_SINCE" &&
>  	gitweb_run "p=3D.git;a=3Dsnapshot;h=3D$ID;sf=3Dtgz" &&
>  	grep "Status: 200 OK" gitweb.headers &&
