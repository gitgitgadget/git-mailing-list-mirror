From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] instaweb: ignore GITWEB_CONFIG_SYSTEM
Date: Fri, 03 Sep 2010 10:23:49 -0700
Message-ID: <7vfwxqzqoq.fsf@alter.siamese.dyndns.org>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino> <20100902223624.GA9613@dcvr.yhbt.net>
 <20100902235237.GA6466@burratino> <20100902235429.GB6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 03 19:24:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrZzo-0004SS-W8
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 19:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756712Ab0ICRYH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Sep 2010 13:24:07 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:38142 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756648Ab0ICRYF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Sep 2010 13:24:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1A4DFD325B;
	Fri,  3 Sep 2010 13:24:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Gmp/lyrsVKqD
	QOT6xo6fFHDjvHk=; b=Tuw5WF4NyfoDu4TNWnT4Dgr+exz0PqQkBOfdvkOwRCke
	ozY4v5/uEEAa+IYyE79ssIiOG41MNH57ypkyPzFUAg5jKtVtBv3AP5rasmevqRtM
	dgnqYdMkQw3wwfXFiA9QmlT7fZxCJZcRvgWFl1FmZpob4/rFkOFgZCl6x5IydCM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=UZBG6f
	T997FQ2RtQYPjaSCkwcCU/vDrv2h8FiPtwBQ+oXNUBAoB41vIz78sLriA1ec925O
	m/hEHfaGVlcw5DHu9aLbfa8y83/bisBnlvkWVD54CePfer1dn2lyTCmUUGJtTpqB
	qISRZ8+Aj+m4yv2jK4LCxe+wPWRG7WyQrKUM8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 79DDDD3256;
	Fri,  3 Sep 2010 13:23:58 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 57D9FD324E; Fri,  3 Sep
 2010 13:23:51 -0400 (EDT)
In-Reply-To: <20100902235429.GB6466@burratino> (Jonathan Nieder's message of
 "Thu\, 2 Sep 2010 18\:54\:29 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 0955DEF4-B780-11DF-A128-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155254>

Jonathan Nieder <jrnieder@gmail.com> writes:

> The configuration in /etc/gitweb.conf might specify any old
> layout; in particular, it is likely not to be identical to that
> which git instaweb sets up.  Noticed by Uwe Kleine-K=C3=B6nig.

I am not sure if this is a reasonable change by reading the above.  In
some cases, the file may stale, but in other cases, it may specify what
the site administrator wants its users to be using, no?

>
> Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> Cc: Eric Wong <normalperson@yhbt.net>
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
>  git-instaweb.sh |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/git-instaweb.sh b/git-instaweb.sh
> index f608014..6279f4d 100755
> --- a/git-instaweb.sh
> +++ b/git-instaweb.sh
> @@ -375,7 +375,8 @@ script=3D'
>  s#^(my|our) \$projectroot =3D.*#$1 \$projectroot =3D "'$(dirname "$f=
qgitdir")'";#;
>  s#(my|our) \$gitbin =3D.*#$1 \$gitbin =3D "'$GIT_EXEC_PATH'";#;
>  s#(my|our) \$projects_list =3D.*#$1 \$projects_list =3D \$projectroo=
t;#;
> -s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tmp=
'";#;'
> +s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tmp=
'";#;
> +s#(my|our) \$GITWEB_CONFIG_SYSTEM =3D.*#$1 \$GITWEB_CONFIG_SYSTEM =3D=
 "";#;'

Perhaps moving the last ' to its own line would help maintaining the
script in the longer term?

> =20
>  gitweb_cgi () {
>  	cat > "$1.tmp" <<\EOFGITWEB
> --=20
> 1.7.2.2
