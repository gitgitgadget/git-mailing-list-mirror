From: =?ISO-8859-1?Q?J=E9r=E9mie_NIKAES?= <jeremie.nikaes@gmail.com>
Subject: Re: Git-mediawiki : Encoding problems in perl
Date: Wed, 8 Jun 2011 20:03:26 +0200
Message-ID: <BANLkTinE9+1cVk09KCP-iW=+GFbRdDAZFg@mail.gmail.com>
References: <BANLkTimy85b3nu05FBjXzdnTJP0RBWdxiQ@mail.gmail.com>
 <20110608150106.GB7805@sigill.intra.peff.net> <vpqhb8049m3.fsf@bauges.imag.fr>
 <BANLkTi=DLZQM_jzove_g0wLy_zgBF6Z0Xw@mail.gmail.com> <vpqtyc0wc1j.fsf@bauges.imag.fr>
 <BANLkTinKV3k7uu=+QzvUjrLdRD0TUj67pw@mail.gmail.com> <vpqsjrkqmdj.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, thomas@xteddy.org, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 08 20:03:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUN6e-0002kU-OU
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 20:03:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710Ab1FHSDr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Jun 2011 14:03:47 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:51358 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751396Ab1FHSDq convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2011 14:03:46 -0400
Received: by pvg12 with SMTP id 12so359916pvg.19
        for <git@vger.kernel.org>; Wed, 08 Jun 2011 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=UdxnNWupnfQztJrv16qnXAOpR+199lCfInu11MAOANw=;
        b=pbHZNCza4gUP+xSFCtf+n4xg1RkXGD1mGAxhVXRH+xW8QBS2JEygS5eZQp3kA3V8Sq
         AtG/++vVjG1ujplJG2H7m9beOCSDUB9tDmq4mqAikVDiKZ7woY26gvIrOzQqqNNKeXgi
         fVXJ78ElQ3a2ZtFwmKoGMoMAjaVfexq6ICjh4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=PLkzgJSK1WWxnbdg18tOVG0yOAuZQgnE/QhUXnoTjTJLF1N8JeXAU2TudLgNuBJLA2
         RKgBiurKbqEOrYRVB8LTQ73RUNYULLS8oIw+tK3LVvfykEGDYQ+HjgJuOrmgOV8loVzB
         mkZFqtfqlM19ljO6KK5LesaN1Gb9AUs9+1EdI=
Received: by 10.68.23.6 with SMTP id i6mr957371pbf.314.1307556226130; Wed, 08
 Jun 2011 11:03:46 -0700 (PDT)
Received: by 10.142.136.2 with HTTP; Wed, 8 Jun 2011 11:03:26 -0700 (PDT)
In-Reply-To: <vpqsjrkqmdj.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175415>

2011/6/8 Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>:

> $mw->edit( {
> =A0 =A0action =3D> 'edit',
> =A0 =A0title =3D> $title,
> =A0 =A0text =3D> $text,
> }, {
> =A0 =A0skip_encoding =3D> 1
> } ) || die $mw->{error}->{code} . ': ' . $mw->{error}->{details};
>
> Tried it, worked :-).
>
Yep this works if you manually set your $title variable earlier in the
code. However, I still have the problem which I think is on the git
side

- I pull the "Et=E9.mw" file from mediawiki
- I edit it
- When I commit it I get this message from git :
[master sha1] commit message
1 files changed [...]
create mode 100644 "Bl\303\251.mw"

As a result, when I parse commit information, the title of the file is
indeed Bl\303\251... so a new page is created on the mediawiki.

--=20
J=E9r=E9mie Nikaes
