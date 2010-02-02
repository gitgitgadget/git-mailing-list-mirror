From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about git rebase --onto
Date: Tue, 02 Feb 2010 10:15:45 -0800
Message-ID: <7vd40n5wry.fsf@alter.siamese.dyndns.org>
References: <4B6865A9.60603@obry.net>
 <7v636f7biw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: pascal@obry.net, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 02 19:16:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcNI8-0004IV-AR
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 19:16:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756381Ab0BBSPz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 13:15:55 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44507 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab0BBSPy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 13:15:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5A57A96FC4;
	Tue,  2 Feb 2010 13:15:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8x5xfaWPOSjHTR/IFhpkj6sN8aU=; b=hNulw4
	NOciMqQOYPKFaiLsEUutxWpBAd9f+12FGdraSbscRtqsbK3qgrQjeqSO9OSi/hDD
	1kCvZT2S6KxWu5ZAZE5KEEBrjaVP77xrJa7WfVzIV7AvdwEeWJJGp7Ni/seBoZ5z
	oaSXrD4UTfPjpp7ZFRoKb2kriscVKnDTuOasU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dtva3UauOLDQpgPYTPyP5/R5cQrD8g5X
	94KdxByZFtQkN+WhnPuO51JfLIdGH2VVUWV0uE8RfHFovch4RDshCKCm3oh6DzYP
	Fg2U4KZHfwyBdDaTk4TiwG/N1dvLomoXQ49Q5Ah8MGfhz+VBJxDgRCtARVRMYsvr
	oUYkHwH34JU=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 35FC696FC1;
	Tue,  2 Feb 2010 13:15:51 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6DC2796FBF; Tue,  2 Feb
 2010 13:15:47 -0500 (EST)
In-Reply-To: <7v636f7biw.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Tue\, 02 Feb 2010 10\:11\:51 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: FEAC79F0-1026-11DF-85AF-6AF7ED7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138735>

Junio C Hamano <gitster@pobox.com> writes:

> Possible user errors I can think of are:
>
>  - If 'topic' is not a local branch, the result will be on a detached
>    HEAD, as you are starting from a detached HEAD (i.e. 'topic' could be a
>    tag);
>
>  - Until you resolved and said "rebase --continue" (or --skip) to allow it
>    to conclude the rebase when the operation conflicted, you would be on a
>    detached HEAD.

Just to clarify, these things are _not_ errors at all.  What I meant by
"user error" was to notice that the HEAD is detached in these cases (which
is not an error) and panicking (which is).  Both of these are normal
procedures and sane states.
