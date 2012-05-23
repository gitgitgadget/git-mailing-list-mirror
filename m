From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Cherry-pick dangles and forgets helpful advice in next
Date: Wed, 23 May 2012 15:47:26 -0700
Message-ID: <7vehqazf9d.fsf@alter.siamese.dyndns.org>
References: <4FBD4904.9090000@cisco.com>
 <7vipfmzfel.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 24 00:47:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXKL7-0000UW-Ba
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 00:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752737Ab2EWWr3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 May 2012 18:47:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46456 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751061Ab2EWWr2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 18:47:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E21680FF;
	Wed, 23 May 2012 18:47:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8GHBLJ3PF3ylobudL7MwBFJygDQ=; b=lUyAi0
	Qv6XoMWu6hnW7El8ezNGU29dcGoFEVFnn08En5U5sXPC88QRZUTkdfMmb/FR6sLm
	S8J4ZIXa3DJL4n5acmjIBHm3H0hxCO5zKzOOJrW+RjdqiSe3g7gRtmEm/aXeB4PQ
	KWD+becBCXEvR/akha/sKayKeQIJyCJmKW3Ws=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aH2xhjET0MSYI6tSURpgsqX1LKAdcab3
	r5nq5KLLBe7QKQ5ksjJ8A9lH3tg/BgrvcFK+E9Q6vPVBJF/IN6YPg1uLko3AV3Gz
	aNAmq5m1glF9tdCYqIhX1aYiyNyWOdjSJ6RUiA79CofTpWb5+LUkMCrqTPjfj3yE
	oPlFoyHQNt8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 44BEA80FE;
	Wed, 23 May 2012 18:47:28 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CBA5D80FD; Wed, 23 May 2012
 18:47:27 -0400 (EDT)
In-Reply-To: <7vipfmzfel.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 23 May 2012 15:44:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 45A40DD4-A529-11E1-B9CE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198333>

Junio C Hamano <gitster@pobox.com> writes:

> Phil Hord <hordp@cisco.com> writes:
>
>> In git.git 'master' when I cherry-pick a commit which is eventually
>> empty, git gives me a friendly description of my supposed error, leaves
>> my cherry-pick "pending" and exits with an error code.
>>
>>
>> $ git cherry-pick a0aff2d                          
>> # On branch master
>> nothing to commit (working directory clean)
>> The previous cherry-pick is now empty, possibly due to conflict resolution.
>> If you wish to commit it anyway, use:
>>
>>     git commit --allow-empty
>>
>> Otherwise, please use 'git reset'
>>
>> In 'next' this is broken.  Now git does not tell me anything and it does
>> not exit with an error code.
>
> ...  The test
> t3505.2 is about failing an attempt to cherry-pick an empty commit:

Ahh, disregard that one.  It is not testing the case where a cherry-pick
results in empty.
