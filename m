From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Fix: wrong offset for CET timezone
Date: Fri, 27 Jun 2014 00:08:52 +0200 (CEST)
Message-ID: <166360487.125996.1403820532765.JavaMail.zimbra@dewire.com>
References: <1403790812-29174-1-git-send-email-mailing@franzoni.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Alan Franzoni <username@franzoni.eu>
To: Alan Franzoni <mailing@franzoni.eu>
X-From: git-owner@vger.kernel.org Fri Jun 27 00:15:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0HxR-0007H7-P9
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 00:15:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751406AbaFZWPu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 26 Jun 2014 18:15:50 -0400
Received: from zimbra.dewire.com ([83.140.172.131]:57685 "EHLO
	zimbra.dewire.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233AbaFZWPt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jun 2014 18:15:49 -0400
X-Greylist: delayed 409 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Jun 2014 18:15:49 EDT
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 85C9C8157A;
	Fri, 27 Jun 2014 00:08:58 +0200 (CEST)
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id qfZN8awJB1SQ; Fri, 27 Jun 2014 00:08:54 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.dewire.com (Postfix) with ESMTP id 74B458164E;
	Fri, 27 Jun 2014 00:08:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at dewire.se
Received: from zimbra.dewire.com ([127.0.0.1])
	by localhost (zimbra.dewire.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id eHe-mnGEeJce; Fri, 27 Jun 2014 00:08:53 +0200 (CEST)
Received: from zimbra.dewire.com (zimbra.dewire.com [10.1.2.96])
	by zimbra.dewire.com (Postfix) with ESMTP id 6870D8157A;
	Fri, 27 Jun 2014 00:08:53 +0200 (CEST)
In-Reply-To: <1403790812-29174-1-git-send-email-mailing@franzoni.eu>
X-Originating-IP: [78.69.107.197]
X-Mailer: Zimbra 8.0.7_GA_6020 (ZimbraWebClient - FF30 (Mac)/8.0.7_GA_6020)
Thread-Topic: wrong offset for CET timezone
Thread-Index: uO5YmyI4SyBSEIUf8KD3fqSw8lnCCg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252529>



----- Ursprungligt meddelande -----
> Fr=C3=A5n: "Alan Franzoni" <mailing@franzoni.eu>
> Till: git@vger.kernel.org
> Kopia: "Alan Franzoni" <username@franzoni.eu>
> Skickat: torsdag, 26 jun 2014 15:53:32
> =C3=84mne: [PATCH] Fix: wrong offset for CET timezone
>=20
> From: Alan Franzoni <username@franzoni.eu>
>=20
> Signed-off-by: Alan Franzoni <username@franzoni.eu>
> ---
>  Documentation/date-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/date-formats.txt b/Documentation/date-form=
ats.txt
> index ccd1fc8..284308a 100644
> --- a/Documentation/date-formats.txt
> +++ b/Documentation/date-formats.txt
> @@ -11,7 +11,7 @@ Git internal format::
>  	It is `<unix timestamp> <time zone offset>`, where `<unix
>  	timestamp>` is the number of seconds since the UNIX epoch.
>  	`<time zone offset>` is a positive or negative offset from UTC.
> -	For example CET (which is 2 hours ahead UTC) is `+0200`.
> +	For example CET (which is 1 hour ahead UTC) is `+0100`.

1 hour in winter and 2 in summer, although some standards seem to say
that summer time is really called CEST, computers apply DST to CET in s=
ummer.

$ TZ=3DUTC date
Tor 26 Jun 2014 22:08:01 UTC

$ TZ=3DCET date
=46re 27 Jun 2014 00:08:05 CEST

-- robin
=20
>  RFC 2822::
>  	The standard email format as described by RFC 2822, for example
> --
> 2.0.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
