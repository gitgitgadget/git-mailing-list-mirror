From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Makefile: clarify definition of TEST_OBJS
Date: Sun, 28 Feb 2010 13:17:21 -0800
Message-ID: <7vhbp1vz4u.fsf@alter.siamese.dyndns.org>
References: <1267304969-1924-1-git-send-email-michael.lukashov@gmail.com>
 <7vy6ietlf7.fsf@alter.siamese.dyndns.org>
 <7vmxyupbpa.fsf@alter.siamese.dyndns.org>
 <63cde7731002271503oac53237ubed6d318b46042e9@mail.gmail.com>
 <20100228091155.GB30143@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Lukashov <michael.lukashov@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 28 22:17:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NlqWH-00024q-DK
	for gcvg-git-2@lo.gmane.org; Sun, 28 Feb 2010 22:17:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032070Ab0B1VRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Feb 2010 16:17:32 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:40640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032065Ab0B1VRb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Feb 2010 16:17:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 48D4C9DBE5;
	Sun, 28 Feb 2010 16:17:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=PjZh00UZcAY1drQMTANw8NN4do0=; b=VZSlyLsWJ9gxeX7KzB2qcdq
	TeeoFr2v/rINEyal6iN1H703ar3uYgS7kzaXRtKuYdB5ChtGmhRHl9opNFmxr92i
	lYnaYm2ObqPnHoaIMwEsu+VoJeFnuMDMLBoZ7/iZscnWCLL8blISV/5DoGJLtsg3
	I0s5iuhDC6G1CjAmRl9s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=h+hvzUr/9/T9q1obZGlnZc+BAQcEqsRcEeJXvqFKC3iLyFHsW
	/Ji9kfyNyVL/4bDy020oCKyFGlM5Y0esu0H3tNifJ3LyDaHM5BpHyf5HnneQ/oej
	KyTeEYSkaHxYVg4MLu/YfqQGBp17RMrjcioXeETEKmny9Z/W1gprqSfy0c=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 158789DBE1;
	Sun, 28 Feb 2010 16:17:27 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68E029DBDB; Sun, 28 Feb
 2010 16:17:23 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: ABDAC74E-24AE-11DF-83E6-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141272>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Oddly enough, with or without this change the behavior of the Makefile
> is the same.  Since TEST_PROGRAMS is defined with delayed evaluation,
> the value of
>
>  TEST_OBJS := $(patsubst test-%$X,test-%.o,$(TEST_PROGRAMS))
>
> is independent of the value of $X when it is evaluated: the $X in the
> pattern and the $X in $(TEST_PROGRAMS) will simply always cancel out.

Ugh.  That is what I missed.  Thanks for explanation.

The mismerge fixed by [PATCH 1/2] comes from my rerere database, and
thanks to J6t's earlier "rerere forget" work, I managed to fix it in
preparation for the eventual merge to 'master'.  I queued the fix-up
directly on 'next' as well.
