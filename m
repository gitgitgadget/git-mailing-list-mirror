From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] git-sh-i18n--envsubst: our own envsubst(1) for
 eval_gettext()
Date: Sun, 08 May 2011 20:17:18 -0700
Message-ID: <7vsjsor29t.fsf@alter.siamese.dyndns.org>
References: <1304856659-10672-1-git-send-email-avarab@gmail.com>
 <1304856659-10672-2-git-send-email-avarab@gmail.com>
 <7v1v09un8y.fsf@alter.siamese.dyndns.org>
 <BANLkTikSvU4haNpRmPq8o2P0yB1Y3t0Ahg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 09 05:17:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJGyU-0001XK-CZ
	for gcvg-git-2@lo.gmane.org; Mon, 09 May 2011 05:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab1EIDR3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 8 May 2011 23:17:29 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47467 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818Ab1EIDR2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2011 23:17:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9C613563A;
	Sun,  8 May 2011 23:19:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b8v9i8OG8H94
	dAkWmShP/GPxbx8=; b=XWH88IxqYt+4801eAojlcG9TTADkXjd472rdWdwD+A5F
	GLWJlWaBh4Ri48jIZiQQToXhAr2ih7DY+fvxua8KxtS87NskD3/B/DtpdlwmiC8m
	t7nqgatB02b2wRyUpDiCkU0+RrXax6BGvydEhNxPOCwPgzUfiYYOBTsasru7otQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=V0LAtC
	3NgrkBKILv13BIV/ZPw1EUvngniF37S/SKm+rWwqYj8n3+ew1+DJr649v6pgXran
	ArccpefWR+vHk4nyHWOPRSvb9gJNKSQ5uB3Dzj6JSgnB+ys2JgmNbUl8eCjcB09e
	O5Y5YXBXG+1wvXbEMqDSEgGWOy/wK/ZwLtshA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 6C58D5639;
	Sun,  8 May 2011 23:19:30 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5C1A35638; Sun,  8 May 2011
 23:19:26 -0400 (EDT)
In-Reply-To: <BANLkTikSvU4haNpRmPq8o2P0yB1Y3t0Ahg@mail.gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Sun, 8 May
 2011 23:33:46 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 273AA354-79EB-11E0-85C9-90BEB0B5FC3A-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173191>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Or are we sure that this can't work in POSIX (or non-POSIX shells)?

You need to implement the same logic to tokenize enough to understand t=
he
expansion the shell does inside dq.  Yes, shell is general programming
language and you can theoretically implement it, but would the result b=
e a
practical solution?  I doubt it.
