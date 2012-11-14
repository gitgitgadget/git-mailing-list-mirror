From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Notes in format-patch
Date: Wed, 14 Nov 2012 05:15:19 -0800
Message-ID: <7v7gpocom0.fsf@alter.siamese.dyndns.org>
References: <50A0B896.8050700@drmicha.warpmail.net>
 <a35a8f44b908bded0b475b02e7917011fb3bf90b.1352728712.git.git@drmicha.warpmail.net> <50A2213B.4060505@drmicha.warpmail.net> <7vhaotfou6.fsf@alter.siamese.dyndns.org> <7vzk2le918.fsf@alter.siamese.dyndns.org> <7vr4nxe7nf.fsf@alter.siamese.dyndns.org> <7vfw4de5oc.fsf@alter.siamese.dyndns.org> <50A361BD.2010806@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Nov 14 14:15:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TYcoc-0002Tn-3b
	for gcvg-git-2@plane.gmane.org; Wed, 14 Nov 2012 14:15:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422831Ab2KNNPX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2012 08:15:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63438 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422805Ab2KNNPX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2012 08:15:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1DE266108;
	Wed, 14 Nov 2012 08:15:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fJZwUvowL8AkIeX+r/sVRVgrlpI=; b=BdZRlN
	44W4pko9CURpUN0y2/gv2mpH07Ie3EsYeE475MJw/4fLMcIhlpipbm0++TnWxzbB
	+9GDMCfdUMqwS6sEI/6LbVyOLy96AOf2UPeow8cYtcYT7ZGt7V4WPskQ8RSHimJs
	UH8iy4ImTmjRRi5sMzwCBlq+/1VDpPA2OvBLY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GnBOTSLRqL/nmdGYFV3lFZYcq1o5bahp
	o9JZodSRPR6O3kNIZEwCpt6TYrS/9FC0kE9ZFAk4Stk3yqv5UVGG/tD8VXseRCwj
	HLG6LDSGNqeITwN/vh8rdNHhR8Aw95VPlFDUJ7HVdgpsY/YoqIrgr9S8uiGSZPzo
	H56hWA8QWi8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0B86E6107;
	Wed, 14 Nov 2012 08:15:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6225E6105; Wed, 14 Nov 2012
 08:15:21 -0500 (EST)
In-Reply-To: <50A361BD.2010806@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Wed, 14 Nov 2012 10:17:49 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 57C81740-2E5D-11E2-B777-54832E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209714>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Junio C Hamano venit, vidit, dixit 13.11.2012 19:09:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>>> ... and it is broken X-<.
>>>
>>> The blank line should be added before the diffstat, not after the
>>> notes message (t3307 shows a case where we give notes without
>>> diffstat, and we shouldn't be adding an extra blank line in that
>>> case.
>> 
>> Second try.
>> 
>> -- >8 --
>> Subject: format-patch: add a blank line between notes and diffstat
>> 
>> The last line of the note text comes immediately before the diffstat
>> block, making the latter unnecessarily harder to view.
>> 
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> 
>>  log-tree.c | 31 +++++++++++++++++++++----------
>>  1 file changed, 21 insertions(+), 10 deletions(-)
>
> Thanks, that patch works. I'm curious, though, where the empty line
> between the --- and your diffstat comes from.

The message you are responding to is *not* an output from
format-patch but was written in my MUA.

The way I work when I show "this should work" patch is to:

 (1) Think, edit in my working tree, compile, eyeball "git diff HEAD",
     think again, and test;

 (2) Hit "Reply All" to the message I am going to give "this should
     work" response to, and start composing the response;

 (3) Run "git diff --stat -p HEAD" to have its output appended at
     the end of the message I started to compose in the previous
     step;

 (4) Write everything that should come before the output I appended
     in the previous step, i.e. "-- >8 --", in-body "Subject:", log,
     sign-off, and three-dash lines;

 (5) Send it out; and

 (6) Run "git reset --hard" and move on.

The blank line was added in step (4), not step (3), which does not
even have any commit log message, as the patch does not come from
any existing commit.  Later I may pick it up and apply to a topic
branch just like I do for patches from other people and that is the
point when such a patch becomes a commit for the first time.
