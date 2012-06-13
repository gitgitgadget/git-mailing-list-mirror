From: =?UTF-8?B?WmJpZ25pZXcgSsSZZHJ6ZWpld3NraS1Tem1law==?= 
	<zbyszek@in.waw.pl>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 13 Jun 2012 23:07:32 +0200
Message-ID: <4FD90114.50006@in.waw.pl>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr> <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org> <4FD89DD6.1070705@in.waw.pl> <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr> <7vipevgjhp.fsf@alter.siamese.dyndns.org> <20120613213836.Horde.qI8GQnwdC4BP2Ow8uCTQqgA@webmail.minatec.grenoble-inp.fr> <4FD8FF25.6030908@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: konglu@minatec.inpg.fr, Junio C Hamano <gitster@pobox.com>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Jun 13 23:07:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Seun3-0004KX-EO
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 23:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498Ab2FMVHl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 17:07:41 -0400
Received: from kawka.in.waw.pl ([178.63.212.103]:38473 "EHLO kawka.in.waw.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750732Ab2FMVHl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 17:07:41 -0400
Received: from 69-mo7-2.acn.waw.pl ([85.222.93.69] helo=[192.168.0.150])
	by kawka.in.waw.pl with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <zbyszek@in.waw.pl>)
	id 1Seumw-0001HX-Vt; Wed, 13 Jun 2012 23:07:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.3) Gecko/20120329 Icedove/10.0.3
In-Reply-To: <4FD8FF25.6030908@kdbg.org>
X-Enigmail-Version: 1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199946>

On 06/13/2012 10:59 PM, Johannes Sixt wrote:
> Am 13.06.2012 21:38, schrieb konglu@minatec.inpg.fr:
>>
>> Junio C Hamano <gitster@pobox.com> a =C3=A9crit :
>>
>>> It looks that editing
>>>
>>>     pick foo            pick foo
>>>     exec cmd1           exec cmd1 && cmd2
>>>     exec cmd2
>>>     pick bar            pick bar
>>>     exec cmd1           exec cmd1 && cmd2
>>>     exec cmd2
>>>
>>> to
>>>
>>>     pick foo            pick foo
>>>                         exec         cmd2
>>>     exec cmd2
>>>     pick bar            pick bar
>>>     exec cmd1           exec cmd1
>>>
>>> would take exactly the same effort, at least to me.  And more
>>> importantly, without editing don't they do *exactly* the same thing=
?
>>> If cmd1 fails, the sequencing stops at that step without running cm=
d2.
>>
>> True. I was thinking under the fact that the user would edit the com=
mands
>> by himself but the purpose of the "--exec" option is to avoid that (=
or at
>> least that the user won't have to type all by himself). Forget what =
I said
>> then :).
>=20
> Not so fast.
>=20
> 	exec cmd1 && cmd2
> and
> 	exec cmd1
> 	exec cmd2
>=20
> are far from equivalent: If cmd1 fails, the first version never runs
> cmd2, but the second version runs cmd2 upon rebase --continue.
>=20
> The updated documentation should not say that the two are "equivalent=
".
Good catch. Word "equivalently" is inappropriate here. I think that jus=
t
removing that one word is best.

Zbyszek
