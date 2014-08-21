From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Aug 2014, #03; Wed, 20)
Date: Thu, 21 Aug 2014 10:08:41 -0700
Message-ID: <xmqqd2btsrc6.fsf@gitster.dls.corp.google.com>
References: <xmqqlhqisqcy.fsf@gitster.dls.corp.google.com>
	<20140821125111.GA68724@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Aug 21 19:09:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKVrC-0000Dv-Vq
	for gcvg-git-2@plane.gmane.org; Thu, 21 Aug 2014 19:09:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753412AbaHURJA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 13:09:00 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52440 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753051AbaHURI5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 13:08:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 96769339F6;
	Thu, 21 Aug 2014 13:08:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1yFdBviruLsCLdt3w5XBmahXdhQ=; b=py9a0n
	qUP0vSPjYyKP0YfTeYh3qFr+88oBLxkZr5m0S/stvCYT6LwW5XFCH8vV/3JWzeE7
	FNoI3A733EbItOF61+/dZ8IcptHaapJOumjcm+k5fkfhJqTJiSnK/PoamfsGguFM
	hsjM39HfVymIUUMCN4UHXVxrfKwCwZtxqGqBo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=e6TmOleUARD3Rz6viqMdyx2OHdP4FpnF
	2/SrSOp9IrQxCg66+pH0tHFN8KedJr4vG5X3ghVmdij9UxgYoRAddO6rZDYl0Wkp
	jBRkPTdCYvvRutwZQL+lx5hXWXgJj8i+4vdMmUTh4uFF0BBks/OUJMmaeuKujBkh
	/GMtINojDjY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 89F7D339F5;
	Thu, 21 Aug 2014 13:08:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D03E4339F1;
	Thu, 21 Aug 2014 13:08:43 -0400 (EDT)
In-Reply-To: <20140821125111.GA68724@book.hvoigt.net> (Heiko Voigt's message
	of "Thu, 21 Aug 2014 14:51:11 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: CE55E456-2955-11E4-8858-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255624>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Wed, Aug 20, 2014 at 04:17:33PM -0700, Junio C Hamano wrote:
>> * hv/submodule-config (2014-06-30) 4 commits
>>   (merged to 'next' on 2014-07-17 at 5e0ce45)
>>  + do not die on error of parsing fetchrecursesubmodules option
>>  + use new config API for worktree configurations of submodules
>>  + extract functions for submodule config set and lookup
>>  + implement submodule config cache for lookup of submodule names
>> 
>>  Will cook in 'next'.
>
> While using the config API for implementing my recursive fetch. I
> discovered a bug in my API here. In submodule_from_name() the lookup of
> the gitmodule sha1 is missing. So currently you would have to pass in
> the gitmodule sha1 instead of the commit sha1 as documented. I will
> extend the test and fix this.

OK, I do not mind temporarily kicking this back to 'pu', so that you
can replace these wholesale instead of doing an incremental patch on
top, when we rewind 'next' in a few days.

Thanks.
