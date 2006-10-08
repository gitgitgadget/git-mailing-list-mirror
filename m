From: Petr Baudis <pasky@suse.cz>
Subject: Re: Does GIT require property like Subversion?
Date: Sun, 8 Oct 2006 18:24:10 +0200
Message-ID: <20061008162410.GK20017@pasky.or.cz>
References: <4528C09B.3030004@gmail.com> <20061008091900.GG30283@lug-owl.de> <egaj49$424$1@sea.gmane.org> <200610081752.10940.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 18:24:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWbRp-00064C-25
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 18:24:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbWJHQYO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 8 Oct 2006 12:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWJHQYO
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 12:24:14 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44011 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751257AbWJHQYN (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 12:24:13 -0400
Received: (qmail 21650 invoked by uid 2001); 8 Oct 2006 18:24:10 +0200
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Content-Disposition: inline
In-Reply-To: <200610081752.10940.robin.rosenberg.lists@dewire.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28541>

Dear diary, on Sun, Oct 08, 2006 at 05:52:10PM CEST, I got a letter
where Robin Rosenberg <robin.rosenberg.lists@dewire.com> said that...
> *I* think git should use UTF-8 internally. Always. Clients could then=
 have
> the option to convert to local conventions.
>=20
> Same for pathname. Internally all paths should be UTF-8 encoded. Enco=
ding=20
> commit info that way would make the i18n option obsolete also.

There is a tradeoff here between independence of the data stored inside
Git on the system where you created it, and willingness to store any
awful garbage you feed inside. It goes down to a policy decision and Gi=
t
lefts it on the user and opting for garbage support, which gives it mor=
e
flexibility.

> s=F6ndag 08 oktober 2006 12:16 skrev Jakub Narebski:
> > But in fact the philosophy of Git _prohibits_ I think property bits=
=2E
> I don't think so, but they aren't needed for the original purpose. Gi=
t already
> does manage file permissions.

Incorrect, Git manages only the execute bit.

> > Unless we add ability (which can be done fairly easy even now, but =
will
> > not be automatic) to save some metainfo (ACL, extended attributes,
> > Subversion-like properties) along with the file (blob) and/or tree
> > (directory).
>=20
> A problem with adding too much metadata is that there is a cost to th=
is. We=20
> like GIT much thanks to it's perforrmance. Git simply gets out of the=
 way=20
> thanks to this. ACL's aren't content at all. Extended attributes howe=
ver are,=20
> but who uses them?

Execute bit isn't content at all either if you look at it this way. But
it's meaningless anyway since you can define content whichever way you
want (this is also why I consider the argument for not tracking
directories dubious).

--=20
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=3Dunpack('H*',$_);$_=3D`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=3Dpack('H*',/((..)*)$/)
