From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH 3/3] completion: remove unused code
Date: Mon, 30 Jan 2012 14:19:29 +0100
Message-ID: <87pqe1nx9a.fsf@thomas.inf.ethz.ch>
References: <1327880479-25275-1-git-send-email-felipe.contreras@gmail.com>
	<1327880479-25275-4-git-send-email-felipe.contreras@gmail.com>
	<20120130025014.GA15944@burratino>
	<CAMP44s1bZeednbHfqXANZR5zVVvGwjRpuV5TFmnh212FD7E-Vg@mail.gmail.com>
	<871uqh3a8s.fsf@thomas.inf.ethz.ch>
	<25ea208e-353d-48f7-a849-143689fb2be6@email.android.com>
	<CAMP44s2ooo1uArhhtJkX3S9N=iE4MNJivMSvr3hsOkxFmJupFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <jch2355@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 30 14:19:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rrr90-0001y4-BX
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jan 2012 14:19:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752027Ab2A3NTd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jan 2012 08:19:33 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:21528 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751671Ab2A3NTc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Jan 2012 08:19:32 -0500
Received: from CAS12.d.ethz.ch (172.31.38.212) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 14:19:29 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS12.d.ethz.ch
 (172.31.38.212) with Microsoft SMTP Server (TLS) id 14.1.355.2; Mon, 30 Jan
 2012 14:19:29 +0100
In-Reply-To: <CAMP44s2ooo1uArhhtJkX3S9N=iE4MNJivMSvr3hsOkxFmJupFA@mail.gmail.com>
	(Felipe Contreras's message of "Mon, 30 Jan 2012 12:38:35 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189357>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, Jan 30, 2012 at 10:22 AM, Junio C Hamano <jch2355@gmail.com> =
wrote:
>> Thomas Rast <trast@inf.ethz.ch> wrote:
>>>Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> No reason. I hope they read the mailing list, otherwise I'll resen=
d
>>>> and CC them. A get_maintainers script, or something like that woul=
d
>>>> make things easier.
>>>
>>>I simply use
>>>
>>> =C2=A0git shortlog -sn --no-merges v1.7.0.. -- contrib/completion/
>>>
>>>(In many parts the revision limiter can be omitted without losing mu=
ch,
>>>but e.g. here this drops Shawn who hasn't worked on it since 2009.)
>>
>> Or "--since=3D1.year", which you can keep using forever without adju=
sting.
>
> Perhaps something like that can be stored in a script somewhere in
> git's codebase so that people can set sendemail.cccmd to that.

Umm, that seems rather AI-complete.  You should always compile the list
by hand.

=46or example, the list in this case started

      25  SZEDER G=C3=A1bor
       4  Michael J Gruber
       3  Teemu Matilainen
       3  Thomas Rast

Would you Cc Michael, Teemu and me?  Probably not.  What if it started

       5  SZEDER G=C3=A1bor
       4  Michael J Gruber
       3  Teemu Matilainen
       3  Thomas Rast

Also, something I didn't mention so far was that you may be patching
squarely into the code of one contributor, even if he only had a single
patch in that area.  To catch this, you should blame the code you are
fixing (you already checked the message of the commit to verify whether
the bug/feature was intentional, right?).  On top of that, the patch ma=
y
have involved a large number of people not listed in the Author field.
As a random example,

  $ git shortlog -sn --no-merges v1.7.0..origin/next -- grep.[ch] built=
in/grep.[ch]
      15  Ren=C3=A9 Scharfe
       9  Junio C Hamano
       8  Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
       5  Micha=C5=82 Kiedrowicz
       4  Johannes Schindelin
       3  Jeff King
       3  Thomas Rast

but if you were to submit a patch that disputes the case made by
53b8d931, you should probably cc Ren=C3=A9, Peff and me (see the Helped=
-by
lines).

Ok, this got rather long-winded.  But I think the bottom line is, tryin=
g
to put this in sendemail.cccmd is trying to script common sense.

--
Thomas Rast
trast@{inf,student}.ethz.ch
