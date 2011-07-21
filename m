From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] ref namespaces: tests
Date: Thu, 21 Jul 2011 14:56:16 -0700
Message-ID: <7v62mux9ae.fsf@alter.siamese.dyndns.org>
References: <20110714205055.GA26956@leaf>
 <7v1uxs3177.fsf@alter.siamese.dyndns.org> <20110715034538.GD28343@leaf>
 <20110715184045.GA2232@leaf> <20110721201054.GA2530@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jamey Sharp <jamey@minilop.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>, git@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 00:03:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkNov-0003ye-4X
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 00:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611Ab1GVWDk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Jul 2011 18:03:40 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48477 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932420Ab1GVWDj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Jul 2011 18:03:39 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 769815338;
	Fri, 22 Jul 2011 18:03:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=c3xXNdEujmcKeNAiaLcUCzcCmI0=; b=nU+J99ZkF9gtVd/ULQ66
	FLiRcsp2RilXhAg9vayjMGf9x32OU+6OYVttPx+G65r1d8EnGa93Fqlxsn9BQAxh
	PJIkqqttcDEMplXF+Mzk9h/fE0F3/B2743wFvCeAeFT/i3M3fuArNXLL3OpT2Yn5
	v+JO/wHuludny5ejSxWr+9U=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=mCPTy8X3k9s90AqP9fyTScE7WqDjybTRhGaSmzzw9vEc+p
	K+RFV2+8WtE0rt+DPN6WqnBtTlSkHEaPjBoo+5WKndY28ei2A7FaJkOV1NJHSMsX
	Zkr386n+4jkgsVDh0cyI6mfx2Bo9R4WzOIDnf3WKVYG14F71z7mqXf+1kzBfY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C4A45337;
	Fri, 22 Jul 2011 18:03:39 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EDF8A5336; Fri, 22 Jul 2011
 18:03:38 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 745458E4-B4AE-11E0-BFF1-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177672>

Josh Triplett <josh@joshtriplett.org> writes:

> At this point I think we've incorporated all the outstanding feedback.
> Does this test need any further changes to allow the ref-namespaces
> branch to graduate to next?

No more nitpicks from me on this patch at least for now.

Are people who expressed concern during the review on the previous round
of the series happy with the second round? I recall there was a strong
sentiment that it is regrettable that the series specifically changes
fetch and push and is not a more general mechanism. Personally I am OK
with the approach taken by this series, as I do not offhand think of other
ways to serve a modified namespace. You have to view the unaltered reality
when interacting with your own refs to enumerate the objects you have,
while giving the altered view to your clients that is limited to the
"virtual" space.

> (Also, for future reference, do you prefer to see later versions of
> patches as replies to the previous version, as I've made this mail a
> reply to PATCHv2, or do you prefer to see them as new threads?)

Often it is very convenient to be able to go "up" in the thread to re-read
the discussions in the previous round. On the other hand it sometimes gets
inconvenient when viewing tons of threads to have a beginning of a new
round buried deep in other threads. Referring to the messages in the
previous round by their message-id (or thread.gmane.org/ URL) in the body
of the patch message below "---" lines may solve both issues, but I can go
either way.
