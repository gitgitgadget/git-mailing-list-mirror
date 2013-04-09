From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH 3/4] gitweb: Don't append ';js=(0|1)' to external links
Date: Tue, 09 Apr 2013 19:59:05 +0200
Message-ID: <516456E9.9070309@gmail.com>
References: <m2wqscbx83.fsf@blackdown.de> <516430D5.6030201@gmail.com> <m2mwt7a8tz.fsf@zahir.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?B?SsO8cmdlbiBLcmVpbGVkZXI=?= <jk@blackdown.de>
X-From: git-owner@vger.kernel.org Tue Apr 09 19:59:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPcp9-0002zW-Ld
	for gcvg-git-2@plane.gmane.org; Tue, 09 Apr 2013 19:59:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934440Ab3DIR7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 9 Apr 2013 13:59:11 -0400
Received: from mail-ea0-f170.google.com ([209.85.215.170]:50468 "EHLO
	mail-ea0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759838Ab3DIR7J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Apr 2013 13:59:09 -0400
Received: by mail-ea0-f170.google.com with SMTP id a15so3072189eae.29
        for <git@vger.kernel.org>; Tue, 09 Apr 2013 10:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=7O5lnEoEl1pUM2wRMenuKT27gMKHfJgwiiPynr1eCuM=;
        b=rDEREs7YLW1htzIdXYBv5Xoq8i6HhblThm4o8+4ckV6HhgotgWWpfhpkSk/0nVxsqL
         6I27B0NW+up+BPAKFGQFGCVVy/8srbn7IDEOHURNCC+cSR1w3Ek7ZZvMWC03TzdaDVI0
         PGLuVhHyB1aOVsiZx0z7eXFQAEWh32rT9PCMmGTpLKByQErG/ZJKP2nhbSGkJarusGgw
         Dh82IUKDGPfLuXUNkVxW8m164G7GsLJyOgR/3AdSFPysh0FkVL55LiWlaQC0CxeJMxLo
         dQNIzrHTd1q1wG4DXfSRazwN2/7TzYtiigy/RWLxtzsjlPfaJyBSQsF5AoSg9SoFqHmH
         G18w==
X-Received: by 10.15.35.193 with SMTP id g41mr17202934eev.45.1365530348345;
        Tue, 09 Apr 2013 10:59:08 -0700 (PDT)
Received: from [192.168.1.14] (dce9.neoplus.adsl.tpnet.pl. [83.23.56.9])
        by mx.google.com with ESMTPS id f47sm39343707eep.13.2013.04.09.10.59.06
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 09 Apr 2013 10:59:07 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <m2mwt7a8tz.fsf@zahir.fritz.box>
X-Enigmail-Version: 1.5.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220604>

W dniu 09.04.2013 19:54, J=C3=BCrgen Kreileder napisa=C5=82:
> Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
>=20
>> J=C3=BCrgen Kreileder wrote:
>>
>>> Don't add js parameters to links outside of gitweb itself.
>>
>> Hmmm... this limits adding ';js=3D(0|1)' to only links which begin w=
ith
>> $my_url, i.e. absolute links beginning with gitweb's base URL.
>>
>> Wouldn't that mean that most internal gitweb-generated links wouldn'=
t
>> get ';js=3D(0|1)'?  href(..., -full =3D> 1) is not the default...
>=20
> No, link.href is always absolute in JavaScript - even if the emitted =
URL
> was relative.

Thanks, I didn't know that.

So, with that explanation:

Acked-by: Jakub Narebski <jnareb@gmail.com>

> Old: https://git.blackdown.de/old.cgi?p=3Dcontactalbum.git;a=3Dsummar=
y;js=3D1
> New: https://git.blackdown.de/?p=3Dcontactalbum.git;a=3Dsummary;js=3D=
1
>=20
> With the old version the external links in the description got ';js=3D=
1'
> appended.  With the new version, ';js=3D1' isn't on those links.
> Other links are the same in both versions.

Thanks.  This is a nice solution for a problem which I didn't know
how to solve (I was thinking about using <a class=3D"internal" ...>,
but your solution is better).

--=20
Jakub Nar=C4=99bski
