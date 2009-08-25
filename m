From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] import-tars: Allow per-tar author and commit message.
Date: Tue, 25 Aug 2009 12:21:16 -0700
Message-ID: <7v8wh7pumr.fsf@alter.siamese.dyndns.org>
References: <20090823203640.B195D189B12@perkele>
 <4A91B8BB.1030906@vilain.net>
 <alpine.DEB.2.00.0908241659380.16576@perkele.intern.softwolves.pp.se>
 <7vab1pf3fj.fsf@alter.siamese.dyndns.org>
 <alpine.DEB.2.00.0908251950010.19406@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>,
	Sam Vilain <sam@vilain.net>, git@vger.kernel.org
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Tue Aug 25 21:21:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mg1ae-00006b-EF
	for gcvg-git-2@lo.gmane.org; Tue, 25 Aug 2009 21:21:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755920AbZHYTV0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Aug 2009 15:21:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755677AbZHYTV0
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Aug 2009 15:21:26 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43069 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560AbZHYTVZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2009 15:21:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 087A9183BB;
	Tue, 25 Aug 2009 15:21:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wKsY/yoWUJC4tUfx++sbUGx3X84=; b=U6IE95
	Mu5pYUmNty+mj+wmqEKhnuD1VBIy9xxe16YU30sk24Nmg28RE7hZZ47F6dDpGRFD
	6Mcgq9V99C/wJXSk+4hL4kRYgH4JGure4YbtnOds3u+ylNaUMehfekoCEAKvDxEK
	0MvVfLWl4g/vNU8HHZnlbzc7jJQ4AV3AH+HVo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vyy1r3RyO+TDRt+qh2lXDfo0UiFQGoyh
	gJeDOBKS0xo8tJ9impJU8ST6fGpI+7JnHT0KJ7u2Qno36Dr0rzIv3dRPa4AiLtJu
	BYZFJcmgi8fAa6GiWle1S8NPyT+OSI+QdqylNXgzozgo1mRDDcvoRTHQxrn140Wk
	5D1XzBEu+Gg=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id B9367183BA;
	Tue, 25 Aug 2009 15:21:22 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E88F9183B5; Tue, 25 Aug
 2009 15:21:17 -0400 (EDT)
In-Reply-To: <alpine.DEB.2.00.0908251950010.19406@ds9.cixit.se> (Peter
 Krefting's message of "Tue\, 25 Aug 2009 19\:52\:16 +0100 \(CET\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 798C10A8-91AC-11DE-9376-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127044>

Peter Krefting <peter@softwolves.pp.se> writes:

> Junio C Hamano:
>
>> Unlike your "import-directories" that is a brand new program without
>> any existing users, you are touching code that other people have
>> already used, and you do not want to change the behaviour for them
>> only because they happen to have unrelated files in the same
>> directory.
>
> Indeed. Not that it is likely that one have stray filetar.gz.msg files
> just laying around, but I'll add a command line switch to enable the
> new functinality. That sounds like the most reasonable way to go,
> leaving the old usage completely unaffected by the change.

And the switch could be "--metainfo=<ext>", so that people can choose to
use other extensions, e.g. with "--metainfo=info" file.tar.info would be
read for descriptions.
