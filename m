From: Junio C Hamano <gitster@pobox.com>
Subject: Re: General support for ! in git-config values
Date: Wed, 01 Feb 2012 14:21:48 -0800
Message-ID: <7v62fq2o03.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
 <20120201184020.GA29374@sigill.intra.peff.net>
 <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 01 23:21:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsiYu-0000KN-1G
	for gcvg-git-2@plane.gmane.org; Wed, 01 Feb 2012 23:21:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237Ab2BAWVv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Feb 2012 17:21:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47123 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755429Ab2BAWVu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Feb 2012 17:21:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44506668F;
	Wed,  1 Feb 2012 17:21:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=kj9M/kmG2oSO
	jM62+II62aFdfBU=; b=D6sA2a6yWhvBCGayHQcjxmGVuRr4u2EDw7074wIAkX3c
	A7vqMYcGe8XcEJ6Mgmqz55rDH1sO4+Uv/PaoW26Q00ZuV0ct4kvPC3MZgEdxu5IF
	Gx50HoIMTHmY+mxrNiVYGKVRqYUZVFctKFVnCG2XclnJcfIIP9g+20vDbs6i9yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=sIEUUM
	nZu0OhubyOBXkzPOvVBUP3cuPfUOCyV6GkAKr18MfcxKKq+EWiB9oGvkLhLdDdzw
	ij3hDK5gmOP58hGx1/PNbWvunJCmzP8IJ76dbnyoXcRj4sIp2NBi9WJ+SuxooB/v
	GgAjraupPgLOedLQ8F0yNEq24qhhCYoNDDwAc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 31138668E;
	Wed,  1 Feb 2012 17:21:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8958B6689; Wed,  1 Feb 2012
 17:21:49 -0500 (EST)
In-Reply-To: <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 1 Feb
 2012 22:25:31 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 227F04B6-4D23-11E1-A105-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189546>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> I.e., everything pertaining to "!" happens after we get the config
>> string. So what is it that you want "git config --with-exec" to do?
>
> I agree that that's how it should work, I just suggested --with-exec
> in case anyone complained about the backwards compatibility issue of
> changing the meaning of "!" for existing configs.

Now you made me utterly confused.

What "backwards compatibility" issue do you have in mind?  If I name
myself '!me' with "user.name =3D !me", do I suddenly break backwards
compatibility of Git with previous versions somehow? If so how?

The --with-exec option you talk about seems to me the option about the
backward compatibility of the _calling script_ of "git config".  The ol=
d
version of git-blorl script may have used foo.bar as a mere string, but=
 a
new version of it may (optionally) interpret foo.bar's value in a speci=
al
way when it begins with a "!", introducing a backward compatibility iss=
ues
to git-blorl script, and users who want to take advantage of that featu=
re
may want to run it as "git-blorl --with-exec", and the relevant part of
the "git-blorl" script might look like this:

	foo_bar=3D$(git config foo.bar)
        case "$with_exec,$foo_bar" in
        yes,\!*)
        	foo_bar=3D$(eval ${foo_bar#\!}) ;;
	esac
        ... then do something interesting using $foo_bar ...
