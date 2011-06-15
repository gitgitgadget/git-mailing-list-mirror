From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Test 9500 - unhelpful without Perl::CGI
Date: Wed, 15 Jun 2011 09:51:15 -0700
Message-ID: <7vips7jaws.fsf@alter.siamese.dyndns.org>
References: <BANLkTikj0GQCN94PvZz6n6fJJb5sHMApig@mail.gmail.com>
 <7vmxhjk539.fsf@alter.siamese.dyndns.org>
 <BANLkTinAfqysABm+t_NkOGO2U+iy57WbVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 18:51:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWtJN-0001OL-Im
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 18:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751910Ab1FOQvU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 15 Jun 2011 12:51:20 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47498 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751858Ab1FOQvT convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jun 2011 12:51:19 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4011B442B;
	Wed, 15 Jun 2011 12:53:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=4iC+pof/URWC
	l80dbzQu7HvYshI=; b=C7vrhL1mlYifm9kpwaWk2lYB8tj5AG9FaiBTsMN2CzJF
	8/90uqxCJ4/KkhGj8Z4jFQ7e0R+d+QdSW7u/3VbLmacO0ueS9fW/qqmsl55BdDVI
	6kykttEwbJaHgMX9EL+Yg5J+s3roNXsPsau9C19bjETM2sK5wOjxsbSBMNcwjjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=xRHWW3
	rFhbViYpoKSxlnwMhnPdY1Dvy8y0Dc8XMi95SCBDln9UIzHYn3tDZ+5fJOnYY3VX
	yYd3L/t9qW2cpmezq7zRhKW0vDXDXXD/dE+Zk5TP+xeRA4gTKMDk8hBN1r8U4hmd
	xRsgamoEUXJqeqjONmwdrUaVgeRSq+AzpKUZk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 37D60442A;
	Wed, 15 Jun 2011 12:53:29 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 942C94429; Wed, 15 Jun 2011
 12:53:28 -0400 (EDT)
In-Reply-To: <BANLkTinAfqysABm+t_NkOGO2U+iy57WbVQ@mail.gmail.com> (Sverre
 Rabbelier's message of "Wed, 15 Jun 2011 09:26:03 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FE62CBEE-976F-11E0-AC64-2C88C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175840>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Wed, Jun 15, 2011 at 07:59, Junio C Hamano <gitster@pobox.com> wro=
te:
>> +perl -MCGI -MCGI::Util -MCGI::Carp -e 0 >/dev/null 2>&1 || {
>> + =C2=A0 =C2=A0 =C2=A0 skip_all=3D'skipping gitweb tests, CGI module=
 unusable'
>> + =C2=A0 =C2=A0 =C2=A0 test_done
>> +}
>> +
>
> Isn't the new style to use test_must_succeed CGI_AVAILABLE '...' '...=
'
> rather than skip_all+test_done?

I do not think that adds any value, at least in this case.  Besides, lo=
ok
at the context line above what you quoted ;-)
