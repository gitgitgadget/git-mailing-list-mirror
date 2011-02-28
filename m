From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] Using index-pack in place of verify-pack
Date: Mon, 28 Feb 2011 08:16:10 -0800
Message-ID: <7vfwr8jfsl.fsf@alter.siamese.dyndns.org>
References: <1298886583-30965-1-git-send-email-gitster@pobox.com>
 <AANLkTimrO6NqB0pXcfz=dAzA5fxz9ZizLyW7YV4Jan6S@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 28 17:16:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pu5ls-0000Vs-Dr
	for gcvg-git-2@lo.gmane.org; Mon, 28 Feb 2011 17:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754344Ab1B1QQW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Feb 2011 11:16:22 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43787 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751322Ab1B1QQW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Feb 2011 11:16:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id C8FBE3BF0;
	Mon, 28 Feb 2011 11:17:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=p+zv1faV0gB2EVzcc73pdKYJ1u8=; b=OvFzuM
	6HsGmgsLxa5BhdB2JXc5crMueiFbFYW5SsOjyUNoGuZFm7t0ULbvZuRBFe1/7vUI
	aPawoN/DFSS9al+9S6p3X69nSepZrYcgOIQICv9xX1bAdsF88VBM9ECpz+wlHQhD
	BCIBGWL+eQnoAtNoiRsDZeXYazbF78USgSB6k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h7pf7ayevSVIbdwNQ7by/4hEyE978qhs
	aIGJfDrfMBX/vOtJ7jjkM7PvYn9Lx0Ffq9x2HCl6yYawikgj73k5r8NYd+zMnt0+
	GpRJr92imEUT5Wi4SF40mXfY+S9197oARQly+CHc0yBDjTiy5eYJ9p1oFABbb90r
	4oPLZ5wwB2k=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 983383BED;
	Mon, 28 Feb 2011 11:17:35 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1C0853BE7; Mon, 28 Feb 2011
 11:17:30 -0500 (EST)
In-Reply-To: <AANLkTimrO6NqB0pXcfz=dAzA5fxz9ZizLyW7YV4Jan6S@mail.gmail.com>
 (Sverre Rabbelier's message of "Mon\, 28 Feb 2011 14\:07\:20 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 40DFDEE4-4356-11E0-85D0-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168118>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Mon, Feb 28, 2011 at 10:49, Junio C Hamano <gitster@pobox.com> wrote:
>> The basic idea, which comes from Shawn Pearce, is to run index-pack on a
>> packfile being verified, and compare the resulting .idx file with the
>> existing one, and make sure they match.
>
> Do you have any timings, on say, the kernel repo?

Not yet; the code has just become in good enough shape to be built and
measured by anybody interested --- didn't I say WIP somewhere?
