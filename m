From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Do not use SHELL_PATH from build system in
 prepare_shell_cmd on Windows
Date: Wed, 18 Apr 2012 22:49:43 -0700
Message-ID: <7v8vhsi83s.fsf@alter.siamese.dyndns.org>
References: <7vvclmoit6.fsf@alter.siamese.dyndns.org>
 <1333157601-6458-1-git-send-email-bwalton@artsci.utoronto.ca>
 <4F8D15B9.70803@viscovery.net> <20120417221449.GC10797@sigill.intra.peff.net>
 <4F8E539F.7030902@viscovery.net> <7vobqpknoq.fsf@alter.siamese.dyndns.org>
 <4F8FA453.8050807@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Ben Walton <bwalton@artsci.utoronto.ca>,
	jrnieder@gmail.com, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 07:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKkFb-0003zf-Jx
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 07:49:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752739Ab2DSFtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 01:49:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57818 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752089Ab2DSFtp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 01:49:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0106B77A1;
	Thu, 19 Apr 2012 01:49:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sN4OISotSuFt5ckN72oVu0F+Vzc=; b=HP8657
	Y+er074B+/upq1Aye9uz/Wy7M6oiH7CPOVuCNot17BG0IdiXfINNFp46QuIKi2M+
	UBWricFkvr73L2heb+jluBN/fGaLATLwTN2g0xiXfW4k7ygY9kHcUmmRWfzQBq1I
	7lxmOMzcCqIYSGDzW+efhRzLB0IdGIsryzWkU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lDiMQVgdMou12lKS3u3RxFBqQIm0zsM7
	Am+FcOdtznCzJq9yA0rcDXmQZMaT0kYTIxEcQ+34zo3UG45UcL1ZktTcPGkXDxvu
	U3EsHOzBceiBdk0+2woxHjEu0HV0VhDwIWuhTDYqdU+6AaCVOX8FsEFX1CKprdnA
	5mcgD9NPCAY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ED29577A0;
	Thu, 19 Apr 2012 01:49:44 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A8FE779E; Thu, 19 Apr 2012
 01:49:44 -0400 (EDT)
In-Reply-To: <4F8FA453.8050807@viscovery.net> (Johannes Sixt's message of
 "Thu, 19 Apr 2012 07:36:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7703A83C-89E3-11E1-85D1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195923>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Am 4/18/2012 18:30, schrieb Junio C Hamano:
>> There is one thing I am confused about your response, though.  I thought
>> the suggestion by Peff was to build your binary with "make SHELL_PATH=sh"
>> (not "make SHELL_PATH=/bin/sh").  I do not know if that works or does not
>> work (I do not see why not, though), but in either case offering a new
>> customization point sounds like a separate issue.
>
> I tried this, and it does not work. (Shell scripts' shbang line would end
> up as '#!sh', and at least bash does not like to run such scripts.)

Ahh, sorry for missing the obvious.  I should have realized about that
one, as customizing that one was the very original motivation of the make
variable.

In any case, as I wrote in the "What's cooking", I'll fast-track the fix
to 'master' shortly, so that Windows port does not have to carry it.

Thanks.
