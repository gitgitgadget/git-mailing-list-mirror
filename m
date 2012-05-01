From: Junio C Hamano <gitster@pobox.com>
Subject: Re: XDL_FAST_HASH breaks git on OS X 10.7.3
Date: Mon, 30 Apr 2012 21:39:13 -0700
Message-ID: <7v8vhccy6m.fsf@alter.siamese.dyndns.org>
References: <441BE38F-E081-4ED8-B587-BF72AD6368EE@gernhardtsoftware.com>
 <87mx5tyy2a.fsf@thomas.inf.ethz.ch>
 <3BE9DFB5-81F9-40D6-A637-6C3C232394A6@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Git List <git@vger.kernel.org>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Tue May 01 06:39:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SP4rz-0002aH-7S
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 06:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752122Ab2EAEjS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 00:39:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42339 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751664Ab2EAEjR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 00:39:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 89D517E11;
	Tue,  1 May 2012 00:39:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=m7d1+VV6McVIRyleTuVdu7EaXbs=; b=p9q2OW
	F1q4WWCsBy8oN2h30mNqI+NFJz4jqH2j2Hx2j91i/w3/7PjNgWrZH7eonnbLQJrI
	VQRx6D/z1elAjwAI7UO2Ts7fubcDZh92/VgYlhp/089HJgyv1gkxF38a4P0PJSIQ
	R4ipGTbJJSpeGcboDFA7LcvstbM1XG69MVQG4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GM5dorcyABVOD4Xp/m+vpHgu7v4dvUmN
	vIQNIEOTue1jvB7DEeHJvRaNsouSnvVVM4BmOaBTttMxHfYEMUuy2YdJt/cy9w8n
	3rc7Hig/77Gprbhu82/Ky7pzjGiaAkDs0oyad1DacxMiap60ft5ueukMQrKUtWTW
	57qvt2g2iig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7FF1D7E10;
	Tue,  1 May 2012 00:39:16 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 14DF77E0F; Tue,  1 May 2012
 00:39:14 -0400 (EDT)
In-Reply-To: <3BE9DFB5-81F9-40D6-A637-6C3C232394A6@gernhardtsoftware.com>
 (Brian Gernhardt's message of "Mon, 30 Apr 2012 22:13:09 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 9B0AC680-9347-11E1-81E8-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196656>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> On Apr 30, 2012, at 12:38 PM, Thomas Rast wrote:
>
>> I can reproduce this.  The problem is that __WORDSIZE is not defined,
>> either because it's Darwin or because the GCC is too old.  It winds up
>> compiling the 32-bit case, which of course doesn't work for 64-bit
>> builds.
>
> Great.  I was worried about having to help you debug it via e-mail round-trips.  :-D
>
>> Perhaps we can rewrite it in terms of sizeof(long) like this?
>
> It does work for me, and seems pretty valid to me since long is actually
> the type you're storing it in.

Thomas, care to roll an incremental update with proper log message, so
that we can unbreak the tip of 'next' for Darwin users?

Thanks, both.
