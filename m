From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Feb 2012, #05; Mon, 13)
Date: Tue, 14 Feb 2012 14:05:16 -0800
Message-ID: <7vmx8l5aw3.fsf@alter.siamese.dyndns.org>
References: <7v4nuuea7r.fsf@alter.siamese.dyndns.org>
 <20120214214729.GA24711@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 14 23:05:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxQV2-0001oI-MD
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 23:05:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761231Ab2BNWFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 17:05:20 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63712 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757329Ab2BNWFT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 17:05:19 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 853FD6C1B;
	Tue, 14 Feb 2012 17:05:18 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+oXEgWgTrCXQK7eEOF7JcwtDr74=; b=lCUzQh
	D641bLy28LoliBA5feM/cdFx6d02W33xvVZOK6lklv4fvncU788osP+rw9Ee0278
	hzbhpNpcCcveVdkwIFiQ5ahVxsIaXgFBmzBS7xmI6JjJyhvR+fdWCzUJZqgAqhmf
	vsjgcwZvOVlHKaBaIK4s8tN0NhCnqyK4WuvVs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sK8BMkhp0tSUf+WT6jEHDDwL9kABVSg/
	F5rIw+YgN/gLQI9rxT5SLAspM5bYEos7C+7fd7JEN9v11jAUoBkvrHneNp0lXcQk
	cqmmX8DbXNvxiWggIC3B+MHl+LdZqIpwqaTYwh+vRJvCVT8nICPQ1qAx5ELxfnpD
	WkcJuByaomM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7C1DB6C1A;
	Tue, 14 Feb 2012 17:05:18 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 100BF6C19; Tue, 14 Feb 2012
 17:05:17 -0500 (EST)
In-Reply-To: <20120214214729.GA24711@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 14 Feb 2012 16:47:29 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FAE2BC88-5757-11E1-B7A0-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190771>

Jeff King <peff@peff.net> writes:

> On Mon, Feb 13, 2012 at 12:42:48PM -0800, Junio C Hamano wrote:
>
>> * jk/config-include (2012-02-06) 2 commits
>>   (merged to 'next' on 2012-02-13 at 307ddf6)
>>  + config: add include directive
>>  + docs: add a basic description of the config API
>> 
>> An assignment to the include.path pseudo-variable causes the named file
>> to be included in-place when Git looks up configuration variables.
>
> Yikes. I was planning to re-roll this, but got sidetracked discussing
> David's git-cola case. Besides a few minor tweaks in the documentation
> patch, the actual include patch is buggy, and accidentally turns on
> includes for "git config --list".

Hmm, I thought t1305 covered "config --list", and ... oops, it makes sure
the output contains the inclusion.

> Do you want to revert and re-do to make master pretty, or should I just
> build on top?

Do you mean 'next'?
