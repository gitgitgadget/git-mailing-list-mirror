From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 1/7] i18n: mark init-db messages for translation
Date: Tue, 12 Apr 2011 00:15:57 -0700
Message-ID: <7vy63gq6s2.fsf@alter.siamese.dyndns.org>
References: <1302464048-21806-1-git-send-email-avarab@gmail.com>
 <1302464048-21806-2-git-send-email-avarab@gmail.com>
 <7v39lorli9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 09:16:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Xpd-0008LH-Hp
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 09:16:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab1DLHQI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2011 03:16:08 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64240 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754712Ab1DLHQG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Apr 2011 03:16:06 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 057412717;
	Tue, 12 Apr 2011 03:18:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=JamGH4roY9yZ
	q+SJxok/u/otgZE=; b=B5pVZHjb0/604/FdnhISTshq1yOQhyoI4fjM0oCOHe2F
	eGZuOzib5VvtZ1QuO6RC9HkDVSt/+/K5n6xRY5gTFHe8vByIwn9BgsYPEXEDFzeJ
	xiVrQzm9aiQ2qLxt9utLF2tnbEn8sHz6KAg8jUFEmEwflJvAnGi/K9ooLf4dWEU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YRgWWE
	8qLw5IyVQrUTzVFkHEqeA/0OgQgt78i/CHlwGeCOGHcamWF2zOkQ/RnYAQUhEk8H
	KoIcImsjbDFh0DwoUzgQNGvz+4r7IJwQYYbXDNch1OY15/8LgaO+/4nDAvDb0Ow3
	PJ/l75sDdyDK0bOAUsLsFs5med+iUnuK+auIE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id CA1ED2714;
	Tue, 12 Apr 2011 03:17:59 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DCCE22713; Tue, 12 Apr 2011
 03:17:56 -0400 (EDT)
In-Reply-To: <7v39lorli9.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue, 12 Apr 2011 00:12:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FF227D0E-64D4-11E0-9E88-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171376>

Junio C Hamano <gitster@pobox.com> writes:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>  	fp =3D fopen(git_link, "w");
>>  	if (!fp)
>> -		die("Could not create git link %s", git_link);
>> -	fprintf(fp, "gitdir: %s\n", git_dir);
>> +		die(_("Could not create git link %s"), git_link);
>> +	fprintf(fp, _("gitdir: %s\n"), git_dir);
>>  	fclose(fp);
>> ...
> I don't think this is correct.  The file "git_link" refers to .git th=
at is
> not a directory but is a regular file whose contents is "gitdir: $pat=
h"
> and that should _never_ be localized, so the patch to die() message i=
s Ok,
> but the string given to fprintf(fp, ...) is _not_.

See read_gitfile_gently() in setup.c; that is the reader of the
information contained in this file.
