From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jul 2013, #03; Tue, 9)
Date: Thu, 11 Jul 2013 09:45:13 -0700
Message-ID: <7v8v1drqp2.fsf@alter.siamese.dyndns.org>
References: <7vr4f7tjo0.fsf@alter.siamese.dyndns.org>
	<D0E044B4-7252-41CB-A478-BCAC9EAE4AD5@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>,
	David Rothenberger <daveroth@acm.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Kyle McKay <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 11 18:45:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJzg-00044f-Dz
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 18:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752907Ab3GKQpU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 12:45:20 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39386 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486Ab3GKQpT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 12:45:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76BC22FFA8;
	Thu, 11 Jul 2013 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=HM1IVBF21G3sJ0FHsETUMAkJIpo=; b=a1bYtt
	4WJ+4OzBEZBolzzft64dd0CdZGPKdZgqC/idqP0+iFYlMrlcU+IQeuXQfcdXDBch
	xd6V3NVVvNqQG1uyYh417CLMLUeMqzXR0YCEiLQFNjtfCiM1ng5ROJMJVQxMtNyT
	hYX+rCIYNMuxIGKOq5/WanRgUYPYpdKtQZbK0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M540Aw4iOpabwtE68dkW45g9UHbzM7I5
	aX6Qfy8lYVVYTids05cdfEEaAi+8TJNjZFyj52iLKGTUKik81XoqC/OblMBzi8bC
	6yP6EcB780JNPgP6FdC2lU6KxjiaWhlEQXtYOKVGE/kJKXvprIjynLmtQuU0L5S2
	SHmD6yZpW8A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D04022FFA3;
	Thu, 11 Jul 2013 16:45:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7ABE42FF97;
	Thu, 11 Jul 2013 16:45:15 +0000 (UTC)
In-Reply-To: <D0E044B4-7252-41CB-A478-BCAC9EAE4AD5@gmail.com> (Kyle McKay's
	message of "Wed, 10 Jul 2013 00:00:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 432DEC1C-EA49-11E2-AB67-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230116>

Kyle McKay <mackyle@gmail.com> writes:

> On Jul 9, 2013, at 16:09, Junio C Hamano wrote:
>> * km/svn-1.8-serf-only (2013-07-07) 2 commits
>> - git-svn: allow git-svn fetching to work using serf
>> - Git.pm: add new temp_is_locked function
>>
>> Comments?
>
>
> Since neither David nor Jonathan have piped in here (they were the two
> primarily involved in the discussion).
>
> On Jul 8, 2013, at 09:22, Junio C Hamano wrote:
>> "Kyle J. McKay" <mackyle@gmail.com> writes:
>>
>>> From: "Kyle J. McKay" <mackyle@gmail.com>
>>> Subject: Re: [PATCH v3 0/2] allow git-svn fetching to work using serf
>>>
>>> This patch allows git-svn to fetch successfully using the
>>> serf library when given an https?: url to fetch from.
>>>
>>> [...]
>>
>> Thanks; I've queued this version to 'pu' at least tentatively.
>>
>> Is everybody who discussed the issue happy with the direction of
>> this patch?
>
> I will add that David previously indicated this patch works for him:
>
> On Jul 6, 2013, at 00:17, David Rothenberger wrote:
>> On 7/5/2013 8:41 PM, Kyle McKay wrote:
>>> This patch allows git-svn to fetch successfully using the
>>> serf library when given an https?: url to fetch from.
>>
>> Thanks, Kyle. I confirm this is working for my problem cases as
>> well.
>
> Subversion 1.8.0 was released less than a month ago on 2013-06-18 so
> there probably aren't too many git-svn users affected by this just
> yet.

Alright.  Let's advance it to 'next' and see what happens.
