From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] general style: replaces memcmp() with proper starts_with()
Date: Wed, 12 Mar 2014 15:38:42 -0700
Message-ID: <xmqqd2hrjb4d.fsf@gitster.dls.corp.google.com>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
	<20140312175624.GA7982@sigill.intra.peff.net>
	<xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
	<20140312194943.GA2912@sigill.intra.peff.net>
	<xmqq61njkwnw.fsf@gitster.dls.corp.google.com>
	<20140312211415.GA10305@sigill.intra.peff.net>
	<20140312220640.GA14802@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 12 23:38:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNrnW-0007nt-5E
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 23:38:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752416AbaCLWiq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 18:38:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43933 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752270AbaCLWip (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 18:38:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C60C7419B;
	Wed, 12 Mar 2014 18:38:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5J8IPWshDHUh5B684aLIRy35zCM=; b=mgtOxm
	OjZvDB3fRCLkzEPFipjn4tKU8ryYxaGcKQ8IVHvDPvAM5TphMedGC9rGKYCfEnJq
	QVHV8iZjkTp8Uxdi/lCjDTR2l3jlyJjtQtCJ4yl73buuiDhU3jz9nNP0PzPWMW/f
	3niiXsz8Nl0l9294LvITs08rv7wRop3cbL178=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K8un+pQdNppUtlp7BmjdMnF9u5a9w+15
	kDFkn1YB0CmBiAPoqnd2df5zcgq6SVv+diXUpICa38rkczZW8aH1b363hWr05I73
	ITGEsnHxStXsvpvYbGu0AkO8A66JzWo3NaIq6IpI886arJhY9+HbH+r4NXjoIwqq
	60lWVrUkWyk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5B6D37419A;
	Wed, 12 Mar 2014 18:38:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9FF9F74198;
	Wed, 12 Mar 2014 18:38:44 -0400 (EDT)
In-Reply-To: <20140312220640.GA14802@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 12 Mar 2014 18:06:40 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 119CABEE-AA37-11E3-AE74-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244006>

Jeff King <peff@peff.net> writes:

> So I think the whole function could use some refactoring to handle
> corner cases better.  I'll try to take a look tomorrow, but please
> feel free if somebody else wants to take a crack at it.

Yup, thanks.
