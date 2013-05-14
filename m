From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Tue, 14 May 2013 15:25:44 -0700
Message-ID: <7vbo8dfbbr.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
	<51929dfa8122e_13a8f89e182115@nysa.mail>
	<7vzjvxfck2.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Wd4VEc_mwr=xguVAnXvn+YVz24u8eS4Nyy0HCjwJ+dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:25:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcNfM-00006c-6B
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758429Ab3ENWZr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:25:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37300 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758091Ab3ENWZq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:25:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 74B101E6A4;
	Tue, 14 May 2013 22:25:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6LJerfEas271pRTCUHecHCurU1E=; b=YZTJsZ
	SxNNu2PDmGVk9SnpWhpizpm+2MDnfLsExcS3H5yZDrARG59EKT9UGcE3NCNxXlFW
	BvO2Yel1xAqFrGJ/hPHK3FuLX3tPt1aKJlqLlVgJVSk0Y5wE43SEBauUwMtgJ6hk
	dpjysRDfHVy9oror3aURilOESfjmosEXKt7nY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UknmqrFQFOvn5WyCRA4sUWCG6TI9BS+h
	PkyIkWqF+WjNdPqwAWNZkR+m3Hxd7qaBdlpqBo+X8usjgbtTwo7fpk6oOsaQHTcj
	+RIwa6HsP+UtbCo/u9b8dz+cRhfMo3amUQlrwwCdc8HsgyK3g0HbAREhtdYr/mQ7
	rAcGo1h1Leg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C11A1E6A3;
	Tue, 14 May 2013 22:25:46 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E879B1E6A2;
	Tue, 14 May 2013 22:25:45 +0000 (UTC)
In-Reply-To: <CAMP44s0Wd4VEc_mwr=xguVAnXvn+YVz24u8eS4Nyy0HCjwJ+dw@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 14 May 2013 17:14:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 38B78CA2-BCE5-11E2-891F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224361>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Tue, May 14, 2013 at 4:59 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> Without this fix, the user would never ever see new bookmarks, only the ones
>>> that (s)he initially cloned.
>>
>> Now, think again and realize how long it took you (the original
>> author) to discover issues and come up with these fixes and
>> explanation since the series was merged before -rc0.
>
> This issue has *always* been there, it's not a regression.

Then why are you rushing it?  -rc is a "regression-fix-only" period.

> Define "ready". It's probably more "ready" than any other bridge
> tool out there.

Anything that needs "oh, we need to push these ten patches to avoid
regressions at the last minute" is not mature enough to be relied
upon by end users for everyday use.  That is what I meant.

But now you are saying these are not regression fixes, in which case
they have to wait because the users have known about the limitations
that existed for a long time and learned to live with them.  That is
a sign of mature (not "not ready") software.

You cannot be both.  Which is it?
