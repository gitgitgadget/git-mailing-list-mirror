From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation/difftool: add deltawalker to list of valid
 diff tools
Date: Thu, 15 Mar 2012 15:16:43 -0700
Message-ID: <7vobrxik6s.fsf@alter.siamese.dyndns.org>
References: <1331828906-5943-1-git-send-email-tim.henigan@gmail.com>
 <7v3999k2h5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, davvid@gmail.com
To: Tim Henigan <tim.henigan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 23:17:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8Iys-0004HY-Cr
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 23:17:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196Ab2COWRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 18:17:02 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965031Ab2COWQ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 18:16:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 18B0D7638;
	Thu, 15 Mar 2012 18:16:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wNXw3qAeJUETl5XScmNggfkAAWY=; b=e1RtlK
	9pNrt1AlMYPz8LgJpJEjP1/hY1/mLLlJVSctFEv19XZtuk3k2IY+ZLBCGteHCdvT
	CIvrfAVw8Zsj+ovsNE7gyWknYreJWjiI12q7f2d98Y+VHDc0fCVmpL8pAlnx+qEs
	e9ROvG6dc/FO2uGNQ2NvGPvpoP917urEof/CY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M74X8Xf2X+xa7WtwVX1wZ9Ws5iBakXQq
	37v60w+DdB+2vHCTbC4yb/08pparbBC6nSdv9Eqclfx8c10osRORid90UVDghLj0
	MVg4ABZfcgMRrBVDZ9GChdlIKResG4jdR7kD6eRf2l4b2rB2/RlYO/p97N54BKEr
	p2FyBueWs0g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 108E87637;
	Thu, 15 Mar 2012 18:16:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 987E27635; Thu, 15 Mar 2012
 18:16:45 -0400 (EDT)
In-Reply-To: <7v3999k2h5.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 15 Mar 2012 13:56:22 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8D187AA6-6EEC-11E1-9958-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193231>

Junio C Hamano <gitster@pobox.com> writes:

> Tim Henigan <tim.henigan@gmail.com> writes:
>
>> The list of valid tools seems prone to error. Right now, there is nothing
>> that tells people to update this documentation when new config files are
>> added to 'mergetools'.  Should I add a README to 'mergetools' with
>> instructions to update this file?  Or would it be better to replace the
>> list in the help string with a more general statement like "<tool> must
>> match one of the files located in $(git --exec-path)/mergetools"?
>
> I would prefer to rip most of them out from this list in the
> documentation, and refer people to ask the installed version of "git
> difftool" to list them.  After bc7a96a (mergetool--lib: Refactor tools
> into separate files, 2011-08-18), that should be the most sensible option.
> I.e.
>
> 	--tool=<tool>::
> 		Use the diff tool specified by <tool>.  Valid diff tools
>                 include emerge, kompare, meld, and vimdiff; for complete
>                 list, run 'git difftool --tool-help'
>
> or something.

The above is the longer-term direction. I'll apply your patch to add
another new tool to the existing list for 1.7.10.
