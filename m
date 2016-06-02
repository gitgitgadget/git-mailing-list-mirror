From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 24/39] i18n: bisect: enable l10n of bisect terms in messages
Date: Thu, 02 Jun 2016 10:33:57 -0700
Message-ID: <xmqqbn3jv6ka.fsf@gitster.mtv.corp.google.com>
References: <1464799289-7639-1-git-send-email-vascomalmeida@sapo.pt>
	<1464799289-7639-25-git-send-email-vascomalmeida@sapo.pt>
	<xmqq4m9czu5u.fsf@gitster.mtv.corp.google.com>
	<574FF6A6.8030609@sapo.pt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Sunshine <sunshine@sunshineco.com>
To: Vasco Almeida <vascomalmeida@sapo.pt>
X-From: git-owner@vger.kernel.org Thu Jun 02 19:34:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8WVU-0003ar-Sh
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 19:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbcFBReE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jun 2016 13:34:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752020AbcFBReC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jun 2016 13:34:02 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7869721F5E;
	Thu,  2 Jun 2016 13:34:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Y4SdrJj7Dqk3
	hKCENBj1/9RgvCk=; b=UgIJdN9NVfCkUnNtQm/pEHglJb+33fEW1uUUWI3RRc7n
	hAnM3T77LJKoBjxyzUmMqj1XgvoM2VII8/ph8emSGZxi1+kVRk5cYlUdwqhEPY98
	qehLx5ILHbUOWY0MWw5mpKxHU/zGzclPS+gJWVI1BHDHn1D9f5YgBZmjNUtMYJM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=X7pdL9
	Q9XKwdHuY5EIYU/ZOrhXYiUdjB64uMYhcdcKdeexbrTLq4hPlOxM6LuGuFX/+2xU
	euRerekBjR+k1uRtDTOPkhCsWtngfmAG/BEsB1JqesZQkiaak/M0MdJeG6J5c/qn
	UgKJqBv2S4RxGJF3vPU1s83j5VQlHhbfpCZBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3C55021F5D;
	Thu,  2 Jun 2016 13:34:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F92C21F5C;
	Thu,  2 Jun 2016 13:33:59 -0400 (EDT)
In-Reply-To: <574FF6A6.8030609@sapo.pt> (Vasco Almeida's message of "Thu, 2
	Jun 2016 09:04:38 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 30BE0C2A-28E8-11E6-8D6D-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296217>

Vasco Almeida <vascomalmeida@sapo.pt> writes:

> =C3=80s 17:38 de 01-06-2016, Junio C Hamano escreveu:
>> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>>=20
>>> +enum term { BAD, GOOD, OLD, NEW };
>>> +static const char *term_names[] =3D {
>>> +/* TRANSLATORS: in bisect.c source code file, the following terms =
are
>>> +   used to describe a "bad commit", "good commit", "new revision",=
 etc.
>>> +   Please, if you can, check the source when you are not sure if a=
 %s
>>> +   would be replaced by one of the following terms. */
>>> +	N_("bad"), N_("good"), N_("old"), N_("new"),  NULL
>>> +};

As you pointed out (below), I _did_ misread these N_() ...


>>>  /* Remember to update object flag allocation in object.h */
>>>  #define COUNTED		(1u<<16)
>>> =20
>>> @@ -725,12 +734,12 @@ static void handle_bad_merge_base(void)
>>>  	if (is_expected_rev(current_bad_oid)) {
>>>  		char *bad_hex =3D oid_to_hex(current_bad_oid);
>>>  		char *good_hex =3D join_sha1_array_hex(&good_revs, ' ');
>>> -		if (!strcmp(term_bad, "bad") && !strcmp(term_good, "good")) {
>>> +		if (!strcmp(term_bad, term_names[BAD]) && !strcmp(term_good, ter=
m_names[GOOD])) {
>>>  			fprintf(stderr, _("The merge base %s is bad.\n"
>>>  				"This means the bug has been fixed "
>>>  				"between %s and [%s].\n"),
>>>  				bad_hex, bad_hex, good_hex);
>>> -		} else if (!strcmp(term_bad, "new") && !strcmp(term_good, "old")=
) {
>>> +		} else if (!strcmp(term_bad, term_names[NEW]) && !strcmp(term_go=
od, term_names[OLD])) {

=2E.. which means the above two changes are "since we have these four
word constants in an array up there, let's use them", i.e. there is
no change in behaviour when running the program in any locale, but
it is a good programming practice (as long as the term_names[] array
that holds the four word constants and indexes into it with enum term
is justifiable, that is).

>>> @@ -739,7 +748,7 @@ static void handle_bad_merge_base(void)
>>>  			fprintf(stderr, _("The merge base %s is %s.\n"
>>>  				"This means the first '%s' commit is "
>>>  				"between %s and [%s].\n"),
>>> -				bad_hex, term_bad, term_good, bad_hex, good_hex);
>>> +				bad_hex, _(term_bad), _(term_good), bad_hex, good_hex);

But this translation still does not make much sense to me.

If the user did not change term_bad and term_good from the default
ones (i.e. the four words above), the flow of control would not come
here; one of the above two !strcmp() lines you changed would trigger.

On the other hand, if the user did change term_bad and term_good by
using --term-old=3Dvelho --term-new=3Dnovo earlier (which is stored in
BISECT_TERMS and read into these two variables), these are strings
that Git encounters at runtime; you cannot expect _(term_bad) aka
_("novo") to be translated by *.po files for the locale.

And even if it were somehow translatable, you do not want to.

Imagine a case where there is a Portuguese word the user used in
place of 'novo' in the example above, and there is an English word
with the same spelling with a totally different meaning.  And
further imagine that English word is used elsewhere in Git and has
translation to Portuguese in your *.po file.  _(term_bad) would
become a translation of that English word into Portuguese, which
would be a word totally unrelated to the word the user used
originally when she did --term-old=3D<that word in portuguese>.

So I do not think _(term_bad) and _(term_good) is a good idea in the
last hunk quoted above (it is not just "not a good idea", but
actually would be harmful), which would make term_names[] and "enum
term" unnecessary.

There is a case where one of the default four words could seep
through to the last else clause.  Is that what you are trying to
address?

That is, when term_bad is left as "bad" but term_good is customized
to "super", neither "term_bad is 'bad' and term_good is 'good'" nor
"term_bad is 'new' and term_good is 'old" is true, and we would say

	Merge base is BAD.  This means the first SUPER commit is ...

With your change to mark _(term_bad) and _(term_good), the message
would translate term_bad to whatever word it is in your language,
and term_good that comes from the end user will be left as SUPER as
the user typed.  I am not sure if it is a good thing to translate
only BAD while leaving SUPER as-is in such a case.
