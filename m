From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH] Port to HP NonStop
Date: Wed, 19 Sep 2012 23:11:08 +0200
Message-ID: <001e01cd96ab$4a9d9df0$dfd8d9d0$@schmitz-digital.de>
References: <000101cd964e$06a255d0$13e70170$@schmitz-digital.de> <alpine.LNX.2.01.1209191945160.19536@nerf07.vanv.qr> <001601cd968f$d8d91ed0$8a8b5c70$@schmitz-digital.de> <alpine.LNX.2.01.1209192232590.19536@nerf07.vanv.qr>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Cc: "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
To: "'Jan Engelhardt'" <jengelh@inai.de>
X-From: git-owner@vger.kernel.org Wed Sep 19 23:11:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TERYV-0001JI-L1
	for gcvg-git-2@plane.gmane.org; Wed, 19 Sep 2012 23:11:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab2ISVL1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 17:11:27 -0400
Received: from moutng.kundenserver.de ([212.227.17.9]:55098 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab2ISVL0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 17:11:26 -0400
Received: from DualCore (dsdf-4d0a1993.pool.mediaWays.net [77.10.25.147])
	by mrelayeu.kundenserver.de (node=mrbap1) with ESMTP (Nemesis)
	id 0LfYt7-1TqD8Y2a0v-00p1Bv; Wed, 19 Sep 2012 23:11:12 +0200
In-Reply-To: <alpine.LNX.2.01.1209192232590.19536@nerf07.vanv.qr>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQFMdLLbfkMGN4L+ay/JCcMH3R8/WwGpV7cXASOJJNoB4e4XV5hu9gcg
Content-Language: de
X-Provags-ID: V02:K0:ExsX6kTZ6DEuoqWugjkJlFUGwShqR1FoDr22Cmm72pF
 LbNp8LRevlpDn4sPNlq9Kwfj2fxtaxGDcI2Lsq/iT7Jgu4Ki9v
 QCepkKNZHjxLaYb00PXXYUkUB4HD9zAoq6U0QstFUAAlBM4pWE
 jLbY08zhKjz1EUeYe0nCCUVwichMBtBJQ/gNytLSCqIYElx+Gn
 BsImNmWVnMduyF1EM7wO7vqDXLZyGZyXITuyiQTMRryJQzGyWB
 4hXcxcNxCZCLcUVQH42IcZkYFnS8NAz3m+nfi6nZ5xL2MGuzGD
 2Izx+eHLfX8TpiInbv18vOkQ22PIMG5lyRWLbjf4HixU/D7q9a
 5j/eKiiYkbqTojLi5gB8vg06I5a3MIAqYBa+3vZOjBj+L3JmbO
 +aaSKDSK4jUJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206002>

> From: Jan Engelhardt [mailto:jengelh@inai.de]
> Sent: Wednesday, September 19, 2012 10:34 PM
> To: Joachim Schmitz
> Cc: 'Junio C Hamano'; git@vger.kernel.org
> Subject: RE: [PATCH] Port to HP NonStop
> 
> On Wednesday 2012-09-19 19:54, Joachim Schmitz wrote:
> 
> >> From: Jan Engelhardt [mailto:jengelh@inai.de]
> >> Sent: Wednesday, September 19, 2012 7:48 PM
> >> To: Joachim Schmitz
> >> Cc: 'Junio C Hamano'; git@vger.kernel.org
> >> Subject: Re: [PATCH] Port to HP NonStop
> >>
> >>
> >> On Wednesday 2012-09-19 12:03, Joachim Schmitz wrote:
> >> >+#ifdef NO_INTPTR_T
> >> >+/*
> >> >+ * On I16LP32, ILP32 and LP64 "long" is the save bet, however
> >> >+ * on LLP86, IL33LLP64 and P64 it needs to be "long long",
> >> >+ * while on IP16 and IP16L32 it is "int" (resp. "short")
> >> >+ * Size needs to match (or exceed) 'sizeof(void *)'.
> >> >+ * We can't take "long long" here as not everybody has it.
> >>
> >> Are you trying to port git to DOS or why would you mention IP16? :-)
> >
> >Just for completness, nothing else ;-)
> 
> The problem would be that some, if not most, C environments in DOS offer
> a P16P32 model - thanks to (near void *) and (far void *).

No problem. "long" would be big enough for these (wasting some space though)
Only LLP86, IL33LLP64 and P64 would need it bigger, "long long".
