From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t9902 fails
Date: Fri, 18 Jan 2013 14:37:18 -0800
Message-ID: <7vpq12p17l.fsf@alter.siamese.dyndns.org>
References: <1358256924-31578-1-git-send-email-pclouds@gmail.com>
 <7v8v7qsagd.fsf@alter.siamese.dyndns.org>
 <7vmww6qmck.fsf@alter.siamese.dyndns.org>
 <201301182323.55378.avila.jn@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Torsten =?utf-8?Q?B=C3=B6gersha?= =?utf-8?Q?usen?= 
	<tboegi@web.de>, Jeff King <peff@peff.net>, git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: =?utf-8?Q?Jean-No=C3=ABl_AVILA?= <avila.jn@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 18 23:37:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TwKZL-0006YD-NF
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jan 2013 23:37:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755253Ab3ARWhZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jan 2013 17:37:25 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35013 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964Ab3ARWhW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jan 2013 17:37:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DFDE3A163;
	Fri, 18 Jan 2013 17:37:21 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=xtUfRHn529fe
	6tpMqESq3UTrYVE=; b=vNVsS0WyUzjUlev3Aj2Uwi7f5Bpqrb5ABB6QLNnPX7kU
	FJEz4eonYek+RdCyteyPmCtwnkonIk0ZYj1NWqsTxiYbJZjWgyWsZfkWClpu1boa
	5d8JXZbSQtyppBmeWkw7bbIMa0KD/KUVL4+jDRhj4Oi+gyY11pC1J78JZuDKGkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kXBu/a
	8qbn+MFBAY7QdlA4zqwDRjVMg3Gdv/4OX9vSEbbqpRPbQCdvGZ94r8LDBJhyLNjd
	wd5f6Lcp8u072o8gH2LyrkeKDKHxaTYyLsV+6e0u6z2sSjsK+UMiJ8GdkTkSf6Bv
	x0vVw0XHMkj4NwfJKL0iRFQ+JlGHi8Pp5nu9c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D20BDA161;
	Fri, 18 Jan 2013 17:37:21 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4675AA159; Fri, 18 Jan 2013
 17:37:20 -0500 (EST)
In-Reply-To: <201301182323.55378.avila.jn@gmail.com> (=?utf-8?Q?=22Jean-No?=
 =?utf-8?Q?=C3=ABl?= AVILA"'s message of "Fri, 18 Jan 2013 23:23:55 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9EABFDB2-61BF-11E2-AA7A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213945>

"Jean-No=C3=ABl AVILA" <avila.jn@gmail.com> writes:

> Le vendredi 18 janvier 2013 21:15:23, Junio C Hamano a =C3=A9crit :
>> Junio C Hamano <gitster@pobox.com> writes:
>> > How about doing something like this and set that variable in the
>> > test instead?  If STD_ONLY is not set, you will get everything, bu=
t
>> > when STD_ONLY is set, we will stop reading from "help -a" when it
>> > starts listing additional stuff.
>
> I tried both of your propositions but none made test 10 of t9902 pass=
=2E

Do you have a leftover git-check-ignore or something from a previous
build that is *not* known to "git" you just built?

Neither will help in such a case.  The test pretty much runs with
GIT_EXEC_PATH set to the build area, and we do want to be able to
test what we have in the build area before we decide to install
them, so that is nothing new.
