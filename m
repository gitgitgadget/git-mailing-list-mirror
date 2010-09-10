From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] gettext docs: the gettext.h C interface
Date: Fri, 10 Sep 2010 16:06:31 -0700
Message-ID: <7v62ydgpvs.fsf@alter.siamese.dyndns.org>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
 <1284147353-18000-4-git-send-email-avarab@gmail.com>
 <7veid1gqjd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 01:06:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuCgG-0002kl-PG
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 01:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882Ab0IJXGs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 19:06:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751991Ab0IJXGr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 19:06:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B78A5D51DC;
	Fri, 10 Sep 2010 19:06:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Gxf54kMZ/r8v
	4XnrTEseBWmrgq0=; b=EdoMHeKWyX5hSlvDbWUUjazd3VZqcza2iBWTYNhi43y0
	m/zk0Koxhs75xB8PCOf1f4ohqU8Z7SEe9LbltJKZ+EwiF0q6HFZeki9APEe0HZGw
	P2+ackRRJCGjGthPPIw1qEEqpFftopxcoMXXWNnT7opzM1uCZ8pA9MwDO4E+tYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PESSf2
	fhIDVfSxjanLK1eDIICVxzBDhLYwgYvGbLWqC5lEjz70I324w6CyHOSzychA2wp6
	rjrCi3H7juJzbzM1xnHIs5OGWv4EaX5R75navjgQB65w6Eygyg4Aj7rHEgjSQ7A8
	La7VGk/QwzuBbLDuh6f/FxPZjOwvy34raMn0A=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 27E1DD51DB;
	Fri, 10 Sep 2010 19:06:37 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AAB08D51D9; Fri, 10 Sep
 2010 19:06:33 -0400 (EDT)
In-Reply-To: <7veid1gqjd.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Fri\, 10 Sep 2010 15\:52\:22 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1024EE22-BD30-11DF-B247-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155982>

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
> ...
>> +        static const char *reset_type_names[] =3D {
>> +            N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("k=
eep"), NULL
>> +        };
>> +       =20
>> +    And then, later:
>> +
>> +        die(_("%s reset is not allowed in a bare repository"),
>> +               _(reset_type_names[reset_type]));
>
> I do not think this is a very good example.  Unless we are doing l10n=
 of
> option names, a Portuguese won't be typing "git reset --misto", so th=
ere
> is no point in invoking _(reset_type_names[]) to begin with, and ther=
e is
> no need to mark mixed/soft/hard/... for translation.

Ahh, I think I should take half of what I said back.  The line of thoug=
ht
here is that

 (1) the user types "git reset --mixed"; no l10n of option names;

 (2) however, various modes of operations in "reset" command have
     human-readable names, not necessarily cuttable-and-pastable for
     machine consumption.  E.g. "git reset --mixed" is called "mixed
     reset" in English and that is primarily meant to be explanation of
     concept in human language, i.e. should be translated.

Under that assumption, localizing reset_type_names[] in the above may m=
ake
sense.

I said "half of", because I think the example is still problematic if y=
ou
want to translate to a language where "reset" in the fixed part of the
die() message may need to be spelled differently depending on what
adjective in reset_type_names[] it takes (or the word order between the
noun "reset" and the adjective may have to be different depending on wh=
at
the adjective is), so an example may probaby need to be more like:

    static const char *error_msgs[] =3D {
        N_("mixed reset is not allowed..."),
        N_("soft reset is not allowed..."),
        ...
    };

    die("%s", _(error_msgs[reset_type]));
