From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 08/10] remote-hg: update bookmarks when pulling
Date: Tue, 14 May 2013 15:49:41 -0700
Message-ID: <7v38tpfa7u.fsf@alter.siamese.dyndns.org>
References: <1368486720-2716-1-git-send-email-felipe.contreras@gmail.com>
	<1368486720-2716-9-git-send-email-felipe.contreras@gmail.com>
	<51929dfa8122e_13a8f89e182115@nysa.mail>
	<7vzjvxfck2.fsf@alter.siamese.dyndns.org>
	<CAMP44s0Wd4VEc_mwr=xguVAnXvn+YVz24u8eS4Nyy0HCjwJ+dw@mail.gmail.com>
	<7vbo8dfbbr.fsf@alter.siamese.dyndns.org>
	<CAMP44s0u0WPNneM-GoiqCkWTC-CT_Xa2z3on=smRiFJdd9ffeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 15 00:49:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UcO2Y-0005lq-8V
	for gcvg-git-2@plane.gmane.org; Wed, 15 May 2013 00:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758559Ab3ENWtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 May 2013 18:49:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53061 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758429Ab3ENWto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 May 2013 18:49:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C1A01F513;
	Tue, 14 May 2013 22:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=tWf6m5DDyxI9Q2PfwykYG38LrxU=; b=NxDAJ0
	/T40gA7sLogxdMEqBFaqbrnwtW2dIbY7eGhb5+17uHSJv26JTddmJCqyMXgmf4+u
	BBWZ6zjcOkZ95dveNV8hDYBYLBRW7M3/fXSZ6WHMbdQQzfYaeyIJkfrZ8xzEyqV+
	2bdQXO8kpTReE9Z+ePA35WRE+OFX5uvvxcdl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=CdMn4AdeQnevtc1EyZWb2XhvFYm9PhDg
	OvYziDGExIFkzcuAJeX56Lh8QsAoWx28YFwyl4E9mAs6SjoAj7Z7osmlaH7JdrQR
	s1/n3iyqbDpRTbAUvNx+ro+Km3ZN1gSZbC/xlH44mlfJiwXwCuR4XxriCWnyvZkD
	P7JUwUSE5qc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5F16B1F512;
	Tue, 14 May 2013 22:49:44 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BF9951F511;
	Tue, 14 May 2013 22:49:43 +0000 (UTC)
In-Reply-To: <CAMP44s0u0WPNneM-GoiqCkWTC-CT_Xa2z3on=smRiFJdd9ffeQ@mail.gmail.com>
	(Felipe Contreras's message of "Tue, 14 May 2013 17:39:02 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 91BB5A60-BCE8-11E2-9ACC-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224366>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> The reason for the "only regression" period is to avoid more
> regressions. If you show me how any of the fixes I sent in this series
> could potentially cause a regression,

I already said that "You can see these patches are so trivially
correct" is not a valid argument. The original patches would also
have been looked correct when they were sent to the list. Things
take time and actual use by the users to mature.

>> You cannot be both.  Which is it?
>
> I marked the patch that fix a regression as such, I marked the patches
> that are obvious fixes with no possibility of regressions as such, and
> I marked the trivial cleanups with no possibility of regressions as
> such.

I think you mean 6/10 by "the patch that fix a regression", but if
that is the case, please send only the regression fix that cleanly
apply to the tip of 'master', without any other dependencies, with a
proper description of what breaks and how it fixes.

We know you can do better than "certain" and "might".

> In certain situations we might end up pushing garbage revisions (e.g. in
> a rebase), and the patches to deal with that haven't been merged yet.
> 
> So let's disable forced pushes by default.

Thanks.
