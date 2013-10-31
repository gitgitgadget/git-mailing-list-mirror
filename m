From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Thu, 31 Oct 2013 10:20:25 -0700
Message-ID: <xmqqa9hp9x2e.fsf@gitster.dls.corp.google.com>
References: <20131024122255.GI9378@mwanda> <20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com> <20131027013402.GA7146@leaf>
	<526CA7D4.1070904@alum.mit.edu> <20131027071407.GA11683@leaf>
	<526E283A.1070801@alum.mit.edu>
	<CALKQrgfsk3fjyF77XL9+CPyJ_s-AfzkNAj4Eaj1LT-G0Ph=bfg@mail.gmail.com>
	<20131029020824.GE11861@sigill.intra.peff.net>
	<CALKQrge8T8R7roUUYyLcu_QnL1afeqTATOp+0n_OOsZZoJXF4Q@mail.gmail.com>
	<CACsJy8DVSpmmDw-jGJoJK171u5UeJR7GKPuX7QAK4=7yYn6n8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Josh Triplett <josh@joshtriplett.org>,
	Git mailing list <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: linux-kernel-owner@vger.kernel.org Thu Oct 31 18:20:41 2013
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Vbvv9-0007vf-NT
	for glk-linux-kernel-3@plane.gmane.org; Thu, 31 Oct 2013 18:20:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753825Ab3JaRUa (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Thu, 31 Oct 2013 13:20:30 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53836 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353Ab3JaRU2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Oct 2013 13:20:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE5CC4CFC6;
	Thu, 31 Oct 2013 13:20:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jK7ZxHdzjwo6zCaxlu9NAC+/iaM=; b=J1mqF8
	FzWmwpCWVS8KxcDPphG57U3x+fekjO1DzBJ4b1DJGPsny71ZRirZU++bRui8RgDE
	b0v1Iy5tEU8tKw3dFrp8kicG9L8Ag85y+Mbp/NhtSSoWqni64+bO9ilGsY+b7Fv8
	y4JRl+yUE+ze8+zs/v/uefeQy1HaIXUbc1mmM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H9qZ9FKPcdn7Uh7ke9TSHORWBZM9wFkd
	mdtqMrcpO/dlUX7pPFAqoFnfIJMWYmmymUBwY9CcBLFRBjN4h73bMfEkLVmhL8Xi
	f4qKJu++NKlONAaJHv6kCtJF6e1IlWpWl3judwcgno7TPKPOj3i9WeR3HpUhknHN
	5hIvmn9Oi7A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D12E44CFC4;
	Thu, 31 Oct 2013 13:20:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1B2394CFC2;
	Thu, 31 Oct 2013 13:20:27 -0400 (EDT)
In-Reply-To: <CACsJy8DVSpmmDw-jGJoJK171u5UeJR7GKPuX7QAK4=7yYn6n8Q@mail.gmail.com>
	(Duy Nguyen's message of "Thu, 31 Oct 2013 13:28:44 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BC1B61B8-4250-11E3-92CF-1FFB7F2839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237131>

Duy Nguyen <pclouds@gmail.com> writes:

> OK how about, if $GIT_DIR/hooks/something is a directory, then the
> directory must contain a file named "index", listing all the hooks of
> type "something". All the hooks in "index" will be executed in the
> listing order.

Hooks that take arbitrary amount of information from the body read
their standard input. How are your multiple hooks supposed to
interact?

Hooks that prevent you from doing something stupid signal allow/deny
with their exit code. Do you fail a commit if any of your pre-commit
hook fails, or is it OK to commit as long as one of them says so?
If the former, do all the hooks described in the index still run, or
does the first failure short-cut the remainder?
