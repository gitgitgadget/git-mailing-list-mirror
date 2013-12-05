From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/5] gitweb: Return plain booleans in validation methods
Date: Thu, 05 Dec 2013 10:16:10 -0800
Message-ID: <xmqq61r3i2ol.fsf@gitster.dls.corp.google.com>
References: <1386164583-14109-1-git-send-email-krzesimir@endocode.com>
	<1386164583-14109-4-git-send-email-krzesimir@endocode.com>
	<CANQwDweGgQpnqDqaekBWt-rczjHkJEmFyXW9qDh2En2r=ZXbMw@mail.gmail.com>
	<1386235422.2186.7.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
	git <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 19:16:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VodTL-0005rH-T4
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 19:16:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757487Ab3LESQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Dec 2013 13:16:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45252 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757273Ab3LESQN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Dec 2013 13:16:13 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 66E685774F;
	Thu,  5 Dec 2013 13:16:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3yhbZIZ/INKS
	R2m8trZifRMYpbU=; b=a8viVdkBoX/cxldsPoyaKwEUkfq+03KhU0kP3ZVJGI56
	z6Z9dw/H2qGrFGDn7HfgXkt5ohTu4YafujOgxm3at2EGgiZRf3/dV7O33GS8ecDT
	+pIz+YXGjPeWY6DgGIPqYWOHDuB1krD/GtXZoOUuD4Wl43JWHRlPWRa1yL4bD7U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=avRa1x
	zRR+0qB6gT+TCOYN/PJ83ycAgRa7PIh5tUuVU0PdFMa17+Fwa40xTCZSHNrh2UAm
	IIBi0BLvh45p74ayxTg7lbwqKupQGeFv778LUFbH94bMc58zbp5L9Ygrsey3DGAs
	/djYVU6YE5lna83LugwXwRCtPf43uX4xiALbI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 559425774E;
	Thu,  5 Dec 2013 13:16:13 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B45155774D;
	Thu,  5 Dec 2013 13:16:12 -0500 (EST)
In-Reply-To: <1386235422.2186.7.camel@localhost.localdomain> (Krzesimir
	Nowak's message of "Thu, 05 Dec 2013 10:23:42 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 52AB0D10-5DD9-11E3-8997-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238893>

Krzesimir Nowak <krzesimir@endocode.com> writes:

> On Wed, 2013-12-04 at 17:07 +0100, Jakub Nar=C4=99bski wrote:
>> The only change that needs to be doe is replacing
>>=20
>>            return $input;
>>=20
>> with
>>=20
>>            return 1;
>>=20
>
> I prefer to use zeros instead of undefs - one might wonder if that un=
def
> is somewhat special that we can't use 0.

=46or Perl speakers, I suspect the code gives a totally opposite
impression.  Normal "false" return from a sub, when there is no
special need, is to return an undef from it, and a "return 0" would
make the readers wonder if there is something special about the way
the returned value has to be numeric zero, no?
