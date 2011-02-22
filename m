From: Magnus =?iso-8859-1?Q?B=E4ck?= <magnus.back@sonyericsson.com>
Subject: Re: an error when using 'git send-email'
Date: Tue, 22 Feb 2011 19:48:45 +0100
Message-ID: <20110222184845.GA17440@jpl.local>
References: <AANLkTiktO_f9+g4+wSS989a=pFZBgWGcORd_kg4pji-x@mail.gmail.com>
 <20110220164427.GA1439@jpl.local>
 <AANLkTinssKFSqjk5ZCqzjZQWU_vFMDewY+3FSfR+_xMb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Yongqiang Yang <xiaoqiangnk@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 22 20:11:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Prxe7-0005Nx-K8
	for gcvg-git-2@lo.gmane.org; Tue, 22 Feb 2011 20:11:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752102Ab1BVTLd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 14:11:33 -0500
Received: from smtprelay-b11.telenor.se ([62.127.194.20]:58535 "EHLO
	smtprelay-b11.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab1BVTLd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 14:11:33 -0500
X-Greylist: delayed 1364 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Feb 2011 14:11:32 EST
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b11.telenor.se (Postfix) with ESMTP id 53797EBC49
	for <git@vger.kernel.org>; Tue, 22 Feb 2011 19:48:47 +0100 (CET)
X-SMTPAUTH-B2: [b627879]
X-SENDER-IP: [83.227.167.132]
X-LISTENER: [smtp.bredband.net]
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ArMPAOqTY01T46eEPGdsb2JhbACIaY5njkoMAQEBATUvvh6DHYJBBJJe
X-IronPort-AV: E=Sophos;i="4.62,207,1297033200"; 
   d="scan'208";a="1716434222"
Received: from ua-83-227-167-132.cust.bredbandsbolaget.se (HELO elwood.jpl.local) ([83.227.167.132])
  by ipb4.telenor.se with ESMTP; 22 Feb 2011 19:48:46 +0100
Received: by elwood.jpl.local (Postfix, from userid 1000)
	id D145B422AF; Tue, 22 Feb 2011 19:48:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <AANLkTinssKFSqjk5ZCqzjZQWU_vFMDewY+3FSfR+_xMb@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167574>

On Tuesday, February 22, 2011 at 14:30 CET,
     Yongqiang Yang <xiaoqiangnk@gmail.com> wrote:

> On Mon, Feb 21, 2011 at 12:44 AM, Magnus B=E4ck
> <magnus.back@sonyericsson.com> wrote:
>
> > You seem to have configured a username and password for SMTP
> > authentication, yet the server Git connects to doesn't support
> > authentication.
> >
> > Make sure the SMTP server you've configured Git to use
> > (sendemail.smtpserver configuration variable) is the right one.
> > If so, clear the smtpemail.smtpuser and smtpemail.smtppass
> > variables as you obviously can't use them with the server.
>
> Contents in my .gitconfig file are as follows.
> [sendemail]
>     smtpencryption =3D tls
>     smtpserver =3D smtp.gmail.com
>     smtpuser =3D xxxxxxx
>     smtpserverport =3D 587
>=20
> When I remove the line smtpuser.  Git said my config file is not
> correct.

According to your previous email you're running Git 1.5.6.5. That
version doesn't support STARTTLS in send-email, only SSL wrappermode.
Unless Gmail supports the latter on port 465 (which I seriously doubt)
you must either upgrade Git to 1.6.0 or later or have send-email submit
the messages to another SMTP host that can relay the message directly t=
o
the final destination or is capable of STARTTLS-based SMTP and thus abl=
e
to connect to Gmail on your behalf. Your Git is ancient so I strongly
suggest the upgrade approach.

--=20
Magnus B=E4ck                      Opinions are my own and do not neces=
sarily
SW Configuration Manager         represent the ones of my employer, etc=
=2E
Sony Ericsson
