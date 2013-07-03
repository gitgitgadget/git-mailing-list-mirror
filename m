From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Feature request: "author branch" in commit object
Date: Wed, 03 Jul 2013 11:19:57 -0700
Message-ID: <7vli5nfquq.fsf@alter.siamese.dyndns.org>
References: <CADL+T9YGtvFrzStxJW64OJEV6H0BroMbkVCJdsDwWDaUWd91zQ@mail.gmail.com>
	<7v38rwlola.fsf@alter.siamese.dyndns.org>
	<CADL+T9ax0maws3GR24YV77Yge7knqHd5mfuPd_AqE9b4UmvYPg@mail.gmail.com>
	<CALWbr2zJFjbaCdA3d1eaFuP4HGShAwnK=gisRD=KHKWWi-XuTg@mail.gmail.com>
	<CADL+T9bbnGSxCjUBqoL3qm7Ss-j9jxorED0L1A6v1NbeLBpRQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Antoine Pelisse <apelisse@gmail.com>, git <git@vger.kernel.org>
To: Ed Hutchins <eh@demeterr.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 20:20:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuRex-0008EV-80
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 20:20:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932575Ab3GCSUA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 14:20:00 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41070 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755972Ab3GCST7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 14:19:59 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 708C62DB72;
	Wed,  3 Jul 2013 18:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OicsFDp+txV+bY5ZXikkt0ODeUs=; b=lRFymx
	7Ge0MCJclpP1UuhzvMowrTUDEGYNozHBQOmwXOsunoDL+49MLApgKahZS7GUXgDk
	UA7TU+Y7RnC3+0fdrGd/c/RpvdZ/xlUrgdaiGC46ByuAJi5GpeLw0v4lym1uNy/u
	r9iXDLopUBkfv4X0rLeKcjx7kyr74UPieYCBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h+2CWmpwh6cfOP4kLhrt8lnOmp+uR2Bk
	ATXKKOgW7/71qbv5tjedt37209MqmvTWO9OlilCRvGjcFcHIQ91pNiB6B7o79GjZ
	PFbxVMQEmAqf27zlXVtDtXIucXkCzz4ijDJXFAfU5rVv6CUV0/eOGF0vFRMZMsX5
	HgiJKn/NNSE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 64CB32DB71;
	Wed,  3 Jul 2013 18:19:59 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D573C2DB6F;
	Wed,  3 Jul 2013 18:19:58 +0000 (UTC)
In-Reply-To: <CADL+T9bbnGSxCjUBqoL3qm7Ss-j9jxorED0L1A6v1NbeLBpRQg@mail.gmail.com>
	(Ed Hutchins's message of "Wed, 3 Jul 2013 10:31:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2B6D8B88-E40D-11E2-BB16-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229504>

Ed Hutchins <eh@demeterr.com> writes:

> I might be able to switch our corporate workflow to adding non-ff merge
> commits, but the reason we moved away from using github's big red button
> in the first place was to avoid the extra noise of merge-only commits.
>
> Actually you've pointed out an inconsistency: why is it okay for merge
> commits to automatically mention branch names, but for regular commits
> this is considered harmful?

We do not care what you write as part of human-readable payload.

Your local convention could be to add, near the end of your log
messages, "Made-on-branch: frotz" line, just like all the commits in
our project have "Signed-off-by: line" at the end.

The problem we avoid is to add it as structural part of the commit
object.
