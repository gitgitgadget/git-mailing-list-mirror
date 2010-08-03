From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] perl/Makefile: Unset INSTALL_BASE when making perl.mak
Date: Tue, 03 Aug 2010 04:16:40 -0700 (PDT)
Message-ID: <m3d3u0osjo.fsf@localhost.localdomain>
References: <1280831411-4511-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 03 13:16:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgFUH-00033r-84
	for gcvg-git-2@lo.gmane.org; Tue, 03 Aug 2010 13:16:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756021Ab0HCLQn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Aug 2010 07:16:43 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:42570 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755986Ab0HCLQm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Aug 2010 07:16:42 -0400
Received: by fxm14 with SMTP id 14so1938669fxm.19
        for <git@vger.kernel.org>; Tue, 03 Aug 2010 04:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=eXvGu4J9UCVenlckiEGS9lkLv6Vrcq0K98o73FU+3m0=;
        b=gV869a5pPEDnJuJ/UhQWSY7UMxd/nCzUkBFn1L4WwIBld1dnKtrtBgfbQh8dFFKeN1
         OSmUOaDh/ke0USScqQE+nARiM8e6p+bGd568wAgnr0LuZAL0Sk3r/gNyn76PLYWuCzJc
         hKne07iNO8rNQRyv4WdLkpfHGq/sTTU0UoKVk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=u4Cnvu5xUBSuLuI9DoIxQ1LykhLa/HvNt4jWt5nKkfqsKyVrDUQDG1LoA9DAMDMMkT
         eHMLRM0mpXoBnPRSXuhEf8Dsc7KgPb936+sOljRdo9M4BZ5J6Mtkh0cgxxus9lSPAaAP
         3ZctFNpv3F1yphLy8vPe+nMshiRWmkEKKcia0=
Received: by 10.223.115.194 with SMTP id j2mr7144099faq.47.1280834201331;
        Tue, 03 Aug 2010 04:16:41 -0700 (PDT)
Received: from localhost.localdomain (abws244.neoplus.adsl.tpnet.pl [83.8.242.244])
        by mx.google.com with ESMTPS id 10sm2424556fax.18.2010.08.03.04.16.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Aug 2010 04:16:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o73BGZuD030362;
	Tue, 3 Aug 2010 13:16:47 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o73BGDIH030345;
	Tue, 3 Aug 2010 13:16:13 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1280831411-4511-1-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152505>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> PREFIX and INSTALL_BASE are mutually exclusive. If both are supplied
> by INSTALL_BASE being set in PERL_MM_OPT ExtUtils::MakeMaker will
> produce an error:
>=20
>     $ echo $PERL_MM_OPT
>     INSTALL_BASE=3D/home/avar/perl5
>     $ make -C perl  PERL_PATH=3D'/usr/bin/perl' prefix=3D'/home/avar'=
 perl.mak
>     make: Entering directory `/home/avar/g/git/perl'
>     /usr/bin/perl Makefile.PL PREFIX=3D'/home/avar'
>     Only one of PREFIX or INSTALL_BASE can be given.  Not both.
>     make: *** [perl.mak] Error 255
>     make: Leaving directory `/home/avar/g/git/perl'
>=20
> Change the perl Makefile to work around this by explicitly unsetting
> INSTALL_BASE.
>=20
> INSTALL_BASE is set in PERL_MM_OPT by e.g. the popular local::lib
> package, from its documentation:
>=20
>     eval $(perl -I$HOME/perl5/lib/perl5 -Mlocal::lib 2>/dev/null)
>=20
> Many other environments might also have set PERL_MM_OPT before
> building Git. This change enables us to build in these environments.
>=20
> Signed-off-by: =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com>

Great!  I really appreciate this, using local::lib myself.

--=20
Jakub Narebski
Poland
ShadeHawk on #git
