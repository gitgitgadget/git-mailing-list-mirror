From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] Change t0204-gettext-reencode-sanity.sh to pass
 under Mac OSX
Date: Wed, 07 Mar 2012 13:34:23 -0800
Message-ID: <7vfwdkm6xs.fsf@alter.siamese.dyndns.org>
References: <201203052039.16893.tboegi@web.de>
 <7vzkbuzss7.fsf@alter.siamese.dyndns.org>
 <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 22:34:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5OVN-00022p-Dx
	for gcvg-git-2@plane.gmane.org; Wed, 07 Mar 2012 22:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441Ab2CGVea convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 7 Mar 2012 16:34:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38372 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030416Ab2CGVe0 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Mar 2012 16:34:26 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 338716A18;
	Wed,  7 Mar 2012 16:34:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pp0c6SORZnwy
	Vy6QpOuhwUlQso4=; b=EZz5JFN3BOOrTXA4+3Z01927eWigWHJatuRIGsNYcrDr
	jsijiAjXC82mDOA5VLves71xmN7d4qmv4pQD/vjsq6+LUkJ1GMKJFqnAheU2awzt
	+94KWrTSKknqJoTuWbQHnyYF8xwg6WsYWJuv3XC/AK2uj59orpiihH7uOgUWtQ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=KFwbUk
	Lw1Ro1tlzuZimcJZUn4+0jBIYQbNnGhePpttU6KYawMULMe9d5GLmGjQ2ydZ5C7y
	pmHUSyPcdv2iTLI6PkI+FctHoSb5IKNU0r1LPRIxcnMecU/YuXSU7nBKqRDvVVyF
	FLjQicaOJJWj+Xp+8kCRmEz9UnFuopnZVUTS0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2AF8D6A17;
	Wed,  7 Mar 2012 16:34:25 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B36656A16; Wed,  7 Mar 2012
 16:34:24 -0500 (EST)
In-Reply-To: <CACBZZX4P=JSdP_vLOMx5r3R+YO8SMSs5W8+vf2DMibKMwBx_Vg@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 7 Mar
 2012 22:03:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4F4D82F2-689D-11E1-A5A7-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192486>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think in particular re-encoding works completely differently under
> the Perl i18n library than it does with GNU gettext (and we don't hav=
e
> tests for this) and instead of just dropping unknown characters under
> non-UTF-8 locales on some platforms everything may turn into complete
> gibberish.
>
> When I added this test this was what I was planning to smoke
> out. Different behaviors on different platforms. In this case the OSX
> behavior seems benign,...

I am not sure where you are drawing the line between "complete
gibberish" and "incorrect transliteration", but if you mean by
"gibberish" something that makes user's terminal go berserk,
spitting out UTF-8 when the reader has asked for and is expecting
Latin-1 is already throwing "gibberish", so Mac OS X should fail the
test, I would think.

But for this particular test case, it is even worse, as the test is
asking to do an impossible task to the transliteration machinery, so
it is not even "gibberish" test.  If the input caused the program to
terminate without an error but without producing an output, that
won't be "gibberish" case, but should that be treated as "success"?

> I think it's important to be pro-active about trying to spot
> any issues that might affect end users before they happen.

The goal is noble, but asking the platform to perform an impossible
task and subjectively judging if the failure mode is acceptable is
not the way to do so, I would have to say.
