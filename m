From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 7/7] t/README: Document the do's and don'ts of tests
Date: Tue, 06 Jul 2010 01:35:33 -0700 (PDT)
Message-ID: <m3sk3xm2jr.fsf@localhost.localdomain>
References: <1278082789-19872-1-git-send-email-avarab@gmail.com>
	<1278082789-19872-8-git-send-email-avarab@gmail.com>
	<7vaaq58hhb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>,
	git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 06 11:05:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OW46E-0005E0-AX
	for gcvg-git-2@lo.gmane.org; Tue, 06 Jul 2010 11:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752514Ab0GFJFp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Jul 2010 05:05:45 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45237 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754114Ab0GFJFl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Jul 2010 05:05:41 -0400
Received: by mail-fx0-f46.google.com with SMTP id 14so4509608fxm.19
        for <git@vger.kernel.org>; Tue, 06 Jul 2010 02:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=z0/KWhgg3pkxKFCVAlrkB7us9rdCmrgvaS8sN2dPuWE=;
        b=YYQ21tgd9AGR5O0v2TkDb8ubBNU1X+I1xP3rqLYdtuEN7bFuZj0WkJ+DdtEvjo2ldr
         /Uf0BuwBFGwlyh8IymwzEqR351AsBL4VZjzDapyNDbh+oVWq7J3+IbbQ0a3O97eaLzMS
         AGwax+6pAwzeqFcIwFRMLBHPKIqcdTuJh99lg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=bqUjtfCAi3wPqD+Kp6PonV2W9CyL/e35ginOCT6F7kJfKlVT0WH4gwbsu9WtrBdt9i
         zl2Ns3m45LCkiqVvcYWIKOnZzZv32DEQIlTiS9mayMb0ExIzxov/n09DojDo44GihJqu
         DkU8hY1yC17cJPe6dVi2skWVjCyI/u/UZt5Ik=
Received: by 10.223.109.193 with SMTP id k1mr3699490fap.37.1278405333744;
        Tue, 06 Jul 2010 01:35:33 -0700 (PDT)
Received: from localhost.localdomain (abwo240.neoplus.adsl.tpnet.pl [83.8.238.240])
        by mx.google.com with ESMTPS id b18sm11245952fab.11.2010.07.06.01.35.32
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 06 Jul 2010 01:35:33 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o668YsdE007263;
	Tue, 6 Jul 2010 10:35:00 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o668YXjS007253;
	Tue, 6 Jul 2010 10:34:33 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vaaq58hhb.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150336>

Junio C Hamano <gitster@pobox.com> writes:
> =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>=20
> > +Do:
> > +
> > + - Put as much code as possible inside test_expect_success and oth=
er
> > +   assertions.
> > +
> > +   Even code that isn't a test per se, but merely some setup code
> > +   should be inside a test assertion if at all possible. Test scri=
pts
> > +   should only have trivial code outside of their assertions.
>=20
> Let's make it even stronger; "should only have trivial" -> "shouldn't=
 have
> any ... unless there is a good reason."

I think that the only thing that can and *should* be put outside
test_expect_* is creating helper file: test vectors ('expect' files),
configuration files, files that are to be arguments to commands, etc.
Is it covered by "there is a good reason"?  Isn't it too severe?

There probably should be description when to put creating such files
in test script, and when to put them as pre-made files in tXXXX/
subdirectory (non US-ASCII is one reason to put it as pre-made file).
=20
--=20
Jakub Narebski
Poland
ShadeHawk on #git
