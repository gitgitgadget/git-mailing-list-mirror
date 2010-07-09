From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] tests: Use skip_all=<reason> to skip tests
Date: Fri, 09 Jul 2010 15:47:32 -0700
Message-ID: <7vlj9kl1bv.fsf@alter.siamese.dyndns.org>
References: <4C36ECDB.9090707@drmicha.warpmail.net>
 <1278675688-4702-1-git-send-email-avarab@gmail.com>
 <7v4og8mtpd.fsf@alter.siamese.dyndns.org>
 <AANLkTilPkKI9KdEc84Zhh3Vn7_B7CYT3UDSkSv7JwGJG@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 10 00:47:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OXMMG-0004oz-O8
	for gcvg-git-2@lo.gmane.org; Sat, 10 Jul 2010 00:47:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170Ab0GIWrm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Jul 2010 18:47:42 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35423 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541Ab0GIWrl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Jul 2010 18:47:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 4613AC30F9;
	Fri,  9 Jul 2010 18:47:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=M9BbplOb+xze
	CmjANmarwGVbLeM=; b=o+FsukYaK9eMZg1lTntGIr6N43Dr9nJdpxOvStcXdeWl
	mNIkPttyUQoEQ2HqvjChw2cyJJzwlKxvp/E4wO3ZO8purIlRGrv5MYSZFCRkhVTh
	hR9TVmbeo1fqqB9d7EYunJWW1RY3dvgt6URga14cwu9n2PMXlPFsXeMgGAvS9QE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=bdcpKJ
	zwz13uPo+4ZxdQE3mtWjXPlcYtdInI5eDd2DkGyZtHW2t0dnMyTOujm1zux4Aa6l
	MZEz7hipouRItdgqep+w7OgfRd1WxxzfHwx9tF4CStuhfhec0gWAsSHvactjct2e
	D1cNALyHkTfjZYy6BdbmTgmDQZyMsju7YAanA=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 10F71C30F5;
	Fri,  9 Jul 2010 18:47:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B9DAC30F1; Fri,  9 Jul
 2010 18:47:33 -0400 (EDT)
In-Reply-To: <AANLkTilPkKI9KdEc84Zhh3Vn7_B7CYT3UDSkSv7JwGJG@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 9 Jul
 2010 19\:14\:10 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: F92B11E8-8BAB-11DF-8336-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150696>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Fri, Jul 9, 2010 at 17:49, Junio C Hamano <gitster@pobox.com> wrot=
e:
> ...
>> Among 63 assignments to $skip_all that are all over in t/*.sh script=
s, the
>> only ones that are not immediately followed by test_done are in
>> lib-git-svn.sh (chooses one among 3 messages), lib-httpd.sh (sets a =
trap
>> before calling test_done), and t3600-rm (makes a mental note to repo=
rt
>> that one test was skipped long before all the tests run).
> ...
>     $ perl -MTest::More -E 'plan tests =3D> 6; pass "gettext stuff ok=
"
> for 1..2; SKIP: { skip "Can not test without locale files", 2 } pass
> "moo" for 1..2'
>     1..6
>     ok 1 - gettext stuff ok
>     ok 2 - gettext stuff ok
>     ok 3 # skip Can not test without locale files
>     ok 4 # skip Can not test without locale files
>     ok 5 - moo
>     ok 6 - moo

Now you are talking.

What t3600-rm does becomes a lot more natural to express with something
like this.  Any test with "prerequisite" missing will automatically get
"this test was skipped because you lack this prerequisite" for free.  W=
e
can lose skip_all=3D assignment there but move the logic to test-lib.sh=
,
which is a good thing.

But that is orthogonal to what you call an API, i.e. your assignment to
the global variable $skip_all that is immediately followed by test_done=
,
no?  The conversion you did for that does not help counting the remaind=
er
of the tests that are skipped anyway, so you will need to redo that
conversion altogether if you ever want to be able to show "these tests
through the end of the scripts were skipped".
