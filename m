From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Building GIT on older systems.
Date: Wed, 29 Feb 2012 13:00:55 -0800
Message-ID: <7vboohs6bc.fsf@alter.siamese.dyndns.org>
References: <CAFqtsHfrk89qHexg8VwMZnKwgWDqbseJNNKFSUkwDtVKX_t=5g@mail.gmail.com>
 <CAFqtsHd=b=Ey8j1zTCC4-fut7rno3daQ2Q3HMs3k2SHFvE4dSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Schumacher <schumact@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 29 22:01:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2qdz-0001CC-Rc
	for gcvg-git-2@plane.gmane.org; Wed, 29 Feb 2012 22:01:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756168Ab2B2VA6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Feb 2012 16:00:58 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63017 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756123Ab2B2VA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Feb 2012 16:00:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 91B556758;
	Wed, 29 Feb 2012 16:00:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gePX6gTYvbtHjhK9WQ59xpfiJaY=; b=Gx0JFv
	5zLxl7TSVO4gNr7gBJjdn9fjcTd850VE9sIe5jS6LCk5/KH5Zl6cHyh6/oG3yjRK
	XRwB4Su2cEuaUXSL6OaPiZl55E8LqsiLtZIZHO4s3zH9BG/yvrK1T5+lHC1sgWcB
	fM3Z5ZnJRa8T0pTeIsSOpB4//f247j0UhyKk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=udXIeiA8zc/qLemd9R7jfgJDZOMQxmdH
	lOkh/DV1PVRu4gwD9bcex6fiCUHgIlk/0SihpFvKF4ixZ3WrTLFVjojCwUFsvPgL
	HiO4Gv4Z/ApEbYJw4dfI+ueZfSChopOep6ebvaeAbTUeCWJvSrm/zewI8KzcTZtf
	P+vlyt3P0Ac=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 893706757;
	Wed, 29 Feb 2012 16:00:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07C006756; Wed, 29 Feb 2012
 16:00:56 -0500 (EST)
In-Reply-To: <CAFqtsHd=b=Ey8j1zTCC4-fut7rno3daQ2Q3HMs3k2SHFvE4dSQ@mail.gmail.com> (Tim
 Schumacher's message of "Wed, 29 Feb 2012 13:22:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 79BAB080-6318-11E1-BA86-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191856>

Tim Schumacher <schumact@gmail.com> writes:

> A couple questions I have so far:
> (1)  how can I make make output the actual command it is executing so
> I can try to debug things more quickly?

make V=1

> (2)  how can I configure the Makefile to automatically set -ldl as
> well as the NO_NSEC flag?

config.mak

> (3)  My perl -v output: This is perl, v5.6.1 built for i386-linux.  Is
> this sufficient?

I think our floor is set at somewhere around 5.8.3, but at the same time,
most of the essential parts of the system such as "git fetch" and "git
checkout", should be usable without any version of Perl.  An environment
for actual development of your software may want to use things such as
"add -i" that require Perl, though.
