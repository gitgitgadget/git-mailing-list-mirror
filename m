From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Move sequencer to builtin
Date: Sun, 09 Jun 2013 14:39:55 -0700
Message-ID: <7vppvvnetw.fsf@alter.siamese.dyndns.org>
References: <20130608164902.GA3109@elie.Belkin>
	<CAMP44s06DaV2G0rbhzJRMujEJnqeGYYv2G-a90pLL6AOS0gp+w@mail.gmail.com>
	<20130608173447.GA4381@elie.Belkin>
	<CAMP44s0n0qEk+1HhpAm-fMn+BWFwOeZCp7pgq9==09COVoNNEw@mail.gmail.com>
	<20130609014049.GA10375@google.com>
	<CAMP44s3CGHVLnkUxo=PR_b+_dTuaz5rwems_pd9GE1_vcEaYRA@mail.gmail.com>
	<20130609052624.GB561@sigill.intra.peff.net>
	<CALkWK0mu2_9M5aTczcEkv37eLaAg5_mGDZ_W9nqQFoesB4wc3g@mail.gmail.com>
	<20130609180437.GB810@sigill.intra.peff.net>
	<CALkWK0kkhDOSSdF=E4PvO24hg++_FpP3YFaGRD3yq80XG0TRJA@mail.gmail.com>
	<20130609184553.GG810@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jun 09 23:40:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlnLG-0006xL-Da
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 23:40:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494Ab3FIVj6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 17:39:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:34062 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751485Ab3FIVj5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 17:39:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 33AA12640D;
	Sun,  9 Jun 2013 21:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=q0PJq3nbFFDkQZS5yHHu5KCFR6E=; b=pHBunF
	MCaao11KzrYpjDM9SavOaxeIgToYYIykdRwbor5ecAaTe4DEvfE43B/Nzk3b6SG4
	fCIaxZaYczIexebkPTVyOjzxPDamMDna23jOJy2wAgC103tUyyBXWzQERqFk7Os/
	s/9PGlP/NtmoeunygEaeT/kOjPDyjaRJ04DTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=MDfeeYZTjQuevKKplIN2Sx493E7e5ALQ
	2/hNkkAvCupDpfhy4jLRWtZFXEJVEBlg4ZM5NPCTaOkpuSohDvCR4Uz+hv0v2558
	mCUBY6qKLfMahZKOLbXTaKOjUrxbmctu4RBm4jYcdFfut8fVAgSUXNQEXszglT4b
	KvHgBxio3U0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 26AF52640C;
	Sun,  9 Jun 2013 21:39:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 87F9226408;
	Sun,  9 Jun 2013 21:39:56 +0000 (UTC)
In-Reply-To: <20130609184553.GG810@sigill.intra.peff.net> (Jeff King's message
	of "Sun, 9 Jun 2013 14:45:54 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 20BD093E-D14D-11E2-BEDE-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227171>

Jeff King <peff@peff.net> writes:

> ... We do not have an explicit code of
> conduct on the list, but it is not as if behavior is without
> consequences. If you are not easy to work with, people will get tired of
> dealing with you eventually[1].

FWIW, I have already reached that point and learned to kill certain
types of threads in my MUA.  There is no point wasting time arguing,
rather than tending to patches from other people.

One example of killing the entire thread is when I see "This patch
will not be applied" by Felipe in a thread started with his patch.
I understand that it is his way to say "this patch is retracted"
without having to explicitly say that he now understands that
reviews showed why the patch was wrong or that he thanks the
reviewer for enlightening him.

The patch will come back, with corrections as necessary, if it has
merit, so we do not lose anything of value anyway by discarding the
thread.
