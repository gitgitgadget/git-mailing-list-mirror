From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH/RFC v8 0/2] Gettext support for Git
Date: Sat, 05 Jun 2010 14:29:13 -0700 (PDT)
Message-ID: <m3vd9xp3oz.fsf@localhost.localdomain>
References: <1275772373-26718-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?iso-8859-15?q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 05 23:29:24 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL0vj-0007R8-2K
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 23:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933183Ab0FEV3R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 5 Jun 2010 17:29:17 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:41897 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932702Ab0FEV3P convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jun 2010 17:29:15 -0400
Received: by bwz11 with SMTP id 11so623900bwz.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 14:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=wyYWKdHqc9yVau7LIh+M89Ls7D8GiZxiAVqeAZpFSkA=;
        b=D/HiKD+cbyZmToSgP43oCHicmX1Cqk05SiR8JX/SzN4nSumlRZULc1kHxeKVTpug0T
         M3a4/JdBcx1gXusoB9WCDsBBQ2wfnzrY7KfxUJFsVB/MNvkrMnEqH3TPHCWcoJk49h41
         RkJlbO3PcTtfKd6yxcojyCQIdGHc1LB4uQpX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        b=miKrm+JgTfYjuKGB0LZSQ5bCVFj+vTx6QDg7v3BWTg422SYih3XSexpYHDaUn6HdKH
         ANgEf7UyTprD4CvINqr0SLxNo23BY4jMEZpTPgzjtIlUNnmNKmo4lTDTNr1qzJRyxuPz
         Yo7WmPeDueViAJU8jG3nBTgL3HbKPAvSfV840=
Received: by 10.204.83.85 with SMTP id e21mr5226366bkl.42.1275773353849;
        Sat, 05 Jun 2010 14:29:13 -0700 (PDT)
Received: from localhost.localdomain (aehn204.neoplus.adsl.tpnet.pl [79.186.195.204])
        by mx.google.com with ESMTPS id z17sm11700546bkx.0.2010.06.05.14.29.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 14:29:13 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o55LV4di014976;
	Sat, 5 Jun 2010 23:31:16 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o55LUr88014973;
	Sat, 5 Jun 2010 23:30:53 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <1275772373-26718-1-git-send-email-avarab@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148500>

=C6var Arnfj=F6r=F0 Bjarmason  <avarab@gmail.com> writes:

> This is version 8 of the series to make Git optionally translatable
> with GNU gettext.
>=20
> Changes since version 7:
[...]

>    * Add back support (and a new test) for the no-op N_() macro. This
>      is used for marking translations for later use, e.g.:
>        =20
>         const char help[] =3D
>         	N_("See 'git help COMMAND' for more information on a specifi=
c command.");
>        =20
>         int main(void)
>         {
>             puts(_(help));

Shouldn't you add also corresponding N__ subroutine to Git::I18N
module?

  # Dummy functions for string marking.
  sub N__($) {
  	return shift;
  }

--=20
Jakub Narebski
Poland
ShadeHawk on #git
