From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH, RFC] diff: add option to show context between close 
  chunks
Date: Tue, 21 Oct 2008 22:48:52 +0200
Message-ID: <48FE4034.2090707@lsrfire.ath.cx>
References: <48FB757B.9030105@lsrfire.ath.cx> <7vabcy3k9l.fsf@gitster.siamese.dyndns.org> <48FD781C.2000103@viscovery.net> <7vskqqzajy.fsf@gitster.siamese.dyndns.org> <20081021112040.GB17363@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Davide Libenzi <davidel@xmailserver.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 21 22:50:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsOBP-00028U-1F
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 22:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756172AbYJUUtA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 21 Oct 2008 16:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751841AbYJUUs7
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Oct 2008 16:48:59 -0400
Received: from india601.server4you.de ([85.25.151.105]:37637 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756172AbYJUUs6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2008 16:48:58 -0400
Received: from [10.0.1.101] (p57B7DC8D.dip.t-dialin.net [87.183.220.141])
	by india601.server4you.de (Postfix) with ESMTPSA id A0AA42F8063;
	Tue, 21 Oct 2008 22:48:56 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.17 (Windows/20080914)
In-Reply-To: <20081021112040.GB17363@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98816>

Jeff King schrieb:
> On Tue, Oct 21, 2008 at 12:12:17AM -0700, Junio C Hamano wrote:
>=20
>> Yeah.  Ren=C3=A9 wanted this for _human consumption_, not mechanical=
 patch
>> application, so "hardcoding" literally there in the very low level o=
f the
>> diff callchain is not quite right (it would affect format-patch whic=
h is
>> primarily for mechanical application).
>>
>> I guess you could make the hardcoded value 1 for everybody else and =
0 for
>> format-patch.
>=20
> I see your reasoning, but at the same time, a large portion of patche=
s I
> read are from format-patch (and Ren=C3=A9 even said that he was tryin=
g to
> save the user from the "apply then diff just to look at the patch"
> annoyance). And I have personally, as a patch submitter, created some
> format-patch output sent to the git list with -U5 to combine hunks an=
d
> make it more readable for reviewers.
>=20
> Not to mention that I sometimes apply or post the output of "git diff=
".

Well, yes, perhaps I was trying to get ahead of myself.  I sure would
like to see everyone create patches with fused hunks (because they are
easier to read), but step 1 is to have the option to create such patche=
s
at all.  We should then try it out for some time or verify its
usefulness statistically and only then turn it on by default.  Or
perhaps throw it away, depending on the results.

And I consider the output of format-patch and git-diff to be intended
primarily for human consumption.

> To me that it implies that either:
>=20
>  - the increased chance of conflict is not a problem in practice, and=
 we
>    should have the option on by default everywhere
>=20
>  - it is a problem, in which case we should ask the user to turn on t=
he
>    feature manually instead of second-guessing how they will use the
>    resulting patch (which they might not even know, since they are
>    making assumptions about how other people might use the patch, and
>    they must decide for their situation between shipping something th=
at
>    is more readable but slightly more conflict prone, or as easy to
>    apply as possible)

To decide which one it is, I'd like to see numbers: how many times woul=
d
a patch with fused hunks have led to a problem for e.g. the kernel repo=
?
  What is the optimal default value (0, 1, even more)?  Before even
thinking about how to get these stats, I'd better head for bed for
today, though..

Ren=C3=A9
