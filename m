From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git apply: option to ignore whitespace differences
Date: Thu, 02 Jul 2009 11:29:07 -0700
Message-ID: <7vocs36irw.fsf@alter.siamese.dyndns.org>
References: <1246539137-24754-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1246539137-24754-2-git-send-email-giuseppe.bilotta@gmail.com>
	<7vws6r822y.fsf@alter.siamese.dyndns.org>
	<cb7bb73a0907021046x7fcb921bs86d55b69de540c9d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Robert Fitzsimons <robfitz@273k.net>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 02 20:29:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMR24-0003br-Da
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 20:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752206AbZGBS3G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2009 14:29:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751707AbZGBS3G
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 14:29:06 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:46621 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbZGBS3F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 14:29:05 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090702182907.JSLJ25927.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Thu, 2 Jul 2009 14:29:07 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id B6V71c00F4aMwMQ046V7o5; Thu, 02 Jul 2009 14:29:07 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=RzdjjvD8XIkA:10 a=pGLkceISAAAA:8
 a=ybZZDoGAAAAA:8 a=AtFXWiiOhRSUtd4OAhYA:9 a=u7UUiHGyqjVSq17pMOXiDoUbFG8A:4
 a=MSl-tDqOz04A:10 a=qIVjreYYsbEA:10
X-CM-Score: 0.00
In-Reply-To: <cb7bb73a0907021046x7fcb921bs86d55b69de540c9d@mail.gmail.com> (Giuseppe Bilotta's message of "Thu\, 2 Jul 2009 19\:46\:27 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122664>

Giuseppe Bilotta <giuseppe.bilotta@gmail.com> writes:

> On Thu, Jul 2, 2009 at 6:46 PM, Junio C Hamano<gitster@pobox.com> wro=
te:
>>> diff --git a/builtin-apply.c b/builtin-apply.c
>>> index dc0ff5e..86860d6 100644
>>> --- a/builtin-apply.c
>>> +++ b/builtin-apply.c
>>> @@ -39,6 +39,7 @@ static int diffstat;
>>> =C2=A0static int numstat;
>>> =C2=A0static int summary;
>>> =C2=A0static int check;
>>> +static int ignore_whitespace =3D 0;
>>
>> s/ =3D 0//;
>
> Ah, I wondered about that. I assume this leaves no possibility for
> uninitialized values because of the way option parsing is done?

It is not "uninitialized" to begin with.

C initializes static variables without explicit initial values to 0.
