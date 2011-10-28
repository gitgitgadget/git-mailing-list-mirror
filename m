From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git alias and --help
Date: Fri, 28 Oct 2011 06:26:04 -0700 (PDT)
Message-ID: <m362j95jv3.fsf@localhost.localdomain>
References: <j8clg9$ldh$1@dough.gmane.org>
	<7vfwiexe6m.fsf@alter.siamese.dyndns.org>
	<7v8vo6xd4u.fsf@alter.siamese.dyndns.org>
	<buoty6t9937.fsf@dhlpc061.dev.necel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Gelonida N <gelonida@gmail.com>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: Miles Bader <miles@gnu.org>
X-From: git-owner@vger.kernel.org Fri Oct 28 15:26:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJmRp-0006Fu-E5
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 15:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755806Ab1J1N0I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Oct 2011 09:26:08 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:36655 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752938Ab1J1N0G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Oct 2011 09:26:06 -0400
Received: by faan17 with SMTP id n17so3610003faa.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 06:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=2HftEisTmwfH/KkKfunWpJ6NULaXVWLpt40jJYCjn9o=;
        b=XwdqmfvfLAeUN5Ep/mVOGBz1wb9g7JO019Q/GVCu8GYlc4Bt9zulnw3qTRycdNq6rW
         gAzw+cCgR1aSa3uAfjG2Rdg2uBrIHkmcfXyVP/SNSILbF9cxyiayj+DHQdB9eic/97HU
         1u/nUqeFJZde1Z0HsokO49pP/gexnxRAN0E1I=
Received: by 10.223.64.207 with SMTP id f15mr6174609fai.7.1319808365080;
        Fri, 28 Oct 2011 06:26:05 -0700 (PDT)
Received: from localhost.localdomain (abvy192.neoplus.adsl.tpnet.pl. [83.8.222.192])
        by mx.google.com with ESMTPS id x19sm9765321fag.5.2011.10.28.06.26.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 28 Oct 2011 06:26:04 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p9SDPQCi032185;
	Fri, 28 Oct 2011 15:25:36 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p9SDP4dl032180;
	Fri, 28 Oct 2011 15:25:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <buoty6t9937.fsf@dhlpc061.dev.necel.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184407>

Miles Bader <miles@gnu.org> writes:
> Junio C Hamano <gitster@pobox.com> writes:

> > > > git branch --help
> > >
> > > How about "git help branch"?
> >
> > The reason why we do not do what you seem to be suggesting is becau=
se
> > giving the same behaviour to "git b --help" as "git branch --help" =
is
> > wrong.
>=20
> I agree with Gelonida's followup:  although what you say makes sense,
> it's still pretty annoying behavior for the very common case of a
> simple renaming alias...
>=20
> E.g., I have "co" aliased to "checkout", and so my fingers are very
> very inclined to say "co" when I mean checkout... including when
> asking for help.  I actually end up typing "git co --help", grumbling=
,
> and retyping with the full command name, quite reguarly.
>=20
> What I've often wished is that git's help system would output
> something like:
>=20
>    $ git help co
>    `git co' is aliased to `checkout'
>=20
>    Here's the help entry for `checkout':
>=20
>    GIT-CHECKOUT(1)                   Git Manual                   GIT=
-CHECKOUT(1)

Wouldn't it be more useful to say something like this:

  $ git co --help
  `git co' is aliased to `checkout'
=20
  You can see help entry for `checkout' with "git checkout --help"

Then help is only copy'n'paste away. =20

(This helping text probably should be controlled by some advice.*
config variable).


P.S. I wonder if allowing to run command if you specify unambiguous
prefix would be a good replacement for such aliases?

--=20
Jakub Nar=EAbski
