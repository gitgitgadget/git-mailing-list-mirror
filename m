From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv7 0/8] Expose submodule parallelism to the user
Date: Tue, 12 Jan 2016 15:50:48 -0800
Message-ID: <xmqqoacqs6g7.fsf@gitster.mtv.corp.google.com>
References: <1452541321-27810-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 00:50:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJ8iF-000348-Cq
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 00:50:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbcALXuv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jan 2016 18:50:51 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:51368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753906AbcALXuu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jan 2016 18:50:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EBCAE3B9B9;
	Tue, 12 Jan 2016 18:50:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=431aFFEZLZABygdnzEhpEF2a2e4=; b=jidGQK
	W8+kJvFFV34o0R385acwjXvdrTiiZhT5fB043jfcKtiVObnOhxnlCyu3W7RqTZAU
	hM1GIRP4N1mXpjAUVR979Zz3J929Uk6q8k6fYwpYyPNfQ9SYkYH/Ey2dRabFQIg+
	2wM4WcFGcB95RWU8gJYS/gmifiNeJzMbjdVB0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=s94GXE28kbnp0abvuN14RABPDf7o+Luc
	ElS7FOPxpKe79VkUCuNuaTaIcHXzk1/GsrJmd5YBGVjtSV/e2uxhTVPERvmIke7P
	4jci+lUQC13L3nJcxam4ZN2hAdwum/cgTgNpLK90BBEUhUitzuO2CHcjSp5K+lUG
	C/gP1Re8/UU=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E34363B9B5;
	Tue, 12 Jan 2016 18:50:49 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 663FA3B9AE;
	Tue, 12 Jan 2016 18:50:49 -0500 (EST)
In-Reply-To: <1452541321-27810-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Mon, 11 Jan 2016 11:41:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4E8E0A3C-B987-11E5-B270-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283854>

Stefan Beller <sbeller@google.com> writes:

> This is a resend of sb/submodule-parallel-update and is available
> at github[1] as well.  It applies on top of
> sb/submodule-parallel-fetch
>
> What does it do?
> ---
> This series should finish the on going efforts of parallelizing
> submodule network traffic. The patches contain tests for
>   clone
>   fetch
>   submodule update
> to use the actual parallelism both via command line as well as a
> configured option. I decided to go with "submodule.fetchJobs" for
> all three for now.
>
> What changed to v5,6?
> ---
> No major changes, I just made it compile again as the order of parameters
> to the parallel processing engine changed.

OK, I am in the process of replacing it but I am also rewinding
'next' and updating 'maint' today, so this update may not be
published until tomorrow's integration cycle.

Here are the changes I noticed, just to double check:

 - There is no change in [1-3/8] relative to the previous round;
   I'll keep the one that has been in my tree to preserve their
   committer/author dates.

 - In the log message of [4/8], the misspelt "submodule.jobs" in the
   previous round now reads "submodule.fetchJobs".

 - There is no change in [5-8/8] relative to the previous round.

Thanks.
