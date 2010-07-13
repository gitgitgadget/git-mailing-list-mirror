From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCHv2/RFC] gitweb: Prepare for splitting gitweb
Date: Tue, 13 Jul 2010 22:30:42 +0000
Message-ID: <AANLkTikyxqPHkNnVaN6kLNdbjxl69e_8Yuf1-n7CwnEg@mail.gmail.com>
References: <1278496676-26575-1-git-send-email-jnareb@gmail.com>
	<AANLkTinxDSS2G60_nQ12UqZpSJCvg_kfWYKzmTqJU7Ox@mail.gmail.com>
	<201007072205.14345.jnareb@gmail.com>
	<201007140024.58446.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Pavan Kumar Sunkara <pavan.sss1991@gmail.com>,
	Petr Baudis <pasky@ucw.cz>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 14 00:31:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYo0O-0005wm-7E
	for gcvg-git-2@lo.gmane.org; Wed, 14 Jul 2010 00:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756804Ab0GMWar convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 Jul 2010 18:30:47 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:48415 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756651Ab0GMWan convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Jul 2010 18:30:43 -0400
Received: by iwn7 with SMTP id 7so6295027iwn.19
        for <git@vger.kernel.org>; Tue, 13 Jul 2010 15:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=/DZPimGZK4pDzGm4+XgyGOyUKasvDnGGsIKl13kb7r8=;
        b=MG1uvQtGAnw60E01POGF8Pr35m4mSqMelxnIORpnF6VDBKhq5zEStI95/Ji9ius2pK
         0noHm+m8YQNr3GkRSigajYC9ZEuCBYXHg9oY0N79xRidg3kruoyl5K6h4u86wHvDRRQ5
         X6ZL9VlDWOo23b9J/9xCuAOHAHF/wdlkd2RkY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bTm36A/Ib578KzKJppEVCQ7mjNwG1nTo53U1koq4b2J/uVoktUKvm+egHmeREfZYVA
         9KwjZlAdE91yLZbmvgqd1VJqWNZIa/SY7jbKaJ8vP0kyNTHym7/AMy6ZKhgBuEx5i/9t
         Ph7cQWhfmEdv6Wag6T+EzARFFx54eAKaDXJyA=
Received: by 10.231.178.103 with SMTP id bl39mr15166571ibb.138.1279060242479; 
	Tue, 13 Jul 2010 15:30:42 -0700 (PDT)
Received: by 10.231.166.79 with HTTP; Tue, 13 Jul 2010 15:30:42 -0700 (PDT)
In-Reply-To: <201007140024.58446.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150934>

On Tue, Jul 13, 2010 at 22:24, Jakub Narebski <jnareb@gmail.com> wrote:

> I wrote simple script that tests result of __DIR__ and $FindBin::Bin.
> For cgi-bin / mod_cgi it was:
>
> =C2=A0__DIR__ =C2=A0 =C2=A0 =C2=A0 =3D /var/www/cgi-bin/gitweb (symli=
nk to /home/local/gitweb)
> =C2=A0$FindBin::Bin =3D /home/local/gitweb
>
> For mod_perl (ModPerl::Registry handler) it was
>
> =C2=A0__DIR__ =C2=A0 =C2=A0 =C2=A0 =3D /var/www/perl/gitweb (symlink =
to /home/local/gitweb)
> =C2=A0$FindBin::Bin =3D /
>
> As you can see it's useless. =C2=A0I have't checked the FastCGI case.=
=2E.

Thanks for spending time researching what was an offhand ignorant "hey
wasn't .." comment. Also, sorry :)

But that's very informative. Good to know that FindBin is broken like
that under mod_perl.
