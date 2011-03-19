From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 2/2] gitweb: introduce localtime feature
Date: Sat, 19 Mar 2011 22:41:13 +0100
Message-ID: <201103192241.13589.jnareb@gmail.com>
References: <ab54ba2199cc7487e383a31e3aa65885@localhost> <201103192209.29759.jnareb@gmail.com> <AANLkTikw7_9Q0MgVZZxX_dXvcxoXfx5VEmRQkVH_k1YC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kevin Cernekee <cernekee@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 19 22:41:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q13tl-0006LM-1f
	for gcvg-git-2@lo.gmane.org; Sat, 19 Mar 2011 22:41:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757649Ab1CSVlS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2011 17:41:18 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40369 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757637Ab1CSVlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Mar 2011 17:41:16 -0400
Received: by fxm17 with SMTP id 17so4600938fxm.19
        for <git@vger.kernel.org>; Sat, 19 Mar 2011 14:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=OxXrFlUrAs6Ou0lDCr5MTK0x4kmjBcjYwiqWjhBc378=;
        b=UWl3GnVS2uDgd7l7bQiyh7VjxAu0eiXpinJj0ZQ5dmEHnR/l4caYKE4jSh9873u72G
         CwsxGrYyIMdKub9PMraXz/dw30jHxOVht+/fBiwyB7n3Ybp6ZjutHpz3eH3x3ltmGsiP
         63LzuA6s8OGTSmoX7Bruy/RjvlJrfVLmrQYVc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=foFIlMJF8tVqfWyyuzeox8PJrwcdSlszUI+tC1JZc5rPCE+UOcq94GodFVz+oAhCWb
         CTgu8rkEh3s+g6QfttCW0YFJWiHBEJOHzWoAWcoL26VKoVrfen8fxzlXA97xB3C/V24g
         MWIGFX6pjsFAAtEv4UfgOxLFLW96IDAi0Iods=
Received: by 10.223.6.198 with SMTP id a6mr2918665faa.126.1300570875752;
        Sat, 19 Mar 2011 14:41:15 -0700 (PDT)
Received: from [192.168.1.13] (abrz59.neoplus.adsl.tpnet.pl [83.8.119.59])
        by mx.google.com with ESMTPS id o12sm1692512fav.30.2011.03.19.14.41.13
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 19 Mar 2011 14:41:14 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTikw7_9Q0MgVZZxX_dXvcxoXfx5VEmRQkVH_k1YC@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169467>

Kevin Cernekee wrote:
> On Sat, Mar 19, 2011 at 2:09 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:

> > =C2=A0sub timestamp_html {
> > =C2=A0 =C2=A0 =C2=A0my %date =3D %{ shift };
> > =C2=A0 =C2=A0 =C2=A0my %opts =3D @_;
>=20
> This did not work for me. =C2=A0It interprets "shift" as a variable n=
ame.

Damn autoquoting ('shift' is taken as bareword here).

Either

        my %date =3D %{ shift @_ };

or

        my %date =3D %{ +shift };

works.  Not that it matter much...
--=20
Jakub Narebski
Poland
