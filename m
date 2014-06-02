From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reset by checkout?
Date: Mon, 02 Jun 2014 14:31:59 -0700
Message-ID: <xmqqr4372e28.fsf@gitster.dls.corp.google.com>
References: <20140531144610.754B.B013761@chejz.com>
	<xmqqvbsj2e6o.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Atsushi Nakagawa <atnak@chejz.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 23:32:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrZq0-0008Ka-AX
	for gcvg-git-2@plane.gmane.org; Mon, 02 Jun 2014 23:32:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751000AbaFBVcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Jun 2014 17:32:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52672 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbaFBVcF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Jun 2014 17:32:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 357DC1D2BF;
	Mon,  2 Jun 2014 17:32:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zCi3xkOvFwW92mw8hwNQ6Wsmleo=; b=sG2VFT
	t/6/d24modVG5Yfu5PyVKqfH6UjZUmyYlAIRnGRqaNFKoS1M04rgYTSXeooYvwHr
	11nSj3uuH9ZYPS8bIpZ5jPFEJsnR+P95HHH9gxX/HMAnXa8Zsk4iyIF47xF9jrU4
	BPfTpNnuGX7YF/VEBp3iRIYEfMjtI2poqINzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Hf+i1K0fXmK+fLddwLGdHjD5PTzA7K/u
	8Aj/aE8spmtsOHjhFF5QDmVjI/UkQiFjeaInqF8jNDhRhLFQCHGjGGxYP3+sbg8O
	b4buYbNBYeoifZ16pd6BLOrIknwgj5+msQ03/V/7SiWeCk6gzzblAJAgCF55kRVn
	cDWu98jWANo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D01A1D2BE;
	Mon,  2 Jun 2014 17:32:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 94BC61D2B9;
	Mon,  2 Jun 2014 17:32:01 -0400 (EDT)
In-Reply-To: <xmqqvbsj2e6o.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 02 Jun 2014 14:29:19 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 557C6A92-EA9D-11E3-A8A8-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250599>

Junio C Hamano <gitster@pobox.com> writes:

> Atsushi Nakagawa <atnak@chejz.com> writes:
>
>> One of the more underrepresented command I use in git use on a regular
>> basis is this "reset by checkout".  It's what's currently achieved by
>> this convoluted expression:
>>
>>   `git checkout -B <current-branch-name> <tree-ish>`
>>
>> This is such an useful notion that I can fathom why there isn't a better,
>> first-tier, alternative.
>
> Hmph.  checkout *is* the first-tier way to do this.  Why do you even
> want to do it via "reset"?  Is it because you learned "reset" first
> and then learned how "checkout" with various modes all do useful
> things?

Ahh, the "branch to be checked out" being the "current" branch is
indeed strange.  That is what "reset --keep" was invented for.

I use "git checkout -B <something-else> <commit>" all the time, and
somehow I thought that was what you were talking about.

Sorry for the noise.
