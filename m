From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] http.c: don't rewrite the user:passwd string multiple times
Date: Tue, 18 Jun 2013 08:32:30 -0700
Message-ID: <7v38sf8mep.fsf@alter.siamese.dyndns.org>
References: <1371520840-24906-1-git-send-email-bcasey@nvidia.com>
	<20130618051902.GA5916@sigill.intra.peff.net>
	<alpine.DEB.2.00.1306180825460.24456@tvnag.unkk.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Brandon Casey <bcasey@nvidia.com>,
	git@vger.kernel.org, Brandon Casey <drafnel@gmail.com>
To: Daniel Stenberg <daniel@haxx.se>
X-From: git-owner@vger.kernel.org Tue Jun 18 17:32:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uoxte-0006FW-D7
	for gcvg-git-2@plane.gmane.org; Tue, 18 Jun 2013 17:32:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756239Ab3FRPce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Jun 2013 11:32:34 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47845 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756105Ab3FRPcd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Jun 2013 11:32:33 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 933A028BA4;
	Tue, 18 Jun 2013 15:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SItjxTYKB2vsHJuxl6iMwE7gYPM=; b=AJ0+n/
	MKwiQWGd4TF2UA4KAZRE88FXHRpP43MwWMQN6xAO0xfGfZ9mX5Cot6mCZbH5O5FR
	nu+rv5PM+5I2rh49kpWNCPfWlI9m0l70DRCd9B/6l44cLZ4icJGgHoP3DrhEayYP
	FoAxGvNMmCvnffufQDeavJ6tVoyNoZmTodHnQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lnU+IU4ednie1QY/rti8NPdmV/gYkBA+
	ISOvPpqEs3mFwYta/hNWOMqKA9VqUSxRmsaXE+MQUg+tHWjVarK2jW8V3s2VNgA9
	VxoyxmB4HhIiV9kkHxlKeIlGuj+OmStU+qjxi99yDrp1o0UhiA6/KAvZi823WoLd
	64F1la9QwO8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8770628BA2;
	Tue, 18 Jun 2013 15:32:32 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 03AF628B9B;
	Tue, 18 Jun 2013 15:32:31 +0000 (UTC)
In-Reply-To: <alpine.DEB.2.00.1306180825460.24456@tvnag.unkk.fr> (Daniel
	Stenberg's message of "Tue, 18 Jun 2013 08:36:59 +0200 (CEST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 4AD6730A-D82C-11E2-8A00-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228252>

Daniel Stenberg <daniel@haxx.se> writes:

> On Tue, 18 Jun 2013, Jeff King wrote:
>
> TL;DR: I'm just confirming what's said here! =)

Thanks.  We are very fortunate to have you as the cURL guru who
gives prompt responses and sanity checks to us.
