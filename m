From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Announce] libgit2 v0.17.0
Date: Wed, 23 May 2012 09:51:46 -0700
Message-ID: <7v8vgi263h.fsf@alter.siamese.dyndns.org>
References: <CAFFjANQ_kfRc8LhZD4nxeYmRML6i5dQEskUv3Caz7GmnvZi2Jw@mail.gmail.com>
 <nngy5oi3o37.fsf@transit.us.cray.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Vicent Marti <vicent@github.com>, <libgit2@librelist.org>,
	<git-dev@github.com>, <git@vger.kernel.org>
To: <dag@cray.com>
X-From: git-owner@vger.kernel.org Wed May 23 18:51:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXEmv-0005sp-Gu
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 18:51:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153Ab2EWQvu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 12:51:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62527 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932085Ab2EWQvs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 12:51:48 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26E4C89D1;
	Wed, 23 May 2012 12:51:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MeO7BaU7wJoJUfbhAD6V7FyX00k=; b=GFG0ah
	hpFjtqh3yrIFzl8Pildo6//NwmD2W/M8iPf7nblJHEDTo+kVQtzrkKI9debwG2Xs
	aWMTQJkdb5oXKH3LpDqQRnAlMcIQGJ3t4sxxZzri7BxUSNRl3XzzEgZmnx1ouOtj
	Hkeas2aoG9Kd8F2OeYLWhwbN06eooXtvT+QOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sUVXnXMJ9chf3xOEJkyMI4sl/Lsofd5U
	OqelNHGgBAyX0kFdyZe5ERsycMYeSD8TQyitr4PyqfPir6oW4s5TxZwq4pd9ZV1W
	HhY9rTN6VQ3szQxiap44vsDBCPpHyLW+60DD/Hz/6w0PdzeYPx66ugPuSWh5800B
	c6S/EZuXQ1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E6C489D0;
	Wed, 23 May 2012 12:51:48 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6FA789CE; Wed, 23 May 2012
 12:51:47 -0400 (EDT)
In-Reply-To: <nngy5oi3o37.fsf@transit.us.cray.com> (dag@cray.com's message of
 "Wed, 23 May 2012 10:37:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 95EBAD6A-A4F7-11E1-93D1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198310>

<dag@cray.com> writes:

> Vicent Marti <vicent@github.com> writes:
>
>> Hello everyone,
>>
>> A new libgit2 release is here. This one is huge (most new features to
>> date). Check out the diff API. It's shiny.
>
> This is cool.  I've wanted this for a while.  How do you ensure that the
> operation of libgit2 matches that of git proper?  Is there any plan to
> slowly convert git commands over to a libgit2 implementation?

There is no "plan" in the "concrete timeline and implementation strategy"
sense, but it is what any sane person would hope is a good longer-term
direction.

But it is also a bit of a chicken and an egg problem.

I am hoping that the library would become solid enough to allow us to
start attempting such an experiment some day, but at the same time, I know
that that "some day" is not in a very near future, after having seen at
$DAYJOB that a certain internal tool linked with a version of libgit2
breaking user's trees from time to time, bugs against the internal tool
getting filed and then some of them getting fixed at libgit2 level, either
by upstreaming fix or by updating to newer snapshot of libgit2.
