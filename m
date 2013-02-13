From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2013, #05; Tue, 12)
Date: Wed, 13 Feb 2013 07:27:49 -0800
Message-ID: <7vpq04b5e2.fsf@alter.siamese.dyndns.org>
References: <7v621xdql8.fsf@alter.siamese.dyndns.org>
 <CAH5451nPKq8DKwo+Bkxh08N-wqrYCY4BihbvaE14z5iGVA1iZw@mail.gmail.com>
 <7vsj51caqb.fsf@alter.siamese.dyndns.org>
 <CAH5451mmXg=xvb-gW0qNvp7f8M5Jk5_ZS+UHAzMaGhJ677zWmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>
To: Andrew Ardill <andrew.ardill@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 16:28:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5eFv-0006hZ-Gg
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 16:28:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934122Ab3BMP14 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 10:27:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758942Ab3BMP1z (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 10:27:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9512FBAFE;
	Wed, 13 Feb 2013 10:27:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+3LMaHvqbX2v2V/i4NO4CFYfTLY=; b=llIX41
	ytQi+MN1cMbE9z7Ef7r8O3wVVxOad9vz4wGP3Fl7Xa2xpABSV9WcaDYaJLD3Zn2u
	WEAR/ILR4clbdIzkHGF8tVetGg4yTKrabumn04J5CkEnDuqyFQjOwFhq/glIOwPa
	UtU2m0Fg6LnJvBOzPGCcgjB3/QRkb+h3eG7yQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UJG5TDmZLS8Qy3nK9P6kO3YhPZ0QuF5g
	FZd1d1d7NgaarWSvIxo8x//ndRdChzFXOhIyzn2bBxUcCBWWu9Qkr1iWSX14wglA
	uMol+uSNq8inYwWTpPwqqnIeJMtjD94MBiyHmSehGeSBaOovffD64Z7mX2PWMMdS
	0TUq8FBGKoo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8884ABAFD;
	Wed, 13 Feb 2013 10:27:52 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AFBBBAF7; Wed, 13 Feb 2013
 10:27:51 -0500 (EST)
In-Reply-To: <CAH5451mmXg=xvb-gW0qNvp7f8M5Jk5_ZS+UHAzMaGhJ677zWmw@mail.gmail.com> (Andrew
 Ardill's message of "Wed, 13 Feb 2013 11:42:06 +1100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EDC46CAE-75F1-11E2-A0EE-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216261>

Andrew Ardill <andrew.ardill@gmail.com> writes:

> On 13 February 2013 11:34, Junio C Hamano <gitster@pobox.com> wrote:
>> The change could negatively affect people who expect that removing
>> files that are not used for their purpose (e.g. a large file that is
>> unnecessary for their build) will _not_ affect what they get from
>> "git add .";
>
> How big a problem is this?

As you said below, it could be fairly big, if you expect a lot of
people do not use "git add -u".

> If we need to support this behaviour than I would suppose a config
> option is required. A default config transition path similar to git
> push defaults would probably work well, in the case where breaking
> these expectations is unacceptable.

We've discussed that before.

http://thread.gmane.org/gmane.comp.version-control.git/171811/focus=171818

>> obviously they must have trained themselves not to do
>> "git add -u" or "git commit -a".
>
> Many people use git add -p by default, so I would not be surprised
> about people not using -u or -a.
