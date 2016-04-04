From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH 5/5] t/t5520: test --[no-]autostash with pull.rebase=true
Date: Mon, 04 Apr 2016 20:21:30 +0200
Message-ID: <vpqy48ti6ad.fsf@anie.imag.fr>
References: <1459258200-32444-1-git-send-email-mehul.jain2029@gmail.com>
	<1459258200-32444-6-git-send-email-mehul.jain2029@gmail.com>
	<CAPig+cQ93+dCqJMRcQYSRHLDuYtwkeK_aSrfv2=2=g7ZhO85TQ@mail.gmail.com>
	<CA+DCAeQPr2vxvm6MKiOLpDtmpC2d=RcvYhuFeimSn+xX2TAvtQ@mail.gmail.com>
	<CAPig+cQyHu1J=FYOtgsmi3ghuN7YyjNgAz-VgO06isfrS+kUSg@mail.gmail.com>
	<CA+DCAeT1DQvHnRpJeApcm2vO6KhXaMaRXZg9HCUmiiBv=hfxzw@mail.gmail.com>
	<CAPig+cSR9Um5FUWzkzHGAM5RanaKssAysA5hGOP4+E5oA0Y5oA@mail.gmail.com>
	<CA+DCAeRqY7-qZt-upa5=nY8OkUL4Q76ogk5nrF_WAaiFiWOy1A@mail.gmail.com>
	<vpq4mbhmi3g.fsf@anie.imag.fr>
	<CA+DCAeTm7wjgdjLwR__pcyev-EsqecdAT8xdGEFfuekg4ToKSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Mehul Jain <mehul.jain2029@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 04 20:21:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1an98E-0002Vm-HR
	for gcvg-git-2@plane.gmane.org; Mon, 04 Apr 2016 20:21:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754292AbcDDSVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 14:21:42 -0400
Received: from mx1.imag.fr ([129.88.30.5]:41587 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756014AbcDDSVi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 14:21:38 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u34ILS2v006923
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Mon, 4 Apr 2016 20:21:29 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u34ILUsa000661;
	Mon, 4 Apr 2016 20:21:30 +0200
In-Reply-To: <CA+DCAeTm7wjgdjLwR__pcyev-EsqecdAT8xdGEFfuekg4ToKSA@mail.gmail.com>
	(Mehul Jain's message of "Mon, 4 Apr 2016 23:06:29 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Mon, 04 Apr 2016 20:21:29 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u34ILS2v006923
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1460398890.94284@gHp+TXofQGKqJ+jaD4T0zw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290714>

Mehul Jain <mehul.jain2029@gmail.com> writes:

> On Mon, Apr 4, 2016 at 10:22 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> I think it would be much simpler to drop the loop, and write instead
>> something like (untested):
>
> I tested it (with few minor changes), and worked fine.
>
> test_autostash () {
>         OLDIFS=$IFS
>         IFS='='
>         set -- $*
>         IFS=$OLDIFS

This $IFS dance is not needed. If you need to split variable and value,
then just pass two arguments on the caller side.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
