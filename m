From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/2] git-send-email: Do not require that addresses added from  body be valid
Date: Sat, 7 May 2011 15:21:05 +0200
Message-ID: <201105071521.06344.jnareb@gmail.com>
References: <20110415034251.GC19621@sigill.intra.peff.net> <20110504213535.GB27779@sigill.intra.peff.net> <201105051601.46012.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 07 15:21:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QIhRd-0008S2-If
	for gcvg-git-2@lo.gmane.org; Sat, 07 May 2011 15:21:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753510Ab1EGNVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 May 2011 09:21:13 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:45262 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119Ab1EGNVM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2011 09:21:12 -0400
Received: by bwz15 with SMTP id 15so3075974bwz.19
        for <git@vger.kernel.org>; Sat, 07 May 2011 06:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=STxv/7tcpu4RhU2WFx7T4lW/01/LAHjFSjm/gwI85/4=;
        b=I9RNVVN4Zl/7C5v8d0SC9NFgzSQ0Mw0e1dk8RkCL2L6z966TbKUbKg7xzLOoE72oyt
         HWURgmdBqTO+XkAAycmKX+tQ7CQc5MiGFB2ZaJCTMCrHBfhvQoArhkFJKKiPeCOt/+Hb
         QoJWGHg7L4kscEH2OklGSa4nleKaMF0rD8vD0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=s+nnF5rQOh7LOWXakp68bG4sgREOx4gY1mMYOII0gkUXeQj3rLORcyzVPZ7A3AEnZh
         KpUB/mLSYDr4bM/kON1RC4ryLd7s9HpadxqQJ/FmqBolpILbVsnZhWNC6lGQ5S9PuGu0
         jt/Bha5X8dNf0K0PIrbbA5Qn73qzpwivjxadw=
Received: by 10.205.81.76 with SMTP id zx12mr2788841bkb.82.1304774470827;
        Sat, 07 May 2011 06:21:10 -0700 (PDT)
Received: from [192.168.1.13] (abwd142.neoplus.adsl.tpnet.pl [83.8.227.142])
        by mx.google.com with ESMTPS id q18sm2568154bka.3.2011.05.07.06.21.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 07 May 2011 06:21:09 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <201105051601.46012.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173052>

On Thu, 5 May 2011, Jakub Narebski wrote:

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0$smtp->to( @recipients ) or die $smtp->messa=
ge;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0$smtp->to( @recipients_extra, { Notify =3D> ['NEVE=
R'], SkipBad =3D> 1 });
                                                  ^^^^^^^^^^^^^^^^^^^^

Note: contrary to what I thought this doesn't mean to not send any
notification request, but to send DSN (Delivery Status Notification)
request of 'NEVER'.  For example when using smtp.gmail.com gives:

  Net::SMTP::recipient: DSN option not supported by host at ./git-send-=
email line 1140

So the underlined part has to be removed.

--=20
Jakub Narebski
Poland
