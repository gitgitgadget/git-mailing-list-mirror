From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Reverting an uncommitted revert
Date: Wed, 20 May 2009 03:16:27 -0700 (PDT)
Message-ID: <m3iqjwjd01.fsf@localhost.localdomain>
References: <4A136C40.6020808@workspacewhiz.com>
	<alpine.LFD.2.00.0905192300070.3906@xanadu.home>
	<20090520032139.GB10212@coredump.intra.peff.net>
	<alpine.LFD.2.00.0905192328310.3906@xanadu.home>
	<025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>, Jeff King <peff@peff.net>,
	Joshua Jensen <jjensen@workspacewhiz.com>, git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Wed May 20 12:16:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6iqi-0006cY-Mt
	for gcvg-git-2@gmane.org; Wed, 20 May 2009 12:16:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754126AbZETKQ3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 May 2009 06:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753500AbZETKQ2
	(ORCPT <rfc822;git-outgoing>); Wed, 20 May 2009 06:16:28 -0400
Received: from mail-px0-f103.google.com ([209.85.216.103]:62715 "EHLO
	mail-px0-f103.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752811AbZETKQ1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 May 2009 06:16:27 -0400
Received: by pxi1 with SMTP id 1so49923pxi.33
        for <git@vger.kernel.org>; Wed, 20 May 2009 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=JBpj5GYdyb7aWne+xAjrsfPLDjrg1b4IFCUJ9YqVWg8=;
        b=VGNLx0VV8wp62HCdABKEq1ZGUUW29Vj1HQ86qfS7xb4Zlyke4BfmhflKMHwwC9CQg1
         sRrbgTbJNQqYBb5IXSxJeElnIykgzwJCpYG1aCpCgp71DfBkyql1hY8xgprzxYF9J55m
         0L81fp243jCI2f/jhVARlutm0uY2vq44Tz0WA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=Yf4tYvR08rSgg7ZVL0O31DhvxySu3rfv8zfUQ+vkDGDod9zL7ekxo/wmOLi6jhACzw
         fWcZxS+52lXJ5uCZtuN+MML4mqx6/sIJz56zvpJs/SKDYTnZdsXtGmEBcH3USrFhaASg
         fh6AkMVZtFqp6bt6D5H9/66GoOf1NdEJ+iiNM=
Received: by 10.142.179.2 with SMTP id b2mr386130wff.308.1242814588816;
        Wed, 20 May 2009 03:16:28 -0700 (PDT)
Received: from localhost.localdomain (abwp37.neoplus.adsl.tpnet.pl [83.8.239.37])
        by mx.google.com with ESMTPS id 32sm2108585wfa.33.2009.05.20.03.16.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 20 May 2009 03:16:27 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n4KAGKCJ028838;
	Wed, 20 May 2009 12:16:20 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n4KAGFbE028835;
	Wed, 20 May 2009 12:16:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <025225A0-FACC-4A29-A747-40201A7FBA19@wincent.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119595>

Wincent Colaiuta <win@wincent.com> writes:
> El 20/5/2009, a las 5:35, Nicolas Pitre escribi=F3:
>=20
> > Having a "trash" reflog would solve this unambiguously.
[...]

> I personally haven't been bitten by a mistaken use of "git reset" and=
 =20
> friends for a long time now, but I really like the ideas that have =20
> been mentioned so far in this thread. This "trash" or "index" or =20
> "reset" reflog would be a huge step forward in "idiot-proofing" Git.

Well, having a kind of 'Attic' for reflogs for deleted branches would
help here in "mistake-proofing" Git (there were even IIRC some
preliminary test implementation), although it is not as necessary
nowadays because of reflog for HEAD, and ability to set longer expiry
time for it (IIRC).

--=20
Jakub Narebski
Poland
ShadeHawk on #git
