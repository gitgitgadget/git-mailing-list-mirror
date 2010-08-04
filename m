From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] tests: A new test prereq for testing chmod -w as root
Date: Wed, 4 Aug 2010 15:40:15 -0500
Message-ID: <20100804204015.GA2920@burratino>
References: <1280934026-25658-1-git-send-email-avarab@gmail.com>
 <7veieefaym.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 04 22:41:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OgkmW-0007Qt-Ok
	for gcvg-git-2@lo.gmane.org; Wed, 04 Aug 2010 22:41:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934753Ab0HDUlj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Aug 2010 16:41:39 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:53700 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934762Ab0HDUlh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Aug 2010 16:41:37 -0400
Received: by vws3 with SMTP id 3so4451844vws.19
        for <git@vger.kernel.org>; Wed, 04 Aug 2010 13:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H1Gyfg04hL3GHdp9cMw4GTfGeReFWbJN4eAlc+i8y+Q=;
        b=mHc76DJ4BJspYEXeYfHgwDpFju4HJ+n5lf/HZr0uoo6UrtMgCM3PzWAqQ6Zawoqhfg
         PoXi+TOrQUk81sKE/xQFAnJ8SpzwFT5tzLm64cAyFGEGqhl42afGeuUzSpqrEz+Vpg4G
         fWeWsrFci/zTG+SGVKnbEi4htMEnyJPdwPbMU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ktxswwjPt0R1xN35JmajvlpjjuudYlGJzX4Tf88XUsaIIRwaPWKErD2RXd9andhdL/
         rxVgWaGW42FzofY7oXIV+VXWqNiJ66x40yQ+8gtS/r0Wus7GAe4sAbXYXpM6z3X+uRpW
         ZuWcyL9r4Hs1sJ4PHQoVh7VnUHLhWPYFpdRQc=
Received: by 10.220.166.71 with SMTP id l7mr6559985vcy.149.1280954495448;
        Wed, 04 Aug 2010 13:41:35 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id k30sm7836410vbl.19.2010.08.04.13.41.34
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 04 Aug 2010 13:41:34 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7veieefaym.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152602>

Hi =C3=86var,

Junio C Hamano wrote:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

>> Some tests depend on not being able to read files after chmod -w. Th=
is
>> doesn't work when running the tests as root.
>
> Obviously you meant s/read/write/ or "chmod -r" ;-)
>=20
> We discussed this prerequisite in the past as "SANITY"
[...]
> Also I think there was a discussion and proposed patch to support mor=
e
> than one prerequisite tokens, concatenated with "," or something

Thanks for picking up this topic.  Here=E2=80=99s some related work:

 - Incomplete series using space-separated test prerequisites:
   http://thread.gmane.org/gmane.comp.version-control.git/145427

 - Why that series is incomplete:
   http://bugs.debian.org/cgi-bin/bugreport.cgi?msg=3D104;bug=3D579273

 - Comma-separated test prerequisites:
   http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=3D=
118434

 - Earlier.
   http://thread.gmane.org/gmane.comp.version-control.git/116729/focus=3D=
118385

>     test_expect_success POSIXPERM,SANITY

Last time I looked, IFS=3D, as used by Hannes looked like a sane
approach.  I noticed too late and did not follow up; sorry about that.
