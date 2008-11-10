From: Michal Nazarewicz <mina86@tlen.pl>
Subject: Re: Something like $Id$, $Revision$ or $Date$?
Date: Mon, 10 Nov 2008 21:00:56 +0100
Message-ID: <871vxjl5af.fsf@erwin.mina86.com>
References: <87ljvsjuq7.fsf@erwin.mina86.com>
	<m3iqqvefmo.fsf@localhost.localdomain>
	<8763mvlbwb.fsf@erwin.mina86.com>
	<200811101903.27685.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 10 21:02:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kzcy1-0002qR-0w
	for gcvg-git-2@gmane.org; Mon, 10 Nov 2008 21:02:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbYKJUBK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Nov 2008 15:01:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbYKJUBK
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Nov 2008 15:01:10 -0500
Received: from el-out-1112.google.com ([209.85.162.177]:49110 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750973AbYKJUBI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Nov 2008 15:01:08 -0500
Received: by el-out-1112.google.com with SMTP id z25so1220959ele.1
        for <git@vger.kernel.org>; Mon, 10 Nov 2008 12:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :x-url:x-pgp-fp:x-pgp:date:in-reply-to:message-id:user-agent
         :mime-version:content-type:sender;
        bh=w83m1guxDEV0X1YGJd/CNC3B/BIePbJbtUu1ytCQGxQ=;
        b=ijVoeqglCvnY6AUTVmTF9RBw34pEWrHEl0OX3MC/i1TipS8AAv+9ybMrX+1nFiWS2L
         alFceUPGT8b/rWT5mKDmLhCiPGtfPRb9OF/psoZ0Ml/+jbKWbuJVZHX4Fb0MQdqm9bji
         LE1BeGpzmMGHHn95CbPHmZEm3knx4dVRqhEHo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:x-url:x-pgp-fp:x-pgp:date:in-reply-to
         :message-id:user-agent:mime-version:content-type:sender;
        b=sa2HlByiIqxB1Ffw3PsCnfR8TUsN2htR6+AI6rM5Y5qdO/tjJo3ktWCfu6a9EYb7Kx
         WqG63YImERrSqBiDc9rZDS5jdzQrbUPDCGWNjX1/LN7dcaaAzIg0Rwi/cdlZ8qIWflSO
         y30I5J4eNFTTy75RQDOzHNsqd4X/mZsMwqwlg=
Received: by 10.103.5.20 with SMTP id h20mr1289212mui.123.1226347266340;
        Mon, 10 Nov 2008 12:01:06 -0800 (PST)
Received: from erwin.piotrekn (cnr161.neoplus.adsl.tpnet.pl [83.31.171.161])
        by mx.google.com with ESMTPS id j9sm33763968mue.3.2008.11.10.12.01.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 10 Nov 2008 12:01:05 -0800 (PST)
X-Url: http://mina86.com/
X-PGP-FP: 9134 06FA 7AD8 D134 9D0C  C33F 532C CB00 B7C6 DF1E
X-PGP: B7C6DF1E
In-Reply-To: <200811101903.27685.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 10 Nov 2008 19:03:27 +0100")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0 (Slckware Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100555>

--=-=-=
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Jakub Narebski <jnareb@gmail.com> writes:

> Dnia poniedzia=B3ek 10. listopada 2008 18:38, Michal Nazarewicz napisa=B3:
>> Jakub Narebski <jnareb@gmail.com> writes:
>>=20
>> > The reason why git doesn't support keywords like $Revision$ or $Date$
>> > is performance: the $Revision$ and $Date$ are keywords related to
>> > _commit_ data, not blob data.=20
>>=20
>> In my case identifying content not commit would be even better.
>
> Well, in that case using `ident` attribute would be enough
> (but cryptic).

Yes, but it forces me to do some voodoo magic (ie. checkout) to get the
Id in the file, ;) like so:

#v+
$ echo '$Id$' >bar && git add bar && git commit -m 'Added bar' && cat bar
Created commit d49d436: Added bar
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 bar
$Id$
$ rm bar && git checkout bar && cat bar
$Id: 055c8729cdcc372500a08db659c045e16c4409fb $
#v-

But never mind, since it seems hard to accomplish in git, I'll have to
learn to live without it. ;)

=2D-=20
Best regards,                                         _     _
 .o. | Liege of Serenly Enlightened Majesty of      o' \,=3D./ `o
 ..o | Computer Science,  Michal "mina86" Nazarewicz   (o o)
 ooo +--<mina86*tlen.pl>--<jid:mina86*jabber.org>--ooO--(_)--Ooo--

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkkYkv0ACgkQUyzLALfG3x7vOgCglJcIa+r4WBveF1KRw6H2ld33
uUsAoKqOO8NsPKqh8l+u7dZkzwGLAgii
=heRy
-----END PGP SIGNATURE-----
--=-=-=--
