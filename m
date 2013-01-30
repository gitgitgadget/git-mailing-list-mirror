From: Junio C Hamano <gitster@pobox.com>
Subject: Re: "sha1 information is lacking or useless" when rebasing with a
 submodule pointer conflict
Date: Wed, 30 Jan 2013 15:39:04 -0800
Message-ID: <7v38xijl5z.fsf@alter.siamese.dyndns.org>
References: <CAFyOhY8YAO4zx6jKQxrEW=-Vbo-TTjU6wJ7UgNVEjA7B2dasng@mail.gmail.com>
 <20130130215615.GA1053@book.hvoigt.net>
 <20130130224904.GB1053@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Sims <michael.h.sims@gmail.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Thu Jan 31 00:39:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0hFb-0008Gk-D1
	for gcvg-git-2@plane.gmane.org; Thu, 31 Jan 2013 00:39:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755953Ab3A3XjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 18:39:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47626 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753300Ab3A3XjH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 18:39:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id ACA60CCC0;
	Wed, 30 Jan 2013 18:39:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1K/yyMWTH9d2FcmoLx1iuf66aTQ=; b=FEvARG
	l4oydBjGy0CaexLiIiPsJ6LXooP4ktymZP4zOnev81VdydkxFFY/6mSWqCF4q8vA
	FDgdUR7dihyRXldR8arBNTwMWWXW6XCyRCNNld2/Xstehs92mrFF63jnOkZueTZh
	Xi4kG6T1/r4IhYaEsP1cWooi3nvbUtpRUb1rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SQ58yVCUkH63vI5vByl84Je1T4pukmSU
	d+EGfGdXwwhN+p+Pb+aHmAdukgGMaRPHoVDi5ajUy+hb7F6XZ5hgNKJFOVOQNLnt
	/Dgz45N8bHljVirkvN5dUDFU5iepn1/1+RX4H+JrCRMSzSY7RWJ8XVXHt3fsfOi3
	kVyj+uuvYV8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9DFDFCCBF;
	Wed, 30 Jan 2013 18:39:06 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 23C60CCBE; Wed, 30 Jan 2013
 18:39:06 -0500 (EST)
In-Reply-To: <20130130224904.GB1053@book.hvoigt.net> (Heiko Voigt's message
 of "Wed, 30 Jan 2013 23:49:04 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C79AACE-6B36-11E2-850C-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215080>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Maybe Martin or Junio immediately see whats going wrong here? I would
> need to further dig into the git-am code to find out how to fix it.

"am -3" has never worked on a patch that describes changes to any
non-blobs; the underlyihng "apply --fake-ancestor" is not prepared
to see anything other than blobs.
