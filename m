From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: when failing, tell the user about options that
  work
Date: Thu, 22 Oct 2009 17:28:59 -0700
Message-ID: <7vhbtrdkc4.fsf@alter.siamese.dyndns.org>
References: <76c5b8580910220810n389d065di349339ab38909ef7@mail.gmail.com>
 <f1e86b9095d63c6541d0a8df6a1cf8eadfe247bb.1256226187.git.trast@student.ethz.ch> <81b0412b0910220940n78ddb774i30338147327b198a@mail.gmail.com> <7v63a7f4ka.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.00.0910222011200.21460@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Thomas Rast <trast@student.ethz.ch>,
	Eugene Sajine <euguess@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Fri Oct 23 02:29:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N181x-0006N6-S4
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 02:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751299AbZJWA3K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2009 20:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751204AbZJWA3K
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Oct 2009 20:29:10 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46376 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750941AbZJWA3J (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2009 20:29:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BBD38829F2;
	Thu, 22 Oct 2009 20:29:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7dc4Ob4Xus+6ZIBDN9nHCuLsHIY=; b=hOMrnj
	MvaaqGlwll1ip6KFv62VjZt7zRj/kyj1k788+QJLkkSo/Vt15hEcXy0gn+ZNjit3
	3QZtWfKdLhOY+FLcBVpoJlBRdqRvq5wPTqLKxJZXrDpIV6l5jsfw5gabdF+1d1dU
	cl4UH+kVd3EBUX08UIezI1myHUCcbl/x0vrCo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OViuzAWbBxuQo0vLTnNIy4HcLb0fCnLh
	7XWSR2iaGzFavHpJeCkSonbwUNq4RBAGVX/+BCi8hGLMQIGF8KwBzAnyqSE0XUVo
	9izcMLGNjBecTZzRKlyeZYodKMB+kZPJ0wsHnfg/lJQpX7Db1YbMcWd51tgoNJiB
	oLQGL3kwH18=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 75A0A829EE;
	Thu, 22 Oct 2009 20:29:08 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6D02F829ED; Thu, 22 Oct 2009
 20:29:01 -0400 (EDT)
In-Reply-To: <alpine.LFD.2.00.0910222011200.21460@xanadu.home> (Nicolas
 Pitre's message of "Thu\, 22 Oct 2009 20\:13\:14 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 13ECDE98-BF6B-11DE-A46F-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131079>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Thu, 22 Oct 2009, Junio C Hamano wrote:
>
>> Alex Riesen <raa.lkml@gmail.com> writes:
>> 
>> > These are quite verbose. Could they be conditional on something like
>> > advice.describeHints?
>> 
>> Concurred.  Please make it so.
>
> I don't have a strong opinion either ways, but is having a less verbose 
> message in the _error_ path really a big issue?

Thanks for catching a thinko---I somehow thought the patch was about
warning when we give an annotated tag that is farther than an unannotated
one.

It should be good enough to unconditionally give hints upon an error, as
long as they are correct.
