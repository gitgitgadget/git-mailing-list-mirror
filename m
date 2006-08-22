From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFD] gitweb: href() function to generate URLs for CGI
Date: Tue, 22 Aug 2006 12:47:28 +0200
Organization: At home
Message-ID: <ecenc1$b5o$1@sea.gmane.org>
References: <200608211739.32993.jnareb@gmail.com> <7v1wrauex2.fsf@assigned-by-dhcp.cox.net> <eccujr$90h$1@sea.gmane.org> <7vlkphqmac.fsf@assigned-by-dhcp.cox.net> <eceekl$b0l$2@sea.gmane.org> <7vodudno88.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
X-From: git-owner@vger.kernel.org Tue Aug 22 12:48:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFTnp-0003sz-Be
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 12:48:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbWHVKsK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 22 Aug 2006 06:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWHVKsK
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 06:48:10 -0400
Received: from main.gmane.org ([80.91.229.2]:15815 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932157AbWHVKsI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 06:48:08 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1GFTnO-0003ly-Hz
	for git@vger.kernel.org; Tue, 22 Aug 2006 12:47:46 +0200
Received: from host-81-190-21-215.torun.mm.pl ([81.190.21.215])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 12:47:46 +0200
Received: from jnareb by host-81-190-21-215.torun.mm.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 22 Aug 2006 12:47:46 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-81-190-21-215.torun.mm.pl
Mail-Copies-To: jnareb@gmail.com
User-Agent: KNode/0.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25851>

Junio C Hamano wrote:

> Semicolons and equals are used as separators between key-value
> pairs (i.e. syntactic elements) so if we have a value
> $params{$name} that happens to contain a ';' or '=3D' character I
> suspect we would want to quote that but not the one we use
> before the value or between tuples. =A0Otherwise, how is a search
> text that is "a =3D b;" encoded in the resulting href?

URL for search is created and encoded by browser I think, so search
for "a =3D b" generates

        gitweb.cgi?p=3Dgit.git&a=3Dsearch&h=3DHEAD&s=3Da+%3D+b

URI (notice it uses '&' as parameter separator, not ';'),=20
but because '=3D' is not on the list of valid $searchtext characters,=20
due to=20

        if ($searchtext =3D~ m/[^a-zA-Z0-9_\.\/\-\+\:\@ ]/)

gitweb returns "403 Forbidden - Invalid search parameter".

--=20
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
