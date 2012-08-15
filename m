From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] help: correct behavior for is_executable on Windows
Date: Wed, 15 Aug 2012 12:39:37 -0700
Message-ID: <7v628k54hy.fsf@alter.siamese.dyndns.org>
References: <20120811070030.GA83665@book.hvoigt.net>
 <7vd32whgvl.fsf@alter.siamese.dyndns.org>
 <20120813170221.GB6418@book.hvoigt.net>
 <7vmx1yel9d.fsf@alter.siamese.dyndns.org>
 <20120815165054.GA43523@book.hvoigt.net>
 <7v7gt06nyk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 15 21:39:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1jRT-00067I-6M
	for gcvg-git-2@plane.gmane.org; Wed, 15 Aug 2012 21:39:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753425Ab2HOTjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Aug 2012 15:39:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42073 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab2HOTjk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2012 15:39:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 14C068D9D;
	Wed, 15 Aug 2012 15:39:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/D0NG3LXwSfyj/lN/fHOGUOZkn8=; b=IYas2o
	XRqTNaEUunadceH+w5eSeM2n0UQqWKk7+y3agdO5hj1Eq9GKrmJoodk4rSiz9p6k
	OYAmqw0/iI9KI0n4VyozMLWpl2WTuEp3QkV7AJFG9IRpdExAznxQwv0mpQPzzxaB
	BGYvWZQjhXMcShLZriodYdWee+c46g3gGYL3E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=IGwozsnXaQBlQC3Pg/eSe5AuYnnizpmQ
	uj8wHoYJz9tothurx9BSMLHyIjCr3WuGP5X/m8NJVvPPH7SVcfPmuvB6BGTinsfP
	B1Ihx74oqrl/O2jCHAznORZzHuYODbUXG3IgQMRZYB4WNcBiT0AmqDYqWpnTcDG7
	0sJZy2+YOkw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 02C2F8D9B;
	Wed, 15 Aug 2012 15:39:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D0208D9A; Wed, 15 Aug 2012
 15:39:39 -0400 (EDT)
In-Reply-To: <7v7gt06nyk.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 15 Aug 2012 10:53:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F3DB209E-E710-11E1-8F28-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> diff --git a/help.c b/help.c
>> ...
>> +
>
> Yuck.
>
> Why should we need even a single line of the implementation of a
> function that tells if a given pathname contains an executable
> command, which we know is platform specific?  

Sorry; sent without sufficient proofreading.  

Obviously we need such an implementation (per platform) somewhere in
the system.

What I meant to ask was "Why should we need a function whose
implementation has to be platform-specific in this help.c file".
The last part of the sentence was missing.
