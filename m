From: Eugen Konkov <kes-kes@yandex.ru>
Subject: Re[2]: Feature request: implement '--follow' option for `git blame`
Date: Mon, 13 Apr 2015 22:07:35 +0300
Organization: ISP FreeLine
Message-ID: <1962526577.20150413220735@yandex.ru>
References: <4215491428322362@web26m.yandex.ru> <xmqqvbh7baij.fsf@gitster.dls.corp.google.com> <209433431.20150410094038@yandex.ru> <xmqqiod04mq6.fsf@gitster.dls.corp.google.com>
Reply-To: Eugen Konkov <kes-kes@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1251
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: KES <kes-kes@yandex.ua>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 13 21:08:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yhjid-0007wP-Hs
	for gcvg-git-2@plane.gmane.org; Mon, 13 Apr 2015 21:08:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbbDMTIX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Apr 2015 15:08:23 -0400
Received: from forward18.mail.yandex.net ([95.108.253.143]:60502 "EHLO
	forward18.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751328AbbDMTIW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Apr 2015 15:08:22 -0400
Received: from smtp19.mail.yandex.net (smtp19.mail.yandex.net [95.108.252.19])
	by forward18.mail.yandex.net (Yandex) with ESMTP id EA58F1780C6F;
	Mon, 13 Apr 2015 22:08:19 +0300 (MSK)
Received: from smtp19.mail.yandex.net (localhost [127.0.0.1])
	by smtp19.mail.yandex.net (Yandex) with ESMTP id 83BE6BE04BD;
	Mon, 13 Apr 2015 22:08:19 +0300 (MSK)
Received: from 46.219.241.28.freenet.com.ua (46.219.241.28.freenet.com.ua [46.219.241.28])
	by smtp19.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id PVLcAs4FCJ-8IvWxPx5;
	Mon, 13 Apr 2015 22:08:18 +0300
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1428952098;
	bh=khb/Btlrv1598U9+QpA6ozH0gf5CqCAMtIuln5+5+8s=;
	h=Date:From:X-Mailer:Reply-To:Organization:X-Priority:Message-ID:To:
	 CC:Subject:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=Nw4MCaJePV+RVrFzqRKahzXIS2+GtwtRSidKw4tUJT5TPmZ0IwaTmTjEMq/m7ZrDn
	 63cJAAqIQZPCPM6Ja4QjUiBl7yhpPy6/U2LwOKpbI4qVw4am0DqJQpL4XPx1p2kjv/
	 c0vXEjbIKTiW/gr71efwy1BC37QNvPh1IDszaKhE=
Authentication-Results: smtp19.mail.yandex.net; dkim=pass header.i=@yandex.ru
X-Mailer: The Bat! (v4.0.24) Professional
X-Priority: 3 (Normal)
In-Reply-To: <xmqqiod04mq6.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267098>

=C7=E4=F0=E0=E2=F1=F2=E2=F3=E9=F2=E5, Junio.

=C2=FB =EF=E8=F1=E0=EB=E8 13 =E0=EF=F0=E5=EB=FF 2015 =E3., 8:32:33:

JCH> Eugen Konkov <kes-kes@yandex.ru> writes:

>> I agree with your complex example.

JCH> Note that it is a norm, not anything complex, that we do not renam=
e
JCH> a file wholesale.

>> But it will be great to guess in simple case, when in version v1.0
>> only one file A which were renamed into C half year later.

JCH> So you used to have A and somebody renamed that into C in the past=
=2E
JCH> The content of C in the current version is what you used to have i=
n
JCH> A.

JCH> What should happen if you also have A, whose contents do not have
JCH> any relation to that old A, in today's code?

JCH> What should happen if you also used to have C, whose contents do n=
ot
JCH> have any relation to that old A or current C?

JCH> What happens if you added such random guessing and you were not so
JCH> familiar with the project history to know these unrelated A's and
JCH> C's that used to exist in the past?

JCH> Current Git _consistently_ behaves, even in the presense of anythi=
ng
JCH> that can lead to confusing behaviour.  When you ask

JCH>     git blame OLD -- A

JCH> it does not matter if you have an unrelated A in the revision that
JCH> you happen to have checked out in your working tree (i.e. HEAD).
JCH> The above command line talks about the old revision OLD and A talk=
s
JCH> about the path A in that old revision.


Yes. you are right. I do not think about these examples.


--=20
=D1 =F3=E2=E0=E6=E5=ED=E8=E5=EC,
 Eugen                          mailto:kes-kes@yandex.ru
