From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 08 Jun 2011 10:04:17 -0700 (PDT)
Message-ID: <m3y61cdzmi.fsf@localhost.localdomain>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: thomas@xteddy.org, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>
To: =?iso-8859-15?q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 19:04:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUMB8-0007NB-MH
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 19:04:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751181Ab1FHREV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 13:04:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:44438 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751343Ab1FHREV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 13:04:21 -0400
Received: by bwz15 with SMTP id 15so593775bwz.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 10:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:x-authentication-warning:to:cc:subject
         :references:from:date:in-reply-to:message-id:lines:user-agent
         :mime-version:content-type:content-transfer-encoding;
        bh=l+zsVB7mK746VPBSRz1A/0xKbjj3lJ1e7fr04VCNyEw=;
        b=NOT3mdVTjbVCCo4FwdxMv1f6VdVk5rUbNyTLxXrm9hfRAmnI6EbPAG/o4is1ZGmJCK
         Zs1RDfsxHQXQJoiU7NzsP+RapcY1ELY5IJHrFAtZbNUyYEk9zHZ99yoWtyTH5JvTu6+R
         gpbbhEOO8ebVGtpHF2DK4W+ntL7YlQq2gPZuw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=aCsqE+jsWv5FgG9b/pvUQKQsCUkhZBEfBqNPMUv3sbbkmNExoObMKsxA7q2ES4pBYI
         SNOhYclHcz5zYMhMZDzJywujM9R6Ap8kvvWbR5+1vHz3PvUEX6JNAghCBAXp9BtzNK21
         0ew9SK8SGFTlTZk81TcsLOMsjjP48pOPloH7U=
Received: by 10.204.14.147 with SMTP id g19mr1284689bka.11.1307552658323;
        Wed, 08 Jun 2011 10:04:18 -0700 (PDT)
Received: from localhost.localdomain (abvo166.neoplus.adsl.tpnet.pl [83.8.212.166])
        by mx.google.com with ESMTPS id q20sm746867bka.5.2011.06.08.10.04.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 08 Jun 2011 10:04:17 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p58H3jFL019974;
	Wed, 8 Jun 2011 19:03:56 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p58H3Y62019962;
	Wed, 8 Jun 2011 19:03:34 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175400>

J=E9r=E9mie NIKAES <jeremie.nikaes@gmail.com> writes:

> While working on the git-mediawiki project[1], we ran into some
> problems regarding utf8 encoding of files. Most of them have been
> solved, however, one is still pretty annoying.
> Let me illustrate it :
>=20
> I want to edit a page on mediawiki using the API, with a very simple =
example :
>=20
> my $mw =3D MediaWiki::API->new();
> $mw->edit( {
>         action =3D> 'edit',
>         title =3D> 'Main_page',
>         text =3D> '=E9t=E9',
> } ) ;
>=20
> But, when I look at the page on mediawiki, I see weird characters : =C3=
=A9t=C3=A9.

Take a look at

  http://stackoverflow.com/questions/6162484/why-does-modern-perl-avoid=
-utf-8-by-default

especially accepted answer.


In short (I don't agree with everything there, and not everything is
needed for all but extremal Unicode usage): if your script is written
using UTF-8 like in above examples, use

  use utf8;

If this is simplification, and this text comes from other file or is
result of output of some command, use

  use utf8::all;

or take a look what it does and put relevant parts in your script.
=20
> I tried text =3D> encode_utf8('=E9t=E9') with no success.
>=20
> This makes pushing changes from git to mediawiki buggy since pulling =
a
> file with accentuated characters and pushing it right after changes
> things on the wiki.
>=20
> While googling (a lot), I found that utf8 was pretty tricky in perl..=
=2E
> The only thing that seems to solve things is a simple addition of 'us=
e
> encoding utf8' at the top of our script.
> However
> A) Adding this line requires that I remove 'use strict;'

  use encoding ':utf8';

or

  use encoding 'utf8';

> B) I found some information about this pragma encoding and it seems t=
o
> be unadvised to use it

--=20
Jakub Narebski
Poland
ShadeHawk on #git
