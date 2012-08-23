From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
Date: Thu, 23 Aug 2012 09:33:55 +0200
Message-ID: <000601cd8101$a6f81900$f4e84b00$@schmitz-digital.de>
References: <002201cd807d$0e83d300$2b8b7900$@schmitz-digital.de> <7v8vd6alqe.fsf@alter.siamese.dyndns.org> <003001cd808b$9d505730$d7f10590$@schmitz-digital.de> <7vk3wq964r.fsf@alter.siamese.dyndns.org> <003c01cd808f$f24e2a60$d6ea7f20$@schmitz-digital.de> <7v7gsq94gd.fsf@alter.siamese.dyndns.org> <004101cd8096$fce3a700$f6aaf500$@schmitz-digital.de> <7vwr0q63po.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 09:34:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Rvh-00076s-Da
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 09:34:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756923Ab2HWHeH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 03:34:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:51396 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756045Ab2HWHeF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 03:34:05 -0400
Received: from DualCore (dsdf-4db5f6fe.pool.mediaWays.net [77.181.246.254])
	by mrelayeu.kundenserver.de (node=mreu3) with ESMTP (Nemesis)
	id 0LknvV-1Tc8BY2aSz-00ajuc; Thu, 23 Aug 2012 09:34:01 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHjEtoBTcn41aOpScwQkPT+c62HTAJeVUchAO6Wu9cBkiD+9QGuygBoAMLnBsUBv8N3IgG0C8qlluUJh8CAAK34UA==
Content-Language: de
X-Provags-ID: V02:K0:fFH5eZ3AvlYqWehgP7EzsJiYBGki7QejxU+/Jon9Tg1
 xODHCwGoB9l6AobrL9PynSA/P9ldAab0vQJjYI9nXIiYRevu0a
 bECPwmmj73ObtpHJpq2IjYT+UU/Nml0iSF8xWHp/gszKKQm8qz
 Ql8SB8w1v+1snUjLPGi2eTVRKIUAF8TdxQ0ABlJY8b1iBXl22O
 o47+HS+xdIWU7uAQuxwkZtbaPbJjxP3HLoF+D8Bov2ovv0WKrv
 CbZ7a6UfEfC2SaaeFUgoWZQArQTPqpw7dW6iiWP2XGpN+KtCUK
 xWh3RkRjBFnV6YClVZhwaZB350Ah0Vn8X6ozjQLItHEG4jTBYi
 yGjIVfif81F9fle2Yzy0lTl0fUdbzmFJQRphoLq5LedbCKH/K1
 QltuQxDF7I8QA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204114>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Wednesday, August 22, 2012 11:06 PM
> To: 'Junio C Hamano'
> Cc: 'git@vger.kernel.org'
> Subject: RE: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
> 
> > From: Junio C Hamano [mailto:gitster@pobox.com]
> > Sent: Wednesday, August 22, 2012 11:02 PM
> > To: Joachim Schmitz
> > Cc: git@vger.kernel.org
> > Subject: Re: [PATCH] Don't use curl_easy_strerror prior to curl-7.12.0
> >
> > "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> >
> > >> > diff --git a/http.c b/http.c
> > >> > index b61ac85..18bc6bf 100644
> > >> > --- a/http.c
> > >> > +++ b/http.c
> > >> > @@ -806,10 +806,12 @@ static int http_request(const char *url, void
> > >> > *result, int target, int options)
> > >>
> > >> Likewrapped X-<
> > >
> > > Any suggestion?
> >
> > Other than "don't wrap" (or "get a real MUA and MTA" X-<), unfortunately no.
> >
> > I do not know if you have checked MUA specific hints section of
> > Documentation/SubmittingPatches; there may be environment specific hints
> > described for a MUA you may have at hand (or not).
> 
> I checked, but Outlook isn't mentioned :-(

OK, Outlook inserts line breaks at position 76. I can't switch it off completely, but can set it to anything between 30 and 132. I
set it to 132 now, does that look OK now?
---

This reverts be22d92 (http: avoid empty error messages for some curl errors, 2011-09-05) on platforms with older versions of
libcURL.

Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
---
 http.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/http.c b/http.c
index b61ac85..18bc6bf 100644
--- a/http.c
+++ b/http.c
@@ -806,10 +806,12 @@ static int http_request(const char *url, void *result, int target, int options)
 				ret = HTTP_REAUTH;
 			}
 		} else {
+#if LIBCURL_VERSION_NUM >= 0x070c00
 			if (!curl_errorstr[0])
 				strlcpy(curl_errorstr,
 					curl_easy_strerror(results.curl_result),
 					sizeof(curl_errorstr));
+#endif
 			ret = HTTP_ERROR;
 		}
 	} else {
-- 
1.7.12


Bye, Jojo
