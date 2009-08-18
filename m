From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] block-sha1: Windows declares ntohl() in winsock2.h
Date: Tue, 18 Aug 2009 06:39:50 -0700
Message-ID: <7v4os5gs0p.fsf@alter.siamese.dyndns.org>
References: <4A8A552D.6020407@viscovery.net> <4A8A8661.5060908@gmail.com>
 <4A8AA511.1060205@gmail.com>
 <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Artur Skawina <art.08.09@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	msysGit <msysgit@googlegroups.com>,
	Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	Git Mailing List <git@vger.kernel.org>
To: Sebastian Schuberth <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 18 15:40:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdOv8-0002Tj-UJ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 15:40:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbZHRNkD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 09:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbZHRNkC
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 09:40:02 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:39720 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbZHRNkB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 09:40:01 -0400
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3B818F016;
	Tue, 18 Aug 2009 09:40:01 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3751F015; Tue, 18 Aug
 2009 09:39:51 -0400 (EDT)
In-Reply-To: <bdca99240908180617n75dfd0b5nfe069aba6e74b722@mail.gmail.com>
 (Sebastian Schuberth's message of "Tue\, 18 Aug 2009 15\:17\:33 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A0BA5582-8BFC-11DE-B59F-EAC21EFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126398>

Sebastian Schuberth <sschuberth@gmail.com> writes:

> On Tue, Aug 18, 2009 at 14:56, Artur Skawina<art.08.09@gmail.com> wrote:
> ...
>> I'd limit it to windows and any other ia32 platform that doesn't pick the
>> bswaps itself; as is, it just adds an unnecessary hidden gcc dependency.
>>
>> Hmm, it's actually a gcc-4.3+ dependency, so it won't even build w/ gcc 4.2;
>> something like this would be required: "(__GNUC__>=4 && __GNUC_MINOR__>=3)" .
>
> So, as you say the code makes no difference under Linux, would you be
> OK with just testing for GCC 4.3+, and not for Windows? That would get
> rid of the "hidden" GCC dependency and not make the preprocessor
> checks overly complex. Moreover, limiting my patch to any "platform
> that doesn't pick the bswaps itself" could possibly require
> maintenance on compiler / CRT updates.

I would say that should be fine, but I'd let Linus and Nico to overrule me
on this if they have any input.
