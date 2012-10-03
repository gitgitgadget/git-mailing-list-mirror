From: Junio C Hamano <gitster@pobox.com>
Subject: Re: grep.patternType
Date: Wed, 03 Oct 2012 15:14:58 -0700
Message-ID: <7vmx032of1.fsf@alter.siamese.dyndns.org>
References: <7vwqz9ak2f.fsf@alter.siamese.dyndns.org>
 <7v626r48cv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
	J Smith <dark.panda@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 05 00:02:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJtKt-0001DP-F1
	for gcvg-git-2@plane.gmane.org; Thu, 04 Oct 2012 23:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756625Ab2JCWPC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2012 18:15:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61720 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754416Ab2JCWPB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2012 18:15:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3CCD49153;
	Wed,  3 Oct 2012 18:15:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zLqbghnoGndqXn4knkGSoyEkZvQ=; b=PKR5X2
	03KuMyk+92MOIZajYo2gR4G+ElHEBJl+VZNKP0NOfbMXH2g81jVeSCfQcWZhJktf
	De0RCWMob/VCLrjlLhm39kWTzpXV3GCmxkw1X4KxEpCdkh4ErHXCNdB5PBFgI3IX
	KyBCiYX2B99Lgeoxs4t5hbT58V0PSv00xhq8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mrGfRCD4B+CNSJdOkg43xGk5c4qelxN1
	GLZh48aly8eS2GQAFAr+RJimJiQZ3Gc26qrr6C6edaE1slTgmUcMT3kjDbrfl6qF
	ivm07HYiCnC13SKR/Eyq5KukuRENKw423Q7BpB6Uzkby1KRqejNX2x+5YhvDATl5
	x78M2mpnmTE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2A9789152;
	Wed,  3 Oct 2012 18:15:00 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9CD2E9151; Wed,  3 Oct 2012
 18:14:59 -0400 (EDT)
In-Reply-To: <7v626r48cv.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 03 Oct 2012 13:18:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C55DEAAE-0DA7-11E2-ABE5-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206954>

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>  * "git grep" learned to use a non-standard pattern type by default if
>>    a configuration variable tells it to.
>
> This addition makes
>
>     git grep -e "(integer|buffer)"
>
> work as expected, when grep.patternType is set to "extended".
>
> Should this
>
>     git log --grep="(integer|buffer)"
>
> also honor the same configuration variable?  If not, why not?
>
> One more thing.  Currently you can say
>
>     git log -E --grep="(integer|buffer)"
>
> to ask for the ERE.  Should we also support -P to ask for pcre?  If
> not, why not?

Answering to myself who has been in tying-loose-ends mode.

My answers to these questions are both yes, and I have a neatly
lined up series that begins with a small bugfix and then
enhancement, but I do not think these do not deserve to in the
upcoming release.  The topic came too late, and even the fix is
for a bug that has been with us for a long time.
