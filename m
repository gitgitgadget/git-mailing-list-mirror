From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] gitweb: Do not show 'patch' link for merge commits
Date: Fri, 9 Oct 2009 14:23:50 +0200
Message-ID: <200910091423.51286.jnareb@gmail.com>
References: <20090930201953.22301.73887.stgit@localhost.localdomain> <200910011118.02875.jnareb@gmail.com> <200910091410.15904.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 14:27:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwEYX-0001o4-8m
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 14:26:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758430AbZJIMZp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Oct 2009 08:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755220AbZJIMZp
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 08:25:45 -0400
Received: from fg-out-1718.google.com ([72.14.220.154]:20221 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbZJIMZo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 08:25:44 -0400
Received: by fg-out-1718.google.com with SMTP id 22so280658fge.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 05:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=c+2dul7npANVuJSpXg0YH4dxEOq/oXEYRBUlTSZx3kk=;
        b=Y5V+14TSUGS4SEAPJdqwj/kYSoFhQaD+eTkHJksEfvht/g1CyrqJ+HUH0SgTcaHtCx
         eFk4Bog8NiA/uX3hW3UcwBF+tZJ4n3/sfHYJKmG89cmHjm77l+6OAYvpj5AJ/PMIUT23
         hrfCAdLzV198Tg4FcSo9vTjpLvRf2rBOORGxo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=MscMMx9EPlS8cysTomiEm72u9dSnVBKNbVQqNK9qOHIOWNbzq177HZSJ37E03yEmnb
         sJI9kFlD7zP8VbX/iEic2v1/0/U30CbiQauA1rzmoGPm/LxLT4KK6ahXAGK7Zx54lruT
         VetjB2x2jKJzJtcXjwKehT6mfiZQhLJ414tL4=
Received: by 10.86.254.23 with SMTP id b23mr1761118fgi.21.1255091036192;
        Fri, 09 Oct 2009 05:23:56 -0700 (PDT)
Received: from ?192.168.1.13? (abve46.neoplus.adsl.tpnet.pl [83.8.202.46])
        by mx.google.com with ESMTPS id l19sm372492fgb.27.2009.10.09.05.23.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 05:23:53 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200910091410.15904.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129793>

Jakub Narebski wrote:

> @@ -5616,7 +5616,7 @@ sub git_commitdiff {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0$formats_nav =3D
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0$cgi->a({-href =3D> href(action=3D>"commitdiff_plain", -replay=3D>1)=
},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0"raw");
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if ($patch_max) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0if ($patch_max && =C2=A0&& @{$co{'parents'}} <=3D =
1) {

Gaaaah. It should be "&&", not "&&  &&".  I'm extremely sorry!

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0$formats_nav .=3D " | " .
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0$cgi->a({-href =3D> =
href(action=3D>"patch", -replay=3D>1)},
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0"patch");

--=20
Jakub Narebski
Poland
