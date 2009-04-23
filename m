From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src) 
	when that is unreliable
Date: Thu, 23 Apr 2009 21:39:38 +0200
Message-ID: <81b0412b0904231239qf317c02xbfa548d0011a0302@mail.gmail.com>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, j6t@kdbg.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 23 21:41:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lx4nK-0000Q8-83
	for gcvg-git-2@gmane.org; Thu, 23 Apr 2009 21:41:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755357AbZDWTjl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 23 Apr 2009 15:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756904AbZDWTjk
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Apr 2009 15:39:40 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:51519 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752716AbZDWTjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Apr 2009 15:39:39 -0400
Received: by yx-out-2324.google.com with SMTP id 3so432576yxj.1
        for <git@vger.kernel.org>; Thu, 23 Apr 2009 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9p3ELaDUuoKRl8RlHDQ05VElHrECo6yDYxRYHeq06k8=;
        b=ArXdHxbtCfQVV5jGSXCf3Z8Wg3xs3sK/l7AWKkvQbJeyqhhlIExqI94/HtT6c2vKT0
         Yb1agVBlAAzEobvnF5nyKLE8uzqqA77dhzf7nSotpEnh7C1mZ7hlgU0l4Gx/VqyjIVu+
         vOC74IuJebs9pqejWOQnuPPQKo0YSoculVpdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=UM29iiQbUdyPPEDtV0J9CkxQVZK7k8b4iIz2/S2yTMc+ymwgtR5VqGwNRhNtIs67Oj
         Yv9S0SpLIseXUPd80YqOTB4/zs3TRQBaJkZYGS61k6uiCogvCOxkqW55MOljX5r5VE7m
         gGINiRDm4JqcAeDH+nheZlwIsOLfDHch+zLE8=
Received: by 10.151.139.10 with SMTP id r10mr907106ybn.175.1240515578179; Thu, 
	23 Apr 2009 12:39:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117374>

2009/4/23 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> - =C2=A0 =C2=A0 =C2=A0 if (link(tmpfile, filename))
> + =C2=A0 =C2=A0 =C2=A0 if (unreliable_hardlinks)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D ~EEXIST;

It is more like "broken_hardlinks" or even "no_hardlinks"!
