From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t5403.1 and adding a file that belongs to a submodule
Date: Wed, 20 Jul 2011 10:50:34 -0700
Message-ID: <7v1uxk96z9.fsf@alter.siamese.dyndns.org>
References: <CACsJy8AKMQa2u6Y5qQHGujbjqq0qnM5D1+aEvcfk7POxQBqsVg@mail.gmail.com>
 <7vk4be9qqm.fsf@alter.siamese.dyndns.org>
 <CACsJy8AgboAj86PHi6jiSyRFsJJ7hn=mkbt+2UdBva6LmKk4ZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Josh England <jjengla@sandia.gov>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 19:50:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qjaux-0007P5-72
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jul 2011 19:50:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752878Ab1GTRui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jul 2011 13:50:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40133 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751997Ab1GTRuh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2011 13:50:37 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 536F743EE;
	Wed, 20 Jul 2011 13:50:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NTCq8ngzF4YQYUnJSCFALHYaTFo=; b=Lwp+t2
	LgfQ/mqaRx3C0u543B8Ygk9g8SeZIkHRnQRdYJsOE88AM5bIRS8J0WLoCCUY7XN9
	iPZikk024C6jbjv+Fr8QyZ0TIOItBEilseGMUUbrzG2hBJkKKIkkoPpYjpNXqGXm
	dNTdElThsWerA3kDiZEvZulj290keHp96KCxg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DHWkwf5blYa4P2rkw3op3BNHivcLuhCF
	98Ycu7mamKwtx7YUh9ESrvzMMPbvoHKMNxe41UBw+4tjPlQQJzRq+8Y+ScS7qUbw
	vn6trp3YRAm6WzpdGlFAX/+RZRjzvs/q8VMkoaOvvVEb7Hcsa+G4k6rJbkW1owOE
	0lp6CwXSHWk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F40043ED;
	Wed, 20 Jul 2011 13:50:36 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BC26043EC; Wed, 20 Jul 2011
 13:50:35 -0400 (EDT)
In-Reply-To: <CACsJy8AgboAj86PHi6jiSyRFsJJ7hn=mkbt+2UdBva6LmKk4ZQ@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 20 Jul 2011 07:17:09 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C597D940-B2F8-11E0-A29E-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177544>

> git init
> mkdir foo
> (cd foo; git init; touch abc; git add abc; git ci -m1)
> git add foo/abc
> Note that doing "touch abc; git add abc foo/abc" instead will only add "abc".

I think you mean s/ci/commit/, but it is an (perhaps lower priority) bug
in "git add". Good that you spotted it.
