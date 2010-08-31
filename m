From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC 01/17] Makefile: A variable for options used by
 xgettext(1) calls
Date: Tue, 31 Aug 2010 09:51:58 -0500
Message-ID: <20100831145158.GD2315@burratino>
References: <1283203703-26923-1-git-send-email-avarab@gmail.com>
 <1283203703-26923-2-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Marcin Cieslak <saper@saper.info>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 31 16:53:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OqSDf-0002Gy-Gv
	for gcvg-git-2@lo.gmane.org; Tue, 31 Aug 2010 16:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757536Ab0HaOxq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Aug 2010 10:53:46 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:63881 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab0HaOxp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Aug 2010 10:53:45 -0400
Received: by wwb28 with SMTP id 28so1339569wwb.1
        for <git@vger.kernel.org>; Tue, 31 Aug 2010 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=i9ZxcCgVAqQFerwAKtr2eeLnD2A5X9PewmNCPnp3COE=;
        b=OQoMT2KuGhDYn6PU6/cTRLSgMNlnymOX0KP9ZreHq/AyequIVRg2STwsABWY5YzOD+
         OUbsaG3adLEY25Kt5ftj3L2mxnmqh2NsgF1iiKUncgHi7BC82t5qfKNcZKjgAez5/fTW
         O2+fOHHATRTWrEI5pbCGO+dTEl28lLokX30AU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=E3f2n4QgUh4vcWlu7ADeDyY6aRKyxnhzj3BMgjRKF5ucutMqXNbbI49geT1LTg1Htt
         SYH6LEc4NsdqZq+WEqvB1ZLsBf/LXYtz+4PJY/3/sCqrQD7LAI1VyA45Www/ulRHQmDu
         1KrW6zfOlqnBV4yYyawGZCuv8NVNoDWLYIzns=
Received: by 10.216.70.10 with SMTP id o10mr6300427wed.83.1283266424194;
        Tue, 31 Aug 2010 07:53:44 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id o49sm5342184wej.43.2010.08.31.07.53.41
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 31 Aug 2010 07:53:43 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283203703-26923-2-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154906>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> +++ b/Makefile
> @@ -2008,10 +2008,11 @@ cscope:
>  	$(RM) cscope*
>  	$(FIND) . -name '*.[hcS]' -print | xargs cscope -b
> =20
> +XGETTEXT_OPTIONS =3D --add-comments
>  pot:
> -	$(XGETTEXT) --add-comments --keyword=3D_ --keyword=3DN_ --output=3D=
po/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
> -	$(XGETTEXT) --add-comments --join-existing --output=3Dpo/git.pot --=
language=3DShell $(SCRIPT_SH) t/t0200/test.sh
> -	$(XGETTEXT) --add-comments --join-existing --keyword=3D__ --output=3D=
po/git.pot --language=3DPerl $(SCRIPT_PERL) t/t0200/test.perl
> +	$(XGETTEXT) $(XGETTEXT_OPTIONS) --keyword=3D_ --keyword=3DN_ --outp=
ut=3Dpo/git.pot --language=3DC $(C_OBJ:o=3Dc) t/t0200/test.c
> +	$(XGETTEXT) $(XGETTEXT_OPTIONS) --join-existing --output=3Dpo/git.p=
ot --language=3DShell $(SCRIPT_SH) t/t0200/test.sh
> +	$(XGETTEXT) $(XGETTEXT_OPTIONS) --join-existing --keyword=3D__ --ou=
tput=3Dpo/git.pot --language=3DPerl $(SCRIPT_PERL) t/t0200/test.perl

The long lines are a bit scary. :)

Maybe more of it could be pulled out into variables.  As a
side-effect, users could override some settings from the command line.
Maybe something like this?

 LOCALIZED_C =3D $(C_OBJ:o=3Dc) t/t0200/test.c
 LOCALIZED_SH =3D $(SCRIPT_SH) t/t0200/test.sh
 LOCALIZED_PERL =3D $(SCRIPT_PERL) t/t0200/test.perl

 XGETTEXT_OPTIONS =3D --add-comments
 XGETTEXT_OPTIONS_C =3D $(XGETTEXT_OPTIONS) -k_ -kN_ -LC
 XGETTEXT_OPTIONS_SH =3D $(XGETTEXT_OPTIONS) -LShell
 XGETTEXT_OPTIONS_PERL =3D $(XGETTEXT_OPTIONS) -k__ -LPerl

 po/git.pot:
	rm -f $@+
	$(XGETTEXT) -o$@+ $(XGETTEXT_OPTIONS_C) $(LOCALIZED_C)
	$(XGETTEXT) -j -o$@+ $(XGETTEXT_OPTIONS_SH) $(LOCALIZED_SH)
	$(XGETTEXT) -j -o$@+ $(XGETTEXT_OPTIONS_PERL) $(LOCALIZED_PERL)
	mv $@+ $@
