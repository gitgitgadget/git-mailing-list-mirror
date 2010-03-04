From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What should "git submodule summary" give before an initial 
 commit?
Date: Wed, 03 Mar 2010 22:43:57 -0800
Message-ID: <7vvddcd1si.fsf@alter.siamese.dyndns.org>
References: <4B8E5450.3040702@gmail.com>
 <20100303200239.GA28904@coredump.intra.peff.net>
 <7vhboxno38.fsf@alter.siamese.dyndns.org>
 <20100303204257.GA5501@coredump.intra.peff.net>
 <7v3a0hktga.fsf@alter.siamese.dyndns.org>
 <7vzl2phz8e.fsf@alter.siamese.dyndns.org>
 <7vhboxf4nx.fsf_-_@alter.siamese.dyndns.org> <4B8F00AA.5050007@web.de>
 <fabb9a1e1003032201l38b052ebk4c0061e9d40f68b6@mail.gmail.com>
 <7vfx4gfvwv.fsf@alter.siamese.dyndns.org>
 <fabb9a1e1003032236x59a781b8ne0266877db25d001@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Ping Yin <pkufranky@gmail.com>,
	Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	A Large Angry SCM <gitzilla@gmail.com>,
	git <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 04 07:44:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nn4nW-0002Wr-Ka
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 07:44:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753401Ab0CDGoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 01:44:20 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:44776 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab0CDGoS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 01:44:18 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1F3AF9F93C;
	Thu,  4 Mar 2010 01:44:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CIPdbWpff+ux+3zj1hDpo9onMJk=; b=s6CvkZ
	elbuZ7jHFa46fDBnaAYRQ/p4IHUk+KQw19AWGjMU2WXdlRLunk6M77MtWS3FNgm7
	zwDa8LqBWT5ot5GyHLsEJ1fE5n+iPcJUnQT7DR5XzBs/V7Ng8wX0PAtJtTFnYYjW
	7DpE+1gYfo6BTyXTME5EYKwOtey9sQcf5OhBU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PfokZkQ2YOd/a507IIq7AbwudvmC29WC
	kUIaRb9W2roqw2S5jgbvcyEwwVABCtW7DhoMolylNO5e13MkAf/0AVrINJiGDYGp
	7mt40gt+RMrWTybuWvkpqdVy27VLV/7cLg/th70wB4gsPXbTKcZb+RLnoF3CjeLr
	DFN13RRWn3I=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 5848E9F93B;
	Thu,  4 Mar 2010 01:44:07 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0DE519F937; Thu,  4 Mar
 2010 01:43:58 -0500 (EST)
In-Reply-To: <fabb9a1e1003032236x59a781b8ne0266877db25d001@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 4 Mar 2010 07\:36\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 54CE22F4-2759-11DF-9D52-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141512>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> Yes, that's what I came up with after sending my email, commands that
> _default_ to HEAD as revision should instead default to an empty
> commit when there is no HEAD yet. Perhaps something we can add to
> parse_opt and then make sure that all commands we care about use that
> feature?

I doubt it would be very much useful as a general feature, as sometimes we
default to HEAD because we want a tree-ish (in which case using "empty
tree" would be appropriate) and other times because we want an actual
commit (e.g. "git commit --amend" should exit, not "amend an empty tree")
and we would need to be careful to study each codepath and use the
appropriate one.

But you are welcome to try and prove me wrong with a working patch ;-).
