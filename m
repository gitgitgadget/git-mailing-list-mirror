From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow test code to check the list of
 declared prerequisites
Date: Fri, 15 Oct 2010 00:34:14 -0500
Message-ID: <20101015053414.GC21830@burratino>
References: <20101014030220.GB20685@sigill.intra.peff.net>
 <20101014030505.GC5626@sigill.intra.peff.net>
 <20101014031642.GB14664@burratino>
 <20101014033448.GB28197@sigill.intra.peff.net>
 <20101014203721.GA28958@burratino>
 <20101014204001.GB28958@burratino>
 <AANLkTikkWw4Ju4jJFtvKX+s2LMkveQX-uBQyS41A=Vh2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <jrk@wrek.org>, Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chase Brammer <cbrammer@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 15 07:44:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6d5s-0003rh-CM
	for gcvg-git-2@lo.gmane.org; Fri, 15 Oct 2010 07:44:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756129Ab0JOFoa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Oct 2010 01:44:30 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:57135 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756119Ab0JOFo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Oct 2010 01:44:29 -0400
Received: by ywi6 with SMTP id 6so179773ywi.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 22:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=sPoW1ZqIPyDzPn+t/Nm+btAW1kBtIhq7A4ak7xOa/t4=;
        b=Dm9phAK8QAweo4/13WF3zNbUWEJo8FxTIZ4UrjpeMRbHvEQoWZuJmXZpbjk6EzCjNB
         8wgY7tof3O0cwkSdcbtEL9U567jfXd2oCS5t5cPHPWZU4cpB175dOROxJ3/iNrc97s0a
         nufqlPk0HFqPSdxFVa/o8a0wEn2DP7ShpFYxw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=VbtybhdBfaEj3kzDrcDGmW6w/osE7CHXne8JiZWRfZYSZ40pCnGooGsoxGvE3EUAit
         4ijPodOSNmh0MDcCG31WuLPc5W2piXaCiizV324IL0Qj/5m+G+crH+1z79/Flhs+LT47
         YND96KwrzCAgo/xRmLJRIaICOpHgtPynrRaY4=
Received: by 10.151.14.10 with SMTP id r10mr923657ybi.190.1287121061262;
        Thu, 14 Oct 2010 22:37:41 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id u3sm808826yba.10.2010.10.14.22.37.39
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 22:37:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikkWw4Ju4jJFtvKX+s2LMkveQX-uBQyS41A=Vh2@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159098>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> On Thu, Oct 14, 2010 at 20:40, Jonathan Nieder <jrnieder@gmail.com> w=
rote:

>> + =C2=A0 =C2=A0 =C2=A0 case ",$test_prereq," in
>> + =C2=A0 =C2=A0 =C2=A0 *,$1,*)
>
> Won't this only work with:
>=20
>     test_expect_success FOO,THINGYOUWANT,BAR '...'
>=20
> And not:
>=20
>     test_expect_success THINGYOUWANT,FOO,BAR '...'
>=20
> ?

	$ case ,X,FOO,BAR, in
	  *,X,*)
		echo ok
		;;
	  *)
		echo not ok
		;;
	  esac
	ok
	$

Looks safe to me.  A * can match any string, including the empty string=
[1].

[1] http://www.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.=
html#tag_18_13_02
