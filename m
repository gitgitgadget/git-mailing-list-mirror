From: Max Horn <max@quendi.de>
Subject: Re: What's cooking in git.git (Mar 2014, #03; Fri, 14)
Date: Wed, 19 Mar 2014 18:21:04 +0100
Message-ID: <0CF0981E-FFF8-4A38-B690-17826686BEA6@quendi.de>
References: <xmqqlhwcfn4a.fsf@gitster.dls.corp.google.com> <53240C0F.2050204@web.de> <xmqqha6wg3o1.fsf@gitster.dls.corp.google.com> <906CACC0-FB16-4BB8-812D-59067DE0CC89@quendi.de> <xmqqlhw65dcq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 18:21:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WQKB5-0001dB-2F
	for gcvg-git-2@plane.gmane.org; Wed, 19 Mar 2014 18:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759425AbaCSRVN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Mar 2014 13:21:13 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:60570 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759422AbaCSRVL convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2014 13:21:11 -0400
Received: from [82.113.99.177] (helo=[10.51.175.177]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WQKAu-0000Ps-R3; Wed, 19 Mar 2014 18:21:08 +0100
X-Mailer: iPhone Mail (11D167)
In-Reply-To: <xmqqlhw65dcq.fsf@gitster.dls.corp.google.com>
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1395249670;9a8f85a0;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244463>



> Am 19.03.2014 um 18:04 schrieb Junio C Hamano <gitster@pobox.com>:
>=20
> Max Horn <max@quendi.de> writes:
>=20
>>> On 17.03.2014, at 18:01, Junio C Hamano <gitster@pobox.com> wrote:
>>>=20
>>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>>=20
>>>>> On 2014-03-14 23.09, Junio C Hamano wrote:
>>>>> * ap/remote-hg-skip-null-bookmarks (2014-01-02) 1 commit
>>>>> - remote-hg: do not fail on invalid bookmarks
>>>>>=20
>>>>> Reported to break tests ($gmane/240005)
>>>>> Expecting a reroll.
>>>> I wonder what should happen here.
>>>> The change breaks all the tests in test-hg-hg-git.sh
>>>> (And the breakage may prevent us from detecting other breakages)
>>>>=20
>>>> The ideal situation would be to have an extra test case for the pr=
oblem
>>>> which we try to fix with this patch.
>>>>=20
>>>> Antoine, is there any way to make your problem reproducable ?
>>>> And based on that, to make a patch which passes all test cases ?
>>>=20
>>> After re-reading the thread briefly (there're just five messages)
>>>=20
>>> http://thread.gmane.org/gmane.comp.version-control.git/239797/focus=
=3D240069
>>=20
>> For some reason, that link does not contain all messages from that
>> conversation (unfortunately, I have seen GMane do that on multiple
>> occasions. I hence try not to rely on it for reviewing email
>> history -- I just don't trust it). In particular, it misses this
>> crucial post:
>=20
> [jc: please avoid overlong lines; I re-flowed above]

Sorry. If anybody knows a way to tech Mail.app to auto-wrap
long lines, I'd appreciate a hint.=20

>=20
>>  http://thread.gmane.org/gmane.comp.version-control.git/239830
>=20
> Interesting.
>=20
>> The (or at least "a") root cause has actually been
>> discovered. Would a patch that adds an xfail test case for it be
>> acceptable?
>=20
> Do you mean a patch that only adds a new test that expects a failure
> to the current code, without touching the current code that has the
> bug it exposes?

Exactly.

>  That would be a good place to start.

Ok.

>=20
>> ... As a matter of fact, I a know a few more bugs in remote-hg for
>> which I could produce xfail test cases. Of course I'd prefer to
>> put them in together with a fix, but I don't know when I can get
>> to that, if ever. So, would such changes be welcome?
>=20
> Surely.  That is to keep tabs on bugs in an actionable form; it is a
> better way of bug tracking than having a bug-tracker that is not
> actively maintained, I would think.

Yeah, makes sense.

So, one more silly (bikeshedding) question: should I do this as one big
patch adding multiple xfail tests - or one commit per test, with perhap=
s a
brief description of the issue at hand? Or should a code comment next t=
o
the failing test explain things?

Actually, some of those bugs might require a lengthy background
explanation, so yet another variant would be to write an email here
With an explanation, then add a gmane ref to the commit message...

>=20
>=20
>=20
>=20
