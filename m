From: Anders Kaseorg <andersk@ksplice.com>
Subject: Re: git log --summary outputs extra newlines inconsistently
Date: Fri, 4 Feb 2011 13:57:29 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1102041351490.32500@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1102021842550.12561@dr-wily.mit.edu> <AANLkTinX6igafGkEv+k97Tm+V-8kEJK0rZs-K0iUGyes@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 19:57:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlQqn-00062J-GJ
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 19:57:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751339Ab1BDS5e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Feb 2011 13:57:34 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:54432 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab1BDS5d convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 13:57:33 -0500
Received: by vxb37 with SMTP id 37so812096vxb.19
        for <git@vger.kernel.org>; Fri, 04 Feb 2011 10:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ksplice.com; s=google;
        h=domainkey-signature:date:from:x-x-sender:to:cc:subject:in-reply-to
         :message-id:references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=xCtP7M9FW8+HjLB1EJg0ps0bAFDGfNeeSEGjFAXTons=;
        b=arI2ljfA2KSmqBWVvyfjdmOidQLdCBUwbPynGU+kj4w5NWhsSnwGDuV7obHIIkhzuR
         2UhXCV6+og4aKaSgA6u/ZxHp+rcSl2AFMOcUhw9sjt6IZwYJ7B3VicWJNaBWykSAbPmg
         RX2TkIWFB2iJKRKLdovTAACzOTzUWQXDKFZDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=ksplice.com; s=google;
        h=date:from:x-x-sender:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=FcVvQZCL947EhzJdjC/ZFzWaPWTYS/bsFjsSj/0ZqVHpO9faGo09t8VQdin0x469QD
         S9d5dM3HFOB2p5LqdaMwFga7FoH23geFwSDJKwpn6pBnR3LYLrLoT1UaDUzwjqJHh8is
         74afpz3LIDhKKJwzA+BwQx2rZYP+i9s9MncHc=
Received: by 10.220.183.5 with SMTP id ce5mr416145vcb.66.1296845852158;
        Fri, 04 Feb 2011 10:57:32 -0800 (PST)
Received: from localhost (DR-WILY.MIT.EDU [18.181.0.233])
        by mx.google.com with ESMTPS id e18sm775988vbm.15.2011.02.04.10.57.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 04 Feb 2011 10:57:31 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <AANLkTinX6igafGkEv+k97Tm+V-8kEJK0rZs-K0iUGyes@mail.gmail.com>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166055>

On Fri, 4 Feb 2011, Junio C Hamano wrote:
> > =E2=80=98git log --summary=E2=80=99 seems to output a newline after=
 every non-merge
> > commit.
>=20
> I suspect you want tformat.

Same problem.

  $ git log --summary --pretty=3Dtformat:'%h %s'
  3c0eee3 Linux 2.6.37

  65f4288 Merge git://git.kernel.org/pub/scm/linux/kernel/git/davem/net=
-2.6
  9fc3bbb ipv4/route.c: respect prefsrc for local routes

  8a87694 remove trim_fs method from Documentation/filesystems/Locking

  989d873 Merge master.kernel.org:/home/rmk/linux-2.6-arm
  d9a1abe arch/mn10300/kernel/irq.c: fix build

  867c202 ima: fix add LSM rule bug

Also, tformat doesn=E2=80=99t seem to work at all with -z (it gives ide=
ntical=20
results with and without -z).

Anders
