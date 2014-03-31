From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/3] patch-id: make it stable against hunk reordering
Date: Mon, 31 Mar 2014 12:35:39 -0700
Message-ID: <xmqqeh1i5fg4.fsf@gitster.dls.corp.google.com>
References: <1396202583-2572-1-git-send-email-mst@redhat.com>
	<xmqqk3ba6yg9.fsf@gitster.dls.corp.google.com>
	<20140331190444.GA12208@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, sunshine@sunshineco.com, jrnieder@gmail.com,
	peff@peff.net
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Mon Mar 31 21:35:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUhzy-0008RH-Ra
	for gcvg-git-2@plane.gmane.org; Mon, 31 Mar 2014 21:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751351AbaCaTfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 15:35:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53365 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750925AbaCaTfx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Mar 2014 15:35:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4C65878E5C;
	Mon, 31 Mar 2014 15:35:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JPiHxHIcz8yjGnlukF/KC1vNXt8=; b=q/a5mJ
	SDNKuJt72mzXkDn9fjftItspe1bVdlBMxoibxUedoc9uoqeVHtZM/SeraWJvBIRw
	TI/j+xDYC9QVyBMW7xxCWiz3JrzzvSxDuETodxl2Khoh6nwgTux+KpLX8W5/oY7j
	WDQ+bm1ozhZUoDR/pI9g8FB2pg6i/snZULnAE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SoxmNs9hlbeteiuDqc4VXdoawWZIyOjg
	y9o1XJ+pWhSS0sNWmvA0uL8LCzo4vtQ9SRPontOwxf7PnJLYZnebvcoW/IyxcJGE
	jisGvEdCNiPVnrPkPDk8WsrL8IoOkc1vXNNAcgT35O4vNCsUGjnD1qvHTZZoB2o8
	GcbDPlLuQ/8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 35CD578E5B;
	Mon, 31 Mar 2014 15:35:53 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68F0478E05;
	Mon, 31 Mar 2014 15:35:41 -0400 (EDT)
In-Reply-To: <20140331190444.GA12208@redhat.com> (Michael S. Tsirkin's message
	of "Mon, 31 Mar 2014 22:04:44 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A4F2710C-B90B-11E3-B259-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245519>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> though it does look like an unrelated enhancement to me.
> Agree?

Yes, that is exactly why I said "opens interesting opportunity" and
"making it possible" ;-) They are all very related, but they do not
have to graduate as parts of the same series.

The important thing is that the basic infrastructure of the new
codepath is designed in such a way that it later allows us to reuse
it in these changes.

I'm queuing these three patches almost as-is (I think I tweaked the
"sizeof" thing) on 'pu', without fixing the test styles and other
issues I may have pointed out in my reviews myself, expecting
further clean-ups.
