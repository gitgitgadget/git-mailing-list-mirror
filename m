From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] ctype: implement islower/isupper macro
Date: Thu, 09 Feb 2012 20:03:30 -0800
Message-ID: <7vliobs5bh.fsf@alter.siamese.dyndns.org>
References: <1328840011-19028-1-git-send-email-namhyung.kim@lge.com>
 <1328840011-19028-2-git-send-email-namhyung.kim@lge.com>
 <7vwr7vsa8j.fsf@alter.siamese.dyndns.org> <4F3481CD.5010303@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?6rmA64Ko7ZiV?= <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Fri Feb 10 05:03:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rvhi0-0008Qt-Va
	for gcvg-git-2@plane.gmane.org; Fri, 10 Feb 2012 05:03:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758094Ab2BJEDg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Feb 2012 23:03:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46405 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754556Ab2BJEDf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Feb 2012 23:03:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34E9D72B2;
	Thu,  9 Feb 2012 23:03:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=wgzex6H/U3+B
	EApPvp0JE1+iXFA=; b=QWk09mLAy4xsi+7Y9Fml+L3lV8RV0wEHsDw9sIqA9rhv
	AM2eRjpBr/8vo7fBGaMtGpwTrucKdvDz2lDb6nqUtHkszIpmNd0jEx2C3wz7mqPW
	Sc+qtdwUgw32LRcSqHFnUa3Gh4czUtzunQNVHsCS19WrqvtczrAa8Zygkg9y5T4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=eZcNFA
	/YfznRSx/Cf02bvqKHBf5k5P/tlCJfvzg2IHQ/kGirIrdAG2iZrn4ug2/+eqzL6t
	u7lyvrwhV0+Dy8AgqSERyJ0w1eNwyE1eDzItcpy4mlGjnZuBaBE6A4eDcc48f7X3
	VNZHcIdG/MZ7fvukt42IOAktFLHMLnUQm4JOQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A85D72B1;
	Thu,  9 Feb 2012 23:03:34 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DC8E72AF; Thu,  9 Feb 2012
 23:03:31 -0500 (EST)
In-Reply-To: <4F3481CD.5010303@lge.com> (=?utf-8?B?Iuq5gOuCqO2YlSIncw==?=
 message of "Fri, 10 Feb 2012 11:32:45 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 31FE24D8-539C-11E1-BC72-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190375>

=EA=B9=80=EB=82=A8=ED=98=95 <namhyung.kim@lge.com> writes:

> 2012-02-10 11:17 AM, Junio C Hamano wrote:
>> Namhyung Kim <namhyung.kim@lge.com> writes:
>>
>>> The git-compat-util.h provides various ctype macros but lacks those=
 two
>>> (along with others). Add them.
>>
>> Isn't that because we do not use them ourselves? Uses in compat/ do =
not
>> count, and judging from the way it is used in compat/fnmatch/fnmatch=
=2Ec,
>> the implementation of sane_iscase() might be overly protective.
>>
>> What problem are you trying to solve?
>
> There's no problem. In fact, these patches come from perf as it uses =
a
> copy of git code in this part.

Kim-ssi, the above is something I would have like to see in your first
message.

> If you don't
> think it's worth applying I'm fine with dropping it.

I never said these patches are worthless.

I just was wondering what the motivation behind them were.  If you are
involved in maintaining Perf, and if it wants to keep its own forked co=
py
as close as ours, that is a good enough justification, as long as the
additions we do not use ourselves is still reasonably done.
