From: Junio C Hamano <gitster@pobox.com>
Subject: Re: RFC: reflog for deleted branches
Date: Thu, 03 May 2012 16:05:44 -0700
Message-ID: <7vwr4sdfw7.fsf@alter.siamese.dyndns.org>
References: <4FA2F7DA.6020108@tu-clausthal.de>
 <7vaa1pdjz8.fsf@alter.siamese.dyndns.org> <4FA30270.6000806@tu-clausthal.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sven Strickroth <sven.strickroth@tu-clausthal.de>
X-From: git-owner@vger.kernel.org Fri May 04 01:05:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ55r-0001kl-TB
	for gcvg-git-2@plane.gmane.org; Fri, 04 May 2012 01:05:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758975Ab2ECXFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 19:05:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57568 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756126Ab2ECXFq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 19:05:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F0D473AA;
	Thu,  3 May 2012 19:05:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6769/O5wVuM0+aWSnZcX03hBsbE=; b=KLZGEC
	12O5Tx9AfWhhLTWMUQlsJ+sNxTCeuCkdFO7vDkL3wFqdjVxP3KQYLdYp68CFRHji
	NNZSXjdS9wn5Jul+RRzVv7YJ8erCNWKy0Ut5ctykkz9UkEKNm7ImOkNpYkLh1SWM
	paxd3axYvPhbXj8haPqT6o44f1gGRop81KMQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=gehkgsb/GN+2nN7nnch5Eot81KOZWn1o
	+ttp3tqjT8AviSvGY7o8OUagvYKrrhLR/b/yPZpiMyZQrXZwqeGJFhOz26twBYQm
	OcLDG9glByBREO5DFpCJboIwexXytbWfvLHQ74NqXBI66ejYcIDl3Heh/avuWDAc
	a7aq0pJN4Fo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5634C73A9;
	Thu,  3 May 2012 19:05:46 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CCE4D73A8; Thu,  3 May 2012
 19:05:45 -0400 (EDT)
In-Reply-To: <4FA30270.6000806@tu-clausthal.de> (Sven Strickroth's message of
 "Fri, 04 May 2012 00:10:56 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 83D7521A-9574-11E1-99EE-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196976>

Sven Strickroth <sven.strickroth@tu-clausthal.de> writes:

> The "normal" reflog cannot be used if you just create and then delete a
> branch - the reflog is empty in this case.

I somehow thought we discussed about the lack of "creation" event.
Perhaps it is sufficient to create a reflog entry for such then?
