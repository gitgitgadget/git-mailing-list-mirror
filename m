From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t4203 (mailmap): stop hardcoding commit ids and dates
Date: Tue, 19 Oct 2010 23:31:52 -0700
Message-ID: <7vlj5twf1j.fsf@alter.siamese.dyndns.org>
References: <87tyksd9er.fsf@meyering.net> <20101011162153.GG25842@burratino>
 <AANLkTimpN5CAC5UbhC2Kydhu_BMouriQn1d6OL5vt09m@mail.gmail.com>
 <20101015061821.GE21830@burratino> <20101015075954.GA8557@burratino>
 <20101015171219.GC10204@burratino> <7vpqv95szu.fsf@alter.siamese.dyndns.org>
 <7vsk01wf65.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Jim Meyering <jim@meyering.net>,
	git list <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 08:32:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8SDe-0002Az-Fp
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 08:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758130Ab0JTGcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 02:32:08 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43492 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0JTGcG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 02:32:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5249EE0F0C;
	Wed, 20 Oct 2010 02:32:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W/iID2bsGPSm
	ZoH6nnMnrX7QmvU=; b=mZk6mglev9hOQDghb3HK0c9aDUXCX9iQKRiHVxvdLL/b
	T82SVRQlHRg0FzCI57Vo8k2uhj3wjHgm773Z66iZ4SlKX1lNVt+kLNkXTRVUMYKd
	GLc5QQv2ri5aHU9AjoGVeAXggjHjcoDNxqSS9Zylo5TOacVThzznj7IDRnSUxsY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=VuojOS
	CZIQYWvDMuXbFU2wANX/dW/oPrh3MumkqZV9zYyJ6xGL7P2Gpi/Ml1barNDv8zHv
	S5q02UlnaAtBqLiEGNkIhtaazW8vtoqeQN11l3pkx6ZekpTAm2EtHChN1KByd7qr
	GL4ZEad8GIoXaxFouhDaAMmi6YcibMEKy5vQs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 01399E0F02;
	Wed, 20 Oct 2010 02:32:00 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2053E0EFE; Wed, 20 Oct
 2010 02:31:53 -0400 (EDT)
In-Reply-To: <7vsk01wf65.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 19 Oct 2010 23\:29\:06 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: BEE82558-DC13-11DF-B6D1-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159396>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>
>>> Here's a better fix.  Still no idea about the other failures =C3=86=
var
>>> and Thomas were seeing.
>>
>> I saw intermittent failures too.  Thanks for the objid fix.
>
> I found a way to reliably make this fail at test #7.
>
>  $ sh t4203-mailmap.sh </dev/null
>
> Without the input redirection, things seem to work Ok.
>
> Still puzzled...

Ah, of course.

 t/t4203-mailmap.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index a267d07..e818de6 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -114,7 +114,7 @@ test_expect_success 'name entry after email entry' =
'
 	mkdir -p internal_mailmap &&
 	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap=
 &&
 	echo "Internal Guy <bugs@company.xx>" >>internal_mailmap/.mailmap &&
-	git shortlog >actual &&
+	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
=20
@@ -131,7 +131,7 @@ test_expect_success 'name entry after email entry, =
case-insensitive' '
 	mkdir -p internal_mailmap &&
 	echo "<bugs@company.xy> <bugs@company.xx>" >internal_mailmap/.mailmap=
 &&
 	echo "Internal Guy <BUGS@Company.xx>" >>internal_mailmap/.mailmap &&
-	git shortlog >actual &&
+	git shortlog HEAD >actual &&
 	test_cmp expect actual
 '
=20
