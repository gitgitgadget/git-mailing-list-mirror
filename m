From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] diff: support --cached on unborn branches
Date: Sat, 30 Oct 2010 20:12:27 -0700
Message-ID: <7vwroz3vj8.fsf@alter.siamese.dyndns.org>
References: <7vhbg56i9s.fsf@alter.siamese.dyndns.org>
 <1288437377-30405-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jonathan Niedier <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 31 04:12:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCOLl-0006V9-6W
	for gcvg-git-2@lo.gmane.org; Sun, 31 Oct 2010 04:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754525Ab0JaDMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 23:12:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40600 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753738Ab0JaDMm convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Oct 2010 23:12:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 401202E35;
	Sat, 30 Oct 2010 23:12:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=7m0kySJXPcwZ
	EkgAvRYDcx2upCE=; b=EXo80qiA0Tar94ed/hzOvp6XxrGJyS8nFD2tuh9Er1Tw
	bVre/wuc88SEWyFX/doSxLz3aJyjGMdgrAaaic4vrftRRSVo9F57MmCSLm3UAkzc
	wF4lzTEHdPWmZNy5nI3pfFc4pEHsg6coMxEP3z5rn8djQlJTxedJ/imxMXtwPrs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=yINYCy
	xP7QLdhVYhTKF76jSogILMNj6iegGz6J4il/sX7W1Satwghk07gsgnacSyA733e1
	5alwsR8kWLqe5GEMrKhuBb7ehjzd/lBhi6tDhZwdJAIauZ98lXFD5qQqvIHjZcwh
	Fbg5+ioPlhVx9cmm/C5Ep6HDtzjjd3DjkoTJY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id F31662E31;
	Sat, 30 Oct 2010 23:12:34 -0400 (EDT)
Received: from pobox.com (unknown [76.102.169.49]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 084E62E2C; Sat, 30 Oct
 2010 23:12:28 -0400 (EDT)
Importance: high
In-Reply-To: <1288437377-30405-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Sat\, 30 Oct
 2010 18\:16\:17 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B5274238-E49C-11DF-B93D-030CEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160409>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> "git diff --cached" (without revision) used to mean "git diff --cache=
d
> HEAD" (i.e. the user was too lazy to type HEAD). This "correctly"
> failed when there was no commit yet. But was that correctness useful?
>
> This patch changes the definition of what particular command means.
> It is a request to show what _would_ be committed without further "gi=
t
> add". The internal implementation is still the same "git diff
> --cached HEAD" when HEAD exists, but when there is no commit yet, it
> compares the index with an empty tree object to achieve the desired
> result.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>

Will take a look at it, and queue.  Thanks.

>  "git diff --cached HEAD" does fail, but I don't really care.

I _do_ care, and so should you.  And I think it _should_ fail, if the u=
ser
explicitly asked to compare the index with HEAD that does not exist yet=
=2E

As we are updating the semantics of a Porcelain command, there should b=
e
an update that explains the new usage in the documentation, no?
