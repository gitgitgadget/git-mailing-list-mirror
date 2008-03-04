From: Michal Rokos <michal.rokos@nextsoft.cz>
Subject: Re: [PATCH] Configure test for FREAD_READS_DIRECTORIES
Date: Tue, 4 Mar 2008 12:17:36 +0100
Organization: NextSoft
Message-ID: <200803041217.37027.michal.rokos@nextsoft.cz>
References: <200803041048.53399.michal.rokos@nextsoft.cz> <7vod9u92fj.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 12:18:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWVA6-0006a7-43
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 12:18:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbYCDLRo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Mar 2008 06:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754218AbYCDLRo
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 06:17:44 -0500
Received: from holub.nextsoft.cz ([195.122.198.235]:41753 "EHLO
	holub.nextsoft.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756145AbYCDLRn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2008 06:17:43 -0500
Received: by holub.nextsoft.cz (Postfix, from userid 111)
	id 7BE1B8E3; Tue,  4 Mar 2008 12:17:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by holub.nextsoft.cz (Postfix) with ESMTP id 8BDA48E2;
	Tue,  4 Mar 2008 12:17:41 +0100 (CET)
Received: from holub.nextsoft.cz ([127.0.0.1])
	by localhost (holub.nextsoft.cz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 07929-02; Tue, 4 Mar 2008 12:17:41 +0100 (CET)
Received: from 89-24-113-79.i4g.tmcz.cz (89-24-113-79.i4g.tmcz.cz [89.24.113.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by holub.nextsoft.cz (Postfix) with ESMTP id 4270B6A9;
	Tue,  4 Mar 2008 12:17:41 +0100 (CET)
User-Agent: KMail/1.9.9
In-Reply-To: <7vod9u92fj.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Bogosity: Ham, tests=bogofilter, spamicity=0.000000, version=1.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76064>

Hello,

On Tuesday 04 March 2008 12:03:12 Junio C Hamano wrote:
> > +#
> > +# Define FREAD_READS_DIRECTORIES if your are on a system which suc=
ceeds
> > +# when attempting to read from an fopen'ed directory.
> > +AC_CACHE_CHECK([whether system succeeds to read fopen'ed directory=
],
> > + [ac_cv_fread_reads_directories],
> > +[
> > +AC_RUN_IFELSE(
> > +	[AC_LANG_PROGRAM([AC_INCLUDES_DEFAULT],
> > +		[[char c;
> > +		FILE *f =3D fopen("/etc", "r");
>
> Why "/etc" and not "." I have to wonder...

I think "." is brilliant - ie no reason for "/etc" apart that I'm dumb.

> On how many different platforms was this configure check tested on?

Test works on Linux (no FREAD_READS_DIRECTORIES) and HPUXes=20
(FREAD_READS_DIRECTORIES): HP-UX B.11.23 ia64 (Itanium) and HP-UX B.11.=
11=20
9000/800 (PaRisc)

Do you want me to resend with "."?

MR
--=20
Michal Rokos

NextSoft s.r.o.
Vysko=C4=8Dilova 1/1410
140 21 Praha 4
phone:  +420 267 224 311
fax:    +420 267 224 307
mobile: +420 736 646 591
e-mail: michal.rokos@nextsoft.cz
