From: =?UTF-8?Q?J=C3=B6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH] Use perl instead of tac
Date: Mon, 28 Apr 2008 11:46:29 +0000 (UTC)
Message-ID: <slrng1be8l.25r.joerg@alea.gnuu.de>
References: <8D73338C-4EC3-4078-8A34-51DAC1842C2B@silverinsanity.com>
 <20080427064250.GA5455@sigill.intra.peff.net>
 <739FA851-F7F5-4CF9-B384-25AA7022B0C2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 28 14:53:21 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqSqp-0001jP-ME
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 14:53:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934030AbYD1MwL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Apr 2008 08:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934015AbYD1MwL
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 08:52:11 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:4894 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933941AbYD1MwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 08:52:09 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id ACB4A488034; Mon, 28 Apr 2008 14:52:07 +0200 (CEST)
Received: from news by alea.gnuu.de with local (Exim 4.63)
	(envelope-from <news@alea.gnuu.de>)
	id 1JqRoU-000406-14
	for git@vger.kernel.org; Mon, 28 Apr 2008 13:46:30 +0200
Path: not-for-mail
Newsgroups: local.mailinglist.git
X-Trace: alea.gnuu.de 1209383189 15374 192.168.0.5 (28 Apr 2008 11:46:29 GMT)
X-Complaints-To: usenet@alea.gnuu.de
User-Agent: slrn/pre0.9.9-102 (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80528>

Hi,

Brian Gernhardt <benji@silverinsanity.com> wrote:
> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 1751b08..303b754 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -469,7 +469,7 @@ create_extended_todo_list () {
>   	test -n "${last_parent:-}" -a "${last_parent:-}" !=3D $SHORTUPSTRE=
AM =20
> && \
>   		echo reset $last_parent
>   	) | \
> -	tac | \
> +	perl -e 'print reverse <>' | \

What about using a shell function and a *big* variable or an intermedia=
te
file?

tac()
{
	while read line
	do
		reversed=3D"$line
$reversed"
	done
	echo "${reversed%
}"
}

Bye, J=C3=B6rg.
--=20
Ich halte ihn zwar f=C3=BCr einen Schurken und das was er sagt f=C3=BCr
falsch =E2=80=93 aber ich bin bereit mein Leben daf=C3=BCr einzusetzen,=
 da=C3=9F
er seine Meinung sagen kann.		(Voletair)
