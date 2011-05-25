From: Stephen Bash <bash@genarts.com>
Subject: Re: Git EOL Normalization
Date: Wed, 25 May 2011 14:06:20 -0400 (EDT)
Message-ID: <20898727.40273.1306346780207.JavaMail.root@mail.hq.genarts.com>
References: <BANLkTik3iRKx4P_3nbzygadmLPEOr2vGhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 20:06:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPITY-0006XW-SG
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 20:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261Ab1EYSG1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 May 2011 14:06:27 -0400
Received: from hq.genarts.com ([173.9.65.1]:42737 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751900Ab1EYSG1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 May 2011 14:06:27 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 42CD715C8003;
	Wed, 25 May 2011 14:06:26 -0400 (EDT)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WfmIT7CUq8AL; Wed, 25 May 2011 14:06:20 -0400 (EDT)
Received: from mail.hq.genarts.com (mail.hq.genarts.com [10.102.202.62])
	by mail.hq.genarts.com (Postfix) with ESMTP id 420C915C8001;
	Wed, 25 May 2011 14:06:20 -0400 (EDT)
In-Reply-To: <BANLkTik3iRKx4P_3nbzygadmLPEOr2vGhA@mail.gmail.com>
X-Mailer: Zimbra 6.0.10_GA_2692 (ZimbraWebClient - SAF3 (Mac)/6.0.10_GA_2692)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174442>

----- Original Message -----
> From: "Dmitry Potapov" <dpotapov@gmail.com>
> Sent: Wednesday, May 25, 2011 1:58:33 PM
> Subject: Re: Git EOL Normalization
>
> > =C2=A01) what is the actual text file detection algorithm?
> > =C2=A02) what is the autocrlf LF/CRLF detection algorithm?
> > =C2=A03) how does autocrlf handle mixed line endings? (either in th=
e
> > =C2=A0working copy or repo)
>
> Currently, the following heuristics are used:
>=20
> A file is considered as text if it does not have '\0' or a bare CR,
> and the number of non-printable characters is less than 1 in 128.
>=20
> Non-printable characters are DEL (127) and anything less than 32
> except CR, LF, BS, HT, ESC and FF.
>
> Also, to avoid problems with autocrlf=3Dtrue when someone has already
> put a text file with CRLF, CRLF->LF conversion happens only if the tr=
acked
> file in the index does not have any CR.
>
> PS I wrote this mostly from my memory, so I could miss some detail.

Thanks!  This is very helpful.

Stephen
