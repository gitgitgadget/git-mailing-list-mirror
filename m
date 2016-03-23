From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git_config_push_parameter: handle empty GIT_CONFIG_PARAMETERS
Date: Wed, 23 Mar 2016 13:46:03 -0700
Message-ID: <xmqqy498c48k.fsf@gitster.mtv.corp.google.com>
References: <1456786715-24256-1-git-send-email-jacob.e.keller@intel.com>
	<1456786715-24256-8-git-send-email-jacob.e.keller@intel.com>
	<20160322185628.GA19993@google.com>
	<20160322192309.GA9782@sigill.intra.peff.net>
	<20160322195051.GA20563@sigill.intra.peff.net>
	<20160322214355.GI28749@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.e.keller@intel.com>,
	git@vger.kernel.org, Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Shin Fan <shinfan@google.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 23 21:46:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aipfT-0008RS-21
	for gcvg-git-2@plane.gmane.org; Wed, 23 Mar 2016 21:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662AbcCWUqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Mar 2016 16:46:10 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:64964 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752640AbcCWUqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Mar 2016 16:46:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7F17F50520;
	Wed, 23 Mar 2016 16:46:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5qB1RyFIb5ovy9b8h7r1P0OHQT8=; b=bQU8AA
	wLnzFwHo19D73a/EZ+GW7vtYQ9NTnTirfkSMdP6XpNyU+9gWnKswbnK7NDh9poN7
	RGJiXptiFpad7ehGIl1IiaovlhkIcOm1JCc1FwphRUyaO+gilwKHniRjBvBkualn
	IHDyZQd6mTm/GHvGkJul1O4ejy1DPzMx+6Vus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pQ8UXkbrAQUEsEOYteYgkdwjy4es74++
	ktJnrnL33Zcj8uPhirIQqI6npxUNJf8p3HnpwGpB5167aE0l6PySj/QVpVXxBrYh
	KG/OlGHT81k7VHnK0ZMSX8PSlAic38lXJJldAkoCowbxrwyh2jsV+X+Sh6OuDYIZ
	JYJ+FPDxZlA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 70E505051E;
	Wed, 23 Mar 2016 16:46:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8CC3D5051A;
	Wed, 23 Mar 2016 16:46:05 -0400 (EDT)
In-Reply-To: <20160322214355.GI28749@google.com> (Jonathan Nieder's message of
	"Tue, 22 Mar 2016 14:43:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4366F57C-F138-11E5-A455-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289681>

Jonathan Nieder <jrnieder@gmail.com> writes:

> I should have mentioned this is
>
> Reported-by: Shin Fan <shinfan@google.com>
>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>> I just did this on master, and it is standalone. But for the reasons
>> above I think it would also be fine to stick on the tip of the
>> jk/submodule-c-credential topic.
>>
>>  config.c               |  2 +-
>>  t/t1300-repo-config.sh | 14 ++++++++++++++
>>  2 files changed, 15 insertions(+), 1 deletion(-)
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
> Tested-by: Jonathan Nieder <jrnieder@gmail.com>
>
> Thanks for the quick fix.
>
> Sincerely,
> Jonathan
>
> [1] http://thread.gmane.org/gmane.comp.version-control.git/287928/focus=289551

Thanks for keeping an eye on the 'next' front.

It is much more pleasant to find and fix problems before a new topic
hits 'master', and I wish there were more people like you who use
Git that is newer than 'master' regularly and report issues.

Thanks.
