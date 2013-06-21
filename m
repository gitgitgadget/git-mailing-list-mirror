From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/16] Cleanup {branches,remotes}-file cruft
Date: Fri, 21 Jun 2013 09:33:55 -0700
Message-ID: <7v38sbo230.fsf@alter.siamese.dyndns.org>
References: <1371813160-4200-1-git-send-email-artagnon@gmail.com>
	<7vsj0bo7pr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, akpm@linux-foundation.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 21 18:34:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uq4Hl-00043J-K6
	for gcvg-git-2@plane.gmane.org; Fri, 21 Jun 2013 18:34:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423370Ab3FUQd7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Jun 2013 12:33:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64141 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1423252Ab3FUQd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Jun 2013 12:33:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 348092A93E;
	Fri, 21 Jun 2013 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4eriPbAfX96C/93zeHXL/CW/sXU=; b=GzbhIK
	Dpj/AmlU4bXQ0TRY3OZ2SZW/9etd774oowUhpu/VIGnezG3n5tAuqIR7s4ODmFpl
	NWsqLy6w2mtZpRzozWt7DZ4QHVp4X2HRgksz63sKUeiwthF78wzD06eN6WXWK3DC
	MUu0NzdM4ri6aT2/7+1I/8Wq3uYhRE1boYEWs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H2ujglaJWKRA2gGy/4lg/bx11gBStZS3
	SFJv8PJnpk+nURS3zG+LyGdXDuS8L+u8SRiYJGSJYxPAaLiU0rhQWmaDO2kklkjW
	s1d0Cj2lW35VfOaJxC8F0PB4MhMzuULtHw+thqCAj8fFfIdUVZlzxzQ9VeSnYgkY
	WN9Cu3dVrk8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 28FA82A93C;
	Fri, 21 Jun 2013 16:33:57 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8DBBD2A935;
	Fri, 21 Jun 2013 16:33:56 +0000 (UTC)
In-Reply-To: <7vsj0bo7pr.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 21 Jun 2013 07:32:16 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E3F64A4-DA90-11E2-BA72-80EC6777888E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228629>

Junio C Hamano <gitster@pobox.com> writes:

> I myself thought that replacing the established work process of
> these people to the one that instead uses "git config" should be
> simple enough even back then, and in the longer term, these old
> mechanisms will become disused so that we can remove them, but
> deciding _when_ is the good time is not a no-brainer at all.

I do not fundamentally have a strong objection against deprecation
of these older mechanisms, if the removal is aimed to coincide with
a major version bump, like Git 2.0.

It however needs to be very well advertised, with clear instruction
to help migrate people's workflow and scripts to the mechanism that
will survive the purge (i.e. "git config").

We do not want to repeat the "We have advertised that 'git-foo' will
stop working at v1.6.0 for 6 months since v1.5.4 release notes, but
people complained loudly only after it happend." fiasco again for
something "minor" like this.

I say "minor" only because I think the cost of keeping these old
mechanisms alive is very low (if it is a heavy burden on the
maintenance, please tell me and how).

So from my point of view, a proposal to remove them has an almost no
benefit vs potentially very high cost of having to break many people
who are silently happily using them; not a very good benefit/cost
ratio.
