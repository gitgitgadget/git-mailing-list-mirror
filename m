From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] fix potential infinite loop given large unsigned integer
Date: Mon, 10 Aug 2009 07:24:52 +0200
Message-ID: <200908100724.53345.chriscool@tuxfamily.org>
References: <a3f15ee60908082141l7b2134cg5ddcef17c45fc888@mail.gmail.com> <7v3a81a13z.fsf@alter.siamese.dyndns.org> <40aa078e0908090525h7b4d6efeh658e2edcfbe16c7e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ryan Flynn <parseerror@gmail.com>, git@vger.kernel.org
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Aug 10 07:24:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MaNMo-0003MK-Hh
	for gcvg-git-2@gmane.org; Mon, 10 Aug 2009 07:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751779AbZHJFYJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Aug 2009 01:24:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbZHJFYJ
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Aug 2009 01:24:09 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:36785 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798AbZHJFYI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Aug 2009 01:24:08 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 1F8628180D3;
	Mon, 10 Aug 2009 07:24:00 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id E6E608180B5;
	Mon, 10 Aug 2009 07:23:57 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <40aa078e0908090525h7b4d6efeh658e2edcfbe16c7e@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125403>

On Sunday 09 August 2009, Erik Faye-Lund wrote:
> On Sun, Aug 9, 2009 at 9:38 AM, Junio C Hamano<gitster@pobox.com> wro=
te:
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 static char num_buf[64];
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rev.total =3D total + start_number -=
 1;
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 sprintf(num_buf, "%d", rev.total);
> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rev.num_width =3D strlen(num_buf);
>
> how about
> rev.num_width =3D (int)log10((double)rev.total) + 1;
>
> hm?
>
> log10() appears to be C99, but can be emulated on earlier C-versions =
by
> doing #define log10(x) (log(x) / log(10.0))

That would mean linking with -lm?

Regards,
Christian.
