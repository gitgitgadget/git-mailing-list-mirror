From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [eclipse7@gmx.net: [PATCH] diff: Only count lines in
 show_shortstats()]
Date: Thu, 07 Jun 2012 13:29:04 -0700
Message-ID: <7vk3zig92n.fsf@alter.siamese.dyndns.org>
References: <20120607122149.GA3070@akuma> <4FD0FB75.4090906@in.waw.pl>
 <20120607200434.GA2965@akuma>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
	"git\@vger.kernel.org" <git@vger.kernel.org>, mj@ucw.cz,
	Johannes Sixt <j.sixt@viscovery.net>
To: Alexander Strasser <eclipse7@gmx.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 22:29:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScjKW-000106-Ui
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jun 2012 22:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756224Ab2FGU3M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Jun 2012 16:29:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752846Ab2FGU3L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jun 2012 16:29:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1530F8C65;
	Thu,  7 Jun 2012 16:29:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=FrYmjt8r3Vdv
	UxyJ++0KUIhJaqc=; b=AbotQAubrLAiglE/djMxjM04S6nqMGxfpxnAQdx8Q2gM
	mx+iJyb4VQVO4cVzlCgrgKaBo1caKNV8zvJ6KvlYlQ6CxKgXydan4zdgI1kfRjXb
	4ez53R3u6tjuk1WUq3oJF+3WSYoCiZPGCnsuuNeFbYqXyFri8QJzAq75TTHZcjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PXa6Xh
	T/qGpEt3tAcGiL9TMsus7908IZpQya+xearayGQaF47QalqJujHF8W2if1wVGhlQ
	4a+CA2xS/cL58UXArdPw52icHuDYZG71HuSJASw+jvAIRhI1aQmp1J5CcaJ2WkgN
	gkzR+6mJozkyH/RWy4nGdzs/m1FDbEI/1NFo0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0C9588C64;
	Thu,  7 Jun 2012 16:29:07 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7E6D68C61; Thu,  7 Jun 2012
 16:29:06 -0400 (EDT)
In-Reply-To: <20120607200434.GA2965@akuma> (Alexander Strasser's message of
 "Thu, 7 Jun 2012 22:04:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6DDE228C-B0DF-11E1-B575-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199445>

Alexander Strasser <eclipse7@gmx.net> writes:

Administrivia.

Please do not use Mail-Followup-To header to deflect direct response
to you away to other people.  When I want to reply to you and Cc
others, I do not want to see other people's name on To field for me
to edit and correct, and when somebody else wants to reply to you, I
do not want to see my name on its To line, as such a message may not
be of immediate interest for me.

> Zbigniew J=C4=99drzejewski-Szmek wrote:
> ...
>> >   I think I should have put you in CC. But I am not so sure about
>> > Git patch submission policies.
>> The policy is to CC everyone who might be interested, and also to ad=
d
>> TO:gitster@pobox.com, if the patch is intended for merging, as yours=
 is.

Correction.  It is not "is intended for merging", but only when it
is *ready* to be merged, when stakeholders are happy with the patch.

>> So basically taking the address list from the discussion of e18872b
>> would be the simplest and most effective choice.

>   Yes, seems so. I was seeing changing line counts in GitStats output
> compared to older and newer Git versions. I found the exact commit wi=
th
> "git bisect" which was a big help.

Thanks.

>> > Signed-off-by: Alexander Strasser <eclipse7@gmx.net>
>> Small note: normally the paragraphs are not indented.
>
>   Noted. I probably should have also dropped the () in the subject. A=
fter
> submitting I noticed this notation was not used in analog log message=
s.
>
> [...]
>> > --- a/t/t4012-diff-binary.sh
>> > +++ b/t/t4012-diff-binary.sh
>> > @@ -36,6 +36,14 @@ test_expect_success '"apply --stat" output for =
binary file change' '
>> >  	test_i18ncmp expected current
>> >  '
>> > =20
>> > +cat > expected <<\EOF
>> > + 4 files changed, 2 insertions(+), 2 deletions(-)
>> > +EOF
>> > +test_expect_success 'diff with --shortstat' '
>> > +	git diff --shortstat >current &&
>> > +	test_cmp expected current
>> > +'
>> > +
>> The test is OK, and follows the style of surrounding tests, but curr=
ent
>> style is slightly different:
>> - no space after '>'
>> - expected output is inlined if it is short
>> - test_i18ncmp is used, even if the message is not yet i18n-ized
>>=20
>> Something like this:
>> test_expect_success 'diff --shortstat output for binary file change'=
 '
>> 	echo " 4 files changed, 2 insertions(+), 2 deletions(-)" >expect &&
>> 	git diff --shortstat >current &&
>> 	test_i18ncmp expect current
>> '
>
>   Should I rewrite the test for this patch? Or should it be changed f=
or the
> whole file at once?

Please keep a bugfix patch to only fixes with tests.  Style fixes
should be done later after dust from more important changes (e.g. a
bugfix) settles.

Thanks.
