From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/3] git-svn: Reduce temp file usage when dealing with
 non-links
Date: Tue, 12 Aug 2008 11:53:38 -0400
Message-ID: <48A1B202.5000204@griep.us>
References: <489DBB8A.2060207@griep.us> <1218470035-13864-1-git-send-email-marcus@griep.us> <1218470035-13864-2-git-send-email-marcus@griep.us> <1218470035-13864-3-git-send-email-marcus@griep.us> <1218470035-13864-4-git-send-email-marcus@griep.us> <20080812033700.GC14051@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Aug 12 17:55:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSwCv-0001bD-Ro
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 17:54:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752191AbYHLPxr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 11:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752133AbYHLPxr
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 11:53:47 -0400
Received: from wx-out-0506.google.com ([66.249.82.239]:14997 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137AbYHLPxq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 11:53:46 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1659949wxd.4
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 08:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=CbBFkCdz5buQPGTfTpDkbJw5FHx8brVcwhzcaW7cBjk=;
        b=lrE7NqKK1bhGFRS70ZjobWOgfvMVlNq1h1hOxuhZuqiadjrq5BSwxqiL2mQWn9H501
         SfekD/fhrlnCfErI5EWyOoZ0YgzNoALX4bLEKO8QGfkHWWVI/AtsfdEXVX/UZRid/Z5F
         c8/J3UAP4g1Mk/MZRMNevS7FSfxMTJ3nqDFyU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=k0mkFiOrLTcupJHFiyKIbD7Y71A/0wqpe1xcmtzJRFKOYMsyooEMoLIqbDOE7DrHkt
         I27XxTzzGV4aSiUSECp2eZYJzc8fhXPK3KE+wDfjbdmq1SM33sslqYyPmMRIu7O9nOkA
         5bsBIeiCFAFhgzj9fqHIybR+hjuOhjqftRMfU=
Received: by 10.90.49.8 with SMTP id w8mr7646922agw.104.1218556425566;
        Tue, 12 Aug 2008 08:53:45 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id m29sm4063334wrm.3.2008.08.12.08.53.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Aug 2008 08:53:42 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <20080812033700.GC14051@untitled>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92105>

Eric Wong wrote:
> Sweet optimization!  Thanks!

I'm glad to have found something significant.

> One thing, again, can you please make sure things don't exceed
> 80-columns when using 8 character-wide tabs?
>=20
> I'm not sure how much it matters to the guys maintaining Git.pm, but
> that's the standard for here and the Linux kernel (although it
> unfortunately seems to have gotten more lax in recent years...).
>=20
> Larger monitors can't help me because I use big fonts that would requ=
ire
> me to move my neck or eyes to see across the screen, leading to more =
eye
> and neck strain (I have a bad neck).  I very much wish ANSI had
> standardized on something even smaller, perhaps 64-char wide terminal=
s
> :)

I added a regex to the standard pre-commit hook to check line length, a=
nd
now it is working properly, even with tabs.  If people are interested, =
I
could submit a patch for the standard pre-commit hook that includes a l=
ine
length check.

Overall, expect new patches to be sent in reply to each email as versio=
n 2's.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
