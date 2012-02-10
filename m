From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: 1.7.9, libcharset missing from EXTLIBS
Date: Fri, 10 Feb 2012 05:15:34 -0800 (PST)
Message-ID: <m37gzuvni4.fsf@localhost.localdomain>
References: <4F3472F4.4060605@aegee.org>
	<7v1uq3toyq.fsf@alter.siamese.dyndns.org>
	<CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?iso-8859-5?b?tNjb790gv9Db0OPX3tI=?= <dilyan.palauzov@aegee.org>,
	git@vger.kernel.org
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 14:15:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvqKD-0002la-Pj
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 14:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758793Ab2BJNPg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Feb 2012 08:15:36 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47130 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754427Ab2BJNPg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Feb 2012 08:15:36 -0500
Received: by eekc14 with SMTP id c14so952272eek.19
        for <git@vger.kernel.org>; Fri, 10 Feb 2012 05:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=gMziO46dyYJSds8b/MmktgWL7LcfOoTfqknaSPYJ2nI=;
        b=xTwNZks144RkYU/t6w8kTKB/fPQsXsD12NWtBEb/Fqn8FyNyGnC7aV/PzYdXDnB1yi
         Ok6nhv5cKu2Rv9GQHuZucdhoIyVCHVEt8GpsXgU8UjBslGfrPzPZRoI6f+I+Z0jKosMM
         6hq68MDtzzDzJjEMpB0IehiaKuF8+kNJn1bPw=
Received: by 10.213.32.5 with SMTP id a5mr223790ebd.51.1328879734821;
        Fri, 10 Feb 2012 05:15:34 -0800 (PST)
Received: from localhost.localdomain (abwh187.neoplus.adsl.tpnet.pl. [83.8.231.187])
        by mx.google.com with ESMTPS id v51sm22076742eef.2.2012.02.10.05.15.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 10 Feb 2012 05:15:34 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1ADF1Gr026555;
	Fri, 10 Feb 2012 14:15:11 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1ADEiVR026548;
	Fri, 10 Feb 2012 14:14:44 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CACBZZX45=mr=FMqFF+Pw4KPaDAtvs-ePLbFATpyFA93vSfZatw@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190406>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> 2012/2/10 Junio C Hamano <gitster@pobox.com>:
>> =D0=94=D0=B8=D0=BB=D1=8F=D0=BD =D0=9F=D0=B0=D0=BB=D0=B0=D1=83=D0=B7=D0=
=BE=D0=B2 =C2=A0<dilyan.palauzov@aegee.org> writes:

>>> git 1.7.9 makes use of libcharset and /Makefile contains:
> >>
>>> ifdef HAVE_LIBCHARSET_H
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 BASIC_CFLAGS +=3D -DHAVE_LIBCHARSET_H
>>> endif
>>> ...
>>> and the problem is, that libcharset is not used when linking. =C2=A0=
To
>>> solve this, please replace the above extract from /Makefile with
>>>
>>> ifdef HAVE_LIBCHARSET_H
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 BASIC_CFLAGS +=3D -DHAVE_LIBCHARSET_H
>>> =C2=A0 =C2=A0   =C2=A0 EXTLIBS +=3D -lcharset
>>> endif
[....]
> I've had some similar (privately sent) bug reports about the i18n
> stuff from someone who built his own Linux distro.
>=20
> Basically we make assumptions that certain stuff will be in the C
> library on certain platforms, certain headers go with certain
> libraries etc.
>=20
> Evidently none of this can really be relied upon and we'd have to
> probe for each one if we wanted to make it reliable.

Well, there is always *optional* configure.ac to do detection;
"make configure; ./configure <options>" will generate config.mak.autoge=
n
with appropriate options -- we can add autodetection if -lcharset
must be added.

--=20
Jakub Nar=C4=99bski
