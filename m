From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH 2/3] gitweb: Support caching projects list
Date: Mon, 17 Mar 2008 21:25:38 +0100
Message-ID: <200803172125.39150.jnareb@gmail.com>
References: <1205766570-13550-1-git-send-email-jnareb@gmail.com> <200803171952.15186.jnareb@gmail.com> <20080317191029.GE18624@mail-vs.djpig.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	"J.H." <warthog19@eaglescrag.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Mon Mar 17 21:34:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbM2o-00029t-AU
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 21:34:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757743AbYCQUeI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Mar 2008 16:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757688AbYCQUeI
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 16:34:08 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:2812 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757541AbYCQUeG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 16:34:06 -0400
Received: by py-out-1112.google.com with SMTP id u52so7963090pyb.10
        for <git@vger.kernel.org>; Mon, 17 Mar 2008 13:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=IU+la+dqFZ8pwivDgdGu9D/Ym52SOPgF9cS3/zMtfQ0=;
        b=TW+qBngnO9Pgw436L6t3pfgF9snU3YMf0nUJPRCF8mXz2mF8Pgo+yk05se1jIro4NUgWEYN/PzPPxiW6oW3zc+sx0EDl82amGmfj1aDdNnvUVULvKRgl6URc3DTSC4ht9xMTea3UE48sNan+ZvmIyzP20jUwvZmkSHf4ry0Jq00=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=w9GlhjLUQE6IqL4Agx3niBQs71A2eIHFAFrUJdx5IlsofyrjJ1jhIvJ5jrrmdw2Hd07IHrZW8exqJoKtDu5Fx0y5oEPZd8e2hmYg/6rd8wSqYNoT7Lf/hmgGOLEV3CSGtwaBpYp3h9Tn0i65I90G0ZAxDBjLXMI88V1dSAv6lzM=
Received: by 10.35.33.5 with SMTP id l5mr1029142pyj.59.1205786027680;
        Mon, 17 Mar 2008 13:33:47 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.213.235])
        by mx.google.com with ESMTPS id g1sm38652202muf.5.2008.03.17.13.33.43
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Mar 2008 13:33:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080317191029.GE18624@mail-vs.djpig.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77463>

Dnia poniedzia=C5=82ek 17. marca 2008 20:10, Frank Lichtenheld napisa=C5=
=82:
> On Mon, Mar 17, 2008 at 07:52:13PM +0100, Jakub Narebski wrote:
>> Dnia poniedzia=C5=82ek 17. marca 2008 17:54, Frank Lichtenheld napis=
a=C5=82:
>>=20
>>>At the very least you should:
>> [...]
>>> =C2=A0- Check if the file is owned by the uid gitweb is running und=
er and
>>> =C2=A0 =C2=A0not word-writable.
>>=20
>> UID ($>) or PID ($$) should be equal to cache owner: stat($file)->ui=
d?
>=20
> I'm not sure what the PID has to do with anything here?
> But yeah, $> was what I meant.
> (Although I actually prefer to use POSIX::geteuid instead, since I ca=
n
> understand that faster).

Actually what I wanted to ask was UID ($<) vs EUID ($>), or appropriate
POSIX::get*uid functions.

--=20
Jakub Narebski
Poland
