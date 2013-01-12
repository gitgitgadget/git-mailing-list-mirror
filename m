From: Modestas Vainius <modestas@vainius.eu>
Subject: Re: [PATCH] Support FTP-over-SSL/TLS for regular FTP
Date: Sat, 12 Jan 2013 16:51:46 +0200
Message-ID: <7057807.F3QETssImX@mdxdesktop>
References: <1357999192-877-1-git-send-email-modestas@vainius.eu> <20130112142521.GA21639@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Jan 12 15:52:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tu2RV-00028W-Ek
	for gcvg-git-2@plane.gmane.org; Sat, 12 Jan 2013 15:52:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab3ALOv5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Jan 2013 09:51:57 -0500
Received: from smtp-q8.skynet.lt ([212.122.94.187]:54953 "EHLO
	smtp-q3.skynet.lt" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753616Ab3ALOv5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Jan 2013 09:51:57 -0500
Received: from nd1.smtpcl1.5ci.lt (nd1.smtpcl1.5ci.lt [212.122.94.182])
	by smtp-q3.skynet.lt (Postfix) with ESMTP id C4C0361E6BC;
	Sat, 12 Jan 2013 16:51:42 +0200 (EET)
Received: from [127.0.0.1] (helo=localhost)
	by nd1.smtpcl1.5ci.lt with esmtp (Exim 4.77)
	(envelope-from <modestas@vainius.eu>)
	id 1Tu2R2-0006IS-9G; Sat, 12 Jan 2013 16:51:48 +0200
X-Spam-Flag: NO
X-Spam-Score: 1.274
X-Spam-Level: *
X-Spam-Status: No, score=1.274 required=8 tests=[RDNS_NONE=1.274]
	autolearn=disabled
Received: from nd1.smtpcl1.5ci.lt ([127.0.0.1])
	by localhost (nd1.smtpcl1.5ci.lt [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2UEj1SliL2Lo; Sat, 12 Jan 2013 16:51:42 +0200 (EET)
Received: from [84.240.22.131] (helo=mdxdesktop.lan.vainius.eu)
	by nd1.smtpcl1.5ci.lt with esmtp (Exim 4.77)
	(envelope-from <modestas@vainius.eu>)
	id 1Tu2Qw-0006IB-E0; Sat, 12 Jan 2013 16:51:42 +0200
Received: from localhost ([::1] helo=mdxdesktop.localnet)
	by mdxdesktop.lan.vainius.eu with esmtp (Exim 4.80)
	(envelope-from <modestas@vainius.eu>)
	id 1Tu2R1-0000YJ-6o; Sat, 12 Jan 2013 16:51:47 +0200
User-Agent: KMail/4.8.4 (Linux/3.2.0-4-amd64; KDE/4.8.5; x86_64; ; )
In-Reply-To: <20130112142521.GA21639@ftbfs.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213285>

Hello,

Saturday 12 January 2013 06:25:21 ra=C5=A1=C4=97:
> On Sat, Jan 12, 2013 at 03:59:52PM +0200, Modestas Vainius wrote:
> > @@ -306,6 +311,11 @@ static CURL *get_curl_handle(void)
> >=20
> >  	if (curl_ftp_no_epsv)
> >  =09
> >  		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
> >=20
> > +#ifdef CURLOPT_USE_SSL
> > +    if (curl_ssl_try)
> > +		curl_easy_setopt(result, CURLOPT_USE_SSL, CURLUSESSL_TRY);
> > +#endif
> > +
> >=20
> >  	if (curl_http_proxy) {
> >  =09
> >  		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> >  		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
>=20
> It looks like the indentation of the "if" line you added is messed up=
=2E

Yeah, sorry about that. I will fix it.

--=20
Modestas Vainius <modestas@vainius.eu>
