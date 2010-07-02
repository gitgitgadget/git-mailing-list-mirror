From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] git-cvsserver: pserver-auth-script
Date: Fri, 02 Jul 2010 14:31:48 -0700 (PDT)
Message-ID: <m31vbloa6m.fsf@localhost.localdomain>
References: <20100702095406.7af15d20@ashinlaszlo.pta.neti.hu>
	<AANLkTinGZsCLF8CFKgQJaB63Jh9anGfQK4ZSHFPl4R4N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?iso-8859-15?q?L=E1szl=F3_=C1SHIN?= <laszlo.ashin@neti.hu>,
	git@vger.kernel.org
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 23:32:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUnqc-0002gu-Kp
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 23:32:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751649Ab0GBVc3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 17:32:29 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37435 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238Ab0GBVc2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jul 2010 17:32:28 -0400
Received: by bwz1 with SMTP id 1so1817327bwz.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 14:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=igLMKHbXBXeS7ogmR/IxhWFwBGSOjiSa8KPfIrUkeU0=;
        b=Y6QNtfGMFPnik33w7GKlk2ZDiwr7OMgAdaHyjunaq76lLLSntJuDNqWZw87vt2BZ3A
         iz0BPcr9fAgyk1+10Mn780bKYowNxQxKd9immkMaTvT4N96d0wcgVtQ92TdG9TxUyBDH
         DP8/5tP2nV/2Fs9GOB8JhX4E00dBI8vgsKAVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=cLrHQohRM37RmPC7GtjDRhcKd/g3PA/cTt0u/3/ZvhJ81toUjsEqLBfSc6NAt7zEZK
         1FCj/x2XJI9BxdmF17R1BmKuB76ItM3snUQqmk4ET6EyDEXlyqD9AmgDee0w+3C54oO4
         lS6rxJ4OIw5z13KwekRMcRGBSfLILe1ARbITk=
Received: by 10.204.84.99 with SMTP id i35mr1093147bkl.165.1278106309807;
        Fri, 02 Jul 2010 14:31:49 -0700 (PDT)
Received: from localhost.localdomain (abwh100.neoplus.adsl.tpnet.pl [83.8.231.100])
        by mx.google.com with ESMTPS id r10sm4651291bkh.12.2010.07.02.14.31.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 14:31:48 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o62LHrWZ004296;
	Fri, 2 Jul 2010 23:18:04 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o62LHbUh004292;
	Fri, 2 Jul 2010 23:17:37 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <AANLkTinGZsCLF8CFKgQJaB63Jh9anGfQK4ZSHFPl4R4N@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150168>

=C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
> On Fri, Jul 2, 2010 at 07:54, L=E1szl=F3 =C1SHIN <laszlo.ashin@neti.h=
u> wrote:
>=20
> > +
> > + =A0 =A0 =A0 =A0 =A0 =A0open SCRIPTIN, '|' . $authscript or die $!=
;
> > + =A0 =A0 =A0 =A0 =A0 =A0print SCRIPTIN $user . "\n";
> > + =A0 =A0 =A0 =A0 =A0 =A0print SCRIPTIN descramble($password) . "\n=
";
> > + =A0 =A0 =A0 =A0 =A0 =A0close SCRIPTIN;
>=20
> Nit: Nice use of three-arg open, but you should use lexical
> filehandles instead. I.e.:
>=20
>     open my $script, '|' . $authscript or die $!;
>     ...

This is two-argument open, not three-argument magic open.  There is
string concatenation operator '.' there, not a comma ',' delimiting
arguments.

It should be

   open my $script_fd, '|-', $authscript
   	or die "Couldn't open authentication script '$authscript': $!";
=20
> > + =A0 =A0 =A0 =A0} else {
> > + =A0 =A0 =A0 =A0 =A0 =A0if (not exists $cfg->{gitcvs}->{authdb}) {

Why not elsif?

> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0print "E the repo config file need=
s a [gitcvs] section with an 'authdb' parameter set to the filename of =
the authentication database\n";

Overly long line.  Perhaps it would be better to split it into
concatenated parts.


> > + =A0 =A0 =A0 =A0 =A0 =A0my $auth_ok;
> > + =A0 =A0 =A0 =A0 =A0 =A0open my $passwd, "<", $authdb or die $!;

And here you use three-argument form of (ordinary) open.

> > + =A0 =A0 =A0 =A0 =A0 =A0while (<$passwd>) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (m{^\Q$user\E:(.*)}) {
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (crypt($user, descrambl=
e($password)) eq $1) {

Why nested if, and not short-circuit &&?

    + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (/^\Q$user\E:(.*)/ &&
    + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0crypt($user, descramble($p=
assword)) eq $1) {
   =20
--=20
Jakub Narebski
Poland
ShadeHawk on #git
