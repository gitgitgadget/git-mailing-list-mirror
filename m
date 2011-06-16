From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git log --follow doesn't follow a rename over a merge
Date: Thu, 16 Jun 2011 12:36:08 -0700
Message-ID: <7vlix1h8lz.fsf@alter.siamese.dyndns.org>
References: <BANLkTimjEp0ntq80qttT9uZN2YGuhsnZBw@mail.gmail.com>
 <m362o5vrhd.fsf@localhost.localdomain>
 <BANLkTik1-UvEXqzgdXwcK3x6_o8fDiwB7g@mail.gmail.com>
 <20110616173451.GB6584@sigill.intra.peff.net>
 <7vy611hd38.fsf@alter.siamese.dyndns.org>
 <BANLkTikMNYyV40XM26rc6Ov6ZYO643mukA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: James Blackburn <jamesblackburn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 16 21:36:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QXIMa-00065F-6l
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 21:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197Ab1FPTgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2011 15:36:13 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:54014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757517Ab1FPTgM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2011 15:36:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 61BD866D0;
	Thu, 16 Jun 2011 15:38:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zRfBEcB/2qnt5aLoOWHgjTFKWus=; b=fug+4c
	4bJl2wW9FBU4rYs44M6LZ0rKZA89WAfXNDqrVlYxqXMyeQRvUJHCWDHel5P5IUtt
	XRzhPu4jYuxVgJb9CrbYSOqwFrtnUhhrcWV0AwX+s+g7mMbYVkpjiD7uveYnUnzw
	TQUx1ktxHOgvIaWYRiF6Di/0uUskTg471J1QM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=g0Cm7AGUBX/hzz3uD+UhALGmLBxc3c5r
	YQgKVZUi7kz9ywZk56nL9e4hEe0sifxi3xYPw7Sn6D+SZWyl1dE7HzVOlZ0hT5C/
	tVJJkm6l7KSSB9V0UA1jxXjY4TexNFIvMU/5VeAOm9hvTJxhevx5/rFHD61LQsMr
	EgwsjPq0bNo=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B15F66CF;
	Thu, 16 Jun 2011 15:38:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9DB5966CE; Thu, 16 Jun 2011
 15:38:20 -0400 (EDT)
In-Reply-To: <BANLkTikMNYyV40XM26rc6Ov6ZYO643mukA@mail.gmail.com> (James
 Blackburn's message of "Thu, 16 Jun 2011 19:41:14 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 30E9D0EA-9850-11E0-A2D9-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175919>

James Blackburn <jamesblackburn@gmail.com> writes:

> Given the file was removed during my 'merge' graft in commit X,
> shouldn't it be visible  in log without --simplify-merges?

The merge simplification logic does not treat earlier parent commits any
differently than later parent commits of a merge (except when two parents
are the same with respect to a given pathspec, and if the logic needs to
pick only one, the earlier parent will be picked), and that is by design.

So the short answer is no.
