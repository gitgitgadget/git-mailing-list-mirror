From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Dec 2010, #06; Tue, 21)
Date: Fri, 24 Dec 2010 11:23:10 -0800
Message-ID: <7vzkrvynz5.fsf@alter.siamese.dyndns.org>
References: <7vlj3i5zz9.fsf@alter.siamese.dyndns.org>
 <AANLkTinH0h5euL=_wMpGirVEEYgoA9hXGhKGja9oPa2j@mail.gmail.com>
 <7vfwto2ytb.fsf@alter.siamese.dyndns.org>
 <4D13DCDD.3050300@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Joshua Jensen <jjensen@workspacewhiz.com>
X-From: git-owner@vger.kernel.org Fri Dec 24 20:23:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWDEf-00069q-Jh
	for gcvg-git-2@lo.gmane.org; Fri, 24 Dec 2010 20:23:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854Ab0LXTXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Dec 2010 14:23:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:42018 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752736Ab0LXTXW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Dec 2010 14:23:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BAE7E3F0B;
	Fri, 24 Dec 2010 14:23:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=FsNUJ4gZrRkd7FvcH2iw2On3UUw=; b=xJWsMC
	/v+kR7cZg9yTzKJId23F8bDbrfMHdhNbTLaSZ1r1grOb55ohjXTOdb6pjjQm6hCc
	WgBqQz+OQFdn0e/xU8iPiX1m/pjLsCf9bIO6aSOuCf9o+YoQvY/K4vckuSi+VBbX
	0zq/4MOB4ZddJlI0wTdrRuodcIvIdCwyaw9rY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=sis0gA8i4dqlEHUsqFRnyGl9Em46njg+
	tockgEwtzdJtLzVSYiGHgNtIpvmVRg3ionegRjGeFcjMoszA5Y82rRNaxDz7ntJE
	p2jliwb5KdUasW4YrWJ0TbCRG7lpUngF2BUI2Mhb5LVmG6HsnygOTJC8SokZ+Ob3
	++lWokEgMYs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 846CB3F03;
	Fri, 24 Dec 2010 14:23:48 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 484853F02; Fri, 24 Dec 2010
 14:23:44 -0500 (EST)
In-Reply-To: <4D13DCDD.3050300@workspacewhiz.com> (Joshua Jensen's message of
 "Thu\, 23 Dec 2010 16\:35\:57 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 55316C2E-0F93-11E0-A3E4-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164163>

Joshua Jensen <jjensen@workspacewhiz.com> writes:

> From: Junio C Hamano
> Date: 12/23/2010 10:17 AM
>> Nguyen Thai Ngoc Duy<pclouds@gmail.com>  writes:
>>
>>> On Wed, Dec 22, 2010 at 8:59 AM, Junio C Hamano<gitster@pobox.com>  wrote:
>>> With jj/icase-directory merged to master, match_pathspec() and
>>> match_pathspec_depth() now diverse again.
>>>
>>> When I wrote match_pathspec_depth(), I assumed that match_pathspec()
>>> would not change much and I would have more time for converting the
>>> rest of git to use match_*_depth(). Looks like I need to add case
>>> insensitive matching to struct pathspec and friends then remove
>>> match_pathspec() in this series too. At least if somebody changes
>>> match_pathspec() again, it would cause a conflict so I can catch it.
>> While this topic is something I have long wanted to see, I have started
>> feeling that this needs to cook a bit longer than be in the next release.
>> So perhaps the best course of action might be to rebase the series once
>> after the 1.7.4 feature freeze, cook it in 'next' for a while and make it
>> part of the release after that.  I think at that point we may probably
>> want to have other changes that are not strictly backward compatible but
>> their incompatibilities do not matter in practice (e.g. cquoting pathspecs
>> in the attributes file comes to mind, but I am sure there will be other
>> changes that people wanted to have but we held them off due to worries on
>> compatibility).
>>
>> What do you think?
> ...
> Having said that, I have had 100 people using the jj/icase-directory
> series on Windows daily for 4 months now without issue.  Prior to
> that, a majority of the series had been used for a full year by a
> dozen people....

Just to make sure nobody misunderstood me, what I was proposing to put on
hold was not the "case insensitivity" work of yours, which is already
scheduled to be part of the coming release.
