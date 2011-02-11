From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Challenges for an octopus merge
Date: Fri, 11 Feb 2011 10:22:21 -0800
Message-ID: <7vd3my1leq.fsf@alter.siamese.dyndns.org>
References: <4D53F694.1060105@web.de>
 <7v8vxn6fdv.fsf@alter.siamese.dyndns.org> <4D55627F.30305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Markus Elfring <Markus.Elfring@web.de>
X-From: git-owner@vger.kernel.org Fri Feb 11 19:22:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pnxdk-0006pl-Vy
	for gcvg-git-2@lo.gmane.org; Fri, 11 Feb 2011 19:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757946Ab1BKSWd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Feb 2011 13:22:33 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:59015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757906Ab1BKSWb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Feb 2011 13:22:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 379BC4A02;
	Fri, 11 Feb 2011 13:23:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=48i9LDvoUTQwQBj6hvjsrWQ9N4U=; b=ekgfMu
	wRtezrG08IfMlfLUan11M10rIA7wJZCBOI7bs8ajvLfhMDSiZtXX/Jgk2lVqZUop
	roljA4pVkvWOsmJFH7I1iU6G7airO+1aYFm87tFsv8zOK0t6VdT2yRfoV62DQhJY
	OMwwQxxUtUMzhJwQC3jSslCSxL+nGBGibzsHE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TbYkbyjUOtRBjl1xButGthjw/r+2Y50e
	5lEV4Kfvj5RlLbnBmouMK0yv0GgAdLxQksMKj7gnEyFesH+WWnkxIKE4YBnjBq7i
	pR9qF0cmwJRO6NeP02rZU/pKJHT9XPwDFuC9rEKD+YmS+Ql5ac5yEimZEqa6urpz
	EbOe9tNooAk=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 139DA49FB;
	Fri, 11 Feb 2011 13:23:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 2F0E249FA; Fri, 11 Feb 2011
 13:23:24 -0500 (EST)
In-Reply-To: <4D55627F.30305@web.de> (Markus Elfring's message of "Fri\, 11
 Feb 2011 17\:23\:27 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 05785DB0-360C-11E0-9D79-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166566>

Markus Elfring <Markus.Elfring@web.de> writes:

>> The second-to-last line of the output needs to be rephrased.
>
> Which wording adjustment have you got in mind?

Something along the two lines below to rephase the second-to-last line of
the output I quoted from your original message.

>> Octopus is not for recording conflicting merges and when it punts you
>> shouldn't be attempting to resolve and record it as an octopus merge.

> Would it make sense to specify that the merging process may switch to the
> strategy "resolve" on demand?

Depends on what you mean by "on demand", but if you mean "git merge A B C"
automagically turns into "git merge A; git merge B; git merge C" then I
don't think that makes much sense.  The user needs to decide what to do
next; the user may choose to do "git merge A C ; git merge B" instead, but
*after* inspecting the situation.
