From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] git-tag: fix -l switch handling regression.
Date: Mon, 17 Dec 2007 12:13:12 -0800
Message-ID: <7vtzmh6pwn.fsf@gitster.siamese.dyndns.org>
References: <1197915797-30679-1-git-send-email-madcoder@debian.org>
	<1197915797-30679-2-git-send-email-madcoder@debian.org>
	<1197915797-30679-3-git-send-email-madcoder@debian.org>
	<1197915797-30679-4-git-send-email-madcoder@debian.org>
	<1197915797-30679-5-git-send-email-madcoder@debian.org>
	<1197915797-30679-6-git-send-email-madcoder@debian.org>
	<1197915797-30679-7-git-send-email-madcoder@debian.org>
	<1197915797-30679-8-git-send-email-madcoder@debian.org>
	<20071217185652.GE22554@artemis.madism.org>
	<20071217190328.GF22554@artemis.madism.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 21:16:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4MNT-0003OL-Vk
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 21:15:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933341AbXLQUN0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Dec 2007 15:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757576AbXLQUNZ
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 15:13:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:54170 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937175AbXLQUNX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 17 Dec 2007 15:13:23 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E9AD3B3E;
	Mon, 17 Dec 2007 15:13:17 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E6D5B3B3B;
	Mon, 17 Dec 2007 15:13:14 -0500 (EST)
In-Reply-To: <20071217190328.GF22554@artemis.madism.org> (Pierre Habouzit's
	message of "Mon, 17 Dec 2007 20:03:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68609>

Pierre Habouzit <madcoder@debian.org> writes:

> On Mon, Dec 17, 2007 at 06:56:52PM +0000, Pierre Habouzit wrote:
>>   And I managed to resend the broken version, hurray myself.
>>=20
>> > +		OPT_INTEGER('l', NULL, &list, "list tag names"),
>>                 OPT_BOOLEAN
>>=20
>>=20
>>=20
>> Both these last minute fixes are applied to my public git.git.
>>=20
>> Let's now write 1000 times: I will run the test-suite before I send
>> patches, I will rune the test-suite before I send patches, =E2=80=A6
>
>   oh and t7004 doesn't pass anymore because of the:
>
>   git -n xxx -l or git -n "" -l tests. If we really want to allow tha=
t
> (but it _REALLY_ feels wrong to me) we have to make '-l' a callback t=
hat
> groks non integers as 0. Else the test also has to be fixed, I'm not
> sure what to do here.

I did not understand what "git tag -n xxx" was meant to do, either.
Time to run blame and ask the responsible party?

I suspect "-n ''" there might be meant as a way to spell the "no
argument here -- use our default" instruction.  It looks slightly nicer
than that '{}' but not quite.
