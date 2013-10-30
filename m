From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git v1.8.4.2 test failure in ./t5570-git-daemon.sh
Date: Tue, 29 Oct 2013 18:12:58 -0700
Message-ID: <xmqqr4b3d0it.fsf@gitster.dls.corp.google.com>
References: <20131029005430.GA23920@ruderich.org>
	<20131029013024.GA11861@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Simon Ruderich <simon@ruderich.org>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 30 02:13:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbKLL-0006Qj-4T
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 02:13:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753183Ab3J3BNB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 21:13:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41381 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752829Ab3J3BNA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 21:13:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 898C346659;
	Wed, 30 Oct 2013 01:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=bDl8SJf9TMHzuN9Pwd34mD6UKrU=; b=qPXNPC
	ISUhWBCrsKlxfyQ+t3iN2ZWMK028ADRzs7vh9guabe5Q4MAoNKv75M2yT5ATSbPl
	xwC/4N/fNV/M+QqHYgAaBO0aczKFpy1Z6jmQjs8CvBuJ1NdpsoN5eH1d2OLMnPS8
	0FFURReNELFNGy7J1yPMapxJaoXnYan9sPvjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QvSIAm1oWOCRkrM9weLT1DWJqfRuR3d6
	mxk5sAJFxdnrjCZlB96h61tRsUGD6+EN9HrrcXFnVN4qZP4PlP1GszoBEbcfy1Pk
	wElvOw5WAdDrlW/F6VNZL1MmLFRoDW49bDeQBtu7vEo+Qbcfb1/5GBSPnEIoa55e
	CaeXpJEPPaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7979146658;
	Wed, 30 Oct 2013 01:13:00 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D60A846657;
	Wed, 30 Oct 2013 01:12:59 +0000 (UTC)
In-Reply-To: <20131029013024.GA11861@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 28 Oct 2013 21:30:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6ACC9472-4100-11E3-AA0B-8F264F2CC097-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236956>

Jeff King <peff@peff.net> writes:

> On Tue, Oct 29, 2013 at 01:54:31AM +0100, Simon Ruderich wrote:
>
>> I just compiled Git v1.8.4.2 on Debian Wheezy amd64 and test
>> t5570 fails (with GIT_TEST_GIT_DAEMON=1):
>> [...]
>> Bisecting leads to this commit:
>> 
>>     commit 68b939b2f097b6675c4aaa178655559aa81b25cb
>>     Author: Jeff King <peff@peff.net>
>>     Date:   Wed Sep 18 16:05:13 2013 -0400
>> 
>>         clone: send diagnostic messages to stderr
>
> This is already fixed by Brian Gernhardt's 360a326 (t5570: Update for
> clone-progress-to-stderr branch, 2013-10-21).
>
> Junio, that patch seems to have gone onto jc/upload-pack-send-symref,
> but should have gone onto jk/clone-progress-to-stderr. The latter made
> it into maint for v1.8.4.2, but the former did not.
>
> I think it was just a simple mixup caused by Brian sending two fixups to
> t5570 as series, when they are really fixups for two different topics.
> Not worth an immediate v1.8.4.3, I think, but you may want to
> cherry-pick 360a326 onto maint if there is another release before
> v1.8.5.

I am torn on this, actually.  I've been hoping that the other topic
that fixes a long-standing bug will also be a part of maintenance
track.
