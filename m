From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 3/7] gitweb: separate heads and remotes lists
Date: Fri, 17 Sep 2010 00:30:05 +0200
Message-ID: <201009170030.05999.jnareb@gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com> <1284629465-14798-4-git-send-email-giuseppe.bilotta@gmail.com> <AANLkTi=N=jyj8ueVNu601N9qtBktmC-kVv9+0jSA=Sv-@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: "=?utf-8?q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason" 
	<avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 17 00:30:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwMyD-000477-VR
	for gcvg-git-2@lo.gmane.org; Fri, 17 Sep 2010 00:30:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756608Ab0IPWaO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 18:30:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:37471 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754786Ab0IPWaN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Sep 2010 18:30:13 -0400
Received: by bwz11 with SMTP id 11so2073503bwz.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 15:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=im4bioQLRVRnXCeMZwGfHZWmZQG7iMv/xtVl5N9dN2c=;
        b=a72Reb2p01NsjOf8uAk5TguKv+vFWq5xzoXSE+W7phU49S9sQNXXpxrq+X5auuWblO
         gMh04sbLrzWIXIiWqoJ1mclO8QlWG9yxGbnlsLoHpridHKhXNXW6AQlKHt98P9L6O3Tf
         IkTCq/W7lwi0M1xXBeCje2+Fi/BrLZUCvnJ2s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=guO5wRQ5CaneY28stcYxOd9wVEd8Gr7py0yU7MqWq5UX6Wv2YFpKdipm8+MKANLw53
         MKdFzhVUEmFTlo1p8/VvBLLbq1OGbswx2a3sVvRVx0hiv1kF6cCa8TgD0kjacL82frQa
         5D6ZDJ7qQxye2hd1XnM4tjVmsVjpmkzN0cRBI=
Received: by 10.204.47.193 with SMTP id o1mr2997524bkf.134.1284676211794;
        Thu, 16 Sep 2010 15:30:11 -0700 (PDT)
Received: from [192.168.1.13] (abvm37.neoplus.adsl.tpnet.pl [83.8.210.37])
        by mx.google.com with ESMTPS id x19sm2962075bkv.21.2010.09.16.15.30.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 16 Sep 2010 15:30:10 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTi=N=jyj8ueVNu601N9qtBktmC-kVv9+0jSA=Sv-@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156358>

On Thu, 16 Sep 2010, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Sep 16, 2010 at 09:31, Giuseppe Bilotta
> <giuseppe.bilotta@gmail.com> wrote:
>=20
> > + =C2=A0 =C2=A0 =C2=A0 if (@remotelist) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_print_header=
_div('remotes');
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git_heads_body(\=
@remotelist, $head, 0, 15,
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$#remotelist <=3D 15 ? undef :
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0$cgi->a({-href =3D> href(action=3D=
>"remotes")}, "..."));
> > + =C2=A0 =C2=A0 =C2=A0 }
>=20
> Nit: The $# syntax is pseudo-deprecated, and since you use 16 as a
> constant above this would be clearer anyway:
>=20
>     @remotelist <=3D 16 ? undef : ...

Actually gitweb uses *15* as a constant above...=20

--=20
Jakub Narebski
Poland
