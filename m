From: John Tapsell <johnflux@gmail.com>
Subject: Re: [PATCH] rev-list: estimate number of bisection step left
Date: Thu, 19 Feb 2009 06:02:09 +0000
Message-ID: <43d8ce650902182202s4c06a261jd68a2f86607f00ef@mail.gmail.com>
References: <20090217060944.488184b0.chriscool@tuxfamily.org>
	 <7vljs58qul.fsf@gitster.siamese.dyndns.org>
	 <200902190616.18747.chriscool@tuxfamily.org>
	 <200902190632.50156.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Thomas Rast <trast@student.ethz.ch>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu Feb 19 07:09:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1La26L-0007gr-9j
	for gcvg-git-2@gmane.org; Thu, 19 Feb 2009 07:09:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbZBSGII convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2009 01:08:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751333AbZBSGIG
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Feb 2009 01:08:06 -0500
Received: from mail-gx0-f174.google.com ([209.85.217.174]:55378 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751265AbZBSGIF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2009 01:08:05 -0500
X-Greylist: delayed 352 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Feb 2009 01:08:05 EST
Received: by gxk22 with SMTP id 22so716011gxk.13
        for <git@vger.kernel.org>; Wed, 18 Feb 2009 22:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fpaObSHyazdrr/Nx81zcw2vJi5ECzc/NqCdMAP5NgTk=;
        b=PY+YN9I3YmuvMqhsvwm8VmU7ENPe3KxPgTVTDjn+ExUlDIrYvx79Zm8KLcZwZaveGr
         IYDNVz4QuFYP06NM+4hdi4H8uZD1YDpHG3LkETCBVYmyvrPxGFiGyzxb/SZi7ChD5UEY
         sazTgWgLsggoE6xPsMbhGKV9H9kPw809i/FRw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=i/g6SIwOJwY2h3YELu0e0BZhWsxc8p2Qb6aDzfsN9kPVl/MnNfoi8Xh5mxNfSCKRJZ
         0fXAlH2GC8z3kqC6dnESA3pl00B+dIwThjfTzbKCgBsVm4/b9hilH/fJ+zXcSo/01ZMI
         zeC4bkP3qp03JHuSGCDGdqlYm94QNkBnj2CNg=
Received: by 10.150.182.16 with SMTP id e16mr631497ybf.174.1235023330025; Wed, 
	18 Feb 2009 22:02:10 -0800 (PST)
In-Reply-To: <200902190632.50156.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110630>

2009/2/19 Christian Couder <chriscool@tuxfamily.org>:
> Le jeudi 19 f=C3=A9vrier 2009, Christian Couder a =C3=A9crit :
>>
>> But on Linux, log2 and exp2 are defined in "math.h" and available wi=
th:

log2 in math.h is for doubles, when we only want an integer answer.
There's no need for math.h here.
