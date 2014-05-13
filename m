From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib: remote-helpers: add move warnings (v2.0)
Date: Tue, 13 May 2014 15:02:40 -0700
Message-ID: <xmqq7g5pmj5r.fsf@gitster.dls.corp.google.com>
References: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 14 00:02:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkKmi-0004E2-2g
	for gcvg-git-2@plane.gmane.org; Wed, 14 May 2014 00:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754234AbaEMWCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 18:02:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57801 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753065AbaEMWCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 18:02:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CE6BE1878E;
	Tue, 13 May 2014 18:02:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Fg38LsAjKySA6CHAYySSawgboJ8=; b=HtfFO9
	jikthd1ol1Krhl3M/cKpMUorckuEyipcgwAjEAd9J1a6DiZHP3M/PW6MDUmxKkI8
	q2YzmNCmktGGT54NopUycEOUo8uklND5+/esv/q1K3tdsRkBb4URi9rDTefEklEt
	7Qty4jymviVuCJcTbMsPLebDCXPR7yYPSw2cw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mJ6M5IoTYVSPteIAt2pfuPlAfhnPPx8I
	heZsZjLB1FEMofUL4LDYRKzOYjlS8aGiEfHUvSu28qobfXcY8TZ2bbVuG9rKepTa
	lwsCwwaRgZakGujBDfAGjo6tqtg3P6B1ukPlwEWOStCW7Yx7RcvKF/Mqki1OcAWA
	Q0vobS2jMow=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C5BA61878D;
	Tue, 13 May 2014 18:02:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9410B1877A;
	Tue, 13 May 2014 18:02:41 -0400 (EDT)
In-Reply-To: <1400016596-13178-1-git-send-email-felipe.contreras@gmail.com>
	(Felipe Contreras's message of "Tue, 13 May 2014 16:29:56 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4DF26C58-DAEA-11E3-9540-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248871>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The tools are now maintained out-of-tree, and they have a regression in
> v2.0.

You seem not to understand at all what a regression is.

My understanding is that versions of remote-hg shipped with all
versions of Git did not work with Hg 3.0, so not working with Hg 3.0
is a regression in v2.0 at all.  A recent report was about Hg 3.0
not working with 1.9.3, but I think you earlier said all versions of
Git does not work with Hg 3.0, and I can believe it.  That is hardly
a regression.

You could argue that Hg has a new regression to its external users
of its API when it went to 3.0.  We actually had a similar breakage
in 1.5.4, where it was reported late in the cycle after -rc0 [*1*]
that cgit that linked with our internal API libgit.a was broken by a
change on our side, which resulted in us fixing the breakage (even
though technically you may be able to say that it was cgit's fault
to link with libgit.a in the first place) with 18125644 (Move
sha1_file_to_archive into libgit, 2008-01-14) very late in the
cycle.  Calling that a regression in cgit would have been insane,
even if we did not patch our side up to accomodate it.

Stop this idiocy.


[References]

*1* http://thread.gmane.org/gmane.comp.version-control.git/70117/focus=71064
