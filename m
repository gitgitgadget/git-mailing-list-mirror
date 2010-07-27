From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC PATCH 1/2] Allow "git log --grep foo" as synonym for "git  log --grep=foo".
Date: Tue, 27 Jul 2010 03:24:51 -0700 (PDT)
Message-ID: <m3ocdtkytn.fsf@localhost.localdomain>
References: <1280168078-31147-1-git-send-email-Matthieu.Moy@imag.fr>
	<1280168078-31147-2-git-send-email-Matthieu.Moy@imag.fr>
	<AANLkTikGPMDvxQKjpKOBge8UwrC_GuC36_=C_tYR_ngr@mail.gmail.com>
	<buohbjll3l9.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Tue Jul 27 12:24:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OdhLG-00074L-Kv
	for gcvg-git-2@lo.gmane.org; Tue, 27 Jul 2010 12:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756018Ab0G0KYy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 27 Jul 2010 06:24:54 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:55878 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab0G0KYx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jul 2010 06:24:53 -0400
Received: by fxm14 with SMTP id 14so517741fxm.19
        for <git@vger.kernel.org>; Tue, 27 Jul 2010 03:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=r2ZcRldEtP0bZMICYPLi1u3wdIFSiBisZV7sqGTBdJ4=;
        b=QxXgHYZ56q5sFWnmcCT2wXFOnuRjPynHxvHc6c6BDwZ8vXoG8S+ygulMT4yKixzb+s
         36CT/l+ZH6SFAKExaxTmTWvRj2X7JXhNHM3oA3bAE727KIKLcmm4O5fcBcIOR+LyBC/K
         347lpV3Xk+7Idvb8xy86i1Hqiiaw98i/V3/00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=wkaPYcIK994veL45LRw9uvW11Rp0buzlk7+ExZzgcIRJwtVm4AqLho+iLnDL8Xs3aC
         0wBaSUkNx7Fr76lVTbPX1A/CXOc52b46MdnGySdA/JlnkKtaVoCD9/vK/fiqQVdYIU0s
         NIxfdVLtNnhD/jzGowYBq6ZqcSVjgPEab853Q=
Received: by 10.223.119.147 with SMTP id z19mr7779142faq.64.1280226291969;
        Tue, 27 Jul 2010 03:24:51 -0700 (PDT)
Received: from localhost.localdomain (abwn25.neoplus.adsl.tpnet.pl [83.8.237.25])
        by mx.google.com with ESMTPS id b11sm1842214faq.6.2010.07.27.03.24.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 27 Jul 2010 03:24:51 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o6RAOHjs027553;
	Tue, 27 Jul 2010 12:24:18 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o6RANn3N027545;
	Tue, 27 Jul 2010 12:23:49 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <buohbjll3l9.fsf@dhlpc061.dev.necel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151927>

Miles Bader <miles@gnu.org> writes:
> Sverre Rabbelier <srabbelier@gmail.com> writes:

>>> + =A0 =A0 =A0 } else if (!strcmp(arg, "--grep")) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_message_grep(revs, optarg);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 2;
>>
>> This one makes a little less sense since to me '--flag' are always
>> booleans, whereas '-m' can take an argument (such as '-m' from 'git
>> commit'.
>=20
> The fact that --grep requires the "=3D" is amazingly confusing if you=
're
> used to standard GNU long-argument parsing (which many standard
> utilities use, and which git's argument syntax is clearly modelled
> after), where both forms are equivalent, and documentation typically
> only refers to the "=3D" form, but implicitly allows the separate-arg=
s
> form.

I think that parseopt allows both sticky (-mfoo, --message=3Dfoo) and
non-sticky (-m foo, --message foo) forms, if I remember it correctly
with exception of arguments with *optional* parameters which require
sticky form.
=20
> I'm continually getting tripped up by git's idiosynchratic argument
> parsing, and it's nice to see it getting cleaned up a bit...

I guess that this solution is simpler than moving to parseopt... is
that because log options and diff options crop everywhere?  Do
parseopt have no support for sub-parsers, like e.g. argp from libc:

  (libc.info.gz)Argp
  (libc.info.gz)Argp Children   =20
  http://www.gnu.org/s/libc/manual/html_node/Argp-Children.html

--=20
Jakub Narebski
Poland
ShadeHawk on #git
