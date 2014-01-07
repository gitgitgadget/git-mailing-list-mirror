From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] format-patch: introduce format.defaultTo
Date: Tue, 07 Jan 2014 13:07:08 -0800
Message-ID: <xmqqvbxvbiwz.fsf@gitster.dls.corp.google.com>
References: <1389028732-27760-1-git-send-email-artagnon@gmail.com>
	<1389028732-27760-3-git-send-email-artagnon@gmail.com>
	<xmqqlhythrzq.fsf@gitster.dls.corp.google.com>
	<CALkWK0kZn44x98td9YXNT5VfhVs=ueeSty9M7Vh08bdoGjGQYg@mail.gmail.com>
	<xmqqa9f8j2n8.fsf@gitster.dls.corp.google.com>
	<20140106201854.GA28162@sigill.intra.peff.net>
	<CALkWK0k21W4gz9Rm8CyLMwjXq2A9wvm=XCVDsqs06oeW3VUg6w@mail.gmail.com>
	<20140107205618.GA28102@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jan 07 22:07:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0drp-00044R-SB
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jan 2014 22:07:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbaAGVHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jan 2014 16:07:14 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60056 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752996AbaAGVHM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jan 2014 16:07:12 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B176461E79;
	Tue,  7 Jan 2014 16:07:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OA36cfp5XmDzSWCSkPfjhBh6iRM=; b=INyqHj
	gFBjIGsLDpoHYcVLIrBRJ8b1+22BZuXIStRG2/xvyR9+vDAOCTF6z7NPKa3/7Zmh
	qn4m++1wRpR21FaW5E0L96xabgH+q4+7vJJJJ5hwK8mDPO8SeEHSDZLq5Wgeqjp+
	aa/jDeNXCLYECCXJsBILVxt+RcnJjxU29aIYE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vfBZj8Jrn1mX+eIID6Zdi6+uPut8ebct
	zJnayRqNBIJKW0M317MX7N2wPif968K4qpV1t8qSESZqdAbwbCvCMWTfZzUxvOKm
	OnW8nMXWqHrxiLAi5wzPwqOqq4C0aHuB4SZ9ZpIwZ4gl5L01ERd6R4Wf7FNap1b0
	GAHe2DMHIF4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A14AE61E78;
	Tue,  7 Jan 2014 16:07:11 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60E3661E77;
	Tue,  7 Jan 2014 16:07:10 -0500 (EST)
In-Reply-To: <20140107205618.GA28102@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 7 Jan 2014 15:56:18 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: AC575010-77DF-11E3-A86C-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240155>

Jeff King <peff@peff.net> writes:

> Yes, "pushbranch" is probably a better name for what I am referring to.
> I agree that pushremote is probably enough for sane cases. I seem to
> recall that people advocating the "upstream" push-default thought that
> branch name mapping was a useful feature, but I might be
> mis-remembering. I will let those people speak up for the feature if
> they see fit; it seems somewhat crazy to me.

I think "branch mapping" you recall are for those who want to push
their 'topic' to 'review/topic' or something like that.  With Git
post 7cdebd8a (Merge branch 'jc/push-refmap', 2013-12-27), I think
"remote.*.push" can be used to implement that, by the way.

>> Frankly, I don't use full triangular workflows myself mainly because
>> my prompt is compromised: when I have a branch.*.remote different from
>> branch.*.pushremote, I'd like to see where my branch is with respect
>> to @{u} and @{publish} (not yet invented);
>
> Yes, as two separate relationships, you would theoretically want to be
> able to see them separately (or simultaneously side by side). Whether
> exposing that in the prompt is too clunky, I don't know (I don't even
> show ahead/behind in my prompt, but rather prefer to query it when I
> care; I have a separate script that queries the ahead/behind against my
> publishing point, but it would be nice if git handled this itself).

Same here. I do not bother a/b in prompt and comparison with
publishing point is done with a custom script.  It would be nice to
have it natively, and @{publish} would be a good first step to do
so.
