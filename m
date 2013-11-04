From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Nov 2013, #01; Fri, 1)
Date: Mon, 04 Nov 2013 09:37:33 -0800
Message-ID: <xmqqeh6w131e.fsf@gitster.dls.corp.google.com>
References: <xmqqob6320rt.fsf@gitster.dls.corp.google.com>
	<52743547.7020001@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Mon Nov 04 18:37:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VdO5v-00083O-4R
	for gcvg-git-2@plane.gmane.org; Mon, 04 Nov 2013 18:37:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436Ab3KDRhi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Nov 2013 12:37:38 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65473 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753395Ab3KDRhi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Nov 2013 12:37:38 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0D5464BFA6;
	Mon,  4 Nov 2013 12:37:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rMS9tB7WX1ODjHusseySUgMYy24=; b=V/nSH8
	bems5ZUna1u/9xkweH6CC10TVj0VZpbqjMPju4FuwBTEIMWGuVZulIB6pCexrt9b
	a0snxuntLFZpF1D55xd2Of7wlDQySZvj0YM2/sk7h31CFr7sFPwEt0xjNsvXL/4y
	mrMbXUulKD/TGIKwl5NMSY106C37sBZrGeg5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ky0bz/8mJBLRGMkYL+HZXO0MPYzQgSZr
	05FE09pzbi9JDhUb1WSYixVaByzsgq+0tm7lebomzEHB1zlNRRSgXr4NRNkb56OO
	iPq51iuqtoZJkvtuBYzzD5rcGwf5BmbzMcC+z47gb2OLccQ1CjVUzrWFxnWMyJ/B
	lNjIZsO8H3A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ECA204BFA5;
	Mon,  4 Nov 2013 12:37:36 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4B9474BFA4;
	Mon,  4 Nov 2013 12:37:36 -0500 (EST)
In-Reply-To: <52743547.7020001@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Fri, 01 Nov 2013 23:12:07 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CB29B0B8-4577-11E3-ADF9-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237290>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 01/11/13 22:52, Junio C Hamano wrote:
>> Here are the topics that have been cooking.  Commits prefixed with
>> '-' are only in 'pu' (proposed updates) while commits prefixed with
>> '+' are in 'next'.
>>
> [ ... ]
>> 
>> 
>> * fc/transport-helper-fixes (2013-11-01) 11 commits
>>  - transport-helper: demote lack of "force" option to a warning
>>  - transport-helper: add support to delete branches
>>  - fast-export: add support to delete refs
>>  - fast-import: add support to delete refs
>>  - transport-helper: add support for old:new refspec
>>  - fast-export: add new --refspec option
>>  - fast-export: improve argument parsing
>>  - transport-helper: check for 'forced update' message
>>  - transport-helper: add 'force' to 'export' helpers
>>  - transport-helper: don't update refs in dry-run
>>  - transport-helper: mismerge fix
>> 
>>  Updates transport-helper, fast-import and fast-export to allow the
>>  ref mapping and ref deletion in a way similar to the natively
>>  supported transports.
>> 
>>  Will merge to 'next'.
>
> Commit ad24a30ef ("fast-export: add new --refspec option", 31-10-2013)
> causes sparse to complain:
>
>       SP builtin/fast-export.c
>   builtin/fast-export.c:739:55: warning: Variable length array is used.
>
> Do we want to use this C99 feature?

Good eyes, and no---this needs to be fixed before going forward.

Thanks for spotting.
