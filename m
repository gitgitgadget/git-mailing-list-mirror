From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2016, #07; Thu, 25)
Date: Fri, 26 Feb 2016 15:35:10 -0800
Message-ID: <xmqqtwkvhwpd.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuwgmlgy.fsf@gitster.mtv.corp.google.com>
	<56D078F3.9070905@web.de>
	<xmqqsi0fjpez.fsf@gitster.mtv.corp.google.com>
	<56D0D2DF.1040807@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Feb 27 00:35:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZRuw-0001X2-CF
	for gcvg-git-2@plane.gmane.org; Sat, 27 Feb 2016 00:35:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbcBZXfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 26 Feb 2016 18:35:14 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:63226 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754003AbcBZXfN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Feb 2016 18:35:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5DD2947544;
	Fri, 26 Feb 2016 18:35:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vrCr7VuwqGp4
	22vgDRp5oQj3Mxg=; b=CqKnK+syd/2ciwKAQUkFRzijoulXcH5wYHD21zdFtsvb
	t4hDc8/RafveLHx0t0Od5a2jIm6oTyxoXNsGipyvNeLsZy77AdF4CDdAsd313vKK
	LWa0I4bzExazA30/8xMWGX0ajWoNVz3hYzd9CV7DSXo7Wir5DUrcbbtV42LTxNc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jUSOJD
	SdiCp2peGYupfeLn6iNL5KHRph0SBigFfHbM6K3nhLwGRobdGRCYUMnVCMnWSL5B
	b1h1wLrzL5Aucl70BaAw1uErX/qh2qYmoSwj0SXniVmL2rWu2q2PomqQy9fj3pyP
	DHTKBeqAi7B5/x9ktbxK84BiG+SZJzExDHv5Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 5557547543;
	Fri, 26 Feb 2016 18:35:12 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CD85C47540;
	Fri, 26 Feb 2016 18:35:11 -0500 (EST)
In-Reply-To: <56D0D2DF.1040807@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Fri, 26 Feb 2016 23:34:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 944DC6CA-DCE1-11E5-B020-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287639>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> On 2016-02-26 19.29, Junio C Hamano wrote:
>> Torsten B=C3=B6gershausen <tboegi@web.de> writes:
>>=20
>>> CC combine-diff.o
>>> combine-diff.c: In function =E2=80=98diff_tree_combined=E2=80=99:
>>> combine-diff.c:1391: internal compiler error: Segmentation fault
>>> Please submit a full bug report,
>>> with preprocessed source if appropriate.
>>> See <URL:http://developer.apple.com/bugreporter> for instructions.
>>> make: *** [combine-diff.o] Error 1
>>>
>>> Revert "use st_add and st_mult for allocation size computation" did=
n't fix it.
>>> I haven't digged deeper yet.
>>=20
>> Hmph, I am not quite sure what you meant by "I haven't digged
>> deeper"; I do not think you should be debugging Apple's compiler
>> (unless you have the source to it and that is your job to do so,
>> that is).
>>=20
>> In any case, merging the topic to 'master', and reverting that
>> commit will leave this only this change between 'master' and the
>> result.  I do not immediately spot anything trickier in the
>> postimage compared to the preimage that may trickle a compiler bug,
>> but what would I know without the source ;-)
>>=20
> Digging means:
> run git bisect and report the commit.
> And this makes the compiler happy:
>   Revert "tree-diff: catch integer overflow in combine_diff_path allo=
cation"

So?

Identifying two versions of the same C file, for one of which the
Apple compiler does not give you "internal compiler error" and for
the other it does, may help Apple engineers to debug their compiler.

But we cannot and will not revert any of our code only because some
vendor compiler is broken.  It would be a different story if we were
throwing an invalid C at compilers and relying on a bug in GCC that
accepts an invalid code, but I do not think that is the case here.



>
>     This reverts commit 5b442c4f2723211ce0d862571e88ee206bfd51bf.
>
> Test suite passes,
> ( except t9115, the 2 new test cases "svn.pathnameencoding=3Dcp932".
>   More info about that later)
