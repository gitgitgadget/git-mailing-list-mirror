From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] submodule: change submodule.<name>.branch default from master to HEAD
Date: Fri, 28 Mar 2014 10:28:46 -0700
Message-ID: <xmqqk3beb5bl.fsf@gitster.dls.corp.google.com>
References: <20140328030556.GD25485@odin.tremily.us>
	<c66d89d854407469b6fd223213a09e5d60eeec0a.1395977055.git.wking@tremily.us>
	<CAPig+cT7tmxvYz+sLQY68SgF6osM+pAj-gFb7xvyuH+Gnw5xrg@mail.gmail.com>
	<20140328035255.GF25485@odin.tremily.us>
	<20140328035827.GG25485@odin.tremily.us> <5335AA0E.7000001@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: "W. Trevor King" <wking@tremily.us>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 28 18:28:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTaaO-00039i-QL
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 18:28:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752432AbaC1R2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 13:28:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48840 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751819AbaC1R2t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 13:28:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCFA178229;
	Fri, 28 Mar 2014 13:28:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hxbIVoE0Gruiohg8WKEDgHnH7uU=; b=ObOOMz
	GUHyRufV1PGyp4sZCdT0ZgdK1+79oJrmtEw5GbiUn+erW1nK5LPA5sQ6j/+JTV7J
	2qpQVq8WNbkt9mXmpcl/VpmwYePOQtMoQCyD8VMSX+5Y9x7tVE00P3Na9Ca7qyAL
	+z8qc2y80kkZIePPNjTsU+dJXI2QHYZNrU3pw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HTqceDqCiSDpuQDGcbrJHWM19h8qvpQo
	1qR6ECseQ25796bcWLc5ypBEgIxqgeaNMOnbUhT1hf7facG3kbkY9Uh2OumvW+ZK
	EndCTSiYpTMCUb3XVp7jTBN1xSizVkwKOhQnGOVPPqVFEv1vSxeFGSIEfIlzha/S
	47EEyWSRGu4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C928E78228;
	Fri, 28 Mar 2014 13:28:48 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1AA7C78223;
	Fri, 28 Mar 2014 13:28:48 -0400 (EDT)
In-Reply-To: <5335AA0E.7000001@web.de> (Jens Lehmann's message of "Fri, 28 Mar
	2014 17:57:50 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6BDB02A4-B69E-11E3-97EE-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245403>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> Am 28.03.2014 04:58, schrieb W. Trevor King:
>> On Thu, Mar 27, 2014 at 08:52:55PM -0700, W. Trevor King wrote:
>>> On Thu, Mar 27, 2014 at 11:43:47PM -0400, Eric Sunshine wrote:
>>>> On Thu, Mar 27, 2014 at 11:36 PM, W. Trevor King <wking@tremily.us> wrote:
>>>>>  submodule.<name>.branch::
>>>>>         A remote branch name for tracking updates in the upstream submodule.
>>>>> -       If the option is not specified, it defaults to 'master'.  See the
>>>>> -       `--remote` documentation in linkgit:git-submodule[1] for details.
>>>>> +       If the option is not specified, it defaults to the subproject's
>>>>
>>>> Did you mean s/subproject/submodule/ ?
>>>>
>>>>> +       HEAD.  See the `--remote` documentation in linkgit:git-submodule[1]
>>>>> +       for details.
>>>
>>> No the remote branch is in the upstream subproject.  I suppose I meant
>>> “the submodule's remote-tracking branch following the upstream
>>> subproject's HEAD which we just fetched so it's fairly current” ;).
>> 
>> Hmm, maybe we should change the existing “upstream submodule” to
>> “upstream subproject” for consistency?
>
> For me it's still an "upstream submodule" ...

I inherited the habit of saying "submodule" vs "superproject" from
Linus (I think) during the very early days, and there is no such
thing as "subproject" or "supermodule" in my vocabulary.

Just one documentation-reader's opinion, not an edict from the
maintainer.
