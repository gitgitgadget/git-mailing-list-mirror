From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: gitweb: Add committags support
Date: Fri, 08 Sep 2006 22:57:59 +0200
Organization: At home
Message-ID: <edslfm$tb9$1@sea.gmane.org>
References: <200609081246.56423.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Fri Sep 08 22:58:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLnQD-0000ec-GL
	for gcvg-git@gmane.org; Fri, 08 Sep 2006 22:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWIHU5n convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 8 Sep 2006 16:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751245AbWIHU5n
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 16:57:43 -0400
Received: from main.gmane.org ([80.91.229.2]:27089 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751244AbWIHU5n (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Sep 2006 16:57:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GLnPu-0000ay-RT
	for git@vger.kernel.org; Fri, 08 Sep 2006 22:57:40 +0200
Received: from host-81-190-21-28.torun.mm.pl ([81.190.21.28])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 22:57:38 +0200
Received: from jnareb by host-81-190-21-28.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 08 Sep 2006 22:57:38 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-28.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26708>

Jakub Narebski wrote:

> our %committags =3D (
> =A0=A0=A0=A0=A0=A0=A0=A0'commitsha' =3D> {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'pattern' =3D> qr/[0-=
9a-fA-F]{40}/,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'sub' =3D> sub {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0my $hash_text =3D shift;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0if (git_get_type($hash_text) eq "commit") {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0return
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$cgi->a({-href =3D> =
href(action=3D>"commit", hash=3D>$hash_text),
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0-cla=
ss =3D> "text"}, $hash_text);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0return undef;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'islink' =3D> 1,
> =A0=A0=A0=A0=A0=A0=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0'mantis' =3D> {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'pattern' =3D> qr/(BU=
G|FEATURE)\(\d+\)/,
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'options' =3D> [ 'htt=
p://bugs.xmms2.xmms.se/view.php?id=3D' ],
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'sub' =3D> sub {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0my $match =3D shift;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0my $URL =3D shift;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0my ($issue) =3D $match =3D~ /(\d+)/;
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0return
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0$cgi->a({-href =3D> "$URL$issue"},
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0 =A0 =A0$match);
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0},
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0'islink' =3D> 1,
> =A0=A0=A0=A0=A0=A0=A0=A0},
> );

Yet another committag:

        'URL' =3D> { # simple URL, no query strings
                   # because of the whole esc_html() + ' '->'&nbsp;' th=
ing
                'pattern' =3D> qr!(http|ftp)s?://[a-zA-Z0-9%./]+!,
                'sub' =3D> sub {
                        my $url =3D shift;
                        return
                                $cgi->a({-href =3D> $url},
                                        $url); # should be perhaps shor=
tened
                },
                'islink' =3D> 1,
        },

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
