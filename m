From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: [PATCH v3] Support for setitimer() on platforms lacking it
Date: Fri, 7 Sep 2012 20:29:01 +0200
Message-ID: <004701cd8d26$a7710cd0$f6532670$@schmitz-digital.de>
References: <002201cd8cde$ea7cacc0$bf760640$@schmitz-digital.de> <7va9x1zszj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>
To: "'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 20:29:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TA3Iw-00046N-Gn
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 20:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754760Ab2IGS3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 14:29:15 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:63511 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753401Ab2IGS3O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 14:29:14 -0400
Received: from DualCore (dsdf-4d0a1723.pool.mediaWays.net [77.10.23.35])
	by mrelayeu.kundenserver.de (node=mrbap3) with ESMTP (Nemesis)
	id 0Lr24R-1TnUur1zAx-00eZLP; Fri, 07 Sep 2012 20:29:10 +0200
In-Reply-To: <7va9x1zszj.fsf@alter.siamese.dyndns.org>
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQHn+VypN6jmWEsrctbe7PHxSD6ISwKVN9SHlzWwmvA=
Content-Language: de
X-Provags-ID: V02:K0:03uZf8JUWN0wcHIAN6dO5MJeVodn520hzPh00zwEC5S
 9cySC3DE+a888bNWFuP3b6ZgxBxSl2rpU7IitTODDmOeAtYg7a
 U+bXY+UNv4Gjh/QlSdLDmZsRjmIhljzrmYRBycaa0jjr+Kq9zc
 HBH0OZGGgy1E4S0yjocG0x2g3cC+HrHg/3+rSF9zbu479PvVTe
 knTiJt6kb300QOR70NZ28mC9WLMco0QnEaXDlEYgxcOhamlVyW
 /2sMpBz12X64aHXyWsaFbDwAYUIFUtcxJTMf4itHnw6xNTk2rq
 u7xXpreZNpPoVEeUkdszAHu6nPDkHiPeRhPf2ugvrKAcw/28oV
 nwSGzw5+SRPraK8eDT5on1AWwvA/o6Q1Hh0OwpcCNDfWwsLHrg
 usPEKKkCv46Mg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204985>

> From: Junio C Hamano [mailto:gitster@pobox.com]
> Sent: Friday, September 07, 2012 6:41 PM
> To: Joachim Schmitz
> Cc: git@vger.kernel.org
> Subject: Re: [PATCH v3] Support for setitimer() on platforms lacking it
> 
> "Joachim Schmitz" <jojo@schmitz-digital.de> writes:
> 
> > HP NonStop (currently) doesn't have setitimer(). The previous attempt of an
> > emulation (reverted by this commit) was not a real substitute for a recurring
> > itimer (as here we also don't have SA_RESTART, so can't re-arm the timer).
> > As setitimer() is only used in cases of perceived latency and it doesn't affect
> > correctness, it now gets disabled entirely, if NO_SETITIMER is set.
> > HP NonStop does provide struct itimerval, but other platforms may not, so this
> > is taken care of in this commit too, by setting NO_STRUCT_ITIMERVAL.
> >
> > Signed-off-by: Joachim Schmitz <jojo@schmitz-digital.de>
> 
> The end-result looks simple and nice (thanks for NO_STRUCT_ITIMERVAL).
> 
> As we are not going to include the earlier failed attempt in our
> longer-term history (i.e. 'master', that never rewinds), however,
> I would prefer to see a replacement patch (as opposed to this one
> that incrementally updates the previous failed attempt).  I could
> squash this into the previous one myself though ;-)

Yes, please ;-)

Bye, Jojo
