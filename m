From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitattributes.txt: mention exceptions to gitignore rules
Date: Tue, 04 Jan 2011 11:17:14 -0800
Message-ID: <7vwrmkfphh.fsf@alter.siamese.dyndns.org>
References: <iftvu6@dough.gmane.org>
 <1294147915-1475-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Marcin =?utf-8?Q?Wi=C5=9Bnicki?= <mwisnicki@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 04 20:17:33 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PaCNw-0002Ik-Lp
	for gcvg-git-2@lo.gmane.org; Tue, 04 Jan 2011 20:17:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699Ab1ADTR0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Jan 2011 14:17:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65094 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129Ab1ADTRZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Jan 2011 14:17:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 828932F87;
	Tue,  4 Jan 2011 14:18:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=py/eEnbogRwX
	Hz06rzbsahhdPN4=; b=MSRyXdpBG/Db1BJX312cOxHHMDmKmsVaX3UGqx8RrrGw
	3LYYO/oVBsKs9t/tlMk/drZiShxYhajBCqpp6mMT+vcht5ovvQ0VlmRgpHyM9rW4
	Y/xVXmOagdDU+OuJDWT1RxRL0gkKRoj71Kfnu2we5h6kHta9z3kf6K8g4NtEVOo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=PHtyz4
	m4pJBvirw3fRU/wgZB50SkMukyxQRuCc/9LBGkif0OBS+ON5BzFFD6OtFAO7TI7z
	NBeTG9GENsdG+C5dOFyBNAqdv3/EaIvRWYtf4VUAdAUirkHWNDJlWNOpWBUCS/pG
	LcVlutoSpFpxhaqBUYh5mi0S8zgAX6xlN5Qfs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 521452F83;
	Tue,  4 Jan 2011 14:17:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 054B32F82; Tue,  4 Jan 2011
 14:17:52 -0500 (EST)
In-Reply-To: <1294147915-1475-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Tue\,  4 Jan
 2011 20\:31\:55 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5666FC74-1837-11E0-80D9-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164507>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

>  2011/1/4 Marcin Wi=C5=9Bnicki <mwisnicki@gmail.com>:
>  > I think that for the time being at least the manual page must chan=
ge to
>  > reflect reality.
>
>  Looks like changes will be more than just a few lines because path_m=
atches()
>  needs to learn about directories (iow less likely to get fixed right=
 away).
>  So, yes, good idea.

Not really.  I'd rather see a handful of test cases added to t0003 to h=
elp
interested parties to see what is broken and what is not.

Quoting from Marcin's other message, assuming that "Patterns" are store=
d
in either .gitattributes at the top level or .git/info/attributes:

> Example for file: d1/d2/f1.c
>=20
> Patterns that match:
>   *.c

No slashes, so it should match anywhere (correct).

>   d1/d2/*

With slashes, so this is anchored at the toplevel of the working tree, =
and
the path should match (correct).

>   /d1/d2/*

The same as above;, the leading '/' is only to make it explicit that it=
 is
anchored at the level

>   */d2/*

Should match.

>   */*/*

Should match.

> Patterns that do not match but should:
>   d2/*

This shouldn't match unless it appears in d1/.gitattributes.

The presense of '/' makes the pattern anchored to the directory it appe=
ar
in, and .git/info/attributes is taken as being at the top level.

>   d2/
>   d2

These shouldn't for the same reason.

>   d1/d2
>   /d1/d2

We somehow don't do leading path match like we do for gitignore, but I =
do
not think this was intended.  My gut feeling is that these should match=
=2E

The thinking back, when we wrote the code, could have been that, unlike
gitignore that maintains only one bit (either "ignored" or "not"),
attributes are richer and giving the same attribute (say "whitespace
checking criteria") to files inside a directory and the containing
directory itself was nonsensical.  But if that was the reason, it is
faulty, as we do not track directories anyway.

Wouldn't it be sufficient to teach attr.c:path_matches() that a pattern
could also match with leading path?  That would automatically cover the
case where a pattern is terminated with a slash, as pattern "d/e/" woul=
d
never match path "d/e" but does match "d/e/f"?
