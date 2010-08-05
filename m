From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] stash: Allow git stash branch to process commits 
 that look like stashes but are not stash references.
Date: Thu, 05 Aug 2010 13:13:32 -0700
Message-ID: <7vtyn8ddhv.fsf@alter.siamese.dyndns.org>
References: <1280831775-30759-1-git-send-email-jon.seymour@gmail.com>
 <1280831775-30759-3-git-send-email-jon.seymour@gmail.com>
 <7vwrs6djie.fsf@alter.siamese.dyndns.org>
 <AANLkTikA0_Og4bzB8AHo3s2cLCvf6pc9=wC4w_8emuxU@mail.gmail.com>
 <AANLkTi=FbF3X83uLjBDoCYUCuig3udTzZCXuE=1_w-Ld@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 05 22:13:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh6p6-0007sU-Mw
	for gcvg-git-2@lo.gmane.org; Thu, 05 Aug 2010 22:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933507Ab0HEUNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 16:13:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62801 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932599Ab0HEUNm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 16:13:42 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 3A14ACA7A8;
	Thu,  5 Aug 2010 16:13:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pVAOz1Xu9Ai+0NlKpz5b11HANMY=; b=Rig0o7
	bDXTeKqcfWngPRMF9nCKnSo1tuN/5oIqNFNAZLpEtMiDoEUu8b1gKHXYiRDlZyhd
	PtS3siDW7VrSaXk+Tv56aHrAHf1F8VM+HArxiMyhV59dSyUOvERb1byu/ay+B/Xg
	J6gcU0wu8B3A5UA9jxFbnqc53M2l+qa7GOpFo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FgOTkuTd9I0LCuMpB4n06X0ZzMH8/iwx
	xP5zJWtj5UwFCJZZzVor9L4YQAQHo6KnbCfYG2sKeGB7Xg+FAbi1Di8SGtavnQ3f
	KLogLJRJ++xmdbtgWilmN3dAb0ANj1J7weYdNyNXg/eGzN2JYQa03ilH4XToxoEw
	E0V5g/QQCpE=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 14162CA7A6;
	Thu,  5 Aug 2010 16:13:38 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A3B66CA79D; Thu,  5 Aug
 2010 16:13:34 -0400 (EDT)
In-Reply-To: <AANLkTi=FbF3X83uLjBDoCYUCuig3udTzZCXuE=1_w-Ld@mail.gmail.com>
 (Jon Seymour's message of "Thu\, 5 Aug 2010 17\:50\:12 +1000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: EEDBE302-A0CD-11DF-90F5-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152709>

Jon Seymour <jon.seymour@gmail.com> writes:

> One question about test patches. Are you ok with test_expect_failure
> tests that document the expected failure of a feature yet to be
> developed, followed by the feature, followed by the patch that makes
> the tests into test_expect_success tests, or would you prefer to see
> the pre- and post- test patches rolled into a single test that is
> delivered after the feature patch?

I think a single patch that implements the feature and at the same time
protects it with new tests from getting broken by others would be the best
form.
