From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH V5 2/2] user-manual: add section documenting shallow clones
Date: Tue, 29 Dec 2015 15:39:59 -0800
Message-ID: <xmqq8u4cg6y8.fsf@gitster.mtv.corp.google.com>
References: <xmqqfuymji50.fsf@gitster.mtv.corp.google.com>
	<1451415296-3960-1-git-send-email-ischis2@cox.net>
	<4187709.UG5bg1kMPP@thunderbird>
	<xmqqd1tog88a.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Stephen & Linda Smith <ischis2@cox.net>
X-From: git-owner@vger.kernel.org Wed Dec 30 00:40:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aE3s9-0001mB-AJ
	for gcvg-git-2@plane.gmane.org; Wed, 30 Dec 2015 00:40:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbbL2XkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Dec 2015 18:40:06 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54645 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752951AbbL2XkE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Dec 2015 18:40:04 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 65E7D39D2D;
	Tue, 29 Dec 2015 18:40:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=J8Y1W3omm4yfI4uhPFrVp64xz/Q=; b=CBVhq5
	5UTG/fcbjS11jlygDgSlLcW1vJ4P/vbeoviVQbevCughONjNh4XWE5Pn4QI4efQs
	CchV7225Ev0rOTUuMGbk+IjW9iq/lQ2LDeghmoPypjtGr5KJ3MpNGv2ZKeFgtXEY
	LmiZmkPVJ+GoDt4tLKYKCifuFkOVPdGwJy0M0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mt3NQkgTWBOsc13pXdD67i4Vu6r71dYI
	vV4WcaqutHfPP/nOTrAd3tNJ4l/OFY/5A8u0f+6F00tSJcATzWCxFZ1vT42zjOW1
	8xpVAztXxH7jMARNUGRkJKP0/N5anrRvKagihskAY6jytLzN5uPXpcSZf4Erhd0a
	bZjwaEazwRs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2079239D2B;
	Tue, 29 Dec 2015 18:40:02 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 02D1D39D2A;
	Tue, 29 Dec 2015 18:40:00 -0500 (EST)
In-Reply-To: <xmqqd1tog88a.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 29 Dec 2015 15:12:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 7A61C00C-AE85-11E5-93DE-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283159>

Junio C Hamano <gitster@pobox.com> writes:

> Thanks for working on this.  Perhaps the last paragraph can be like
> this?
>
>     Merging inside a <<def_shallow_clone,shallow clone>> will work
>     as long as a merge base is found in the resent history.
>     Otherwise, it will be like merging unrelated histories and may
>     have to result in huge conflicts.  This limitation may make such
>     a repository unsuitable to be used in merge based workflows.

I forgot to say this, but "a" merge base above is very much
deliberate.  There can be (and indeed are in real life projects)
multiple merge bases between two commits being merged, and an
automatic merge wouldn't "be like merging unrelated histories" as
long as one of them exists in the shallowed history.
