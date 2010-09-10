From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] gettext docs: the gettext.h C interface
Date: Fri, 10 Sep 2010 15:52:22 -0700
Message-ID: <7veid1gqjd.fsf@alter.siamese.dyndns.org>
References: <AANLkTikdHZFmXAdABvS9hPXtbXNJU5NdCOrw5_KP73bX@mail.gmail.com>
 <1284147353-18000-4-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 11 00:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OuCST-0004mo-6F
	for gcvg-git-2@lo.gmane.org; Sat, 11 Sep 2010 00:52:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753363Ab0IJWwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 10 Sep 2010 18:52:31 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:64670 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753160Ab0IJWwa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Sep 2010 18:52:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D1761D5054;
	Fri, 10 Sep 2010 18:52:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=KyP41Wh6w+jN
	slR6FE03qsDwtuM=; b=UuCRoMgbhlJNVq0NaOOopduZH1h1AC7S0c+XQUvDLJRx
	lZ7tnGSS/qwSmp9XE0g9l7FXr/qqSEEiyUZXxKn0gTOVohndm/TU48CfW+w6LkuV
	UocA31jUqCIrYeCNGyOGKfjZvYbiFHZsrszxCu5kFhmehgekZC9O8VNm4AZG0Vo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=SZbU/9
	o1rC3Lyrj0NrXOxWAcdwhUt8gwOau8ThTFowfCvixacyfMWZrQueL5StIo3Ala3y
	FvnYdTTMsobJ2UENVFDnvwfvVVGNOqFJerUSJ1lkMVcRRSQpFNGIeKe+mqoNlDkD
	s1goD3GEpDYAj3Lil4+ce22iTpWjGlwviVr8Y=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id AEDE2D5051;
	Fri, 10 Sep 2010 18:52:26 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F1F8ED504C; Fri, 10 Sep
 2010 18:52:23 -0400 (EDT)
In-Reply-To: <1284147353-18000-4-git-send-email-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri\, 10 Sep
 2010 19\:35\:51 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 153D2F8E-BD2E-11DF-AE52-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155977>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +   - _()
> +
> +    Mark and translate a string. E.g.:
> +
> +        printf(_("HEAD is now at %s"), hex);
> +
> +   - N_()
> +
> +    A no-op pass-through macro for marking strings inside static
> +    initializations, e.g.:
> +       =20
> +        static const char *reset_type_names[] =3D {
> +            N_("mixed"), N_("soft"), N_("hard"), N_("merge"), N_("ke=
ep"), NULL
> +        };
> +       =20
> +    And then, later:
> +
> +        die(_("%s reset is not allowed in a bare repository"),
> +               _(reset_type_names[reset_type]));

I do not think this is a very good example.  Unless we are doing l10n o=
f
option names, a Portuguese won't be typing "git reset --misto", so ther=
e
is no point in invoking _(reset_type_names[]) to begin with, and there =
is
no need to mark mixed/soft/hard/... for translation.

And we won't be doing l10n of option names or subcommand names, I hope =
;-).
