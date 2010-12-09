From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH 0/2] [RFD] Using gitrevisions :/search style with other operators
Date: Thu, 9 Dec 2010 02:54:23 +0100
Message-ID: <201012090254.24999.jnareb@gmail.com>
References: <1291820319-12455-1-git-send-email-pclouds@gmail.com> <201012082051.09730.jnareb@gmail.com> <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 09 02:54:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQViT-00065n-RT
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 02:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab0LIByg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 8 Dec 2010 20:54:36 -0500
Received: from mail-bw0-f45.google.com ([209.85.214.45]:37573 "EHLO
	mail-bw0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756438Ab0LIByf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 20:54:35 -0500
Received: by bwz16 with SMTP id 16so2086116bwz.4
        for <git@vger.kernel.org>; Wed, 08 Dec 2010 17:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Q8u/duYyrKwPkA9lSeSnBmVXE7hWD4Oo4hadDZGK4LA=;
        b=TCHZNJICpGtKQ2d+X0FVoDUWbpyF7N9m9flmzEoY1jVrIoZuJObNv7E95naxOt8hhz
         FzyWyRKYSHVi6i+KeMFiDtpi8XCQKovwCCAZmLN3mRw97Kq1mM3b3pgqwYiiFFTz1JPn
         PJZUmM6labiN7Axs/ehcAl1gpK26pe5LaaSR0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=X31vq8NXRouuGRqh81eL3fpTaTWWO1X6bsj9Hqnk+8Cn9nK4XMsz9jm3KxBWCHWBKb
         f+lTl/5+M5C4c8QWYODupiy7kOjz5LMJryIJLPVGiTMViOtkmFX+QU+/Cv51LigimhbJ
         MuPdN8428pnw5OLRQcyiLzNSCruXSfVqhztlw=
Received: by 10.204.52.138 with SMTP id i10mr2670779bkg.23.1291859674226;
        Wed, 08 Dec 2010 17:54:34 -0800 (PST)
Received: from [192.168.1.13] (abvw115.neoplus.adsl.tpnet.pl [83.8.220.115])
        by mx.google.com with ESMTPS id q18sm664533bka.3.2010.12.08.17.54.31
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 08 Dec 2010 17:54:33 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimU6Bhx-2XsZ45_7BmT9fo9MpK8TJWB3zZ=j-i7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163255>

Nguyen Thai Ngoc Duy wrote:
> On Thu, Dec 9, 2010 at 2:51 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> Dnia =C5=9Broda 8. grudnia 2010 19:06, Jonathan Nieder napisa=C5=82:
>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>>>
>>>> Let's start off from where the previous discussion [1] stopped. Pe=
ople
>>>> seem to agree ref^{/regex} is a good choice. But we have not come =
to
>>>> conclusion how to specify the count yet. Possible suggestions are
>>>>
>>>> =C2=A0- ref^{/foo}2
>>>> =C2=A0- ref^{2/foo}
>>>> =C2=A0- ref^{:2/foo}
>>>> =C2=A0- ref^{2nd/foo}
>>>
>>> How about
>>>
>>> =C2=A0 =C2=A0 =C2=A0 ref^{/foo}^^{/foo}
>>>
>>> ?
>>
>> I'll assume that there is invisible ";)" emoticon here.
>>
>>
>> First, it would be ref^{/foo}^@^{/foo}, otherwise you would follow o=
nly
>> first parent.
>>
>> Second, consider ref^{:nth(10)/foo} in your workaround...
>=20
> Maybe we should generalize this to apply to all operators. Currently
> foo~3 is expanded to foo^^^. How about ~~X (or xN) denote repeat the
> last operator N times? For example, HEAD^2x3 =3D> HEAD^2^2^2,
> HEAD^{/foo}x3 =3D> HEAD^{/foo}^{/foo}^{/foo}.

Unless you allow grouping, it wouldn't help in the case of ^{/foo},
because ^{/foo} is idempotent.  HEAD^{/foo} finds first commit that
contains "foo", and HEAD^{/foo}^{/foo} finds first commit containing
"foo" starting from *and including* first commit from HEAD containing
"foo" - which is HEAD^{/foo}

  HEAD^{/foo}^{/foo} =3D=3D=3D HEAD^{/foo}

You would need HEAD{^{/foo}^@}x3, or use special rule that HEAD^{/foo}x=
2
means really HEAD^{/foo}^@^{/foo}, with ^@ used to join them.

--=20
Jakub Narebski
Poland
