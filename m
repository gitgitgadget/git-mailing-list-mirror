From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Recording the current branch on each commit?
Date: Mon, 28 Apr 2014 17:10:11 -0700
Message-ID: <xmqqfvkxm1wc.fsf@gitster.dls.corp.google.com>
References: <535C47BF.2070805@game-point.net>
	<CALKQrgfmBByMwMhxu3HkJqJGWy2Rwvij6Hi1_4npjfsxcSgpaQ@mail.gmail.com>
	<535D4085.4040707@game-point.net>
	<CALKQrgemFx=2JaC1BaRqCwEV+knC8QftxcZ7K0AsT9azzuyVdA@mail.gmail.com>
	<535D6EB1.9080208@game-point.net>
	<535e18cdc7bce_338911e930c72@nysa.notmuch>
	<87bnvl6bdg.fsf@fencepost.gnu.org>
	<535e8e4253196_45651483310b3@nysa.notmuch>
	<152626b3-0642-4e26-9333-7d911d45c669@email.android.com>
	<535edfb9baa4a_4c5c11c92f0bc@nysa.notmuch>
	<xmqqk3a9m3ah.fsf@gitster.dls.corp.google.com>
	<535ee95fc17d5_5a07e812f018@nysa.notmuch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: James Denholm <nod.helm@gmail.com>, David Kastrup <dak@gnu.org>,
	Jeremy Morton <admin@game-point.net>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 29 02:10:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wevct-0006IA-Mc
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 02:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbaD2AKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 20:10:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52717 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347AbaD2AKP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 20:10:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 01266817F9;
	Mon, 28 Apr 2014 20:10:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q3lkMIqCNon3RmbItabJQXuxGTA=; b=juSX58
	WFgK0gbVDIkSA1uIc3OnUrVYTeewXjS/qcFyM/qCQ3jfPa5CL9bwRP7ke2ldwoZM
	5OQHpv8TjTj3JA/9AoJY+ujYLq6ivocmQsdT3pE1yqH9SfT+8ZHVEGuBw8kS1cKZ
	YpvUSYzsewPkzM8fzWfbyRow+Dc3fAPMu7ko4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZUOux5KI7/gWPxbKD3Ndi/+0Gyx5pZLX
	KCRN4IZuO+nzj3YYoHr3eCb2GwgNc6xaBiHwkb1HsRE2l/MCivgTdFqHPmUN2TMu
	SpBOJf5fyFvquf3i0RCSPgUOPZz1Pj6eybDR0o++CK2MDbh9RQUAftn1Zu4HCXAQ
	zedUkmuzHks=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8234817F8;
	Mon, 28 Apr 2014 20:10:14 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C2C2E817F0;
	Mon, 28 Apr 2014 20:10:12 -0400 (EDT)
In-Reply-To: <535ee95fc17d5_5a07e812f018@nysa.notmuch> (Felipe Contreras's
	message of "Mon, 28 Apr 2014 18:50:55 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A23FC116-CF32-11E3-AE86-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247501>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> In this context James was talking about what Git should be. But the vast
> majority agree on this issue, so that's not what's preventing change.

Sorry, I saw "take your patches" from James and "my patch" from you
in the context above that part, and somehow thought that the
discussion was about the reason why a particular implementation that
hit 'pu' once stalled and did not result in changing Git.

I agree that recognition of the issue is not what prevents a change.
